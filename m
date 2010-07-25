From: <lynn.lin@emc.com>
Subject: RE: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 08:21:55 -0400
Message-ID: <7F48A44C0E1FBF48B00D4DA49C85432E54F99F@CORPUSMX100A.corp.emc.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com><AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com><4C4BFAA3.3050700@digium.com><7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com><AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com><7F48A44C0E1FBF48B00D4DA49C85432E54F99A@CORPUSMX100A.corp.emc.com><AANLkTilhoF670uZ1WbosZP9TNbXect2A3gELRJL0ZZIn@mail.gmail.com><m2d3ubojfr.fsf@igel.home> <AANLkTilK_8wVQG6s8pUrscwd7ZnvgGyjOjJP41uXYfEl@mail.gmail.com> <7F48A44C0E1FBF48B00D4DA49C85432E54F99D@CORPUSMX100A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <kpfleming@digium.com>, <git@vger.kernel.org>
To: <lynn.lin@emc.com>, <avarab@gmail.com>, <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Jul 25 14:22:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od0Dq-0004Wp-0W
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 14:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab0GYMWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 08:22:20 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:25656 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592Ab0GYMWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 08:22:20 -0400
Received: from hop04-l1d11-si01.isus.emc.com (HOP04-L1D11-SI01.isus.emc.com [10.254.111.54])
	by mexforward.lss.emc.com (Switch-3.3.2/Switch-3.1.7) with ESMTP id o6PCM5Pf015268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 Jul 2010 08:22:05 -0400
Received: from mailhub.lss.emc.com (nagas.lss.emc.com [10.254.144.15]) by hop04-l1d11-si01.isus.emc.com (RSA Interceptor); Sun, 25 Jul 2010 08:21:58 -0400
Received: from corpussmtp3.corp.emc.com (corpussmtp3.corp.emc.com [10.254.169.196])
	by mailhub.lss.emc.com (Switch-3.4.2/Switch-3.3.2mp) with ESMTP id o6PCLv4p011387;
	Sun, 25 Jul 2010 08:21:58 -0400
Received: from CORPUSMX100A.corp.emc.com ([128.222.76.57]) by corpussmtp3.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 25 Jul 2010 08:21:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7F48A44C0E1FBF48B00D4DA49C85432E54F99D@CORPUSMX100A.corp.emc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Makefile: don't include git version file on 'make clean'
Thread-Index: Acsr8xqzkZeOIS0bT1yuDOpY78JtywAAC7yQAAAoFpA=
X-OriginalArrivalTime: 25 Jul 2010 12:21:57.0612 (UTC) FILETIME=[F9AD42C0:01CB2BF3]
X-EMM-EM: Active
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151734>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBnaXQtb3duZXJAdmdlci5rZXJu
ZWwub3JnIFttYWlsdG86Z2l0LW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIGx5
bm4ubGluQGVtYy5jb20NClNlbnQ6IDIwMTDlubQ35pyIMjXml6UgMjA6MTkNClRvOiBhdmFyYWJA
Z21haWwuY29tOyBzY2h3YWJAbGludXgtbTY4ay5vcmcNCkNjOiBrcGZsZW1pbmdAZGlnaXVtLmNv
bTsgZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUkU6IFtQQVRDSF0gTWFrZWZpbGU6IGRv
bid0IGluY2x1ZGUgZ2l0IHZlcnNpb24gZmlsZSBvbiAnbWFrZSBjbGVhbicNCg0KDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiBb
bWFpbHRvOmF2YXJhYkBnbWFpbC5jb21dIA0KU2VudDogMjAxMOW5tDfmnIgyNeaXpSAyMDoxNg0K
VG86IEFuZHJlYXMgU2Nod2FiDQpDYzogTGluLCBMeW5uOyBrcGZsZW1pbmdAZGlnaXVtLmNvbTsg
Z2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gTWFrZWZpbGU6IGRvbid0
IGluY2x1ZGUgZ2l0IHZlcnNpb24gZmlsZSBvbiAnbWFrZSBjbGVhbicNCg0KT24gU3VuLCBKdWwg
MjUsIDIwMTAgYXQgMTI6MDUsIEFuZHJlYXMgU2Nod2FiIDxzY2h3YWJAbGludXgtbTY4ay5vcmc+
IHdyb3RlOg0KPiDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiA8YXZhcmFiQGdtYWlsLmNvbT4g
d3JpdGVzOg0KPg0KPj4gTWFrZWZpbGUgdGFyZ2V0cyBhcmVuJ3QgdHJpZ2dlcmVkIGJ5IHRoZSBp
bmNsdWRlIGRpcmVjdGl2ZS4NCj4NCj4gVW1tLCB5ZXMgdGhleSBhcmUsIHNlZSAobWFrZSkgUmVt
YWtpbmcgTWFrZWZpbGVzLg0KDQpBaCwgeWVzLiBCdXQgaXQgd2FzIGJlaW5nIGluY2x1ZGVkIGlu
IG1vcmUgcGxhY2VzIHRoYW4ganVzdCB0aGF0DQotaW5jbHVkZSBkaXJlY3RpdmUsIHNvIEkgZGlk
bid0IHNwb3QgdGhlIGRpZmZlcmVuY2U6DQoNCldpdGhvdXQgdGhhdCBkaXJlY3RpdmUsIHN0aWxs
IGdlbmVyYXRlZCBvbiBtYWtlIGNsZWFuOg0KDQogICAgJCBnaXQgZGlmZiAtVTAgfCBjYXQNCiAg
ICBkaWZmIC0tZ2l0IGEvR0lULVZFUlNJT04tR0VOIGIvR0lULVZFUlNJT04tR0VODQogICAgaW5k
ZXggZTg4ZjUwYy4uZjI5NDA2YiAxMDA3NTUNCiAgICAtLS0gYS9HSVQtVkVSU0lPTi1HRU4NCiAg
ICArKysgYi9HSVQtVkVSU0lPTi1HRU4NCiAgICBAQCAtMiwwICszLDIgQEANCiAgICArZWNobyBN
T08gPiAvdG1wL21vbw0KICAgICsNCiAgICBkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmls
ZQ0KICAgIGluZGV4IGI2OTc1YWEuLjVlZGZlY2EgMTAwNjQ0DQogICAgLS0tIGEvTWFrZWZpbGUN
CiAgICArKysgYi9NYWtlZmlsZQ0KICAgIEBAIC0yNDEgKzI0MCwwIEBAIEdJVC1WRVJTSU9OLUZJ
TEU6IEZPUkNFDQogICAgLS1pbmNsdWRlIEdJVC1WRVJTSU9OLUZJTEUNCiAgICAkIHJtIC12IC90
bXAvbW9vOyBtYWtlIGNsZWFuID4gL2Rldi9udWxsOyBjYXQgL3RtcC9tb28NCiAgICByZW1vdmVk
IGAvdG1wL21vbycNCiAgICBHSVRfVkVSU0lPTiA9IDEuNy4yLjYuZzY1YTBkMy5kaXJ0eQ0KICAg
IEdJVEdVSV9WRVJTSU9OID0gMC4xMi4wLjY0Lmc4OWQ2MS1kaXJ0eQ0KICAgIE1PTw0KDQpEZWxl
dGVkIHRoZSBydWxlLCBub3QgZ2VuZXJhdGVkLCBidXQgb3RoZXIgdGhpbmdzIGFyZSBzdGlsbCBj
YWxsaW5nDQp0aGUgcnVsZToNCg0KDQpXaHkgbm90IGRlbGV0ZSB0aGUgcnVsZT8gV2Ugb25seSBo
YW5kbGUgdGhpcyBvbiAnbWFrZSBjbGVhbicgY29tbWFuZCAoJ21ha2UgZGlzdGNsZWFuJykgdGFy
Z2V0DQoNCg0KU29ycnkuaXQncyB0eXBvIC5XaHkgZGVsZXRlIHRoZSBydWxlDQoNCg0KDQogICAg
JCBnaXQgZGlmZiAtVTAgfCBjYXQNCiAgICBkaWZmIC0tZ2l0IGEvR0lULVZFUlNJT04tR0VOIGIv
R0lULVZFUlNJT04tR0VODQogICAgaW5kZXggZTg4ZjUwYy4uZjI5NDA2YiAxMDA3NTUNCiAgICAt
LS0gYS9HSVQtVkVSU0lPTi1HRU4NCiAgICArKysgYi9HSVQtVkVSU0lPTi1HRU4NCiAgICBAQCAt
MiwwICszLDIgQEANCiAgICArZWNobyBNT08gPiAvdG1wL21vbw0KICAgICsNCiAgICBkaWZmIC0t
Z2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQ0KICAgIGluZGV4IGI2OTc1YWEuLjFhMTg5ZGEgMTAw
NjQ0DQogICAgLS0tIGEvTWFrZWZpbGUNCiAgICArKysgYi9NYWtlZmlsZQ0KICAgIEBAIC0yMzks
NCArMjM4LDAgQEAgYWxsOjoNCiAgICAtR0lULVZFUlNJT04tRklMRTogRk9SQ0UNCiAgICAtICAg
ICAgIEAkKFNIRUxMX1BBVEgpIC4vR0lULVZFUlNJT04tR0VODQogICAgLS1pbmNsdWRlIEdJVC1W
RVJTSU9OLUZJTEUNCiAgICAtDQogICAgJCBybSAtdiAvdG1wL21vbzsgbWFrZSBjbGVhbiA+IC9k
ZXYvbnVsbDsgY2F0IC90bXAvbW9vDQogICAgcmVtb3ZlZCBgL3RtcC9tb28nDQogICAgbWFrZVsy
XTogKioqIE5vIHJ1bGUgdG8gbWFrZSB0YXJnZXQgYEdJVC1WRVJTSU9OLUZJTEUnLiAgU3RvcC4N
CiAgICBtYWtlWzJdOiAqKiogTm8gcnVsZSB0byBtYWtlIHRhcmdldCBgR0lULVZFUlNJT04tRklM
RScuICBTdG9wLg0KICAgIG1ha2VbMl06ICoqKiBObyBydWxlIHRvIG1ha2UgdGFyZ2V0IGBHSVQt
VkVSU0lPTi1GSUxFJy4gIFN0b3AuDQogICAgR0lUR1VJX1ZFUlNJT04gPSAwLjEyLjAuNjQuZzg5
ZDYxLWRpcnR5DQogICAgY2F0OiAvdG1wL21vbzogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0K
DQpOcnnYslh22JYpe27Hidi2F316ajp2DQp6Wnpmfnp32qIpGw0K
