From: <lynn.lin@emc.com>
Subject: RE: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 07:46:09 -0400
Message-ID: <7F48A44C0E1FBF48B00D4DA49C85432E54F99A@CORPUSMX100A.corp.emc.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com><AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com><4C4BFAA3.3050700@digium.com><7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com> <AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <kpfleming@digium.com>, <git@vger.kernel.org>
To: <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 13:46:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oczf2-0006hE-HZ
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 13:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab0GYLqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 07:46:22 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:23110 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab0GYLqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 07:46:21 -0400
Received: from hop04-l1d11-si03.isus.emc.com (HOP04-L1D11-SI03.isus.emc.com [10.254.111.23])
	by mexforward.lss.emc.com (Switch-3.3.2/Switch-3.1.7) with ESMTP id o6PBkH9Z014254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 Jul 2010 07:46:17 -0400
Received: from mailhub.lss.emc.com (sesha.lss.emc.com [10.254.144.16]) by hop04-l1d11-si03.isus.emc.com (RSA Interceptor); Sun, 25 Jul 2010 07:46:11 -0400
Received: from corpussmtp5.corp.emc.com (corpussmtp5.corp.emc.com [128.221.166.229])
	by mailhub.lss.emc.com (Switch-3.4.2/Switch-3.3.2mp) with ESMTP id o6PBkAVd024192;
	Sun, 25 Jul 2010 07:46:10 -0400
Received: from CORPUSMX100A.corp.emc.com ([128.222.76.57]) by corpussmtp5.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 25 Jul 2010 07:46:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Makefile: don't include git version file on 'make clean'
Thread-Index: Acsr7l2YIxq6rurTT6GVfcezz0ZDWAAAE/pQ
X-OriginalArrivalTime: 25 Jul 2010 11:46:10.0638 (UTC) FILETIME=[F9FB06E0:01CB2BEE]
X-EMM-EM: Active
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151726>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBnaXQtb3duZXJAdmdlci5rZXJu
ZWwub3JnIFttYWlsdG86Z2l0LW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mID92
YXIgQXJuZmo/cmUgQmphcm1hc29uDQpTZW50OiAyMDEw5bm0N+aciDI15pelIDE5OjQyDQpUbzog
TGluLCBMeW5uDQpDYzoga3BmbGVtaW5nQGRpZ2l1bS5jb207IGdpdEB2Z2VyLmtlcm5lbC5vcmcN
ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIE1ha2VmaWxlOiBkb24ndCBpbmNsdWRlIGdpdCB2ZXJzaW9u
IGZpbGUgb24gJ21ha2UgY2xlYW4nDQoNCk9uIFN1biwgSnVsIDI1LCAyMDEwIGF0IDExOjI4LCAg
PGx5bm4ubGluQGVtYy5jb20+IHdyb3RlOg0KPg0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBLZXZpbiBQLiBGbGVtaW5nIFttYWlsdG86a3BmbGVtaW5nQGRpZ2l1bS5j
b21dDQo+IFNlbnQ6IDIwMTDlubQ35pyIMjXml6UgMTY6NTANCj4gVG86IMOGdmFyIEFybmZqw7Zy
w7AgQmphcm1hc29uDQo+IENjOiBMaW4sIEx5bm47IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gTWFrZWZpbGU6IGRvbid0IGluY2x1ZGUgZ2l0IHZlcnNpb24gZmls
ZSBvbiAnbWFrZSBjbGVhbicNCj4NCj4gT24gMDcvMjQvMjAxMCAwMjozNiBQTSwgw4Z2YXIgQXJu
ZmrDtnLDsCBCamFybWFzb24gd3JvdGU6DQo+PiBPbiBTYXQsIEp1bCAyNCwgMjAxMCBhdCAwMzo1
MywgwqA8THlubi5MaW5AZW1jLmNvbT4gd3JvdGU6DQo+Pj4gRnJvbTogTHlubiBMaW4gPEx5bm4u
TGluQGVtYy5jb20+DQo+Pj4NCj4+PiAtLS0NCj4+PiDCoE1ha2VmaWxlIMKgIMKgIMKgIMKgIHwg
wqAgwqA0ICsrKy0NCj4+PiDCoGdpdC1ndWkvTWFrZWZpbGUgfCDCoCDCoDQgKysrLQ0KPj4+IMKg
MiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+
PiBkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQ0KPj4+IGluZGV4IGJjM2M1NzAuLmVi
MjhiOTggMTAwNjQ0DQo+Pj4gLS0tIGEvTWFrZWZpbGUNCj4+PiArKysgYi9NYWtlZmlsZQ0KPj4+
IEBAIC0yMzgsNyArMjM4LDkgQEAgYWxsOjoNCj4+Pg0KPj4+IMKgR0lULVZFUlNJT04tRklMRTog
Rk9SQ0UNCj4+PiDCoCDCoCDCoCDCoEAkKFNIRUxMX1BBVEgpIC4vR0lULVZFUlNJT04tR0VODQo+
Pj4gLS1pbmNsdWRlIEdJVC1WRVJTSU9OLUZJTEUNCj4+PiAraWZuZXEgIiQoTUFLRUNNREdPQUxT
KSIgImNsZWFuIg0KPj4+ICsgwqAtaW5jbHVkZSBHSVQtVkVSU0lPTi1GSUxFDQo+Pj4gK2VuZGlm
DQo+Pj4NCj4+PiDCoHVuYW1lX1MgOj0gJChzaGVsbCBzaCAtYyAndW5hbWUgLXMgMj4vZGV2L251
bGwgfHwgZWNobyBub3QnKQ0KPj4+IMKgdW5hbWVfTSA6PSAkKHNoZWxsIHNoIC1jICd1bmFtZSAt
bSAyPi9kZXYvbnVsbCB8fCBlY2hvIG5vdCcpDQo+Pj4gZGlmZiAtLWdpdCBhL2dpdC1ndWkvTWFr
ZWZpbGUgYi9naXQtZ3VpL01ha2VmaWxlDQo+Pj4gaW5kZXggMTk3YjU1ZS4uOTFlMWVhNSAxMDA2
NDQNCj4+PiAtLS0gYS9naXQtZ3VpL01ha2VmaWxlDQo+Pj4gKysrIGIvZ2l0LWd1aS9NYWtlZmls
ZQ0KPj4+IEBAIC05LDcgKzksOSBAQCBhbGw6Og0KPj4+DQo+Pj4gwqBHSVQtVkVSU0lPTi1GSUxF
OiBGT1JDRQ0KPj4+IMKgIMKgIMKgIMKgQCQoU0hFTExfUEFUSCkgLi9HSVQtVkVSU0lPTi1HRU4N
Cj4+PiAtLWluY2x1ZGUgR0lULVZFUlNJT04tRklMRQ0KPj4+ICtpZm5lcSAiJChNQUtFQ01ER09B
TFMpIiAiY2xlYW4iDQo+Pj4gKyDCoC1pbmNsdWRlIEdJVC1WRVJTSU9OLUZJTEUNCj4+PiArZW5k
aWYNCj4+Pg0KPj4+IMKgdW5hbWVfUyA6PSAkKHNoZWxsIHNoIC1jICd1bmFtZSAtcyAyPi9kZXYv
bnVsbCB8fCBlY2hvIG5vdCcpDQo+Pj4gwqB1bmFtZV9PIDo9ICQoc2hlbGwgc2ggLWMgJ3VuYW1l
IC1vIDI+L2Rldi9udWxsIHx8IGVjaG8gbm90JykNCj4+PiAtLQ0KPj4+IDEuNy4xDQo+Pg0KPj4g
VGhpcyBwYXRjaCBuZWVkcyBhIHJhdGlvbmFsZSwgd2h5IHdhcyBpdCBuZWVkZWQ/IFRoZSAiLWlu
Y2x1ZGUiDQo+PiBkaXJlY3RpdmUgd2lsbCBzaW1wbHkgaWdub3JlIGZpbGVzIHRoYXQgZG9uJ3Qg
ZXhpc3QgKGFzIG9wcG9zZWQgdG8NCj4+ICJpbmNsdWRlIiksIHNvIGluY2x1ZGluZyBHSVQtVkVS
U0lPTi1GSUxFIGR1cmluZyAibWFrZSBjbGVhbicNCj4+IHNob3VsZG4ndCBiZSBhbiBpc3N1ZS4N
Cj4NCj4gSnVzdCBndWVzc2luZyBoZXJlLCBidXQgc2luY2UgR0lULVZFUlNJT04tRklMRSBoYXMg
YSAnRk9SQ0UnDQo+IHByZXJlcXVpc2l0ZSwgdGhhdCBtZWFucyB0aGF0IHRoZSBvcGVyYXRpb25z
IHRvIGdlbmVyYXRlIGl0IHdpbGwgYmUgcnVuDQo+IGV2ZW4gZm9yICdtYWtlIGNsZWFuJywgd2hp
Y2ggaXMgbm90IHVzZWZ1bCBmb3IgdGhlIGNsZWFuaW5nIG9wZXJhdGlvbi4NCj4gSXQncyBwcm9i
YWJseSBub3QgaGFybWZ1bCBlaXRoZXIuLi4gYnV0IG1heWJlIHRoZSBPUCBoYXMgc29tZSBtb3Jl
DQo+IHNpZ25pZmljYW50IHJlYXNvbiBmb3IgdGhpcyBwYXRjaC4NCj4NCj4NCg0KPiBZZXMsIHdo
ZW4gd2UgcnVuICdtYWtlIGNsZWFuJyAsaXQgYWxzbyBnZW5lcmF0ZSB0aGUgZ2l0IHZlcnNpb24N
Cj4gZmlsZSx0aGVuIHJlbW92ZSBpdCAuSXQncyBub3QgbmVjZXNzYXJ5IHRvIHRyaWdnZXIgdGhl
IG9wZXJhdGlvbg0KPiB3aGVuIHJ1biAnbWFrZSBjbGVhbicgY29tbWFuZA0KDQpTdXJlLCBpdCdz
IG5vdCBuZWVkZWQuIEJ1dCBpdCdzIE9LIHRvIGhhdmUgYSBiaXQgb2YgcmVkdW5kYW5jeSBmb3IN
CnNpbXBsaWNpdHksIHVubGVzcyB0aGF0IHJlZHVuZGFuY3kgaXMgYnJlYWtpbmcgc29tZXRoaW5n
LiBXaGljaCBpcyB3aHkNCkkgYXNrZWQgd2hldGhlciBpdCB3YXMgYWN0dWFsbHkgY2F1c2luZyBh
IHByb2JsZW0gaW4gYW55IGNhc2UuDQoNCldpdGggdGhpcyBwYXRjaCB3ZSBzdGlsbCBjYWxsIC4v
R0lULVZFUlNJT04tR0VOIHRvIG1ha2UgdGhlDQouL0dJVC1WRVJTSU9OLUZJTEUsIHdlIGp1c3Qg
YXJlbid0IGluY2x1ZGluZyBpdCBhbnltb3JlLCBhbmQgaXQgd291bGQNCnN0aWxsIGJlIGluY2x1
ZGVkIG9uICJtYWtlIGRpc3RjbGVhbiIgc2luY2UgeW91J3JlIGp1c3QgbG9va2luZyBhdA0KJChN
QUtFQ01ER09BTFMpLg0KDQpObyxpdCB3b24ndCBjYWxsIC4vR0lULVZFUlNJT04tR0VOIGFzIGl0
IGRvZXNuJ3QgaW5jbHVkZSBHRVQtVkVSU0lPTi1GSUxFIGFueSBtb3JlLnNvIEl0IHdvbid0IHRy
aWdnZXIgdGhlICBHSVQtVkVSU0lPTi1GSUxFIHRhcmdldA0KDQoNCldlIGNhbiBhbHNvIGhhbmRs
ZSBkaXN0Y2xlYW4gdGFyZ2V0DQoNCi0tDQpUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDog
c2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgZ2l0IiBpbg0KdGhlIGJvZHkgb2YgYSBtZXNzYWdl
IHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcNCk1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0
dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0KDQo=
