From: "Schmidt, Marco" <Marco.Schmidt@cassidian.com>
Subject: Allow NTLM-Authentication against a http-proxy server
Date: Tue, 21 Feb 2012 15:31:46 +0100
Message-ID: <4CDEC141B5583D408E79F2931DB7708301802C40@GSX300A.mxchg.m.corp>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01CCF0A5.8CE7AF5A"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 21 15:32:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzqlC-000849-VC
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 15:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab2BUOcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 09:32:00 -0500
Received: from mail.eads.net ([80.156.45.113]:43745 "EHLO mail.eads.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950Ab2BUOb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 09:31:59 -0500
Received: from gsx3072-vs5.mxchg.m.corp ([53.147.176.149])
	by mail.eads.net (8.13.8/8.13.8/Debian-2) with ESMTP id q1LEVREk021821
	for <git@vger.kernel.org>; Tue, 21 Feb 2012 15:31:33 +0100
Received: from gsx300a.mxchg.m.corp ([10.43.212.131]) by gsx3072-vs5.mxchg.m.corp with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 21 Feb 2012 15:31:50 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Allow NTLM-Authentication against a http-proxy server
Thread-Index: AczwpYnkENfk0U5lSGyciOzNWe1wNQ==
X-OriginalArrivalTime: 21 Feb 2012 14:31:50.0761 (UTC) FILETIME=[8CB16D90:01CCF0A5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191161>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CCF0A5.8CE7AF5A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

After some back and forward - here is my patch to support
NTLM-authentication against a http-proxy server again.=20

Big thanks are going to Thomas Rast for helping to fiddle the patch to a
more correct form and his commit message ;).=20

Marco Schmidt



=20

------_=_NextPart_001_01CCF0A5.8CE7AF5A
Content-Type: application/octet-stream;
	name="0001-http-curl-let-user-configure-any-proxy-authenticatio.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-http-curl-let-user-configure-any-proxy-authenticatio.patch
Content-Disposition: attachment;
	filename="0001-http-curl-let-user-configure-any-proxy-authenticatio.patch"

RnJvbSBmNGUxMTJlNDFhZWY3NWYwODUzMmZkYTUzYTFiOTAyMTIwOGEzNzc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJjbyBTY2htaWR0IDxNYXJjby5TY2htaWR0QGNhc3NpZGlh
bi5jb20+CkRhdGU6IFR1ZSwgMjEgRmViIDIwMTIgMTI6MzA6MjkgKzAxMDAKU3ViamVjdDogW1BB
VENIXSBodHRwL2N1cmw6IGxldCB1c2VyIGNvbmZpZ3VyZSAiYW55IiBwcm94eSBhdXRoZW50aWNh
dGlvbgoKICBOb3JtYWxseSwgY3VybCB1c2VzIG9ubHkgdGhlICJiYXNpYyIgYXV0aGVudGljYXRp
b24gc2NoZW1lIHdoZW4KICB0YWxraW5nIHRvIHByb3hpZXMsIHdoaWNoIG1heSBub3QgYmUgZGVz
aXJhYmxlIChpdCBzZW5kcyB0aGUgcGFzc3dvcmQKICBpbiBjbGVhcnRleHQpIG9yIHN1ZmZpY2ll
bnQgKHRoZSBhdXRob3IgbmVlZHMgTlRMTSBhdXRoZW50aWNhdGlvbiBmb3IKICBoaXMgcHJveHkp
LgoKICBJbnRyb2R1Y2UgdGhlIGNvbmZpZyBzZXR0aW5nIGh0dHAucHJveHlBdXRoQW55LiAgV2hl
biBlbmFibGVkLCB3ZSB0ZWxsCiAgY3VybCB0byB1c2UgYW55IGF1dGhlbnRpY2F0aW9uIHNjaGVt
ZSBzdXBwb3J0ZWQgYnkgdGhlIHByb3h5Ci0tLQogaHR0cC5jIHwgICAxMiArKysrKysrKysrKysK
IDEgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9odHRwLmMgYi9odHRwLmMKaW5kZXggMGZmZDc5Yy4uNWM1NWVmZCAxMDA2NDQKLS0t
IGEvaHR0cC5jCisrKyBiL2h0dHAuYwpAQCAtNDEsNiArNDEsNyBAQCBzdGF0aWMgbG9uZyBjdXJs
X2xvd19zcGVlZF9saW1pdCA9IC0xOwogc3RhdGljIGxvbmcgY3VybF9sb3dfc3BlZWRfdGltZSA9
IC0xOwogc3RhdGljIGludCBjdXJsX2Z0cF9ub19lcHN2Owogc3RhdGljIGNvbnN0IGNoYXIgKmN1
cmxfaHR0cF9wcm94eTsKK3N0YXRpYyBpbnQgY3VybF9odHRwX3Byb3h5YXV0aGFueSA9IDA7CiBz
dGF0aWMgY29uc3QgY2hhciAqY3VybF9jb29raWVfZmlsZTsKIHN0YXRpYyBzdHJ1Y3QgY3JlZGVu
dGlhbCBodHRwX2F1dGggPSBDUkVERU5USUFMX0lOSVQ7CiBzdGF0aWMgaW50IGh0dHBfcHJvYWN0
aXZlX2F1dGg7CkBAIC0xOTAsNiArMTkxLDExIEBAIHN0YXRpYyBpbnQgaHR0cF9vcHRpb25zKGNv
bnN0IGNoYXIgKnZhciwgY29uc3QgY2hhciAqdmFsdWUsIHZvaWQgKmNiKQogCX0KIAlpZiAoIXN0
cmNtcCgiaHR0cC5wcm94eSIsIHZhcikpCiAJCXJldHVybiBnaXRfY29uZmlnX3N0cmluZygmY3Vy
bF9odHRwX3Byb3h5LCB2YXIsIHZhbHVlKTsKKwkKKwlpZiAoIXN0cmNtcCgiaHR0cC5wcm94eWF1
dGhhbnkiLCB2YXIpKSB7CisJCWN1cmxfaHR0cF9wcm94eWF1dGhhbnkgPSBnaXRfY29uZmlnX2Jv
b2wodmFyLCB2YWx1ZSk7CisJCXJldHVybiAwOworCX0KIAogCWlmICghc3RyY21wKCJodHRwLmNv
b2tpZWZpbGUiLCB2YXIpKQogCQlyZXR1cm4gZ2l0X2NvbmZpZ19zdHJpbmcoJmN1cmxfY29va2ll
X2ZpbGUsIHZhciwgdmFsdWUpOwpAQCAtMjk3LDYgKzMwMywxMiBAQCBzdGF0aWMgQ1VSTCAqZ2V0
X2N1cmxfaGFuZGxlKHZvaWQpCiAKIAlpZiAoY3VybF9odHRwX3Byb3h5KQogCQljdXJsX2Vhc3lf
c2V0b3B0KHJlc3VsdCwgQ1VSTE9QVF9QUk9YWSwgY3VybF9odHRwX3Byb3h5KTsKKwkKKyNpZmRl
ZiBMSUJDVVJMX0NBTl9IQU5ETEVfQVVUSF9BTlkJCisJaWYgKGN1cmxfaHR0cF9wcm94eWF1dGhh
bnkpIHsKKwkJY3VybF9lYXN5X3NldG9wdChyZXN1bHQsIENVUkxPUFRfUFJPWFlBVVRILCBDVVJM
QVVUSF9BTlkpOworCX0KKyNlbmRpZgogCiAJcmV0dXJuIHJlc3VsdDsKIH0KLS0gCjEuNy43LjEu
bXN5c2dpdC4wCgo=

------_=_NextPart_001_01CCF0A5.8CE7AF5A--
