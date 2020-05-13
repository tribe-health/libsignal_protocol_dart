import 'dart:typed_data';

import 'package:libsignal_protocol_dart/src/ecc/Curve.dart';
import 'package:libsignal_protocol_dart/src/ecc/ECKeyPair.dart';
import 'package:libsignal_protocol_dart/src/kdf/HKDF.dart';
import 'package:libsignal_protocol_dart/src/ratchet/RootKey.dart';
import 'package:test/test.dart';

void main() {
  test('testRootKeyDerivationV2', () {
    var rootKeySeed = Uint8List.fromList([
      0x7b,
      0xa6,
      0xde,
      0xbc,
      0x2b,
      0xc1,
      0xbb,
      0xf9,
      0x1a,
      0xbb,
      0xc1,
      0x36,
      0x74,
      0x04,
      0x17,
      0x6c,
      0xa6,
      0x23,
      0x09,
      0x5b,
      0x7e,
      0xc6,
      0x6b,
      0x45,
      0xf6,
      0x02,
      0xd9,
      0x35,
      0x38,
      0x94,
      0x2d,
      0xcc
    ]);

    var alicePublic = Uint8List.fromList([
      0x05,
      0xee,
      0x4f,
      0xa6,
      0xcd,
      0xc0,
      0x30,
      0xdf,
      0x49,
      0xec,
      0xd0,
      0xba,
      0x6c,
      0xfc,
      0xff,
      0xb2,
      0x33,
      0xd3,
      0x65,
      0xa2,
      0x7f,
      0xad,
      0xbe,
      0xff,
      0x77,
      0xe9,
      0x63,
      0xfc,
      0xb1,
      0x62,
      0x22,
      0xe1,
      0x3a
    ]);

    var alicePrivate = Uint8List.fromList([
      0x21,
      0x68,
      0x22,
      0xec,
      0x67,
      0xeb,
      0x38,
      0x04,
      0x9e,
      0xba,
      0xe7,
      0xb9,
      0x39,
      0xba,
      0xea,
      0xeb,
      0xb1,
      0x51,
      0xbb,
      0xb3,
      0x2d,
      0xb8,
      0x0f,
      0xd3,
      0x89,
      0x24,
      0x5a,
      0xc3,
      0x7a,
      0x94,
      0x8e,
      0x50
    ]);

    var bobPublic = Uint8List.fromList([
      0x05,
      0xab,
      0xb8,
      0xeb,
      0x29,
      0xcc,
      0x80,
      0xb4,
      0x71,
      0x09,
      0xa2,
      0x26,
      0x5a,
      0xbe,
      0x97,
      0x98,
      0x48,
      0x54,
      0x06,
      0xe3,
      0x2d,
      0xa2,
      0x68,
      0x93,
      0x4a,
      0x95,
      0x55,
      0xe8,
      0x47,
      0x57,
      0x70,
      0x8a,
      0x30
    ]);

    var nextRoot = Uint8List.fromList([
      0xb1,
      0x14,
      0xf5,
      0xde,
      0x28,
      0x01,
      0x19,
      0x85,
      0xe6,
      0xeb,
      0xa2,
      0x5d,
      0x50,
      0xe7,
      0xec,
      0x41,
      0xa9,
      0xb0,
      0x2f,
      0x56,
      0x93,
      0xc5,
      0xc7,
      0x88,
      0xa6,
      0x3a,
      0x06,
      0xd2,
      0x12,
      0xa2,
      0xf7,
      0x31
    ]);

    var nextChain = Uint8List.fromList([
      0x9d,
      0x7d,
      0x24,
      0x69,
      0xbc,
      0x9a,
      0xe5,
      0x3e,
      0xe9,
      0x80,
      0x5a,
      0xa3,
      0x26,
      0x4d,
      0x24,
      0x99,
      0xa3,
      0xac,
      0xe8,
      0x0f,
      0x4c,
      0xca,
      0xe2,
      0xda,
      0x13,
      0x43,
      0x0c,
      0x5c,
      0x55,
      0xb5,
      0xca,
      0x5f
    ]);

    var alicePublicKey = Curve.decodePoint(alicePublic, 0);
    var alicePrivateKey = Curve.decodePrivatePoint(alicePrivate);
    var aliceKeyPair = ECKeyPair(alicePublicKey, alicePrivateKey);

    var bobPublicKey = Curve.decodePoint(bobPublic, 0);
    var rootKey = RootKey(HKDF.createFor(2), rootKeySeed);

    var rootKeyChainKeyPair = rootKey.createChain(bobPublicKey, aliceKeyPair);
    var nextRootKey = rootKeyChainKeyPair.item1;
    var nextChainKey = rootKeyChainKeyPair.item2;

    expect(rootKey.getKeyBytes(), rootKeySeed);
    // TODO
//    expect(nextRootKey.getKeyBytes(), nextRoot);
//    expect(nextChainKey.getKey(), nextChain);
  });
}