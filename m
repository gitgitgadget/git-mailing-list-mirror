From: <stefan.naewe@atlas-elektronik.com>
Subject: Re: Bug: Incorrect stripping of the [PATCH] prefix in git-am
Date: Wed, 25 Nov 2015 16:44:21 +0100
Message-ID: <5655D755.8060503@atlas-elektronik.com>
References: <5655D3DA.1050403@informatik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: <nathanael.huebbe@informatik.uni-hamburg.de>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 25 16:44:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1cFT-0003V0-T8
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 16:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbbKYPoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 10:44:46 -0500
Received: from mail96.atlas.de ([194.156.172.86]:13808 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbbKYPop (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 10:44:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 786C410900;
	Wed, 25 Nov 2015 16:44:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3FguoPbOtDnu; Wed, 25 Nov 2015 16:44:32 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed, 25 Nov 2015 16:44:32 +0100 (CET)
Received: from MSEXSRV1.atlas.de (webmail.atlas.de [10.200.102.56])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 6C8AD27169;
	Wed, 25 Nov 2015 16:44:32 +0100 (CET)
Received: from MSSRVS1.atlas.de (10.200.101.71) by MSEXSRV1.atlas.de
 (10.200.102.56) with Microsoft SMTP Server (TLS) id 14.3.248.2; Wed, 25 Nov
 2015 16:44:21 +0100
Received: from MSSRVS4.atlas.de ([10.200.97.74]) by MSSRVS1.atlas.de
 ([10.200.101.71]) with mapi; Wed, 25 Nov 2015 16:44:23 +0100
Thread-Topic: Bug: Incorrect stripping of the [PATCH] prefix in git-am
Thread-Index: AdEnmCd3Vu8L0kChSfqUWSxSy2i9zA==
In-Reply-To: <5655D3DA.1050403@informatik.uni-hamburg.de>
Accept-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
acceptlanguage: de-DE
X-C2ProcessedOrg: 8e578ea2-b414-4638-aa54-659db1be7428
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281716>

QW0gMjUuMTEuMjAxNSB1bSAxNjoyOSBzY2hyaWViIGh1ZWJiZToNCj4gRGVzY3JpcHRpb246DQo+
IA0KPiBXaGVuIGFwcGx5aW5nIGEgcGF0Y2ggY3JlYXRlZCB2aWEgYGdpdCBmb3JtYXQtcGF0Y2hg
IHdpdGggYGdpdCBhbWAsDQo+IGFueSBwcmVmaXggb2YgdGhlIGNvbW1pdCBtZXNzYWdlIHRoYXQn
cyB3aXRoaW4gc3F1YXJlIGJyYWNrZXRzIGlzIHN0cmlwcGVkIGZyb20gdGhlIGNvbW1pdCBtZXNz
YWdlLg0KDQpBcyBhZHZlcnRpc2VkIGluIHRoZSBtYW4gcGFnZSBvZiAnZ2l0IGFtJyAob3IgJ2dp
dCBtYWlsaW5mbycgdGhhdCBpcykuDQoNCklzICdnaXQgYW0gLS1rZWVwLW5vbi1wYXRjaCcgd2hh
dCB5b3UncmUgbG9va2luZyBmb3IgPw0KDQo+IA0KPiANCj4gUmVwcm9kdWN0aW9uOg0KPiANCj4g
ICAgICQgZ2l0IGxvZyAtLW9uZWxpbmUgLS1kZWNvcmF0ZSAtLWdyYXBoIC0tYWxsDQo+ICAgICAq
IGI0MTUxNGIgKEhFQUQpIFtiYXpdIGJheg0KPiAgICAgfCAqIDVlMzE3NDAgKG1hc3RlcikgW2Jh
cl0gYmFyDQo+ICAgICB8Lw0KPiAgICAgKiBhYWY1ZDM0IFtmb29dIGZvbw0KPiAgICAgJCBnaXQg
Zm9ybWF0LXBhdGNoIGFhZjVkMzQNCj4gICAgICQgZ2l0IGNoZWNrb3V0IG1hc3Rlcg0KPiAgICAg
JCBnaXQgYW0gMDAwMS1iYXotYmF6LnBhdGNoDQo+ICAgICAkIGdpdCBsb2cgLS1vbmVsaW5lIC0t
ZGVjb3JhdGUgLS1ncmFwaCAtLWFsbA0KPiAgICAgKiBkNTE2MWI4IChIRUFELCBtYXN0ZXIpIGJh
eg0KPiAgICAgKiA1ZTMxNzQwIFtiYXJdIGJhcg0KPiAgICAgKiBhYWY1ZDM0IFtmb29dIGZvbw0K
PiANCj4gSSBoYXZlIG9taXR0ZWQgYWxsIG91dHB1dCBleGNlcHQgZm9yIHRoZSBgZ2l0IGxvZ2Ag
b3V0cHV0IGZvciBicmV2aXR5Lg0KPiBBcyB5b3UgY2FuIHNlZSwgdGhlIGNvbW1pdCByZXN1bHRp
bmcgZnJvbSBgZ2l0IGFtYCBoYXMgbG9zdCB0aGUgIltiYXJdIiBwcmVmaXggZnJvbSBpdHMgY29t
bWl0IG1lc3NhZ2UuDQo+IA0KPiBMb29raW5nIGF0IHRoZSBwYXRjaCwNCj4gDQo+ICAgICAkIGNh
dCAwMDAxLWJhei1iYXoucGF0Y2gNCj4gICAgIEZyb20gYjQxNTE0YmU4YTcwZmQ0NDA1MmJmZjBk
M2NlNzIwMzczZWM5Y2ZkOCBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gICAgIEZyb206IE5h
dGhhbmFlbCBIdWViYmUgPG5hdGhhbmFlbC5odWViYmVAaW5mb3JtYXRpay51bmktaGFtYnVyZy5k
ZT4NCj4gICAgIERhdGU6IFdlZCwgMjUgTm92IDIwMTUgMTU6Mjg6MDkgKzAxMDANCj4gICAgIFN1
YmplY3Q6IFtQQVRDSF0gW2Jhel0gYmF6DQo+IA0KPiAgICAgLS0tDQo+ICAgICAgYmF6IHwgMSAr
DQo+ICAgICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ICAgICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGJheg0KPiANCj4gICAgIGRpZmYgLS1naXQgYS9iYXogYi9iYXoNCj4gICAgIG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ICAgICBpbmRleCAwMDAwMDAwLi43NjAxODA3DQo+ICAgICAt
LS0gL2Rldi9udWxsDQo+ICAgICArKysgYi9iYXoNCj4gICAgIEBAIC0wLDAgKzEgQEANCj4gICAg
ICtiYXoNCj4gICAgIC0tDQo+ICAgICAyLjEuNA0KPiANCj4gSSBzZWUgdGhhdCB0aGUgY29tbWl0
IG1lc3NhZ2UgY29udGFpbnMgdGhlICJbUEFUQ0hdIi1wcmVmaXggdGhhdCBgZ2l0IGFtYCBpcyBz
dXBwb3NlZCB0byBzdHJpcCwNCj4geWV0IGl0IHNlZW1zIHRvIGluY29ycmVjdGx5IGNvbnRpbnVl
IHRvIGFsc28gc3RyaXAgdGhlICJbYmF6XSItcHJlZml4Lg0KPiANCj4gDQo+IEFmZmVjdGVkIHZl
cnNpb25zOg0KPiBJIGhhdmUgcmVwcm9kdWNlZCB0aGUgYnVnIHdpdGggdmVyc2lvbnMgMS45LjEs
IDIuMS40LCBhbmQgMi42LjMNCj4gDQo+IA0KPiBTZXZlcml0eToNCj4gV2hpbGUgSSBkbyBub3Qg
Y29uc2lkZXIgdGhpcyBhIGhpZ2ggcHJpb3JpdHkgYnVnLCBpdCBiZWNvbWVzIHF1aXRlIGlya3Nv
bWUgaW4gc29tZSB3b3JrZmxvd3MuDQo+IEluIG15IGNhc2UsIGFuIHVwc3RyZWFtIGBzdm5gIHJl
cG9zaXRvcnkgaGFzIHRoZSBwb2xpY3kgb2YgdXNpbmcgIlticmFuY2gtbmFtZV0iIHByZWZpeGVz
DQo+IHRvIHRoZSBjb21taXQgbWVzc2FnZXMsIHdoaWNoIGFyZSBzdHJpcHBlZCB3aGVuZXZlciBJ
IHRyYW5zcGxhbnQgYSBjb21taXQgdXNpbmcgdGhlDQo+IGBnaXQgZm9ybWF0LXBhdGNoYC9gZ2l0
IGFtYCBjb21iaW5hdGlvbi4NCj4gDQo+IA0KPiANCg0KSFRILA0KICBTdGVmYW4NCi0tIA0KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KL2Rldi9yYW5kb20gc2F5czogT3h5bW9yb246IFNsb3cgc3BlZWQuDQpweXRob24gLWMg
InByaW50ICc3Mzc0NjU2NjYxNmUyZTZlNjE2NTc3NjU0MDYxNzQ2YzYxNzMyZDY1NmM2NTZiNzQ3
MjZmNmU2OTZiMmU2MzZmNmQnLmRlY29kZSgnaGV4JykiIA0KR1BHIEtleSBmaW5nZXJwcmludCA9
IDJERjUgRTAxQiAwOUMzIDc1MDEgQkNBOSAgOTY2NiA4MjlCIDQ5QzUgOTIyMSAyN0FGDQo=
