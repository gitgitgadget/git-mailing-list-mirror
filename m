From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: [PATCH JGIT] Circular references shouldn't be created
Date: Thu, 17 Sep 2009 21:23:13 +0200
Message-ID: <C89280B882467443A695734861B942B28759DB95@DEWDFECCR09.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 23:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoOT2-0006jz-AI
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 23:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbZIQVY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 17:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754286AbZIQVY3
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 17:24:29 -0400
Received: from smtpde03.sap-ag.de ([155.56.68.140]:43687 "EHLO
	smtpde03.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223AbZIQVY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 17:24:28 -0400
X-Greylist: delayed 7258 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2009 17:24:28 EDT
Received: from mail.sap.corp
	by smtpde03.sap-ag.de (26) with ESMTP id n8HJNTVU019129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Sep 2009 21:23:30 +0200 (MEST)
Received: from DEWDFEHT01.wdf.sap.corp (dewdfeht01.wdf.sap.corp [10.21.23.100])
	by mail.sap.corp (mail02-26) with ESMTP id n8HJNSjb007170
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 17 Sep 2009 21:23:29 +0200 (MEST)
Received: from DEWDFEHT04.wdf.sap.corp (10.21.23.103) by
 DEWDFEHT01.wdf.sap.corp (10.21.23.100) with Microsoft SMTP Server (TLS) id
 8.1.393.1; Thu, 17 Sep 2009 21:23:28 +0200
Received: from DEWDFECCR09.wdf.sap.corp ([fe80::5efe:10.21.23.18]) by
 DEWDFEHT04.wdf.sap.corp ([fe80::5efe:10.21.23.103%15]) with mapi; Thu, 17 Sep
 2009 21:23:28 +0200
Thread-Topic: [PATCH JGIT] Circular references shouldn't be created
Thread-Index: Aco3zEyMOZdHwExhTk6TtC0uOAV35w==
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-puzzleid: {44B14863-4DD9-4836-BBBC-AF9FA3FEC3E0}
x-cr-hashedpuzzle: A0JF BtkE B0c4 DmCs DxEQ EMOT FPHw GcdV Is7d JZQP KCgC
 M+Ob VGK/ V19X bcjy
 frri;3;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA7AHIAbwBiAGkAbgAuAHIAbwBzAGUAbgBiAGUAcgBnAEAAZABlAHcAaQByAGUALgBjAG8AbQA7AHMAcABlAGEAcgBjAGUAQABzAHAAZQBhAHIAYwBlAC4AbwByAGcA;Sosha1_v1;7;{44B14863-4DD9-4836-BBBC-AF9FA3FEC3E0};bQBhAHQAdABoAGkAYQBzAC4AcwBvAGgAbgBAAHMAYQBwAC4AYwBvAG0A;Thu,
 17 Sep 2009 19:23:13
 GMT;WwBQAEEAVABDAEgAIABKAEcASQBUAF0AIABDAGkAcgBjAHUAbABhAHIAIAByAGUAZgBlAHIAZQBuAGMAZQBzACAAcwBoAG8AdQBsAGQAbgAnAHQAIABiAGUAIABjAHIAZQBhAHQAZQBkAA==
acceptlanguage: en-US, de-DE
X-Scanner: Virus Scanner virwal03
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128772>

RnJvbTogTWF0dGhpYXMgU29obiA8bWF0dGhpYXMuc29obkBzYXAuY29tPg0KQ2lyY3VsYXIgcmVm
ZXJlbmNlcyBzaG91bGRuJ3QgYmUgY3JlYXRlZA0KDQpGaXggZm9yIGJ1ZzogaHR0cHM6Ly9idWdz
LmVjbGlwc2Uub3JnL2J1Z3Mvc2hvd19idWcuY2dpP2lkPTI4Njc0Mw0KDQpTaWduZWQtb2ZmLWJ5
OiBNYXR0aGlhcyBTb2huIDxtYXR0aGlhcy5zb2huQHNhcC5jb20+DQotLS0NCiAuLi4vdHN0L29y
Zy9zcGVhcmNlL2pnaXQvbGliL1JlZlRlc3QuamF2YSAgICAgICAgICB8ICAgIDkgKysrKysrKysr
DQogLi4uL3NyYy9vcmcvc3BlYXJjZS9qZ2l0L2xpYi9SZWZEYXRhYmFzZS5qYXZhICAgICAgfCAg
ICA0ICsrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9vcmcuc3BlYXJjZS5qZ2l0LnRlc3QvdHN0L29yZy9zcGVhcmNl
L2pnaXQvbGliL1JlZlRlc3QuamF2YSBiL29yZy5zcGVhcmNlLmpnaXQudGVzdC90c3Qvb3JnL3Nw
ZWFyY2UvamdpdC9saWIvUmVmVGVzdC5qYXZhDQppbmRleCBmYWJiZTdlLi5jZTYzMjhiIDEwMDY0
NA0KLS0tIGEvb3JnLnNwZWFyY2UuamdpdC50ZXN0L3RzdC9vcmcvc3BlYXJjZS9qZ2l0L2xpYi9S
ZWZUZXN0LmphdmENCisrKyBiL29yZy5zcGVhcmNlLmpnaXQudGVzdC90c3Qvb3JnL3NwZWFyY2Uv
amdpdC9saWIvUmVmVGVzdC5qYXZhDQpAQCAtMTU1LDQgKzE1NSwxMyBAQCBwdWJsaWMgdm9pZCB0
ZXN0T3JpZ1Jlc29sdmVkTmFtZXNTeW1SZWYoKSB0aHJvd3MgSU9FeGNlcHRpb24gew0KIAkJYXNz
ZXJ0RXF1YWxzKCJyZWZzL2hlYWRzL21hc3RlciIsIHJlZi5nZXROYW1lKCkpOw0KIAkJYXNzZXJ0
RXF1YWxzKCJIRUFEIiwgcmVmLmdldE9yaWdOYW1lKCkpOw0KIAl9DQorCQ0KKwlwdWJsaWMgdm9p
ZCB0ZXN0SWxsZWdhbENpcmN1bGFyUmVmKCkgdGhyb3dzIElPRXhjZXB0aW9uIHsNCisJCXRyeSB7
DQorCQkJZGIud3JpdGVTeW1yZWYoIkhFQUQiLCAiSEVBRCIpOw0KKwkJCWZhaWwoImNyZWF0aW9u
IG9mIGNpcmN1bGFyIHJlZmVyZW5jZSBzaG91bGQgZmFpbCIpOw0KKwkJfSBjYXRjaCAoSWxsZWdh
bEFyZ3VtZW50RXhjZXB0aW9uIGV4cGVjdGVkKSB7DQorCQkJLy8gYXR0ZW1wdCB0byBjcmVhdGUg
Y2lyY3VsYXIgcmVmZXJlbmNlIHNob3VsZCBmYWlsDQorCQl9DQorCX0NCiB9DQpkaWZmIC0tZ2l0
IGEvb3JnLnNwZWFyY2UuamdpdC9zcmMvb3JnL3NwZWFyY2UvamdpdC9saWIvUmVmRGF0YWJhc2Uu
amF2YSBiL29yZy5zcGVhcmNlLmpnaXQvc3JjL29yZy9zcGVhcmNlL2pnaXQvbGliL1JlZkRhdGFi
YXNlLmphdmENCmluZGV4IDA5Y2I5YmIuLjQ4M2IxZDAgMTAwNjQ0DQotLS0gYS9vcmcuc3BlYXJj
ZS5qZ2l0L3NyYy9vcmcvc3BlYXJjZS9qZ2l0L2xpYi9SZWZEYXRhYmFzZS5qYXZhDQorKysgYi9v
cmcuc3BlYXJjZS5qZ2l0L3NyYy9vcmcvc3BlYXJjZS9qZ2l0L2xpYi9SZWZEYXRhYmFzZS5qYXZh
DQpAQCAtMTc0LDYgKzE3NCwxMCBAQCBSZWZSZW5hbWUgbmV3UmVuYW1lKFN0cmluZyBmcm9tUmVm
LCBTdHJpbmcgdG9SZWYpIHRocm93cyBJT0V4Y2VwdGlvbiB7DQogCSAqIEB0aHJvd3MgSU9FeGNl
cHRpb24NCiAJICovDQogCXZvaWQgbGluayhmaW5hbCBTdHJpbmcgbmFtZSwgZmluYWwgU3RyaW5n
IHRhcmdldCkgdGhyb3dzIElPRXhjZXB0aW9uIHsNCisJCWlmIChuYW1lLmVxdWFscyh0YXJnZXQp
KQ0KKwkJCXRocm93IG5ldyBJbGxlZ2FsQXJndW1lbnRFeGNlcHRpb24oDQorCQkJCQkiaWxsZWdh
bCBjaXJjdWxhciByZWZlcmVuY2UgOiBzeW1yZWYgIiArIG5hbWUNCisJCQkJCQkJKyAiIGNhbm5v
dCByZWZlciB0byAiICsgdGFyZ2V0KTsNCiAJCWZpbmFsIGJ5dGVbXSBjb250ZW50ID0gQ29uc3Rh
bnRzLmVuY29kZSgicmVmOiAiICsgdGFyZ2V0ICsgIlxuIik7DQogCQlsb2NrQW5kV3JpdGVGaWxl
KGZpbGVGb3JSZWYobmFtZSksIGNvbnRlbnQpOw0KIAkJc3luY2hyb25pemVkICh0aGlzKSB7DQot
LSANCjEuNi40Lm1zeXNnaXQuMA0KDQo=
