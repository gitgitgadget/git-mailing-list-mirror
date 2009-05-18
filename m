From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: [JGIT PATCH] FindBugs: Superclass uses subclass during initialization
Date: Mon, 18 May 2009 15:11:58 +0200
Message-ID: <366BBB1215D0AB4B8A153AF047A287800319BD13@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 18 15:12:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M62e8-0000Cj-VX
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 15:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbZERNMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 09:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbZERNMZ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 09:12:25 -0400
Received: from smtpde03.sap-ag.de ([155.56.68.140]:32952 "EHLO
	smtpde03.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbZERNMY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 09:12:24 -0400
Received: from mail.sap.corp
	by smtpde03.sap-ag.de (26) with ESMTP id n4IDCK1Z010358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 May 2009 15:12:20 +0200 (MEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [JGIT PATCH] FindBugs: Superclass uses subclass during initialization
Thread-Index: AcnSjD6Ul5gId49hTjGQDkNS0WsE4AFLUSsQ
X-OriginalArrivalTime: 18 May 2009 13:12:01.0156 (UTC) FILETIME=[3B0FF440:01C9D7BA]
X-Scanner: Virus Scanner virwal04
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119440>

RnJvbTogTWF0dGhpYXMgU29obiA8bWF0dGhpYXMuc29obkBzYXAuY29tPg0KDQpGaW5kQnVncyBy
ZXBvcnRlZCB0aGUgZm9sbG93aW5nIHByb2JsZW0gd2l0aCBoaWdoIHByaW9yaXR5Og0KL3Vzci9z
cmMvZWdpdC9vcmcuc3BlYXJjZS5qZ2l0L3NyYy9vcmcvc3BlYXJjZS9qZ2l0L21lcmdlL01lcmdl
U3RyYXRlZ3kuamF2YTo1OA0KSW5pdGlhbGl6YXRpb24gb2Ygb3JnLnNwZWFyY2UuamdpdC5tZXJn
ZS5NZXJnZVN0cmF0ZWd5IGFjY2Vzc2VzIGNsYXNzDQpvcmcuc3BlYXJjZS5qZ2l0Lm1lcmdlLlN0
cmF0ZWd5U2ltcGxlVHdvV2F5SW5Db3JlLCB3aGljaCBpc24ndA0KaW5pdGlhbGl6ZWQgeWV0Lg0K
DQpUbyBmaXggdGhpcyBwcm9ibGVtIG1vdmUgaW5zdGFudGlhdGlvbiBmcm9tIFN0cmF0ZWd5U2lt
cGxlVHdvV2F5SW5Db3JlDQp1cCB0byB0aGUgYWJzdHJhY3Qgc3VwZXJjbGFzcyBNZXJnZVN0cmF0
ZWd5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBNYXR0aGlhcyBTb2huIDxtYXR0aGlhcy5zb2huQHNhcC5j
b20+DQotLS0NCiAuLi4vc3JjL29yZy9zcGVhcmNlL2pnaXQvbWVyZ2UvTWVyZ2VTdHJhdGVneS5q
YXZhICB8ICAgIDIgKy0NCiAuLi4vamdpdC9tZXJnZS9TdHJhdGVneVNpbXBsZVR3b1dheUluQ29y
ZS5qYXZhICAgICB8ICAgIDIgLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL29yZy5zcGVhcmNlLmpnaXQvc3JjL29yZy9z
cGVhcmNlL2pnaXQvbWVyZ2UvTWVyZ2VTdHJhdGVneS5qYXZhIGIvb3JnLnNwZWFyY2UuamdpdC9z
cmMvb3JnL3NwZWFyY2UvamdpdC9tZXJnZS9NZXJnZVN0cmF0ZWd5LmphdmENCmluZGV4IDU0Mzll
NWMuLmY1Y2VkNzIgMTAwNjQ0DQotLS0gYS9vcmcuc3BlYXJjZS5qZ2l0L3NyYy9vcmcvc3BlYXJj
ZS9qZ2l0L21lcmdlL01lcmdlU3RyYXRlZ3kuamF2YQ0KKysrIGIvb3JnLnNwZWFyY2UuamdpdC9z
cmMvb3JnL3NwZWFyY2UvamdpdC9tZXJnZS9NZXJnZVN0cmF0ZWd5LmphdmENCkBAIC01NSw3ICs1
NSw3IEBADQogCXB1YmxpYyBzdGF0aWMgZmluYWwgTWVyZ2VTdHJhdGVneSBUSEVJUlMgPSBuZXcg
U3RyYXRlZ3lPbmVTaWRlZCgidGhlaXJzIiwgMSk7DQogDQogCS8qKiBTaW1wbGUgc3RyYXRlZ3kg
dG8gbWVyZ2UgcGF0aHMsIHdpdGhvdXQgc2ltdWx0YW5lb3VzIGVkaXRzLiAqLw0KLQlwdWJsaWMg
c3RhdGljIGZpbmFsIFRocmVlV2F5TWVyZ2VTdHJhdGVneSBTSU1QTEVfVFdPX1dBWV9JTl9DT1JF
ID0gU3RyYXRlZ3lTaW1wbGVUd29XYXlJbkNvcmUuSU5TVEFOQ0U7DQorCXB1YmxpYyBzdGF0aWMg
ZmluYWwgVGhyZWVXYXlNZXJnZVN0cmF0ZWd5IFNJTVBMRV9UV09fV0FZX0lOX0NPUkUgPSBuZXcg
U3RyYXRlZ3lTaW1wbGVUd29XYXlJbkNvcmUoKTsNCiANCiAJcHJpdmF0ZSBzdGF0aWMgZmluYWwg
SGFzaE1hcDxTdHJpbmcsIE1lcmdlU3RyYXRlZ3k+IFNUUkFURUdJRVMgPSBuZXcgSGFzaE1hcDxT
dHJpbmcsIE1lcmdlU3RyYXRlZ3k+KCk7DQogDQpkaWZmIC0tZ2l0IGEvb3JnLnNwZWFyY2Uuamdp
dC9zcmMvb3JnL3NwZWFyY2UvamdpdC9tZXJnZS9TdHJhdGVneVNpbXBsZVR3b1dheUluQ29yZS5q
YXZhIGIvb3JnLnNwZWFyY2UuamdpdC9zcmMvb3JnL3NwZWFyY2UvamdpdC9tZXJnZS9TdHJhdGVn
eVNpbXBsZVR3b1dheUluQ29yZS5qYXZhDQppbmRleCA1ZDQ0NDdjLi42MjZmZTA2IDEwMDY0NA0K
LS0tIGEvb3JnLnNwZWFyY2UuamdpdC9zcmMvb3JnL3NwZWFyY2UvamdpdC9tZXJnZS9TdHJhdGVn
eVNpbXBsZVR3b1dheUluQ29yZS5qYXZhDQorKysgYi9vcmcuc3BlYXJjZS5qZ2l0L3NyYy9vcmcv
c3BlYXJjZS9qZ2l0L21lcmdlL1N0cmF0ZWd5U2ltcGxlVHdvV2F5SW5Db3JlLmphdmENCkBAIC02
MSw4ICs2MSw2IEBADQogICogZmlsZSBjb250ZW50cy4NCiAgKi8NCiBwdWJsaWMgY2xhc3MgU3Ry
YXRlZ3lTaW1wbGVUd29XYXlJbkNvcmUgZXh0ZW5kcyBUaHJlZVdheU1lcmdlU3RyYXRlZ3kgew0K
LQlzdGF0aWMgZmluYWwgVGhyZWVXYXlNZXJnZVN0cmF0ZWd5IElOU1RBTkNFID0gbmV3IFN0cmF0
ZWd5U2ltcGxlVHdvV2F5SW5Db3JlKCk7DQotDQogCS8qKiBDcmVhdGUgYSBuZXcgaW5zdGFuY2Ug
b2YgdGhlIHN0cmF0ZWd5LiAqLw0KIAlwcm90ZWN0ZWQgU3RyYXRlZ3lTaW1wbGVUd29XYXlJbkNv
cmUoKSB7DQogCQkvLw0KLS0gDQoxLjYuMy4xLjMwLmc1NTUyNA0KDQo=
