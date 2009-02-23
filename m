From: <carlos.duclos@nokia.com>
Subject: [PATCH v5] git-archive: Add new option "--output" to write archive
 to a file instead of stdout.
Date: Mon, 23 Feb 2009 09:25:14 +0100
Message-ID: <599636D7828020419E3AB2DE5CCC8130036BF8B1E4@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_599636D7828020419E3AB2DE5CCC8130036BF8B1E4NOKEUMSG02mgd_"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 09:29:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbWBP-0004jR-OT
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 09:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbZBWI12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 03:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbZBWI12
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 03:27:28 -0500
Received: from smtp.nokia.com ([192.100.122.230]:31330 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbZBWI11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 03:27:27 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1N8R5p5015238
	for <git@vger.kernel.org>; Mon, 23 Feb 2009 10:27:24 +0200
Received: from vaebh102.NOE.Nokia.com ([10.160.244.23]) by esebh106.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Feb 2009 10:27:17 +0200
Received: from smtp.mgd.nokia.com ([65.54.30.6]) by vaebh102.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Feb 2009 10:27:08 +0200
Received: from nok-am1mhub-07.mgdnok.nokia.com (65.54.30.14) by
 NOK-am1MHUB-02.mgdnok.nokia.com (65.54.30.6) with Microsoft SMTP Server (TLS)
 id 8.1.291.1; Mon, 23 Feb 2009 09:27:00 +0100
Received: from NOK-EUMSG-02.mgdnok.nokia.com ([65.54.30.107]) by
 nok-am1mhub-07.mgdnok.nokia.com ([65.54.30.14]) with mapi; Mon, 23 Feb 2009
 09:27:00 +0100
Thread-Topic: [PATCH v5] git-archive: Add new option "--output" to write
 archive to a file instead of stdout.
Thread-Index: AQHJlZBuXAfnBcagzk647m9BCZMiGQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 23 Feb 2009 08:27:08.0982 (UTC) FILETIME=[84A22D60:01C99590]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111119>

--_002_599636D7828020419E3AB2DE5CCC8130036BF8B1E4NOKEUMSG02mgd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Patch attached as MIME.

Highlights:
1. Closing output_fd. Notice this is not needed since dup2 will close newfd=
.
2. Moved tests from t0024 to t5000.

Cheers!

--_002_599636D7828020419E3AB2DE5CCC8130036BF8B1E4NOKEUMSG02mgd_
Content-Type: text/x-diff;
	name="0001-git-archive-add-output-file-to-send-output-to-a.patch"
Content-Description: 0001-git-archive-add-output-file-to-send-output-to-a.patch
Content-Disposition: attachment;
	filename="0001-git-archive-add-output-file-to-send-output-to-a.patch";
	size=3590; creation-date="Mon, 23 Feb 2009 09:26:44 GMT";
	modification-date="Mon, 23 Feb 2009 09:26:44 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4YmNiMWYxOGI5YmY5NGFkOWIyYWM1MTc1MDk1Mzk0ZTdkYjQ0YTFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDYXJsb3MgTWFudWVsIER1Y2xvcyBWZXJnYXJhIDxjYXJsb3Mu
ZHVjbG9zQG5va2lhLmNvbT4KRGF0ZTogTW9uLCAxNiBGZWIgMjAwOSAxODoyMDoyNSArMDEwMApT
dWJqZWN0OiBbUEFUQ0hdIGdpdC1hcmNoaXZlOiBhZGQgLS1vdXRwdXQ9PGZpbGU+IHRvIHNlbmQg
b3V0cHV0IHRvIGEgZmlsZSBpbnN0ZWFkIG9mIHN0ZG91dC4KIFdoZW4gYXJjaGl2aW5nIGEgcmVw
b3NpdG9yeSB0aGVyZSBpcyBubyB3YXkgdG8gc3BlY2lmeSBhIGZpbGUgYXMgb3V0cHV0LgogVGhp
cyBwYXRjaCBhZGRzIGEgbmV3IG9wdGlvbiAiLS1vdXRwdXQiIHRoYXQgcmVkaXJlY3RzIHRoZSBv
dXRwdXQgdG8gYSBmaWxlCiBpbnN0ZWFkIG9mIHN0ZG91dC4KClNpZ25lZC1vZmYtYnk6IENhcmxv
cyBNYW51ZWwgRHVjbG9zIFZlcmdhcmEgPGNhcmxvcy5kdWNsb3NAbm9raWEuY29tPgotLS0KIERv
Y3VtZW50YXRpb24vZ2l0LWFyY2hpdmUudHh0IHwgICAgMyArKysKIGFyY2hpdmUuYyAgICAgICAg
ICAgICAgICAgICAgIHwgICAxOCArKysrKysrKysrKysrKysrKysKIHQvdDUwMDAtdGFyLXRyZWUu
c2ggICAgICAgICAgIHwgICAgOCArKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRp
b25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZ2l0LWFy
Y2hpdmUudHh0IGIvRG9jdW1lbnRhdGlvbi9naXQtYXJjaGl2ZS50eHQKaW5kZXggNDFjYmY5Yy4u
NWJkZTE5NyAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9naXQtYXJjaGl2ZS50eHQKKysrIGIv
RG9jdW1lbnRhdGlvbi9naXQtYXJjaGl2ZS50eHQKQEAgLTQ3LDYgKzQ3LDkgQEAgT1BUSU9OUwog
LS1wcmVmaXg9PHByZWZpeD4vOjoKIAlQcmVwZW5kIDxwcmVmaXg+LyB0byBlYWNoIGZpbGVuYW1l
IGluIHRoZSBhcmNoaXZlLgogCistLW91dHB1dD08ZmlsZT46OgorCVdyaXRlIHRoZSBhcmNoaXZl
IHRvIDxmaWxlPiBpbnN0ZWFkIG9mIHN0ZG91dC4KKwogPGV4dHJhPjo6CiAJVGhpcyBjYW4gYmUg
YW55IG9wdGlvbnMgdGhhdCB0aGUgYXJjaGl2ZXIgYmFja2VuZCB1bmRlcnN0YW5kLgogCVNlZSBu
ZXh0IHNlY3Rpb24uCmRpZmYgLS1naXQgYS9hcmNoaXZlLmMgYi9hcmNoaXZlLmMKaW5kZXggZTZk
ZTAzOS4uM2JmNGE3MyAxMDA2NDQKLS0tIGEvYXJjaGl2ZS5jCisrKyBiL2FyY2hpdmUuYwpAQCAt
MjM5LDYgKzIzOSwxOCBAQCBzdGF0aWMgdm9pZCBwYXJzZV90cmVlaXNoX2FyZyhjb25zdCBjaGFy
ICoqYXJndiwKIAlhcl9hcmdzLT50aW1lID0gYXJjaGl2ZV90aW1lOwogfQogCitzdGF0aWMgdm9p
ZCBjcmVhdGVfb3V0cHV0X2ZpbGUoY29uc3QgY2hhciAqb3V0cHV0X2ZpbGUpCit7CisJaW50IG91
dHB1dF9mZCA9IG9wZW4ob3V0cHV0X2ZpbGUsIE9fQ1JFQVQgfCBPX1dST05MWSB8IE9fVFJVTkMs
IDA2NjYpOworCWlmIChvdXRwdXRfZmQgPCAwKQorCQlkaWUoImNvdWxkIG5vdCBjcmVhdGUgYXJj
aGl2ZSBmaWxlOiAlcyAiLCBvdXRwdXRfZmlsZSk7CisJaWYgKG91dHB1dF9mZCAhPSAxKQorCQlp
ZiAoZHVwMihvdXRwdXRfZmQsIDEpIDwgMCkKKwkJCWRpZSgiY291bGQgbm90IHJlZGlyZWN0IG91
dHB1dCIpOworCQllbHNlCisJCQljbG9zZShvdXRwdXRfZmQpOworfQorCiAjZGVmaW5lIE9QVF9f
Q09NUFIocywgdiwgaCwgcCkgXAogCXsgT1BUSU9OX1NFVF9JTlQsIChzKSwgTlVMTCwgKHYpLCBO
VUxMLCAoaCksIFwKIAkgIFBBUlNFX09QVF9OT0FSRyB8IFBBUlNFX09QVF9OT05FRywgTlVMTCwg
KHApIH0KQEAgLTI1Myw2ICsyNjUsNyBAQCBzdGF0aWMgaW50IHBhcnNlX2FyY2hpdmVfYXJncyhp
bnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsCiAJY29uc3QgY2hhciAqYmFzZSA9IE5VTEw7CiAJ
Y29uc3QgY2hhciAqcmVtb3RlID0gTlVMTDsKIAljb25zdCBjaGFyICpleGVjID0gTlVMTDsKKwlj
b25zdCBjaGFyICpvdXRwdXQgPSBOVUxMOwogCWludCBjb21wcmVzc2lvbl9sZXZlbCA9IC0xOwog
CWludCB2ZXJib3NlID0gMDsKIAlpbnQgaTsKQEAgLTI2Miw2ICsyNzUsOCBAQCBzdGF0aWMgaW50
IHBhcnNlX2FyY2hpdmVfYXJncyhpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsCiAJCU9QVF9T
VFJJTkcoMCwgImZvcm1hdCIsICZmb3JtYXQsICJmbXQiLCAiYXJjaGl2ZSBmb3JtYXQiKSwKIAkJ
T1BUX1NUUklORygwLCAicHJlZml4IiwgJmJhc2UsICJwcmVmaXgiLAogCQkJInByZXBlbmQgcHJl
Zml4IHRvIGVhY2ggcGF0aG5hbWUgaW4gdGhlIGFyY2hpdmUiKSwKKwkJT1BUX1NUUklORygwLCAi
b3V0cHV0IiwgJm91dHB1dCwgImZpbGUiLAorCQkJIndyaXRlIHRoZSBhcmNoaXZlIHRvIHRoaXMg
ZmlsZSIpLAogCQlPUFRfX1ZFUkJPU0UoJnZlcmJvc2UpLAogCQlPUFRfX0NPTVBSKCcwJywgJmNv
bXByZXNzaW9uX2xldmVsLCAic3RvcmUgb25seSIsIDApLAogCQlPUFRfX0NPTVBSKCcxJywgJmNv
bXByZXNzaW9uX2xldmVsLCAiY29tcHJlc3MgZmFzdGVyIiwgMSksCkBAIC0yOTQsNiArMzA5LDkg
QEAgc3RhdGljIGludCBwYXJzZV9hcmNoaXZlX2FyZ3MoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiph
cmd2LAogCWlmICghYmFzZSkKIAkJYmFzZSA9ICIiOwogCisJaWYgKG91dHB1dCkKKwkJY3JlYXRl
X291dHB1dF9maWxlKG91dHB1dCk7CisKIAlpZiAobGlzdCkgewogCQlmb3IgKGkgPSAwOyBpIDwg
QVJSQVlfU0laRShhcmNoaXZlcnMpOyBpKyspCiAJCQlwcmludGYoIiVzXG4iLCBhcmNoaXZlcnNb
aV0ubmFtZSk7CmRpZmYgLS1naXQgYS90L3Q1MDAwLXRhci10cmVlLnNoIGIvdC90NTAwMC10YXIt
dHJlZS5zaAppbmRleCBjOTQyYzhiLi4wZDYwZTBlIDEwMDc1NQotLS0gYS90L3Q1MDAwLXRhci10
cmVlLnNoCisrKyBiL3QvdDUwMDAtdGFyLXRyZWUuc2gKQEAgLTc5LDYgKzc5LDEwIEBAIHRlc3Rf
ZXhwZWN0X3N1Y2Nlc3MgXAogICAgICdkaWZmIGIudGFyIGIyLnRhcicKIAogdGVzdF9leHBlY3Rf
c3VjY2VzcyBcCisgICAgJ2dpdCBhcmNoaXZlJyBcCisgICAgJ2dpdCBhcmNoaXZlIC0tb3V0cHV0
PXoudGFyIEhFQUQnCisKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgXAogICAgICdnaXQgYXJjaGl2ZSBp
biBhIGJhcmUgcmVwbycgXAogICAgICcoY2QgYmFyZS5naXQgJiYgZ2l0IGFyY2hpdmUgSEVBRCkg
PmIzLnRhcicKIApAQCAtMTcyLDYgKzE3NiwxMCBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzIFwKICAg
ICAnZ2l0IGFyY2hpdmUgLS1mb3JtYXQ9emlwIHZzLiB0aGUgc2FtZSBpbiBhIGJhcmUgcmVwbycg
XAogICAgICd0ZXN0X2NtcCBkLnppcCBkMS56aXAnCiAKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgXAor
ICAgICdnaXQgYXJjaGl2ZSAtLWZvcm1hdD16aXAnIFwKKyAgICAnZ2l0IGFyY2hpdmUgLS1mb3Jt
YXQ9emlwIC0tb3V0cHV0PXouemlwIEhFQUQnCisKICRVTlpJUCAtdiA+L2Rldi9udWxsIDI+JjEK
IGlmIFsgJD8gLWVxIDEyNyBdOyB0aGVuCiAJZWNobyAiU2tpcHBpbmcgWklQIHRlc3RzLCBiZWNh
dXNlIHVuemlwIHdhcyBub3QgZm91bmQiCi0tIAoxLjYuMi5yYzAuNjMuZzdjYmQwLmRpcnR5Cgo=

--_002_599636D7828020419E3AB2DE5CCC8130036BF8B1E4NOKEUMSG02mgd_--
