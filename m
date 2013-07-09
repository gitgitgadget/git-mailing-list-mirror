From: =?utf-8?B?U2FyYWrDpHJ2aSBUb255?= <Tony.Sarajarvi@digia.com>
Subject: RE: Git --file doesn't override $HOME in version 1.8.1.2
Date: Tue, 9 Jul 2013 12:12:54 +0000
Message-ID: <C8A88C530F38AE47B22BDC434090CBB0ED276E@IT-EXMB01-HKI.it.local>
References: <C8A88C530F38AE47B22BDC434090CBB0ED26E0@IT-EXMB01-HKI.it.local>
 <7vmwpwvt7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 14:13:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwWmz-00047C-PK
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 14:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab3GIMM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 08:12:57 -0400
Received: from smtp1.digia.com ([82.118.214.156]:37731 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439Ab3GIMM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 08:12:57 -0400
Received: from smtp1.digia.com (unknown [127.0.0.1])
	by IMSVA80 (Postfix) with ESMTP id DB5BA370049;
	Tue,  9 Jul 2013 15:12:54 +0300 (EEST)
Received: from IT-EXCAS02-HKI.it.local (unknown [10.9.52.71])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by smtp1.digia.com (Postfix) with ESMTP id C27D5370048;
	Tue,  9 Jul 2013 15:12:54 +0300 (EEST)
Received: from IT-EXMB01-HKI.it.local ([fe80::78ea:e84d:88b4:9f3d]) by
 IT-EXCAS02-HKI.it.local ([fe80::5efe:10.9.52.71%11]) with mapi id
 14.02.0283.003; Tue, 9 Jul 2013 15:12:54 +0300
Thread-Topic: Git --file doesn't override $HOME in version 1.8.1.2
Thread-Index: Ac58lDNuzKSWXOyLSHmV48wyH4v0hQAB7+IYAAApfXA=
In-Reply-To: <7vmwpwvt7a.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.9.5.6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229951>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSnVuaW8gQyBIYW1hbm8g
W21haWx0bzpnaXRzdGVyQHBvYm94LmNvbV0NCj4gU2VudDogOS4gaGVpbsOka3V1dGEgMjAxMyAx
NTowMQ0KPiBUbzogU2FyYWrDpHJ2aSBUb255DQo+IENjOiBnaXRAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBHaXQgLS1maWxlIGRvZXNuJ3Qgb3ZlcnJpZGUgJEhPTUUgaW4gdmVyc2lv
biAxLjguMS4yDQo+IA0KPiBTYXJhasOkcnZpIFRvbnkgPFRvbnkuU2FyYWphcnZpQGRpZ2lhLmNv
bT4gd3JpdGVzOg0KPiANCj4gPiBVc2luZyBVYnVudHUgMTMuMDQgd2l0aCBHaXQgMS44LjEuMiBJ
IHN0dW1ibGVkIHVwb24gYSBwcm9ibGVtIHVzaW5nIFB1cHBldC4NCj4gPg0KPiA+IEluIFB1cHBl
dCB3ZSBsYXVuY2ggR2l0IHdpdGggdGhlIGNvbW1hbmQ6ICcvdXNyL2Jpbi9naXQgY29uZmlnIC0t
ZmlsZQ0KPiAvaG9tZS9xdC8uZ2l0Y29uZmlnIC0tZ2V0ICJ1c2VyLm5hbWUiICJRdCBDb250aW51
b3VzIEludGVncmF0aW9uIFN5c3RlbSInDQo+IA0KPiBIbXBoLiAgV2hhdCBkb2VzIHRoaXMgZXZl
biBtZWFuPw0KPiANCj4gICAgIGdpdCBjb25maWcgLS1nZXQgdXNlci5uYW1lICJRdCBDSVMiDQoN
Ck91ciBwdXBwZXQgY29uZmlndXJhdGlvbiBpcyBhdmFpbGFibGUgZm9yIGFueW9uZSBoZXJlOg0K
aHR0cHM6Ly9xdC5naXRvcmlvdXMub3JnL3F0cWEvc3lzYWRtaW4vYmxvYnMvbWFzdGVyL3B1cHBl
dC9tb2R1bGVzL2dpdC9tYW5pZmVzdHMvY29uZmlnLnBwDQoNCldlIGNoZWNrIHdpdGggJ3VubGVz
cycgaWYgdGhlIHVzZXIubmFtZSBoYXMgYmVlbiBzZXQgdG8gd2hhdCB3ZSBleHBlY3QgaXQgdG8g
YmUuIFRoZSByZXR1cm4gdmFsdWUgaXMgZGlmZmVyZW50IGZyb20gR2l0IGlmIEkgdHlwbyB0aGUg
bmFtZS4NCg0Kcm9vdEBkZXYtdWJ1bnR1MTMwNC14NjQtMDE6fiMgZ2l0IGNvbmZpZyAtLWZpbGUg
L2hvbWUvcXQvLmdpdGNvbmZpZyAtLWdldCB1c2VyLm5hbWUgIlF0IENvbnRpbnVvdXMgSW50ZWdy
YXRpb24gU3lzdGVkIg0Kcm9vdEBkZXYtdWJ1bnR1MTMwNC14NjQtMDE6fiMgZWNobyAkPw0KMQ0K
cm9vdEBkZXYtdWJ1bnR1MTMwNC14NjQtMDE6fiMgZ2l0IGNvbmZpZyAtLWZpbGUgL2hvbWUvcXQv
LmdpdGNvbmZpZyAtLWdldCB1c2VyLm5hbWUgIlF0IENvbnRpbnVvdXMgSW50ZWdyYXRpb24gU3lz
dGVtIg0KUXQgQ29udGludW91cyBJbnRlZ3JhdGlvbiBTeXN0ZW0NCnJvb3RAZGV2LXVidW50dTEz
MDQteDY0LTAxOn4jIGVjaG8gJD8NCjANCg0KPiANCj4gSSBoYXZlIGEgZmVlbGluZyB0aGF0IHRo
ZSBjb21tYW5kIHdpbGwgZXhpdCB3aXRoIGFuIGVycm9yIHN0YXR1cyAxLg0KPiANCj4gPiBIb3dl
dmVyLCBwdXBwZXQgbG9nczogImZhdGFsOiB1bmFibGUgdG8gYWNjZXNzDQo+ID4gJy9yb290Ly5j
b25maWcvZ2l0L2NvbmZpZyc6IFBlcm1pc3Npb24gZGVuaWVkIi4NCj4gPg0KPiA+IFB1cHBldCBp
cyBydW4gYXMgcm9vdCwgc28gSE9NRSBwb2ludHMgdG8gL3Jvb3QsIGJ1dCBzdGlsbCAtZmlsZQ0K
PiA+IHNob3VsZCBvdmVycmlkZSB0aGUgZW52aXJvbm1lbnQgdmFyaWFibGUuDQo+IA0KPiBQcm9i
YWJseS4NCj4gDQo+ID4gSWYgdGhlIHNhbWUgY29tbWFuZCBpcyBydW4gZGlyZWN0bHkgZnJvbSB0
ZXJtaW5hbCBhcyByb290LCBpdCB3b3JrcyBhcyB3ZWxsLg0KPiANCj4gSSBhbSBub3Qgc3VyZSB3
aGF0IHlvdSBtZWFuIGJ5ICJ3b3JrcyBhcyB3ZWxsIi4gIEl0IGJlaGF2ZXMNCj4gZGlmZmVyZW50
bHkgYW5kIGRvZXMgbm90IGZhaWwgdGhlIHNhbWUgd2F5Pw0KPiANCk11c3QgaGF2ZSBiZWVuIHdy
aXRpbmcgc29tZXRoaW5nIGVsc2UgYW5kIGNoYW5nZWQgbXkgbWluZCA6KSBJIHdhcyB0cnlpbmcg
dG8gc2F5IHRoYXQgZXZlcnl0aGluZyB3b3JrcyB3aGVuIHJ1biBmcm9tIHRoZSBjb21tYW5kIGxp
bmUuIFRoZSBwZXJtaXNzaW9uIGRlbmllZCBhcHBlYXJzIHdoZW4gcnVubmluZyB3aXRoIFB1cHBl
dC4gQW5kIFB1cHBldCBpcyBydW4gYXMgcm9vdC4gQW5kIGV2ZW4gaWYgUHVwcGV0IHdhcyBydW4g
YXMgc29tZSBvdGhlciB1c2VyLCBJIHN0aWxsIGRvbid0IHRoaW5rIHRoYXQgR2l0IHNob3VsZCBi
ZSB0cnlpbmcgdG8gdXNlIGFueXRoaW5nIGZyb20gL3Jvb3QsIGFzIHdlJ3JlIGdpdmluZyBpdCB0
aGUgLS1maWxlIHBhcmFtZXRlci4gQXMgaWYgUHVwcGV0IHJlbW92ZWQgdGhlIHdob2xlIC0tZmls
ZSBwYXJhbWV0ZXIgYWx0b2dldGhlci4gQnV0IGFzIGl0IHdvcmtzIHdpdGggYSBuZXdlciBvciBv
bGRlciB2ZXJzaW9uIG9mIEdpdCwgaXQgY2FuJ3QgYmUgZHJvcHBpbmcgdGhlIHBhcmFtZXRlciBv
dXQuIFJvb3QgdXNlciBpcyB0aGUgb25seSBvbmUgd2l0aCBIT01FIHNldCB0byAvcm9vdCwgc28g
aXQgbXVzdCBiZSBnZXR0aW5nIHRoYXQgdmFsdWUgZnJvbSByb290J3MgSE9NRSB2YXJpYWJsZS4N
Cg0KPiA+IFdpdGggMS44LjMuMiB0aGUgcHJvYmxlbSBkaWRuJ3QgcmVvY2N1ci4NCj4gDQo+IFRo
YXQgaXMgcHJvYmFibHkgZHVlIHRvIGIxYzQxOGUxIChNZXJnZSBicmFuY2gNCj4gJ2puL2NvbmZp
Zy1pZ25vcmUtaW5hY2Nlc3NpYmxlJyBpbnRvIG1haW50LCAyMDEzLTA2LTA5KQ0KPiANCj4gQnV0
IGl0IGlzIHB1enpsaW5nLg0KPiANCj4gVGhlICJlcnJvciBvdXQgdXBvbiBhbiBpbmFjY2Vzc2li
bGUgY29uZmlndXJhdGlvbiBmaWxlIGluIHVzdWFsDQo+IHBsYWNlcyIgY2hlY2sgd2UgaGFkIHNp
bmNlIHYxLjguMS4xIHdhcyBtZWFudCB0byBtYWtlIHN1cmUgdGhhdCB5b3UNCj4gd2lsbCBub3Qg
YmUgbWlzc2luZyBhIGJhc2ljIGNvbmZpZ3VyYXRpb24gYmVmb3JlIHJ1bm5pbmcgYW55IGNvbW1h
bmQNCj4gKGluY2x1ZGluZyAiZ2l0IGNvbmZpZyIgaXRzZWxmKS4gIEFzICJyb290IiwgeW91IHNo
b3VsZG4ndCBldmVuIGhhdmUNCj4gdHJpZ2dlcmVkIHRoZSAidW5hYmxlIHRvIGFjY2VzczogUGVy
bWlzc2lvbiBkZW5pbmVkIiBpbiB0aGUgZmlyc3QNCj4gcGxhY2UuICBUaGVyZSBpcyBzb21ldGhp
bmcgZWxzZSBnb2luZyBvbi4NCg0KVGhhdCBpcyBhbHNvIHdlaXJkLCBhZ3JlZWQuDQo=
