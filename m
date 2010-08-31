From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCHv2] completion: make compatible with zsh
Date: Tue, 31 Aug 2010 09:52:02 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC749BF0BEBB9@xmail3.se.axis.com>
References: <1282877156-16149-1-git-send-email-lodatom@gmail.com>
 <20100830141927.GA16495@neumann>
 <AANLkTimNULQNVZ4hzaNY1ZobPRtj_zj545Xi29guGu4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"avarab@gmail.com" <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: Mark Lodato <lodatom@gmail.com>,
	=?utf-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Aug 31 09:56:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqLi3-0000yG-RD
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 09:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756889Ab0HaHw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 03:52:27 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:36246 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756832Ab0HaHw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 03:52:26 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o7V7q319018263;
	Tue, 31 Aug 2010 09:52:03 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Tue, 31 Aug 2010 09:52:03 +0200
Thread-Topic: [PATCHv2] completion: make compatible with zsh
Thread-Index: ActIp9sRHSS9VklmSa6fr0fGMp3AdwAOAsUw
In-Reply-To: <AANLkTimNULQNVZ4hzaNY1ZobPRtj_zj545Xi29guGu4g@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154885>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBnaXQtb3duZXJAdmdlci5rZXJu
ZWwub3JnIFttYWlsdG86Z2l0LW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24NCj4gQmVoYWxmIE9m
IE1hcmsgTG9kYXRvDQo+IFNlbnQ6IGRlbiAzMSBhdWd1c3RpIDIwMTAgMDI6NTYNCj4gVG86IFNa
RURFUiBHw6Fib3INCj4gQ2M6IFNoYXduIE8uIFBlYXJjZTsgZ2l0QHZnZXIua2VybmVsLm9yZzsg
YXZhcmFiQGdtYWlsLmNvbTsgSm9uYXRoYW4NCj4gTmllZGVyOyBBbmRyZXcgU2F5ZXJzDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0h2Ml0gY29tcGxldGlvbjogbWFrZSBjb21wYXRpYmxlIHdpdGggenNo
DQo+IA0KPiAyMDEwLzgvMzAgU1pFREVSIEfDoWJvciA8c3plZGVyQGlyYS51a2EuZGU+DQo+ID4g
T24gVGh1LCBBdWcgMjYsIDIwMTAgYXQgMTA6NDU6NTZQTSAtMDQwMCwgTWFyayBMb2RhdG8gd3Jv
dGU6DQo+ID4gPiBAQCAtMjQxNywzICsyNDMzLDI5IEBAIGlmIFsgQ3lnd2luID0gIiQodW5hbWUg
LW8gMj4vZGV2L251bGwpIiBdOyB0aGVuDQo+ID4gPiDCoGNvbXBsZXRlIC1vIGJhc2hkZWZhdWx0
IC1vIGRlZmF1bHQgLW8gbm9zcGFjZSAtRiBfZ2l0IGdpdC5leGUgMj4vZGV2L251bGwgXA0KPiA+
ID4gwqAgwqAgwqAgfHwgY29tcGxldGUgLW8gZGVmYXVsdCAtbyBub3NwYWNlIC1GIF9naXQgZ2l0
LmV4ZQ0KPiA+ID4gwqBmaQ0KPiA+ID4gKw0KPiA+ID4gK2lmIFtbIC16ICRaU0hfVkVSU0lPTiBd
XTsgdGhlbg0KPiA+DQo+ID4gLXo/IMKgSSB0aGluayB5b3Ugd2FudGVkIHRvIHVzZSAtbiBoZXJl
LCBsaWtlIGF0IHRoZSBvdGhlciBwbGFjZXMuDQo+IA0KPiBPaCwgeWVzLCBzb3JyeS4gIFRoaXMg
d2FzIGEgbWlzdGFrZS4gIFRoYW5rcyBmb3IgY2F0Y2hpbmcgaXQuDQo+IA0KPiANCj4gPiBOaXQ6
IHdoeSAiaWYgW1sgLi4uIF1dIj8gwqBGV0lXICJpZiBbIC4uLiBdIiB3b3VsZCBiZSBlbm91Z2gu
DQo+IA0KPiBCZWNhdXNlIHlvdSBkb24ndCBuZWVkIHRvIHF1b3RlIHZhcmlhYmxlcyB3aXRoIFtb
IC4uLiBdXSAtLS0gZS5nLiBbDQo+ICRsaW5lcyA9IDAgXSBmYWlscywgdGhvdWdoIGluIHRoaXMg
Y2FzZSB0aGlzIGZlYXR1cmUgZG9lcyBub3QgbWF0dGVyDQo+IC0tLSBhbmQgYmVjYXVzZSBbWyAu
Li4gXV0gaXMgZmFzdGVyLg0KPiANCj4gQmFzaCA0LjEuNToNCj4gPiB0aW1lIChmb3IgKCggaSA9
IDA7IGkgPCAyMDAwMDA7IGkrKyApKTsgZG8gWyAteiAkZm9vIF07IGRvbmUpDQo+IHJlYWwgICAg
MG0zLjQzMHMNCj4gdXNlciAgICAwbTMuMjQwcw0KPiBzeXMgICAgIDBtMC4xODBzDQo+ID4gdGlt
ZSAoZm9yICgoIGkgPSAwOyBpIDwgMjAwMDAwOyBpKysgKSk7IGRvIFtbIC16ICRmb28gXV07IGRv
bmUpDQo+IHJlYWwgICAgMG0yLjIxOXMNCj4gdXNlciAgICAwbTIuMDkwcw0KPiBzeXMgICAgIDBt
MC4xMDBzDQo+IA0KPiBac2ggNC4zLjEwOg0KPiA+IHRpbWUgKGZvciAoKCBpID0gMDsgaSA8IDIw
MDAwMDA7IGkrKyApKTsgZG8gWyAteiAkZm9vIF07IGRvbmUpDQo+ICg7IGZvciAoKGkgPSAwOyBp
IDwgMjAwMDAwMDsgaSsrICkpIGRvOyBbIC16ICRmb28gXTsgZG9uZTsgKSAgMTMuNTZzDQo+IHVz
ZXIgMS42NHMgc3lzdGVtIDk5JSBjcHUgMTUuMzI3IHRvdGFsDQo+ID4gdGltZSAoZm9yICgoIGkg
PSAwOyBpIDwgMjAwMDAwMDsgaSsrICkpOyBkbyBbWyAteiAkZm9vIF1dOyBkb25lKQ0KPiAoOyBm
b3IgKChpID0gMDsgaSA8IDIwMDAwMDA7IGkrKyApKSBkbzsgW1sgLXogJGZvbyBdXTsgZG9uZTsg
KSAgNC42MnMNCj4gdXNlciAwLjAxcyBzeXN0ZW0gOTklIGNwdSA0LjY0NCB0b3RhbA0KPiANCj4g
SXMgdGhlcmUgYSByZWFzb24gdG8gcHJlZmVyIFsgLi4uIF0gPw0KDQpUaGUgWyBjb21tYW5kIGlz
IGRlZmluZWQgYnkgUE9TSVgsIHdoaWxlIFtbIGlzIGFuIGV4dGVuc2lvbiB0byB0aGUgDQpzaGVs
bCBsYW5ndWFnZSBpbXBsZW1lbnRlZCBieSBiYXNoIChhbmQgenNoKS4gVGh1cyB0aGUgW1sgY29u
c3RydWN0IA0Kd291bGQgZmFpbCBvbiBhIHN0cmljdGVyIFBPU0lYIGltcGxlbWVudGF0aW9uIG9m
IHRoZSBzaGVsbCBsYW5ndWFnZSwgDQplLmcuLCBhcyBpbXBsZW1lbnRlZCBieSBkYXNoLiBUaHVz
IHRvIGJlIFBPU0lYIGNvbXBsaWFudCAod2hpY2ggaXMNCnJlcXVpcmVkIGZvciBzaGVsbCBzY3Jp
cHRzIGluc3RhbGxlZCBieSBhIG11bHRpIHN5c3RlbSBzdXBwb3J0aW5nIA0KYXBwbGljYXRpb24g
bGlrZSBnaXQpLCB0aGUgW1sgY29uc3RydWN0IGNhbm5vdCBiZSB1c2VkLiANCg0KT2YgY291cnNl
LCB0aGlzIGRvZXMgbm90IHJlYWxseSBhcHBseSB0byBhIHNjcmlwdCBleHBsaWNpdGx5IHdyaXR0
ZW4gDQpmb3IgYmFzaCwgYnV0IHRoYXQgaXMgdGhlIGNvbW1vbiByZWFzb24gdG8gcHJlZmVyIFsg
b3ZlciBbWyBpbiBzaGVsbCANCnNjcmlwdHMuDQoNCi8vUGV0ZXINCg0K
