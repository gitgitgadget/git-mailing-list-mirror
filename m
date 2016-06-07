From: <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH 1/4] diff.h: extend "flags" field to 64 bits because
 we're out of bits
Date: Tue, 7 Jun 2016 06:40:41 +0000
Message-ID: <40fabe80-7e68-bb9a-4b3d-c88c598cc5b8@atlas-elektronik.com>
References: <20160606111643.7122-1-pclouds@gmail.com>
 <20160606111643.7122-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <thomas.braun@virtuell-zuhause.de>
To: <pclouds@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 08:51:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAArK-0002xy-La
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 08:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbcFGGvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 02:51:16 -0400
Received: from mail95.atlas.de ([194.156.172.85]:2339 "EHLO mail95.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752AbcFGGvP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 02:51:15 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jun 2016 02:51:14 EDT
X-IPAS-Result: =?us-ascii?q?A2CkBAAbbFZX/wXKxApcHAEBhB9SBq5iiWuECIYTAhyBWxA?=
 =?us-ascii?q?BAQEBAQEBgQyERgEBAwEjBA1ABQULAgEIGgImAgICHwsGFRACBAEMAQUCAQEUh?=
 =?us-ascii?q?30DD6oPjRMNhAwBAQEBAQEBAQIBAQEBAQEBAR+BAYcdglaCQ4F9F4JqglkFiAW?=
 =?us-ascii?q?FYYovNIwsizqFX4dxh2s1giYcFoE1bokQfwEBAQ?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW101FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 07 Jun 2016 08:41:08 +0200
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
	id 3rP25c068mz2yWPG; Tue,  7 Jun 2016 06:40:45 +0000 (UTC)
Received: from MGW201PAR.atlas.de (unknown [10.206.101.60])
	by SCESRV02.atlas.de (Postfix) with ESMTPS id 3rP2586rYpz2MGjL
	for <git@vger.kernel.org>; Tue,  7 Jun 2016 06:40:44 +0000 (UTC)
Received: from msexsrv3.atlas.de ([10.200.102.58])
  by MGW201DAT.atlas.de with ESMTP/TLS/AES128-SHA; 07 Jun 2016 08:40:44 +0200
Received: from MSEXSRV5.atlas.de ([169.254.3.175]) by MSEXSRV3.atlas.de
 ([10.200.102.58]) with mapi id 14.03.0248.002; Tue, 7 Jun 2016 08:40:45 +0200
Thread-Topic: [PATCH 1/4] diff.h: extend "flags" field to 64 bits because
 we're out of bits
Thread-Index: AQHRv+T9dIE5+kkwAkegsbj3WeK/Xp/dbbOA
In-Reply-To: <20160606111643.7122-2-pclouds@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
x-originating-ip: [10.200.54.122]
Content-ID: <934BA6B758F1284C81ECF7A35773BD60@atlas.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296604>

QW0gMDYuMDYuMjAxNiB1bSAxMzoxNiBzY2hyaWViIE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXk6
DQo+IEN1cnJlbnQgZmxhZ3MgZmllbGQgaXMgMzItYml0cywgYWxsIHVzZWQgZXhjZXB0IG9uZSBi
aXQgYW5kIHdlIG5lZWQgb25lDQo+IG1vcmUgYml0IGlzIG5lZWRlZCBmb3IgdG8gdG9nZ2xlIGkt
dC1hIGJlaGF2aW9yLiBUaGUgOXRoIGJpdCBjb3VsZCBiZQ0KDQpTb21ldGhpbmcncyB3cm9uZyBo
ZXJlLiBFaXRoZXIgZHJvcCB0aGUgImlzIG5lZWRlZCIgb3IgdGhlICJ3ZSBuZWVkIi4NCg0KPiBy
ZXVzZWQgZm9yIHRoaXMsIGJ1dCB3ZSBjb3VsZCBqdXN0IGV4dGVuZCBpdCB0byA2NCBiaXRzIG5v
dyB0byBnaXZlIHJvb20NCj4gZm9yIG1vcmUgZnV0dXJlIGZsYWdzLg0KPiANCj4gZ2NjIC1XY29u
dmVyc2lvbiBpcyB1c2VkIHRvIGNhdGNoIGFzc2lnbm1lbnRzIHRoYXQgdHJ1bmNhdGUgYml0cy4g
Tm8gbmV3DQo+IHdhcm5pbmcgd2FzIGludHJvZHVjZWQgKGluIGZhY3Qgb25lIGluIGluZGV4X2Rp
ZmZlcnNfZnJvbSgpIHdhcw0KPiBlbGltaW5hdGVkKSwNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5n
dXnhu4VuIFRow6FpIE5n4buNYyBEdXkgPHBjbG91ZHNAZ21haWwuY29tPg0KPiAtLS0NCj4gIGJ1
aWx0aW4vY29tbWl0LmMgfCAyICstDQo+ICBkaWZmLWxpYi5jICAgICAgIHwgNCArKy0tDQo+ICBk
aWZmLmMgICAgICAgICAgIHwgMiArLQ0KPiAgZGlmZi5oICAgICAgICAgICB8IDYgKysrLS0tDQo+
ICA0IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9idWlsdGluL2NvbW1pdC5jIGIvYnVpbHRpbi9jb21taXQuYw0KPiBpbmRl
eCA0NDNmZjkxLi5mY2ZhYTJiIDEwMDY0NA0KPiAtLS0gYS9idWlsdGluL2NvbW1pdC5jDQo+ICsr
KyBiL2J1aWx0aW4vY29tbWl0LmMNCj4gQEAgLTkwNiw3ICs5MDYsNyBAQCBzdGF0aWMgaW50IHBy
ZXBhcmVfdG9fY29tbWl0KGNvbnN0IGNoYXIgKmluZGV4X2ZpbGUsIGNvbnN0IGNoYXIgKnByZWZp
eCwNCj4gIAkJCSAqIHN1Ym1vZHVsZXMgd2hpY2ggd2VyZSBtYW51YWxseSBzdGFnZWQsIHdoaWNo
IHdvdWxkDQo+ICAJCQkgKiBiZSByZWFsbHkgY29uZnVzaW5nLg0KPiAgCQkJICovDQo+IC0JCQlp
bnQgZGlmZl9mbGFncyA9IERJRkZfT1BUX09WRVJSSURFX1NVQk1PRFVMRV9DT05GSUc7DQo+ICsJ
CQl1aW50NjRfdCBkaWZmX2ZsYWdzID0gRElGRl9PUFRfT1ZFUlJJREVfU1VCTU9EVUxFX0NPTkZJ
RzsNCj4gIAkJCWlmIChpZ25vcmVfc3VibW9kdWxlX2FyZyAmJg0KPiAgCQkJICAgICFzdHJjbXAo
aWdub3JlX3N1Ym1vZHVsZV9hcmcsICJhbGwiKSkNCj4gIAkJCQlkaWZmX2ZsYWdzIHw9IERJRkZf
T1BUX0lHTk9SRV9TVUJNT0RVTEVTOw0KPiBkaWZmIC0tZ2l0IGEvZGlmZi1saWIuYyBiL2RpZmYt
bGliLmMNCj4gaW5kZXggYmM0OWM3MC4uMjc4ODdkMCAxMDA2NDQNCj4gLS0tIGEvZGlmZi1saWIu
Yw0KPiArKysgYi9kaWZmLWxpYi5jDQo+IEBAIC03MSw3ICs3MSw3IEBAIHN0YXRpYyBpbnQgbWF0
Y2hfc3RhdF93aXRoX3N1Ym1vZHVsZShzdHJ1Y3QgZGlmZl9vcHRpb25zICpkaWZmb3B0LA0KPiAg
ew0KPiAgCWludCBjaGFuZ2VkID0gY2VfbWF0Y2hfc3RhdChjZSwgc3QsIGNlX29wdGlvbik7DQo+
ICAJaWYgKFNfSVNHSVRMSU5LKGNlLT5jZV9tb2RlKSkgew0KPiAtCQl1bnNpZ25lZCBvcmlnX2Zs
YWdzID0gZGlmZm9wdC0+ZmxhZ3M7DQo+ICsJCXVpbnQ2NF90IG9yaWdfZmxhZ3MgPSBkaWZmb3B0
LT5mbGFnczsNCj4gIAkJaWYgKCFESUZGX09QVF9UU1QoZGlmZm9wdCwgT1ZFUlJJREVfU1VCTU9E
VUxFX0NPTkZJRykpDQo+ICAJCQlzZXRfZGlmZm9wdF9mbGFnc19mcm9tX3N1Ym1vZHVsZV9jb25m
aWcoZGlmZm9wdCwgY2UtPm5hbWUpOw0KPiAgCQlpZiAoRElGRl9PUFRfVFNUKGRpZmZvcHQsIElH
Tk9SRV9TVUJNT0RVTEVTKSkNCj4gQEAgLTUxNiw3ICs1MTYsNyBAQCBpbnQgZG9fZGlmZl9jYWNo
ZShjb25zdCB1bnNpZ25lZCBjaGFyICp0cmVlX3NoYTEsIHN0cnVjdCBkaWZmX29wdGlvbnMgKm9w
dCkNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAtaW50IGluZGV4X2RpZmZlcnNfZnJvbShj
b25zdCBjaGFyICpkZWYsIGludCBkaWZmX2ZsYWdzKQ0KPiAraW50IGluZGV4X2RpZmZlcnNfZnJv
bShjb25zdCBjaGFyICpkZWYsIHVpbnQ2NF90IGRpZmZfZmxhZ3MpDQo+ICB7DQo+ICAJc3RydWN0
IHJldl9pbmZvIHJldjsNCj4gIAlzdHJ1Y3Qgc2V0dXBfcmV2aXNpb25fb3B0IG9wdDsNCj4gZGlm
ZiAtLWdpdCBhL2RpZmYuYyBiL2RpZmYuYw0KPiBpbmRleCBkMzczNGQzLi5mNzA0MjVmIDEwMDY0
NA0KPiAtLS0gYS9kaWZmLmMNCj4gKysrIGIvZGlmZi5jDQo+IEBAIC00OTM2LDcgKzQ5MzYsNyBA
QCBpbnQgZGlmZl9jYW5fcXVpdF9lYXJseShzdHJ1Y3QgZGlmZl9vcHRpb25zICpvcHQpDQo+ICBz
dGF0aWMgaW50IGlzX3N1Ym1vZHVsZV9pZ25vcmVkKGNvbnN0IGNoYXIgKnBhdGgsIHN0cnVjdCBk
aWZmX29wdGlvbnMgKm9wdGlvbnMpDQo+ICB7DQo+ICAJaW50IGlnbm9yZWQgPSAwOw0KPiAtCXVu
c2lnbmVkIG9yaWdfZmxhZ3MgPSBvcHRpb25zLT5mbGFnczsNCj4gKwl1aW50NjRfdCBvcmlnX2Zs
YWdzID0gb3B0aW9ucy0+ZmxhZ3M7DQo+ICAJaWYgKCFESUZGX09QVF9UU1Qob3B0aW9ucywgT1ZF
UlJJREVfU1VCTU9EVUxFX0NPTkZJRykpDQo+ICAJCXNldF9kaWZmb3B0X2ZsYWdzX2Zyb21fc3Vi
bW9kdWxlX2NvbmZpZyhvcHRpb25zLCBwYXRoKTsNCj4gIAlpZiAoRElGRl9PUFRfVFNUKG9wdGlv
bnMsIElHTk9SRV9TVUJNT0RVTEVTKSkNCj4gZGlmZiAtLWdpdCBhL2RpZmYuaCBiL2RpZmYuaA0K
PiBpbmRleCAxMjU0NDdiLi5iNDk3MDc4IDEwMDY0NA0KPiAtLS0gYS9kaWZmLmgNCj4gKysrIGIv
ZGlmZi5oDQo+IEBAIC0xMTUsOCArMTE1LDggQEAgc3RydWN0IGRpZmZfb3B0aW9ucyB7DQo+ICAJ
Y29uc3QgY2hhciAqcGlja2F4ZTsNCj4gIAljb25zdCBjaGFyICpzaW5nbGVfZm9sbG93Ow0KPiAg
CWNvbnN0IGNoYXIgKmFfcHJlZml4LCAqYl9wcmVmaXg7DQo+IC0JdW5zaWduZWQgZmxhZ3M7DQo+
IC0JdW5zaWduZWQgdG91Y2hlZF9mbGFnczsNCj4gKwl1aW50NjRfdCBmbGFnczsNCj4gKwl1aW50
NjRfdCB0b3VjaGVkX2ZsYWdzOw0KPiAgDQo+ICAJLyogZGlmZi1maWx0ZXIgYml0cyAqLw0KPiAg
CXVuc2lnbmVkIGludCBmaWx0ZXI7DQo+IEBAIC0zNDgsNyArMzQ4LDcgQEAgZXh0ZXJuIGludCBk
aWZmX3Jlc3VsdF9jb2RlKHN0cnVjdCBkaWZmX29wdGlvbnMgKiwgaW50KTsNCj4gIA0KPiAgZXh0
ZXJuIHZvaWQgZGlmZl9ub19pbmRleChzdHJ1Y3QgcmV2X2luZm8gKiwgaW50LCBjb25zdCBjaGFy
ICoqKTsNCj4gIA0KPiAtZXh0ZXJuIGludCBpbmRleF9kaWZmZXJzX2Zyb20oY29uc3QgY2hhciAq
ZGVmLCBpbnQgZGlmZl9mbGFncyk7DQo+ICtleHRlcm4gaW50IGluZGV4X2RpZmZlcnNfZnJvbShj
b25zdCBjaGFyICpkZWYsIHVpbnQ2NF90IGRpZmZfZmxhZ3MpOw0KPiAgDQo+ICAvKg0KPiAgICog
RmlsbCB0aGUgY29udGVudHMgb2YgdGhlIGZpbGVzcGVjICJkZiIsIHJlc3BlY3RpbmcgYW55IHRl
eHRjb252IGRlZmluZWQgYnkNCj4gDQoNClN0ZWZhbg0KLS0gDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQovZGV2L3JhbmRv
bSBzYXlzOiBNYWtlIEhlYWRsaW5lcy4udXNlIGEgY29yZHVyb3kgcGlsbG93Li4uLg0KcHl0aG9u
IC1jICJwcmludCAnNzM3NDY1NjY2MTZlMmU2ZTYxNjU3NzY1NDA2MTc0NmM2MTczMmQ2NTZjNjU2
Yjc0NzI2ZjZlNjk2YjJlNjM2ZjZkJy5kZWNvZGUoJ2hleCcpIiANCkdQRyBLZXkgZmluZ2VycHJp
bnQgPSAyREY1IEUwMUIgMDlDMyA3NTAxIEJDQTkgIDk2NjYgODI5QiA0OUM1IDkyMjEgMjdBRg==
