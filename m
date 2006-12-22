From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC/PATCH 3/2] Wrap lines in shortlog
Date: Fri, 22 Dec 2006 22:15:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612222208310.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612221030440.18171@xanadu.home> <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-426952902-1166821767=:19693"
Cc: Nicolas Pitre <nico@cam.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 22:16:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxrkN-0006Qo-3c
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 22:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWLVVQD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 16:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWLVVQD
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 16:16:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:53049 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750849AbWLVVQB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 16:16:01 -0500
Received: (qmail invoked by alias); 22 Dec 2006 21:15:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 22 Dec 2006 22:15:59 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
Content-ID: <Pine.LNX.4.63.0612222209400.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35221>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-426952902-1166821767=:19693
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.63.0612222209401.19693@wbgn013.biozentrum.uni-wuerzburg.de>

Hi,

It is nicer to wrap the lines of too long oneline descriptions. This patch 
even works in UTF-8.

The patch is attached, since I cannot find the setting in pine to make it 
a UTF-8 one. Besides, I deliberately fscked up one test case.

Ciao,
Dscho

---1148973799-426952902-1166821767=:19693
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1; NAME=git.txt
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0612222209270.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Description: shortlog.patch
Content-Disposition: ATTACHMENT; FILENAME=git.txt

W1BBVENIXSBVc2UgcHJpbnRfd3JhcHBlZF90ZXh0KCkgaW4gc2hvcnRsb2cN
Cg0KU29tZSBvbmVsaW5lIGRlc2NyaXB0aW9ucyBhcmUganVzdCB0b28gbG9u
Zy4gSW4gc2hvcnRsb2csIGl0IGxvb2tzIG11Y2gNCm5pY2VyIHdoZW4gdGhl
eSBhcmUgd3JhcHBlZC4gU2luY2UgcHJpbnRfd3JhcHBlZF90ZXh0KCkgaXMg
VVRGLTggYXdhcmUsDQppdCBhbHNvIHdvcmtzIHdpdGggdGhvc2UgZGVzY3Jp
cHRpb25zLg0KDQpTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBTY2hpbmRlbGlu
IDxKb2hhbm5lcy5TY2hpbmRlbGluQGdteC5kZT4NCg0KLS0tDQoNCglQcm9i
YWJseSB0aGlzIHNob3VsZCBjaGVjayBpMThuLmNvbW1pdGVuY29kaW5nLCB0
b28uLi4NCg0KIGJ1aWx0aW4tc2hvcnRsb2cuYyAgfCAgICA0ICsrKy0NCiB0
L3Q0MjAxLXNob3J0bG9nLnNoIHwgICA1MCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hh
bmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2J1aWx0aW4tc2hvcnRsb2cuYyBiL2J1aWx0aW4tc2hvcnRs
b2cuYw0KaW5kZXggZWRiNDA0Mi4uMzBlN2NiNSAxMDA2NDQNCi0tLSBhL2J1
aWx0aW4tc2hvcnRsb2cuYw0KKysrIGIvYnVpbHRpbi1zaG9ydGxvZy5jDQpA
QCAtNCw2ICs0LDcgQEANCiAjaW5jbHVkZSAiZGlmZi5oIg0KICNpbmNsdWRl
ICJwYXRoLWxpc3QuaCINCiAjaW5jbHVkZSAicmV2aXNpb24uaCINCisjaW5j
bHVkZSAidXRmOC5oIg0KIA0KIHN0YXRpYyBjb25zdCBjaGFyIHNob3J0bG9n
X3VzYWdlW10gPQ0KICJnaXQtc2hvcnRsb2cgWy1uXSBbLXNdIFs8Y29tbWl0
LWlkPi4uLiBdIjsNCkBAIC0zMjEsNyArMzIyLDggQEAgaW50IGNtZF9zaG9y
dGxvZyhpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIg
KnByZWZpeCkNCiAJCX0gZWxzZSB7DQogCQkJcHJpbnRmKCIlcyAoJWQpOlxu
IiwgbGlzdC5pdGVtc1tpXS5wYXRoLCBvbmVsaW5lcy0+bnIpOw0KIAkJCWZv
ciAoaiA9IG9uZWxpbmVzLT5uciAtIDE7IGogPj0gMDsgai0tKQ0KLQkJCQlw
cmludGYoIiAgICAgICVzXG4iLCBvbmVsaW5lcy0+aXRlbXNbal0ucGF0aCk7
DQorCQkJCXByaW50X3dyYXBwZWRfdGV4dChvbmVsaW5lcy0+aXRlbXNbal0u
cGF0aCwNCisJCQkJCTYsIDksIDc2KTsNCiAJCQlwcmludGYoIlxuIik7DQog
CQl9DQogDQpkaWZmIC0tZ2l0IGEvdC90NDIwMS1zaG9ydGxvZy5zaCBiL3Qv
dDQyMDEtc2hvcnRsb2cuc2gNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRl
eCAwMDAwMDAwLi5lNDA4NWY5DQotLS0gL2Rldi9udWxsDQorKysgYi90L3Q0
MjAxLXNob3J0bG9nLnNoDQpAQCAtMCwwICsxLDUwIEBADQorIyEvYmluL3No
DQorIw0KKyMgQ29weXJpZ2h0IChjKSAyMDA2IEpvaGFubmVzIEUuIFNjaGlu
ZGVsaW4NCisjDQorDQordGVzdF9kZXNjcmlwdGlvbj0nZ2l0LXNob3J0bG9n
DQorJw0KKw0KKy4gLi90ZXN0LWxpYi5zaA0KKw0KK2VjaG8gMSA+IGExDQor
Z2l0IGFkZCBhMQ0KK3RyZWU9JChnaXQgd3JpdGUtdHJlZSkNCitjb21taXQ9
JCgoZWNobyAiVGVzdCI7IGVjaG8pIHwgZ2l0IGNvbW1pdC10cmVlICR0cmVl
KQ0KK2dpdCB1cGRhdGUtcmVmIEhFQUQgJGNvbW1pdCANCisNCitlY2hvIDIg
PiBhMQ0KK2dpdCBjb21taXQgLW0gIlRoaXMgaXMgYSB2ZXJ5LCB2ZXJ5IGxv
bmcgZmlyc3QgbGluZSBmb3IgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIHNlZSBp
ZiBpdCBpcyB3cmFwcGVkIGNvcnJlY3RseSIgYTENCisNCisjIHRlc3QgaWYg
dGhlIHdyYXBwaW5nIGlzIHN0aWxsIHZhbGlkIHdoZW4gcmVwbGFjaW5nIGFs
bCBpJ3MgYnkgdHJlYmxlIGNsZWZzLg0KK2VjaG8gMyA+IGExDQorZ2l0IGNv
bW1pdCAtbSAiJChlY2hvICJUaGlzIGlzIGEgdmVyeSwgdmVyeSBsb25nIGZp
cnN0IGxpbmUgZm9yIHRoZSBjb21taXQgbWVzc2FnZSB0byBzZWUgaWYgaXQg
aXMgd3JhcHBlZCBjb3JyZWN0bHkiIHwgc2VkICJzL2kvMTIzNC9nIiB8IHRy
IDEyMzQgJ1wzNjBcMjM1XDIwNFwyMzYnKSIgYTENCisNCisjIG5vdyBmc2Nr
IHVwIHRoZSB1dGY4DQorZ2l0IHJlcG8tY29uZmlnIGkxOG4uY29tbWl0ZW5j
b2Rpbmcgbm9uLXV0Zi04DQorZWNobyA0ID4gYTENCitnaXQgY29tbWl0IC1t
ICIkKGVjaG8gIlRoaXMgaXMgYSB2ZXJ5LCB2ZXJ5IGxvbmcgZmlyc3QgbGlu
ZSBmb3IgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIHNlZSBpZiBpdCBpcyB3cmFw
cGVkIGNvcnJlY3RseSIgfCBzZWQgInMvaS8xMjM0L2ciIHwgdHIgMTIzNCAn
XDM3MFwyMzVcMjA0XDIzNicpIiBhMQ0KKw0KK2VjaG8gNSA+IGExDQorZ2l0
IGNvbW1pdCAtbSAiYQkJCQkJCQkJMTIJMzQJNTYJNzgiIGExDQorDQorZ2l0
IHNob3J0bG9nIEhFQUQgPiBvdXQNCisNCitjYXQgPiBleHBlY3QgPDwgRU9G
DQorQSBVIFRob3IgKDUpOg0KKyAgICAgIFRlc3QNCisgICAgICBUaGlzIGlz
IGEgdmVyeSwgdmVyeSBsb25nIGZpcnN0IGxpbmUgZm9yIHRoZSBjb21taXQg
bWVzc2FnZSB0byBzZWUgaWYNCisgICAgICAgICBpdCBpcyB3cmFwcGVkIGNv
cnJlY3RseQ0KKyAgICAgIFRo8J2EnnMg8J2EnnMgYSB2ZXJ5LCB2ZXJ5IGxv
bmcgZvCdhJ5yc3QgbPCdhJ5uZSBmb3IgdGhlIGNvbW3wnYSedCBtZXNzYWdl
IHRvIHNlZSDwnYSeZg0KKyAgICAgICAgIPCdhJ50IPCdhJ5zIHdyYXBwZWQg
Y29ycmVjdGx5DQorICAgICAgVGj4nYSecyD4nYSecyBhIHZlcnksIHZlcnkg
bG9uZyBm+J2EnnJzdCBs+J2Enm5lIGZvciB0aGUgY29tbfidhJ50DQorICAg
ICAgICAgbWVzc2FnZSB0byBzZWUg+J2EnmYg+J2EnnQg+J2EnnMgd3JhcHBl
ZCBjb3JyZWN0bHkNCisgICAgICBhCQkJCQkJCQkxMgkzNA0KKyAgICAgICAg
IDU2CTc4DQorDQorRU9GDQorDQordGVzdF9leHBlY3Rfc3VjY2VzcyAnc2hv
cnRsb2cgd3JhcHBpbmcnICdkaWZmIC11IGV4cGVjdCBvdXQnDQorDQordGVz
dF9kb25lDQo=

---1148973799-426952902-1166821767=:19693--
