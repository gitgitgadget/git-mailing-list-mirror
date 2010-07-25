From: <lynn.lin@emc.com>
Subject: RE: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 09:21:59 -0400
Message-ID: <7F48A44C0E1FBF48B00D4DA49C85432E54F9A3@CORPUSMX100A.corp.emc.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com><AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com><4C4BFAA3.3050700@digium.com><7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com><AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com><7F48A44C0E1FBF48B00D4DA49C85432E54F99A@CORPUSMX100A.corp.emc.com><AANLkTilhoF670uZ1WbosZP9TNbXect2A3gELRJL0ZZIn@mail.gmail.com><m2d3ubojfr.fsf@igel.home><AANLkTilK_8wVQG6s8pUrscwd7ZnvgGyjOjJP41uXYfEl@mail.gmail.com><7F48A44C0E1FBF48B00D4DA49C85432E54F99D@CORPUSMX100A.corp.emc.com><7F48A44C0E1FBF48B00D4DA49C85432E54F99F@CORPUSMX100A.corp.emc.com><7F48A44C0E1FBF48B00D4DA49C85432E54F9A0@CORPUSMX100A.corp.emc.com><AANLkTinjmUEHxnGI2kRBwN17689MEwRRX_1uOQx-ZaHY@mail.gmail.com><7F48A44C0E1FBF48B00D4DA49C85432E54F9A1@C
 ORPUSMX100A.corp.emc.com> <AANLkTillxO38RTicjCw8ujzliFIhY3oHYHOCHAvUe7mB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <schwab@linux-m68k.org>, <kpfleming@digium.com>,
	<git@vger.kernel.org>
To: <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 15:22:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od1A0-0002Aw-Ft
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 15:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab0GYNW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 09:22:26 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:29682 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab0GYNWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 09:22:23 -0400
Received: from hop04-l1d11-si01.isus.emc.com (HOP04-L1D11-SI01.isus.emc.com [10.254.111.54])
	by mexforward.lss.emc.com (Switch-3.3.2/Switch-3.1.7) with ESMTP id o6PDM8M1030311
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 Jul 2010 09:22:08 -0400
Received: from mailhub.lss.emc.com (nagas.lss.emc.com [10.254.144.15]) by hop04-l1d11-si01.isus.emc.com (RSA Interceptor); Sun, 25 Jul 2010 09:22:02 -0400
Received: from corpussmtp5.corp.emc.com (corpussmtp5.corp.emc.com [128.221.166.229])
	by mailhub.lss.emc.com (Switch-3.4.2/Switch-3.3.2mp) with ESMTP id o6PDM2G1024407;
	Sun, 25 Jul 2010 09:22:02 -0400
Received: from CORPUSMX100A.corp.emc.com ([128.222.76.57]) by corpussmtp5.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 25 Jul 2010 09:22:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <AANLkTillxO38RTicjCw8ujzliFIhY3oHYHOCHAvUe7mB@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Makefile: don't include git version file on 'make clean'
Thread-Index: Acsr+zSBryGThkpsQaWi6FGbdxc1xAAAJrFQ
X-OriginalArrivalTime: 25 Jul 2010 13:22:01.0937 (UTC) FILETIME=[5E059C10:01CB2BFC]
X-EMM-EM: Active
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151743>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBnaXQtb3duZXJAdmdlci5rZXJu
ZWwub3JnIFttYWlsdG86Z2l0LW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mID92
YXIgQXJuZmo/cmUgQmphcm1hc29uDQpTZW50OiAyMDEw5bm0N+aciDI15pelIDIxOjA4DQpUbzog
TGluLCBMeW5uDQpDYzogc2Nod2FiQGxpbnV4LW02OGsub3JnOyBrcGZsZW1pbmdAZGlnaXVtLmNv
bTsgZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gTWFrZWZpbGU6IGRv
bid0IGluY2x1ZGUgZ2l0IHZlcnNpb24gZmlsZSBvbiAnbWFrZSBjbGVhbicNCg0KT24gU3VuLCBK
dWwgMjUsIDIwMTAgYXQgMTI6MzcsICA8bHlubi5saW5AZW1jLmNvbT4gd3JvdGU6DQo+DQo+DQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IMOGdmFyIEFybmZqw7Zyw7AgQmph
cm1hc29uIFttYWlsdG86YXZhcmFiQGdtYWlsLmNvbV0NCj4gU2VudDogMjAxMOW5tDfmnIgyNeaX
pSAyMDozNA0KPiBUbzogTGluLCBMeW5uDQo+IENjOiBzY2h3YWJAbGludXgtbTY4ay5vcmc7IGtw
ZmxlbWluZ0BkaWdpdW0uY29tOyBnaXRAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIE1ha2VmaWxlOiBkb24ndCBpbmNsdWRlIGdpdCB2ZXJzaW9uIGZpbGUgb24gJ21ha2Ug
Y2xlYW4nDQo+DQo+IE9uIFN1biwgSnVsIDI1LCAyMDEwIGF0IDEyOjI5LCDCoDxseW5uLmxpbkBl
bWMuY29tPiB3cm90ZToNCj4NCj4+IE15IHBhdGNoIGlzIHRvIGRvbid0IGNhbGwgR0lULVZFUlNJ
T04tRklMRSB0YXJnZXQgd2hlbiB5b3UgcnVuICdtYWtlIGNsZWFuJw0KPg0KPiBZZXMsIGJ1dCBh
cyBJIGRlbW9uc3RyYXRlZCBpdCBnZXRzIGNhbGxlZCBhbnl3YXkuIFByZXN1bWFibHkgYmVjYXVz
ZQ0KPiBvZiB0aGUgJChNQUtFKSAtQyAuLi4gY2xlYW4gcnVsZXMuIEJ1dCBJIGhhdmVuJ3QgbG9v
a2VkIGludG8gaXQuDQo+DQo+DQo+IElmIHdlIGRvbid0IHNwZWNpZnkgc3BlY2lhbCBnb2Fscywg
d2hlbiB3ZSBydW4gYW55IHRhcmdldCAsaXQgd2lsbCBjYWxsIEdJVC1WRVJTSU9ORi1GSUxFIHRh
cmdldCBhcyBpdCBpbmNsdWRlIHRoaXMgdGFyZ2V0DQo+DQo+IEV4YW1wbGUgZnJvbSBHTlUgbWFr
ZSBtYW51YWw6DQo+IGh0dHA6Ly93d3cuZ251Lm9yZy9zb2Z0d2FyZS9hdXRvY29uZi9tYW51YWwv
bWFrZS9Hb2Fscy5odG1sDQo+DQo+DQo+IEFuIGV4YW1wbGUgb2YgYXBwcm9wcmlhdGUgdXNlIGlz
IHRvIGF2b2lkIGluY2x1ZGluZyAuZCBmaWxlcyBkdXJpbmcgY2xlYW4gcnVsZXMgKHNlZSBBdXRv
bWF0aWMgUHJlcmVxdWlzaXRlcyksIHNvIG1ha2Ugd29uJ3QgY3JlYXRlIHRoZW0gb25seSB0byBp
bW1lZGlhdGVseSByZW1vdmUgdGhlbSBhZ2FpbjoNCj4NCj4gwqAgwqAgwqAgwqAgwqBzb3VyY2Vz
ID0gZm9vLmMgYmFyLmMNCj4NCj4gwqAgwqAgaWZuZXEgKCQoTUFLRUNNREdPQUxTKSxjbGVhbikN
Cj4gwqAgwqAgaW5jbHVkZSAkKHNvdXJjZXM6LmM9LmQpDQo+IMKgIMKgIGVuZGlmDQoNClllcywg
SSBrbm93IChub3cpIGhvdyBpbmNsdWRlIGRpcmVjdGl2ZXMgd29yay4gV2hhdCBJJ20gc2F5aW5n
IGlzIHRoYXQNCnlvdXIgcGF0Y2ggZG9lc24ndCB3b3JrIGJlY2F1c2UgdGhlIG1haW4gTWFrZWZp
bGUgY2xlYW4gZGlyZWN0aXZlDQpjYWxscyAqb3RoZXIqIG1ha2VmaWxlcywgd2hpY2ggaW4gdHVy
biBpbmNsdWRlIHRoZSB2ZXJzaW9uIGZpbGU6DQoNCiAgICAkIHJtIEdJVC1WRVJTSU9OLUZJTEUg
OyBtYWtlIC1DIGdpdHdlYiBjbGVhbjsgY2F0IEdJVC1WRVJTSU9OLUZJTEUNCiAgICBtYWtlOiBF
bnRlcmluZyBkaXJlY3RvcnkgYC9ob21lL2F2YXIvZy9naXQvZ2l0d2ViJw0KICAgIG1ha2VbMV06
IEVudGVyaW5nIGRpcmVjdG9yeSBgL2hvbWUvYXZhci9nL2dpdCcNCiAgICBHSVRfVkVSU0lPTiA9
IDEuNy4yLjYuZzY1YTBkMw0KICAgIG1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvaG9tZS9h
dmFyL2cvZ2l0Jw0KICAgIG1ha2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeSBgL2hvbWUvYXZhci9n
L2dpdCcNCiAgICBtYWtlWzFdOiBgR0lULVZFUlNJT04tRklMRScgaXMgdXAgdG8gZGF0ZS4NCiAg
ICBtYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL2hvbWUvYXZhci9nL2dpdCcNCiAgICBtYWtl
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL2hvbWUvYXZhci9nL2dpdC9naXR3ZWInDQogICAgbWFrZTog
RW50ZXJpbmcgZGlyZWN0b3J5IGAvaG9tZS9hdmFyL2cvZ2l0L2dpdHdlYicNCiAgICBtYWtlWzFd
OiBFbnRlcmluZyBkaXJlY3RvcnkgYC9ob21lL2F2YXIvZy9naXQnDQogICAgbWFrZVsxXTogYEdJ
VC1WRVJTSU9OLUZJTEUnIGlzIHVwIHRvIGRhdGUuDQogICAgbWFrZVsxXTogTGVhdmluZyBkaXJl
Y3RvcnkgYC9ob21lL2F2YXIvZy9naXQnDQogICAgcm0gLWYgZ2l0d2ViLmNnaSBzdGF0aWMvZ2l0
d2ViLm1pbi5qcyBzdGF0aWMvZ2l0d2ViLm1pbi5jc3MNCkdJVFdFQi1CVUlMRC1PUFRJT05TDQog
ICAgbWFrZTogTGVhdmluZyBkaXJlY3RvcnkgYC9ob21lL2F2YXIvZy9naXQvZ2l0d2ViJw0KICAg
IEdJVF9WRVJTSU9OID0gMS43LjIuNi5nNjVhMGQzDQoNClNvIGp1c3QgcmVtb3ZpbmcgdGhlIGlu
Y2x1c2lvbiBpbiB0aGUgbWFpbiBNYWtlZmlsZSBkb2Vzbid0IGRvDQphbnl0aGluZyBhdCBhbGwu
DQoNClRvIGdldCBpdCB0byB3b3JrIHlvdSBuZWVkIHRvIHBhdGNoIHRoZSAqL01ha2VmaWxlIGZp
bGVzIHRvbywgYW5kDQpwYXRjaCBvdGhlciBjbGVhbiB0YXJnZXRzIGxpa2UgZGlzdGNsZWFuLg0K
DQpUaGVyZSBhcmUgRG9jdW1lbnQsZ2l0d2ViIGFuZCBnaXQtZ3VpIG1vZHVsZSBoYXZlIHRoZSBz
YW1lICJpc3N1ZXMiDQoNCg0KQnV0IHBlcnNvbmFsbHkgSSB0aGluayB0aGlzIHdob2xlIHRoaW5n
IGlzIGEgYml0IHNpbGx5LCBidXQgb3RoZXJzIG1heQ0KZGlzYWdyZWUuIEkndmUgc2FpZCBteSBi
aXQuDQoNCg0KSSB0aGluayB3ZSBjYW4gZG8gYmV0dGVyIHdoZW4gd2UgZmluZCByZWR1bmRhbnQg
Y29kZSwgY29ycmVjdD8NCg0KDQpUaGFua3MgZm9yIGNvbnRyaWJ1dGluZyB0byBHaXQgYW55d2F5
LCB5b3VyIGhlbHAgaXMgYXBwcmVjaWF0ZWQuDQotLQ0KVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlz
IGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2NyaWJlIGdpdCIgaW4NCnRoZSBib2R5IG9mIGEg
bWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnDQpNb3JlIG1ham9yZG9tbyBpbmZv
IGF0ICBodHRwOi8vdmdlci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWwNCg0K
