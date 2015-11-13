From: Dominik Rauch <dominik.rauch@gmx.at>
Subject: Re: Re: git log --merges doesn't show commits as expected
Date: Fri, 13 Nov 2015 23:10:44 +0000
Message-ID: <AMSPR02MB168F9B2126871F4702CBA5483110@AMSPR02MB168.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 14 00:11:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxNUb-0004MU-0j
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 00:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbbKMXKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 18:10:49 -0500
Received: from mail-am1on0133.outbound.protection.outlook.com ([157.56.112.133]:48417
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751071AbbKMXKs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 18:10:48 -0500
Received: from AMSPR02MB168.eurprd02.prod.outlook.com (10.242.94.25) by
 AMSPR02MB166.eurprd02.prod.outlook.com (10.242.94.22) with Microsoft SMTP
 Server (TLS) id 15.1.325.17; Fri, 13 Nov 2015 23:10:44 +0000
Received: from AMSPR02MB168.eurprd02.prod.outlook.com ([10.242.94.25]) by
 AMSPR02MB168.eurprd02.prod.outlook.com ([10.242.94.25]) with mapi id
 15.01.0325.003; Fri, 13 Nov 2015 23:10:44 +0000
Thread-Topic: Re: git log --merges doesn't show commits as expected
Thread-Index: AdEeZjdN1KONQPfbQ9qWVinESKX0jQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dominik@dominikrauch.onmicrosoft.com; 
x-ms-exchange-messagesentrepresentingtype: 2
x-originating-ip: [212.186.82.27]
x-microsoft-exchange-diagnostics: 1;AMSPR02MB166;5:pwVqTcvB36v/jQR4Ut5putzFXtUYCaYcZc6g9g0t8xwEnjbU3sZb650ttaUJqnDegS+4gvOMjsZBBV6hFvqDZU07hZscmWolVn6sU0Jg6SGskSiTWkhNW/GW2Pzhl8pEif+ilWMUic5f1Ohq7FnDPw==;24:oZpNhmx5gk7hrXVuj3HgVUnBQNUPkUe97Bv382Te2hi5d/U5nhudE2W9dVw38K8DKDf2OTCyLnX6Z49lkf/LdOfpUMsIR7OOK8LYw26huWE=;20:Hw1JGOYmI6rdFCq8StFagjbjgxa8kjn7NPzGRq/Ocb4z78YRf02iHUBAiGHfQi5C37dVlVKkNi6F9bUlUVdslQ==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AMSPR02MB166;
x-microsoft-antispam-prvs: <AMSPR02MB1663F595F3D2A51D3DCBA7B83110@AMSPR02MB166.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(2401047)(520078)(5005006)(8121501046)(10201501046)(3002001);SRVR:AMSPR02MB166;BCL:0;PCL:0;RULEID:;SRVR:AMSPR02MB166;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(189002)(199003)(76104003)(33656002)(74482002)(64872006)(54356999)(50986999)(89136004)(66066001)(10400500002)(76576001)(586003)(74316001)(106356001)(105586002)(5001960100002)(189998001)(97736004)(110136002)(92566002)(81156007)(5002640100001)(11100500001)(5003600100002)(5007970100001)(5004730100002)(40100003)(77096005)(102836002)(2900100001)(101416001)(86902001)(87936001)(122556002)(86972001)(42882005);DIR:OUT;SFP:1102;SCL:1;SRVR:AMSPR02MB166;H:AMSPR02MB168.eurprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
received-spf: None (protection.outlook.com: dominikrauch.onmicrosoft.com does
 not designate permitted sender hosts)
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
X-OriginatorOrg: dominikrauch.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2015 23:10:44.1774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 62860c5f-96cd-494b-b6bc-19dacd3a942d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMSPR02MB166
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281270>

VGhhbmsgeW91IEplZmYgZm9yIHlvdXIgZWxhYm9yYXRpb24hIFRoZSBhbGdvcml0aG0gaXMgbm93
IGNsZWFyIHRvIG1lIGFuZCBJIGNhbiBzZWUgd2h5IHRoZSBsb2cgaGFzIGJlZW4gZW1wdHkuDQoN
Ckhvd2V2ZXIsIEkgZG9uJ3QgdGhpbmsgdGhlIGRlZmF1bHQgc2ltcGxpZmljYXRpb24gYWxnb3Jp
dGhtIGlzIGEgZ29vZCBkZWZhdWx0IHdoZW4gdXNlZCBpbiBjb21iaW5hdGlvbiB3aXRoICItLW1l
cmdlcyIuICJnaXQgbG9nIC0tbWVyZ2VzIGZpbGUiIGxvb2tzIHZlcnkgbmF0dXJhbCBpZiBJIHdh
bnQgdG8gYW5zd2VyIHRoZSBxdWVzdGlvbiAiV2hlbiBoYXMgZmlsZSBiZWVuIG1lcmdlZCBpbnRv
IG15IG1hc3Rlci9kZXZlbG9wL3doYXRzb2V2ZXIgYnJhbmNoPyIgYW5kIGl0IGp1c3QgZG9lc24n
dCB3b3JrLiBJcyB0aGVyZSBhIHNpbXBsZXIgd2F5IHRvIGFuc3dlciB0aGF0IHF1ZXN0aW9uPyBX
aGF0IGlzIHRoZSBwcmltYXJ5IHVzZSBvZiAiLS1tZXJnZXMiIGlmIG5vdCBjb21iaW5lZCB3aXRo
ICItLWZ1bGwtaGlzdG9yeSIgb3IgYXQgbGVhc3QgIi0tZmlyc3QtcGFyZW50Ij8gSSB3b3VsZCBv
bmx5IHNlZSBtZXJnZXMgd2hlcmUgZmlsZSBoYXMgYmVlbiBhICJtZXJnZSBjb25mbGljdCIuIFdo
YXQgZG8geW91IHRoaW5rIGFib3V0IGltcGx5aW5nICItLWZ1bGwtaGlzdG9yeSIgd2hlbiB1c2lu
ZyAiLS1tZXJnZXMiPw0KDQpCZXN0IHJlZ2FyZHMsDQpEb21pbmlrDQoNCj4gPiAoVGhpcyBpcyBt
eSBmaXJzdCBwb3N0IHRvIHRoaXMgbWFpbGluZyBsaXN0IGFuZCBJIGNvdWxkbid0IGZpbmQgYSBG
QVEgDQo+ID4gc2VjdGlvbiAtIHBsZWFzZSBleGN1c2UgbWUsIGlmIEkgaGF2ZW4ndCBmb2xsb3dl
ZCBhbGwgdGhlIGVzdGFibGlzaGVkIA0KPiA+IHBvc3RpbmcgZ3VpZGVsaW5lcyB5ZXQuKQ0KPiAN
Cj4gVGhpcyBpcyB0aGUgcmlnaHQgcGxhY2UuIFdlbGNvbWUuIDopDQo+IA0KPiA+IEkgaGF2ZSB0
aGUgZm9sbG93aW5nIHJlcG9zaXRvcnkgdHJlZToNCj4gPiANCj4gPiBDDQo+ID4gfFwNCj4gPiB8
IEINCj4gPiB8IC8NCj4gPiBBDQo+ID4gDQo+ID4gQ29tbWl0IEE6IFBhcmVudHM9KCkuIEluaXRp
YWwgY29tbWl0LiBDb250YWlucyBmaWxlIGZvbyB3aXRoIGNvbnRlbnQgIkFCQyIuDQo+ID4gQ29t
bWl0IEI6IFBhcmVudHM9KEEpLiBSZXByZXNlbnRzIGEgY29tbWl0IG9uIHNvbWUgZmVhdHVyZSBi
cmFuY2guIENvbnRhaW5zIGZpbGUgZm9vIHdpdGggY29udGVudCAiWFlaIi4NCj4gPiBDb21taXQg
QzogUGFyZW50cz0oQSwgQikuIFJlcHJlc2VudHMgYSBtZXJnZSBjb21taXQgb2YgYSBmZWF0dXJl
IGJyYW5jaCBiYWNrIHRvIHRoZSBtYWluIGJyYW5jaC4gQ29udGFpbnMgZmlsZSBmb28gd2l0aCBj
b250ZW50ICJYWVoiLg0KPiA+IA0KPiA+IEkgZXhwZWN0ZWQgImdpdCBsb2cgLS1tZXJnZXMgZm9v
IiB0byBzaG93IEMsIGhvd2V2ZXIsIHRoZSBsb2cgaXMgDQo+ID4gZW1wdHkhIFNwZWNpZnlpbmcg
Ii0tZnVsbC1oaXN0b3J5IiByZXN1bHRzIGluIHRoZSBjb3JyZWN0IGhpc3RvcnksIA0KPiA+IHRo
ZXJlZm9yZSBJIGFzc3VtZSwgSSBtaXN1bmRlcnN0YW5kIEdpdCdzIGRlZmF1bHQgaGlzdG9yeSAN
Cj4gPiBzaW1wbGlmaWNhdGlvbiBhbGdvcml0aG0uIFVuZm9ydHVuYXRlbHksIHRoZSBleGFtcGxl
IGluIHRoZSBHaXQgZG9jcyANCj4gPiBhdCBbMV0gZG9lcyBub3QgY29udGFpbiB0aGUgdmVyeSBz
YW1lIHNpdHVhdGlvbiAoYWx0aG91Z2ggaXQgaXMgDQo+ID4gcHJvYmFibHkgb25lIG9mIHRoZSBt
b3N0IGNvbW1vbiBzaXR1YXRpb25zLi4uKS4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgIi0tbWVyZ2Vz
IiBpcyByZWxldmFudCB0byB0aGUgc2ltcGxpZmljYXRpb24gaGVyZS4gQnkgYXNraW5nIGZvciAi
Zm9vIiwgdGhhdCB0dXJucyBvbiBoaXN0b3J5IHNpbXBsaWZpY2F0aW9uLiBTaW5jZSB0aGUgbWVy
Z2UgYXQgQyB0b29rIG9uZSBzaWRlIGRpcmVjdGx5LCB0aGF0IG1lYW5zIHdlIGNhbiBjdWxsIHRo
ZSBwYXJlbnQgbGluayB0aGF0IGxlYWRzIHRvIEEgKGl0cyBmb289QUJDIGRpZCBub3QgY29udHJp
YnV0ZSB0byB0aGUgZmluYWwgb3V0Y29tZSkuIEFuZCB0aGVuIEMgaXMgVFJFRVNBTUUgdG8gaXRz
IG9ubHkgcmVtYWluaW5nIHBhcmVudCAodGhleSBib3RoIGhhdmUgZm9vPVhZWiksIHNvIGl0IGNh
biBiZSByZW1vdmVkLCBsZWF2aW5nIG9ubHkgY29tbWl0IEIgdG8gYmUgcGFzc2VkIHRvIHRoZSBu
ZXh0IHN0YWdlLg0KPiANCj4gQW5kIHRoZW4gd2UgYXBwbHkgIi0tbWVyZ2VzIiwgYW5kIHNlZSB0
aGF0IEIgaXMgbm90IGEgbWVyZ2UsIGFuZCBzbyBkbyBub3Qgc2hvdyBpdCAoYnV0IHdlIHN0aWxs
IHRyYXZlcnNlIGl0LCBvZiBjb3Vyc2UpLg0KPiANCj4gSW4gdGhlb3J5IHdlIGNvdWxkIGFwcGx5
ICItLW1lcmdlcyIgZmlyc3QgKGJ5IHNpbXBsaWZ5aW5nIGhpc3RvcnkgdG8gc2hyaW5rIGFueSBj
aGFpbnMgb2Ygbm9uLW1lcmdlcyB0byBhIHNpbmdsZSBwb2ludCkuIEJ1dCBJIGRvbid0IHRoaW5r
IHRoZXJlJ3MgYW55IHdheSB0byBkbyB0aGF0IGN1cnJlbnRseSB3aXRoIGdpdC4NCj4gDQo+IC1Q
ZWZmDQo=
