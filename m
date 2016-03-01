From: <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH v2] Mark win32's pthread_exit() as NORETURN
Date: Tue, 1 Mar 2016 15:38:13 +0100
Message-ID: <56D5A955.8010904@atlas-elektronik.com>
References: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de>
 <d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <git@vger.kernel.org>, <peff@peff.net>, <tboegi@web.de>
To: <johannes.schindelin@gmx.de>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 15:46:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aalZ1-0001Lh-8L
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 15:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbcCAOqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 09:46:10 -0500
Received: from mail96.atlas.de ([194.156.172.86]:27464 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568AbcCAOqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 09:46:08 -0500
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Mar 2016 09:46:08 EST
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 7FEDB10158;
	Tue,  1 Mar 2016 15:38:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TYD4MfgnaapW; Tue,  1 Mar 2016 15:38:16 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Tue,  1 Mar 2016 15:38:15 +0100 (CET)
Received: from MSEXSRV1.atlas.de (msexsrv1.atlas.de [10.200.102.56])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 1DC872716A;
	Tue,  1 Mar 2016 15:38:14 +0100 (CET)
Received: from MSSRVS1.atlas.de (10.200.101.71) by MSEXSRV1.atlas.de
 (10.200.102.56) with Microsoft SMTP Server (TLS) id 14.3.248.2; Tue, 1 Mar
 2016 15:38:14 +0100
Received: from MSSRVS4.atlas.de ([10.200.97.74]) by MSSRVS1.atlas.de
 ([10.200.101.71]) with mapi; Tue, 1 Mar 2016 15:38:14 +0100
Thread-Topic: [PATCH v2] Mark win32's pthread_exit() as NORETURN
Thread-Index: AdFzx/vj40B1lwemTyCQxitx1u0/SA==
In-Reply-To: <d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de>
Accept-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
acceptlanguage: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288028>

QW0gMDEuMDMuMjAxNiB1bSAxNToxMyBzY2hyaWViIEpvaGFubmVzIFNjaGluZGVsaW46DQo+IFRo
ZSBwdGhyZWFkX2V4aXQoKSBmdW5jdGlvbiBpcyBub3QgZXhwZWN0ZWQgdG8gcmV0dXJuLiBFdmVy
LiBPbiBXaW5kb3dzLA0KPiB3ZSBjYWxsIEV4aXRUaHJlYWQoKSB3aG9zZSBkb2N1bWVudGF0aW9u
IGNsYWltczogIlRoaXMgZnVuY3Rpb24gZG9lcyBub3QNCj4gcmV0dXJuIGEgdmFsdWUuIjoNCg0K
RG9lcyB0aGlzIHJlYWxseSBtZWFuIHRoYXQgRXhpdFRocmVhZCgpIGRvZXMgbm90IHJldHVybiA/
DQoNCkp1c3Qgd29uZGVyaW5nLi4uDQoNCj4gICAgICAgICBodHRwczovL21zZG4ubWljcm9zb2Z0
LmNvbS9lbi11cy9saWJyYXJ5L3dpbmRvd3MvZGVza3RvcC9tczY4MjY1OQ0KPiANCj4gUG9pbnRl
ZCBvdXQgYnkgSmVmZiBLaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgU2NoaW5k
ZWxpbiA8am9oYW5uZXMuc2NoaW5kZWxpbkBnbXguZGU+DQo+IC0tLQ0KPiANCj4gICAgICAgICBS
ZWxhdGl2ZSB0byB2MSwgb25seSB0aGUgY29tbWl0IG1lc3NhZ2UgY2hhbmdlZCAodG8gY2xhcmlm
eSB0aGF0DQo+ICAgICAgICAgRXhpdFRocmVhZCgpIGluZGVlZCBuZXZlciByZXR1cm5zKS4NCj4g
DQo+ICBjb21wYXQvd2luMzIvcHRocmVhZC5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29tcGF0L3dp
bjMyL3B0aHJlYWQuaCBiL2NvbXBhdC93aW4zMi9wdGhyZWFkLmgNCj4gaW5kZXggMjBiMzVhMi4u
MTQ4ZGI2MCAxMDA2NDQNCj4gLS0tIGEvY29tcGF0L3dpbjMyL3B0aHJlYWQuaA0KPiArKysgYi9j
b21wYXQvd2luMzIvcHRocmVhZC5oDQo+IEBAIC03OCw3ICs3OCw3IEBAIGV4dGVybiBpbnQgd2lu
MzJfcHRocmVhZF9qb2luKHB0aHJlYWRfdCAqdGhyZWFkLCB2b2lkICoqdmFsdWVfcHRyKTsNCj4g
ICNkZWZpbmUgcHRocmVhZF9lcXVhbCh0MSwgdDIpICgodDEpLnRpZCA9PSAodDIpLnRpZCkNCj4g
IGV4dGVybiBwdGhyZWFkX3QgcHRocmVhZF9zZWxmKHZvaWQpOw0KPiANCj4gLXN0YXRpYyBpbmxp
bmUgaW50IHB0aHJlYWRfZXhpdCh2b2lkICpyZXQpDQo+ICtzdGF0aWMgaW5saW5lIGludCBOT1JF
VFVSTiBwdGhyZWFkX2V4aXQodm9pZCAqcmV0KQ0KPiAgew0KPiAgICAgICAgIEV4aXRUaHJlYWQo
KERXT1JEKShpbnRwdHJfdClyZXQpOw0KPiAgfQ0KPiAtLQ0KDQoNClN0ZWZhbg0KLS0gDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQovZGV2L3JhbmRvbSBzYXlzOiBXZSdyZSBsb3N0LCBidXQgd2UncmUgbWFraW5nIGdvb2Qg
dGltZS4NCnB5dGhvbiAtYyAicHJpbnQgJzczNzQ2NTY2NjE2ZTJlNmU2MTY1Nzc2NTQwNjE3NDZj
NjE3MzJkNjU2YzY1NmI3NDcyNmY2ZTY5NmIyZTYzNmY2ZCcuZGVjb2RlKCdoZXgnKSIgDQpHUEcg
S2V5IGZpbmdlcnByaW50ID0gMkRGNSBFMDFCIDA5QzMgNzUwMSBCQ0E5ICA5NjY2IDgyOUIgNDlD
NSA5MjIxIDI3QUYNCg==
