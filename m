From: BGaudreault Brian <BGaudreault@edrnet.com>
Subject: RE: Repository Code Security (Plan Text)
Date: Wed, 24 Jun 2015 20:17:00 +0000
Message-ID: <BLUPR0701MB19695641DC72D62EC246EDF3D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
References: <BLUPR0701MB19693B73E05DF433C6B70182D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
	 <20150624213111.61ce6933040bbb7220d5903c@domain007.com>
	 <BLUPR0701MB196947C0396E91F8CCE39200D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
	 <alpine.DEB.2.02.1506241217010.4148@nftneq.ynat.uz>
	 <BLUPR0701MB1969E8CB9B348504F02231F3D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
 <1435176014.6499.4.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: David Lang <david@lang.hm>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 22:17:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7r6a-0006h7-7V
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 22:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbbFXURE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 16:17:04 -0400
Received: from mail-bl2on0063.outbound.protection.outlook.com ([65.55.169.63]:30522
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752695AbbFXURC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 16:17:02 -0400
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com (10.163.121.20) by
 BLUPR0701MB1969.namprd07.prod.outlook.com (10.163.121.20) with Microsoft SMTP
 Server (TLS) id 15.1.195.15; Wed, 24 Jun 2015 20:17:00 +0000
Received: from BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) by
 BLUPR0701MB1969.namprd07.prod.outlook.com ([10.163.121.20]) with mapi id
 15.01.0195.005; Wed, 24 Jun 2015 20:17:00 +0000
Thread-Topic: Repository Code Security (Plan Text)
Thread-Index: AdCuqem2MqHLznfSRzO/+eUOqJToogAAgfmAAABNYKAAAWr1AAAA8xfAAABwwAAAAAlKgA==
In-Reply-To: <1435176014.6499.4.camel@twopensource.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: twopensource.com; dkim=none (message not signed)
 header.d=none;
x-originating-ip: [12.188.185.200]
x-microsoft-exchange-diagnostics: 1;BLUPR0701MB1969;5:fk7E0nWeQm5bAx8RZYkEuOUBkgMv9uVmiwikgF4SbQO76xPPYb4/cuOhJlh1SvVLYsqRaiov5sDtHFgmUrpIbeXRFHWD530vquP8tFZ1yqGc7zXyTkMsbcvpYvMlfHrhDsfBv7f9ZL6jWMcdETY6nw==;24:vC1dI/kMPShOCuEc56kAsZYgVHJuG0oUQjQiB1UfCJmH8BxDaVkv5toby+wMBTmqa9W8Ll0FsZN/jHfup4pRNe9LsL/Wl+e7wQNNocaQHCM=;20:cSVHWDkmySLgPR5Le4DUXGWzcWnrT6zMoSDs4PfIpL+2wPkTmPJDD3R07S9YYwYE1Pra8fyTD17iWhokr12o6g==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(42134001)(42139001);SRVR:BLUPR0701MB1969;
x-microsoft-antispam-prvs: <BLUPR0701MB19691315AFDD8D89AB255831D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BLUPR0701MB1969;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1969;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(164054003)(13464003)(377424004)(377454003)(51704005)(24454002)(76576001)(66066001)(40100003)(2950100001)(80792005)(122556002)(77156002)(93886004)(50986999)(74316001)(2420400003)(62966003)(99286002)(76176999)(5002640100001)(54356999)(2900100001)(7110500001)(86362001)(19580405001)(110136002)(19580395003)(5003600100002)(15975445007)(77096005)(102836002)(2656002)(189998001)(33656002)(92566002)(46102003)(87936001)(5001960100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1969;H:BLUPR0701MB1969.namprd07.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-OriginatorOrg: edrnet.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2015 20:17:00.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5294837-2991-446b-82ba-9a6e606fbfae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1969
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272605>

T2ssIHRoYW5rcy4gIEkgZGlkbid0IHJlYWxpemUgdGhlcmUgd2FzIGEgZGlmZmVyZW5jZSEgIEkg
dGhvdWdodCBHaXQgU0NNIHJhbiBHaXRIdWIuICBJIGhhdmVuJ3QgeWV0IHJlYWQgdGhpcyBjbGVh
ciBkaXN0aW5jdGlvbi4gIE9mIGNvdXJzZSBJIHdhc24ndCB0aGUgb25lIHdobyBjaG9zZSBHaXRI
dWIgaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogRGF2aWQgVHVybmVyIFttYWlsdG86ZHR1cm5lckB0d29wZW5zb3VyY2UuY29tXSANClNlbnQ6
IFdlZG5lc2RheSwgSnVuZSAyNCwgMjAxNSA0OjAwIFBNDQpUbzogQkdhdWRyZWF1bHQgQnJpYW4N
CkNjOiBEYXZpZCBMYW5nOyBLb25zdGFudGluIEtob21vdXRvdjsgZ2l0QHZnZXIua2VybmVsLm9y
Zw0KU3ViamVjdDogUmU6IFJlcG9zaXRvcnkgQ29kZSBTZWN1cml0eSAoUGxhbiBUZXh0KQ0KDQpH
aXQgaXMgbm90IEdpdEh1YiAoYW55IG1vcmUgdGhhbiBhIGNhdCBpcyBhIGNhdGhvdXNlKS4gIEdp
dCBpcyBhIHBpZWNlIG9mIHNvZnR3YXJlOyBHaXRIdWIgaXMgYSBob3N0aW5nIHNlcnZpY2UgZm9y
IEdpdC4gIENvbnRhY3QgR2l0SHViIGZvciBHaXRIdWIgc3VwcG9ydC4NCg0KDQpPbiBXZWQsIDIw
MTUtMDYtMjQgYXQgMTk6NTMgKzAwMDAsIEJHYXVkcmVhdWx0IEJyaWFuIHdyb3RlOg0KPiBIaSBE
YXZpZCBMYW5nLA0KPiANCj4gSSdtIHNvcnJ5LCBidXQgSSdtIGNvbmZ1c2VkIGJ5IHlvdXIgZmly
c3QgdHdvIHJlc3BvbnNlcy4gIEFtIEkgbm90IGNvbnRhY3RpbmcgR2l0IHdoZW4gSSBlLW1haWwg
dGhpcyBlLW1haWwgYWRkcmVzcz8gIFlvdSBzb3VuZCBsaWtlIHlvdSBkb24ndCBrbm93IGV4YWN0
bHkgaG93IEdpdEh1YiB3b3Jrcy4gIFNob3VsZCBJIGJlIGNvbnRhY3Rpbmcgc29tZW9uZSBlbHNl
IGZvciBHaXRIdWIgc3VwcG9ydD8NCj4gDQo+IFRoYW5rcywNCj4gQnJpYW4NCj4gDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhdmlkIExhbmcgW21haWx0bzpkYXZpZEBs
YW5nLmhtXQ0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjQsIDIwMTUgMzoyMCBQTQ0KPiBUbzog
QkdhdWRyZWF1bHQgQnJpYW4NCj4gQ2M6IEtvbnN0YW50aW4gS2hvbW91dG92OyBnaXRAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBSZXBvc2l0b3J5IENvZGUgU2VjdXJpdHkgKFBsYW4g
VGV4dCkNCj4gDQo+IE9uIFdlZCwgMjQgSnVuIDIwMTUsIEJHYXVkcmVhdWx0IEJyaWFuIHdyb3Rl
Og0KPiANCj4gPiBUaGFua3MuICBZZXMsIEkgbWVhbnQgdGhhdCAibG9jYWwgY29kZSIgaXMgY29k
ZSBwdWxsZWQgZG93biB0byBhIHBlcnNvbidzIFBDLCBzbyB3ZSBkb24ndCB3YW50IHRoZW0gdG8g
bGVhdmUgdGhlIGNvbXBhbnkgd2l0aCBhY2Nlc3MgdG8gdGhpcyBjb2RlLiAgU28gd2UgY2FuIG9u
bHkgcHJldmVudCB0aGlzIHNjZW5hcmlvIGJ5IHJ1bm5pbmcgR2l0TGFiIGluIG91ciBlbnZpcm9u
bWVudCBpbnN0ZWFkIG9mIHJ1bm5pbmcgR2l0SHViIGluIHRoZSBjbG91ZD8gIFdvdWxkIHJlbW92
aW5nIGEgR2l0SHViIGFjY291bnQgZnJvbSB0aGUgR2l0SHViIHJlcG9zaXRvcnkgcHJldmVudCB0
aGVtIGZyb20gYWNjZXNzaW5nIHRoZSBjb2RlIG9uIHRoZWlyIFBDPw0KPiA+DQo+ID4gSG93IGRv
IHlvdSBwcmV2ZW50IHByaXZhdGUgR2l0SHViIHJlcG9zaXRvcmllcyBmcm9tIGJlaW5nIHB1bGxl
ZCBkb3duIHRvIHVuYXV0aG9yaXplZCBQQ3M/DQo+IA0KPiBwb2xpY3ksIHlvdSBzYXkgdGhhdCBp
dCdzIGFnYWluc3QgcG9saWN5IGZvciBzb21lb25lIHRvIHB1dCBjb21wYW55IGluZm8gb24gYSBw
ZXJzb25hbCBtYWNoaW5lLg0KPiANCj4gWW91IHByb2JhYmx5IHJ1biB5b3VyIG93biByZXBvc2l0
b3J5IHRoYXQncyBvbmx5IGF2YWlsYWJsZSB3aXRoaW4geW91ciANCj4gbmV0d29yayAob3Igb3Zl
ciB5b3VyIFZQTikgcmF0aGVyIHRoYW4gdXNpbmcgYSBjbG91ZCBzZXJ2aWNlIGxpa2UgDQo+IGdp
dGh1YiAoeW91IG1heSB3YW50IHRvIGNoZWNrIHdpdGggZ2l0aHViIHRvIHNlZSBpZiB0aGV5IGNh
biBsb2NrIGRvd24gDQo+IGEgcHJpdmF0ZSByZXBvIHRvIG9ubHkgYmUgYWNjZXNzZWQgZnJvbSBz
cGVjaWZpYyBJUCBhZGRyZXNzZXMpDQo+IA0KPiB5b3Ugd2lsbCBhbHNvIG5lZWQgdG8gbWFrZSBz
dXJlIHRoYXQgcGVvcGxlIGRvbid0IHBsdWcgcGVyc29uYWwgbGFwdG9wcyBpbnRvIHlvdXIgY29y
cG9yYXRlIG5ldHdvcmssIGFuZCB0aGF0IHRoZXkgZG9uJ3QgdXNlIHBlcnNvbmFsIHBob25lcyB0
byBhY2Nlc3MgY29tcGFueSBlLW1haWwuDQo+IA0KPiBUaGUgYm90dG9tIGxpbmUgaXMgdGhhdCBp
dCdzIG5vIGRpZmZlcmVudCBmcm9tIHByZXZlbnRpbmcgdGhlbSBmcm9tIGhhdmluZyBhY2Nlc3Mg
dG8gYW55IG90aGVyIHNlbnNpdGl2ZSBkYXRhIGluIHlvdXIgY29tcGFueS4gV2hhdCBtZWFzdXJl
cyBkbyB5b3UgaGF2ZSBpbiBwbGFjZSB0byBrZWVwIHRoZW0gZnJvbSB0YWtpbmcgc2Vuc2l0aXZl
IFdvcmQgRG9jcyBvciBzcHJlYWRzaGVldHMgd2hlbiB0aGV5IGxlYXZlPyBkbyB0aGUgc2FtZSB0
aGluZyB0byBkZWFsIHdpdGggdGhlaXIgYWNjZXNzIHRvIGNvZGUuDQo+IA0KPiBEYXZpZCBMYW5n
DQo+IA0KPiA+IFRoYW5rcywNCj4gPiBCcmlhbg0KPiA+DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPg0KPiA+IE9uIFdlZCwgMjQgSnVuIDIwMTUgMTg6MTg6MDAgKzAwMDANCj4g
PiBCR2F1ZHJlYXVsdCBCcmlhbiA8QkdhdWRyZWF1bHRAZWRybmV0LmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPj4gSWYgc29tZW9uZSBkb3dubG9hZHMgY29kZSB0byB0aGVpciBub3RlYm9vayBQQyBhbmQg
bGVhdmVzIHRoZSANCj4gPj4gY29tcGFueSwgd2hhdCBwcm90ZWN0aW9uIGRvIHdlIGhhdmUgYWdh
aW5zdCB0aGVtIG5vdCBiZWluZyBhYmxlIHRvIA0KPiA+PiBhY2Nlc3MgdGhlIGxvY2FsIGNvZGUg
Y29weSBhbnltb3JlPw0KPiA+DQo+ID4gV2hhdCBkbyB5b3UgbWVhbiBieSAibG9jYWwgY29kZSI/
DQo+ID4gVGhhdCBvbmUgd2hpY2ggaXMgb24gdGhlIG5vdGVib29rPw0KPiA+IFRoZW4geW91IGNh
biBkbyBsaXRlcmFsbHkgbm90aGluZyBleGNlcHQgZm9yIG5vdCBhbGxvd2luZyBjbG9uaW5nIHlv
dXIgR2l0IHJlcG9zaXRvcmllcyBvbnRvIHJhbmRvbSBjb21wdXRlcnMgaW4gdGhlIGZpcnN0IHBs
YWNlLg0KPiA+DQo+ID4gSWYgeW91IGluc3RlYWQgbWVhbiB0aGUgY29weSBvZiBjb2RlIGF2YWls
YWJsZSBpbiB0aGUgcmVwb3NpdG9yaWVzIGhvc3RlZCBpbiB5b3VyIGVudGVycHJpc2UgdGhlbiBh
bGwgeW91IG5lZWQgdG8gZG8gaXMgdG8gc29tZWhvdyB0ZXJtaW5hdGUgdGhlIGFjY2VzcyBvZiB0
aGF0IGVtcGxveWVlIHdobydzIGxlZnQgdG8gdGhvc2UgcmVwb3NpdG9yaWVzLg0KPiA+IChUaGlz
IGFzc3VtZXMgdGhleSdyZSBhY2Nlc3NpYmxlIGZyb20gdGhlIG91dHNpZGU7IGlmIHRoZXkgYXJl
bid0LCANCj4gPiB0aGUgcHJvYmxlbSBzaW1wbHkgZG8gbm90IGV4aXN0LikNCj4gPiAtLQ0KPiA+
IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmli
ZSBnaXQiIGluIA0KPiA+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5r
ZXJuZWwub3JnIE1vcmUgbWFqb3Jkb21vIA0KPiA+IGluZm8gYXQgaHR0cDovL3ZnZXIua2VybmVs
Lm9yZy9tYWpvcmRvbW8taW5mby5odG1sDQo+ID4NCg0KDQo=
