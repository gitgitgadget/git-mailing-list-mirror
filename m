From: <lynn.lin@emc.com>
Subject: RE: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 08:19:10 -0400
Message-ID: <7F48A44C0E1FBF48B00D4DA49C85432E54F99D@CORPUSMX100A.corp.emc.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com><AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com><4C4BFAA3.3050700@digium.com><7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com><AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com><7F48A44C0E1FBF48B00D4DA49C85432E54F99A@CORPUSMX100A.corp.emc.com><AANLkTilhoF670uZ1WbosZP9TNbXect2A3gELRJL0ZZIn@mail.gmail.com><m2d3ubojfr.fsf@igel.home> <AANLkTilK_8wVQG6s8pUrscwd7ZnvgGyjOjJP41uXYfEl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <kpfleming@digium.com>, <git@vger.kernel.org>
To: <avarab@gmail.com>, <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Jul 25 14:19:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od0BH-0003VH-H8
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 14:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab0GYMTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 08:19:42 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:25473 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab0GYMTl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 08:19:41 -0400
Received: from hop04-l1d11-si02.isus.emc.com (HOP04-L1D11-SI02.isus.emc.com [10.254.111.55])
	by mexforward.lss.emc.com (Switch-3.3.2/Switch-3.1.7) with ESMTP id o6PCJQNT020575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 Jul 2010 08:19:26 -0400
Received: from mailhub.lss.emc.com (nagas.lss.emc.com [10.254.144.15]) by hop04-l1d11-si02.isus.emc.com (RSA Interceptor); Sun, 25 Jul 2010 08:19:13 -0400
Received: from corpussmtp5.corp.emc.com (corpussmtp5.corp.emc.com [128.221.166.229])
	by mailhub.lss.emc.com (Switch-3.4.2/Switch-3.3.2mp) with ESMTP id o6PCJCer009504;
	Sun, 25 Jul 2010 08:19:12 -0400
Received: from CORPUSMX100A.corp.emc.com ([128.222.76.57]) by corpussmtp5.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 25 Jul 2010 08:19:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <AANLkTilK_8wVQG6s8pUrscwd7ZnvgGyjOjJP41uXYfEl@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Makefile: don't include git version file on 'make clean'
Thread-Index: Acsr8xqzkZeOIS0bT1yuDOpY78JtywAAC7yQ
X-OriginalArrivalTime: 25 Jul 2010 12:19:12.0589 (UTC) FILETIME=[9750BFD0:01CB2BF3]
X-EMM-EM: Active
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151733>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiDDhnZhciBBcm5masO2csOwIEJq
YXJtYXNvbiBbbWFpbHRvOmF2YXJhYkBnbWFpbC5jb21dIA0KU2VudDogMjAxMOW5tDfmnIgyNeaX
pSAyMDoxNg0KVG86IEFuZHJlYXMgU2Nod2FiDQpDYzogTGluLCBMeW5uOyBrcGZsZW1pbmdAZGln
aXVtLmNvbTsgZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gTWFrZWZp
bGU6IGRvbid0IGluY2x1ZGUgZ2l0IHZlcnNpb24gZmlsZSBvbiAnbWFrZSBjbGVhbicNCg0KT24g
U3VuLCBKdWwgMjUsIDIwMTAgYXQgMTI6MDUsIEFuZHJlYXMgU2Nod2FiIDxzY2h3YWJAbGludXgt
bTY4ay5vcmc+IHdyb3RlOg0KPiDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiA8YXZhcmFiQGdt
YWlsLmNvbT4gd3JpdGVzOg0KPg0KPj4gTWFrZWZpbGUgdGFyZ2V0cyBhcmVuJ3QgdHJpZ2dlcmVk
IGJ5IHRoZSBpbmNsdWRlIGRpcmVjdGl2ZS4NCj4NCj4gVW1tLCB5ZXMgdGhleSBhcmUsIHNlZSAo
bWFrZSkgUmVtYWtpbmcgTWFrZWZpbGVzLg0KDQpBaCwgeWVzLiBCdXQgaXQgd2FzIGJlaW5nIGlu
Y2x1ZGVkIGluIG1vcmUgcGxhY2VzIHRoYW4ganVzdCB0aGF0DQotaW5jbHVkZSBkaXJlY3RpdmUs
IHNvIEkgZGlkbid0IHNwb3QgdGhlIGRpZmZlcmVuY2U6DQoNCldpdGhvdXQgdGhhdCBkaXJlY3Rp
dmUsIHN0aWxsIGdlbmVyYXRlZCBvbiBtYWtlIGNsZWFuOg0KDQogICAgJCBnaXQgZGlmZiAtVTAg
fCBjYXQNCiAgICBkaWZmIC0tZ2l0IGEvR0lULVZFUlNJT04tR0VOIGIvR0lULVZFUlNJT04tR0VO
DQogICAgaW5kZXggZTg4ZjUwYy4uZjI5NDA2YiAxMDA3NTUNCiAgICAtLS0gYS9HSVQtVkVSU0lP
Ti1HRU4NCiAgICArKysgYi9HSVQtVkVSU0lPTi1HRU4NCiAgICBAQCAtMiwwICszLDIgQEANCiAg
ICArZWNobyBNT08gPiAvdG1wL21vbw0KICAgICsNCiAgICBkaWZmIC0tZ2l0IGEvTWFrZWZpbGUg
Yi9NYWtlZmlsZQ0KICAgIGluZGV4IGI2OTc1YWEuLjVlZGZlY2EgMTAwNjQ0DQogICAgLS0tIGEv
TWFrZWZpbGUNCiAgICArKysgYi9NYWtlZmlsZQ0KICAgIEBAIC0yNDEgKzI0MCwwIEBAIEdJVC1W
RVJTSU9OLUZJTEU6IEZPUkNFDQogICAgLS1pbmNsdWRlIEdJVC1WRVJTSU9OLUZJTEUNCiAgICAk
IHJtIC12IC90bXAvbW9vOyBtYWtlIGNsZWFuID4gL2Rldi9udWxsOyBjYXQgL3RtcC9tb28NCiAg
ICByZW1vdmVkIGAvdG1wL21vbycNCiAgICBHSVRfVkVSU0lPTiA9IDEuNy4yLjYuZzY1YTBkMy5k
aXJ0eQ0KICAgIEdJVEdVSV9WRVJTSU9OID0gMC4xMi4wLjY0Lmc4OWQ2MS1kaXJ0eQ0KICAgIE1P
Tw0KDQpEZWxldGVkIHRoZSBydWxlLCBub3QgZ2VuZXJhdGVkLCBidXQgb3RoZXIgdGhpbmdzIGFy
ZSBzdGlsbCBjYWxsaW5nDQp0aGUgcnVsZToNCg0KDQpXaHkgbm90IGRlbGV0ZSB0aGUgcnVsZT8g
V2Ugb25seSBoYW5kbGUgdGhpcyBvbiAnbWFrZSBjbGVhbicgY29tbWFuZCAoJ21ha2UgZGlzdGNs
ZWFuJykgdGFyZ2V0DQoNCg0KDQogICAgJCBnaXQgZGlmZiAtVTAgfCBjYXQNCiAgICBkaWZmIC0t
Z2l0IGEvR0lULVZFUlNJT04tR0VOIGIvR0lULVZFUlNJT04tR0VODQogICAgaW5kZXggZTg4ZjUw
Yy4uZjI5NDA2YiAxMDA3NTUNCiAgICAtLS0gYS9HSVQtVkVSU0lPTi1HRU4NCiAgICArKysgYi9H
SVQtVkVSU0lPTi1HRU4NCiAgICBAQCAtMiwwICszLDIgQEANCiAgICArZWNobyBNT08gPiAvdG1w
L21vbw0KICAgICsNCiAgICBkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQ0KICAgIGlu
ZGV4IGI2OTc1YWEuLjFhMTg5ZGEgMTAwNjQ0DQogICAgLS0tIGEvTWFrZWZpbGUNCiAgICArKysg
Yi9NYWtlZmlsZQ0KICAgIEBAIC0yMzksNCArMjM4LDAgQEAgYWxsOjoNCiAgICAtR0lULVZFUlNJ
T04tRklMRTogRk9SQ0UNCiAgICAtICAgICAgIEAkKFNIRUxMX1BBVEgpIC4vR0lULVZFUlNJT04t
R0VODQogICAgLS1pbmNsdWRlIEdJVC1WRVJTSU9OLUZJTEUNCiAgICAtDQogICAgJCBybSAtdiAv
dG1wL21vbzsgbWFrZSBjbGVhbiA+IC9kZXYvbnVsbDsgY2F0IC90bXAvbW9vDQogICAgcmVtb3Zl
ZCBgL3RtcC9tb28nDQogICAgbWFrZVsyXTogKioqIE5vIHJ1bGUgdG8gbWFrZSB0YXJnZXQgYEdJ
VC1WRVJTSU9OLUZJTEUnLiAgU3RvcC4NCiAgICBtYWtlWzJdOiAqKiogTm8gcnVsZSB0byBtYWtl
IHRhcmdldCBgR0lULVZFUlNJT04tRklMRScuICBTdG9wLg0KICAgIG1ha2VbMl06ICoqKiBObyBy
dWxlIHRvIG1ha2UgdGFyZ2V0IGBHSVQtVkVSU0lPTi1GSUxFJy4gIFN0b3AuDQogICAgR0lUR1VJ
X1ZFUlNJT04gPSAwLjEyLjAuNjQuZzg5ZDYxLWRpcnR5DQogICAgY2F0OiAvdG1wL21vbzogTm8g
c3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KDQo=
