From: <lynn.lin@emc.com>
Subject: RE: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 07:28:34 -0400
Message-ID: <7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com> <AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com> <4C4BFAA3.3050700@digium.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <git@vger.kernel.org>
To: <kpfleming@digium.com>, <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 13:28:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OczO4-0000QJ-Ey
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 13:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308Ab0GYL2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 07:28:51 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:22045 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab0GYL2u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 07:28:50 -0400
Received: from hop04-l1d11-si01.isus.emc.com (HOP04-L1D11-SI01.isus.emc.com [10.254.111.54])
	by mexforward.lss.emc.com (Switch-3.3.2/Switch-3.1.7) with ESMTP id o6PBSkBm005748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 Jul 2010 07:28:46 -0400
Received: from mailhub.lss.emc.com (nagas.lss.emc.com [10.254.144.15]) by hop04-l1d11-si01.isus.emc.com (RSA Interceptor); Sun, 25 Jul 2010 07:28:37 -0400
Received: from corpussmtp5.corp.emc.com (corpussmtp5.corp.emc.com [128.221.166.229])
	by mailhub.lss.emc.com (Switch-3.4.2/Switch-3.3.2mp) with ESMTP id o6PBSaqq031320;
	Sun, 25 Jul 2010 07:28:36 -0400
Received: from CORPUSMX100A.corp.emc.com ([128.222.76.57]) by corpussmtp5.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 25 Jul 2010 07:28:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <4C4BFAA3.3050700@digium.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Makefile: don't include git version file on 'make clean'
Thread-Index: Acsr1lhyneXSC5WiTz20AHaMYSh8WgAFdgrw
X-OriginalArrivalTime: 25 Jul 2010 11:28:36.0488 (UTC) FILETIME=[85A88080:01CB2BEC]
X-EMM-EM: Active
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151724>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLZXZpbiBQLiBGbGVtaW5nIFtt
YWlsdG86a3BmbGVtaW5nQGRpZ2l1bS5jb21dIA0KU2VudDogMjAxMOW5tDfmnIgyNeaXpSAxNjo1
MA0KVG86IMOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uDQpDYzogTGluLCBMeW5uOyBnaXRAdmdl
ci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBNYWtlZmlsZTogZG9uJ3QgaW5jbHVk
ZSBnaXQgdmVyc2lvbiBmaWxlIG9uICdtYWtlIGNsZWFuJw0KDQpPbiAwNy8yNC8yMDEwIDAyOjM2
IFBNLCDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiB3cm90ZToNCj4gT24gU2F0LCBKdWwgMjQs
IDIwMTAgYXQgMDM6NTMsICA8THlubi5MaW5AZW1jLmNvbT4gd3JvdGU6DQo+PiBGcm9tOiBMeW5u
IExpbiA8THlubi5MaW5AZW1jLmNvbT4NCj4+DQo+PiAtLS0NCj4+ICBNYWtlZmlsZSAgICAgICAg
IHwgICAgNCArKystDQo+PiAgZ2l0LWd1aS9NYWtlZmlsZSB8ICAgIDQgKysrLQ0KPj4gIDIgZmls
ZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlDQo+PiBpbmRleCBiYzNjNTcwLi5lYjI4Yjk4IDEw
MDY0NA0KPj4gLS0tIGEvTWFrZWZpbGUNCj4+ICsrKyBiL01ha2VmaWxlDQo+PiBAQCAtMjM4LDcg
KzIzOCw5IEBAIGFsbDo6DQo+Pg0KPj4gIEdJVC1WRVJTSU9OLUZJTEU6IEZPUkNFDQo+PiAgICAg
ICAgQCQoU0hFTExfUEFUSCkgLi9HSVQtVkVSU0lPTi1HRU4NCj4+IC0taW5jbHVkZSBHSVQtVkVS
U0lPTi1GSUxFDQo+PiAraWZuZXEgIiQoTUFLRUNNREdPQUxTKSIgImNsZWFuIg0KPj4gKyAgLWlu
Y2x1ZGUgR0lULVZFUlNJT04tRklMRQ0KPj4gK2VuZGlmDQo+Pg0KPj4gIHVuYW1lX1MgOj0gJChz
aGVsbCBzaCAtYyAndW5hbWUgLXMgMj4vZGV2L251bGwgfHwgZWNobyBub3QnKQ0KPj4gIHVuYW1l
X00gOj0gJChzaGVsbCBzaCAtYyAndW5hbWUgLW0gMj4vZGV2L251bGwgfHwgZWNobyBub3QnKQ0K
Pj4gZGlmZiAtLWdpdCBhL2dpdC1ndWkvTWFrZWZpbGUgYi9naXQtZ3VpL01ha2VmaWxlDQo+PiBp
bmRleCAxOTdiNTVlLi45MWUxZWE1IDEwMDY0NA0KPj4gLS0tIGEvZ2l0LWd1aS9NYWtlZmlsZQ0K
Pj4gKysrIGIvZ2l0LWd1aS9NYWtlZmlsZQ0KPj4gQEAgLTksNyArOSw5IEBAIGFsbDo6DQo+Pg0K
Pj4gIEdJVC1WRVJTSU9OLUZJTEU6IEZPUkNFDQo+PiAgICAgICAgQCQoU0hFTExfUEFUSCkgLi9H
SVQtVkVSU0lPTi1HRU4NCj4+IC0taW5jbHVkZSBHSVQtVkVSU0lPTi1GSUxFDQo+PiAraWZuZXEg
IiQoTUFLRUNNREdPQUxTKSIgImNsZWFuIg0KPj4gKyAgLWluY2x1ZGUgR0lULVZFUlNJT04tRklM
RQ0KPj4gK2VuZGlmDQo+Pg0KPj4gIHVuYW1lX1MgOj0gJChzaGVsbCBzaCAtYyAndW5hbWUgLXMg
Mj4vZGV2L251bGwgfHwgZWNobyBub3QnKQ0KPj4gIHVuYW1lX08gOj0gJChzaGVsbCBzaCAtYyAn
dW5hbWUgLW8gMj4vZGV2L251bGwgfHwgZWNobyBub3QnKQ0KPj4gLS0NCj4+IDEuNy4xDQo+IA0K
PiBUaGlzIHBhdGNoIG5lZWRzIGEgcmF0aW9uYWxlLCB3aHkgd2FzIGl0IG5lZWRlZD8gVGhlICIt
aW5jbHVkZSINCj4gZGlyZWN0aXZlIHdpbGwgc2ltcGx5IGlnbm9yZSBmaWxlcyB0aGF0IGRvbid0
IGV4aXN0IChhcyBvcHBvc2VkIHRvDQo+ICJpbmNsdWRlIiksIHNvIGluY2x1ZGluZyBHSVQtVkVS
U0lPTi1GSUxFIGR1cmluZyAibWFrZSBjbGVhbicNCj4gc2hvdWxkbid0IGJlIGFuIGlzc3VlLg0K
DQpKdXN0IGd1ZXNzaW5nIGhlcmUsIGJ1dCBzaW5jZSBHSVQtVkVSU0lPTi1GSUxFIGhhcyBhICdG
T1JDRScNCnByZXJlcXVpc2l0ZSwgdGhhdCBtZWFucyB0aGF0IHRoZSBvcGVyYXRpb25zIHRvIGdl
bmVyYXRlIGl0IHdpbGwgYmUgcnVuDQpldmVuIGZvciAnbWFrZSBjbGVhbicsIHdoaWNoIGlzIG5v
dCB1c2VmdWwgZm9yIHRoZSBjbGVhbmluZyBvcGVyYXRpb24uDQpJdCdzIHByb2JhYmx5IG5vdCBo
YXJtZnVsIGVpdGhlci4uLiBidXQgbWF5YmUgdGhlIE9QIGhhcyBzb21lIG1vcmUNCnNpZ25pZmlj
YW50IHJlYXNvbiBmb3IgdGhpcyBwYXRjaC4NCg0KDQoNClllcywgd2hlbiB3ZSBydW4gJ21ha2Ug
Y2xlYW4nICxpdCBhbHNvIGdlbmVyYXRlIHRoZSBnaXQgdmVyc2lvbiBmaWxlLHRoZW4gcmVtb3Zl
IGl0IC5JdCdzIG5vdCBuZWNlc3NhcnkgdG8gdHJpZ2dlciB0aGUgb3BlcmF0aW9uIHdoZW4gcnVu
ICdtYWtlIGNsZWFuJyBjb21tYW5kDQoNCkx5bm4NCg0KDQotLSANCktldmluIFAuIEZsZW1pbmcN
CkRpZ2l1bSwgSW5jLiB8IERpcmVjdG9yIG9mIFNvZnR3YXJlIFRlY2hub2xvZ2llcw0KNDQ1IEph
biBEYXZpcyBEcml2ZSBOVyAtIEh1bnRzdmlsbGUsIEFMIDM1ODA2IC0gVVNBDQpza3lwZToga3Bm
bGVtaW5nIHwgamFiYmVyOiBrZmxlbWluZ0BkaWdpdW0uY29tDQpDaGVjayB1cyBvdXQgYXQgd3d3
LmRpZ2l1bS5jb20gJiB3d3cuYXN0ZXJpc2sub3JnDQoNCg==
