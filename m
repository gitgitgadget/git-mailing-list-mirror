From: <carlos.duclos@nokia.com>
Subject: [PATCH v4] git-archive: Add new option "--output" to write archive
 to a file instead of stdout.
Date: Wed, 18 Feb 2009 10:05:33 +0100
Message-ID: <599636D7828020419E3AB2DE5CCC8130036BF8B1DC@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_599636D7828020419E3AB2DE5CCC8130036BF8B1DCNOKEUMSG02mgd_"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 10:10:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZiRj-0006pN-LN
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 10:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbZBRJI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 04:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbZBRJIz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 04:08:55 -0500
Received: from smtp.nokia.com ([192.100.122.233]:52007 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbZBRJIx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 04:08:53 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1I98Uda002002
	for <git@vger.kernel.org>; Wed, 18 Feb 2009 11:08:48 +0200
Received: from vaebh104.NOE.Nokia.com ([10.160.244.30]) by vaebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 18 Feb 2009 11:08:28 +0200
Received: from smtp.mgd.nokia.com ([65.54.30.5]) by vaebh104.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 18 Feb 2009 11:08:19 +0200
Received: from nok-am1mhub-08.mgdnok.nokia.com (65.54.30.15) by
 NOK-am1MHUB-01.mgdnok.nokia.com (65.54.30.5) with Microsoft SMTP Server (TLS)
 id 8.1.291.1; Wed, 18 Feb 2009 10:08:19 +0100
Received: from NOK-EUMSG-02.mgdnok.nokia.com ([65.54.30.107]) by
 nok-am1mhub-08.mgdnok.nokia.com ([65.54.30.15]) with mapi; Wed, 18 Feb 2009
 10:08:19 +0100
Thread-Topic: [PATCH v4] git-archive: Add new option "--output" to write
 archive to a file instead of stdout.
Thread-Index: AQHJkahmyi67RZJmlk+NrwX5VcwZwg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 18 Feb 2009 09:08:19.0669 (UTC) FILETIME=[71365850:01C991A8]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110516>

--_002_599636D7828020419E3AB2DE5CCC8130036BF8B1DCNOKEUMSG02mgd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Patch attached as MIME.

Patch highlights:
1. Remove duplicated tests
1.1 Tests are present on t0024.
1.2 Introduced some comments in t5000 to make it easy to read.
2. Removed close(2) and comments from archive.c
3. Rewrote commit message.
4. Signed off.

Cheers!

--_002_599636D7828020419E3AB2DE5CCC8130036BF8B1DCNOKEUMSG02mgd_
Content-Type: text/x-diff;
	name="0001-git-archive-add-output-file-to-send-output-to-a.patch"
Content-Description: 0001-git-archive-add-output-file-to-send-output-to-a.patch
Content-Disposition: attachment;
	filename="0001-git-archive-add-output-file-to-send-output-to-a.patch";
	size=4260; creation-date="Wed, 18 Feb 2009 10:08:10 GMT";
	modification-date="Wed, 18 Feb 2009 10:08:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzYTE0MzI0NGI4NGQ4MGFkYmE5MWYzNzMwN2UzMGVjOGZiM2E2NzAxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDYXJsb3MgTWFudWVsIER1Y2xvcyBWZXJnYXJhIDxjYXJsb3Mu
ZHVjbG9zQG5va2lhLmNvbT4KRGF0ZTogTW9uLCAxNiBGZWIgMjAwOSAxODoyMDoyNSArMDEwMApT
dWJqZWN0OiBbUEFUQ0hdIGdpdC1hcmNoaXZlOiBhZGQgLS1vdXRwdXQ9PGZpbGU+IHRvIHNlbmQg
b3V0cHV0IHRvIGEgZmlsZSBpbnN0ZWFkIG9mIHN0ZG91dC4KIFdoZW4gYXJjaGl2aW5nIGEgcmVw
b3NpdG9yeSB0aGVyZSBpcyBubyB3YXkgdG8gc3BlY2lmeSBhIGZpbGUgYXMgb3V0cHV0LgogVGhp
cyBwYXRjaCBhZGRzIGEgbmV3IG9wdGlvbiAiLS1vdXRwdXQiIHRoYXQgcmVkaXJlY3RzIHRoZSBv
dXRwdXQgdG8gYSBmaWxlCiBpbnN0ZWFkIG9mIHN0ZG91dC4KClNpZ25lZC1vZmYtYnk6IENhcmxv
cyBNYW51ZWwgRHVjbG9zIFZlcmdhcmEgPGNhcmxvcy5kdWNsb3NAbm9raWEuY29tPgotLS0KIERv
Y3VtZW50YXRpb24vZ2l0LWFyY2hpdmUudHh0IHwgICAgMyArKysKIGFyY2hpdmUuYyAgICAgICAg
ICAgICAgICAgICAgIHwgICAxNiArKysrKysrKysrKysrKysrCiB0L3QwMDI0LWNybGYtYXJjaGl2
ZS5zaCAgICAgICB8ICAgMTkgKysrKysrKysrKysrKysrKysrKwogdC90NTAwMC10YXItdHJlZS5z
aCAgICAgICAgICAgfCAgICA4ICsrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlv
bnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9naXQtYXJj
aGl2ZS50eHQgYi9Eb2N1bWVudGF0aW9uL2dpdC1hcmNoaXZlLnR4dAppbmRleCA0MWNiZjljLi41
YmRlMTk3IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2dpdC1hcmNoaXZlLnR4dAorKysgYi9E
b2N1bWVudGF0aW9uL2dpdC1hcmNoaXZlLnR4dApAQCAtNDcsNiArNDcsOSBAQCBPUFRJT05TCiAt
LXByZWZpeD08cHJlZml4Pi86OgogCVByZXBlbmQgPHByZWZpeD4vIHRvIGVhY2ggZmlsZW5hbWUg
aW4gdGhlIGFyY2hpdmUuCiAKKy0tb3V0cHV0PTxmaWxlPjo6CisJV3JpdGUgdGhlIGFyY2hpdmUg
dG8gPGZpbGU+IGluc3RlYWQgb2Ygc3Rkb3V0LgorCiA8ZXh0cmE+OjoKIAlUaGlzIGNhbiBiZSBh
bnkgb3B0aW9ucyB0aGF0IHRoZSBhcmNoaXZlciBiYWNrZW5kIHVuZGVyc3RhbmQuCiAJU2VlIG5l
eHQgc2VjdGlvbi4KZGlmZiAtLWdpdCBhL2FyY2hpdmUuYyBiL2FyY2hpdmUuYwppbmRleCBlNmRl
MDM5Li4zYTY0NmU1IDEwMDY0NAotLS0gYS9hcmNoaXZlLmMKKysrIGIvYXJjaGl2ZS5jCkBAIC0y
MzksNiArMjM5LDE2IEBAIHN0YXRpYyB2b2lkIHBhcnNlX3RyZWVpc2hfYXJnKGNvbnN0IGNoYXIg
Kiphcmd2LAogCWFyX2FyZ3MtPnRpbWUgPSBhcmNoaXZlX3RpbWU7CiB9CiAKK3N0YXRpYyB2b2lk
IGNyZWF0ZV9vdXRwdXRfZmlsZShjb25zdCBjaGFyICpvdXRwdXRfZmlsZSkKK3sKKwlpbnQgb3V0
cHV0X2ZkID0gb3BlbihvdXRwdXRfZmlsZSwgT19DUkVBVCB8IE9fV1JPTkxZIHwgT19UUlVOQywg
MDY2Nik7CisJaWYgKG91dHB1dF9mZCA8IDApCisJCWRpZSgiY291bGQgbm90IGNyZWF0ZSBhcmNo
aXZlIGZpbGU6ICVzICIsIG91dHB1dF9maWxlKTsKKwlpZiAob3V0cHV0X2ZkICE9IDEpCisJCWlm
IChkdXAyKG91dHB1dF9mZCwgMSkgPCAwKQorCQkJZGllKCJjb3VsZCBub3QgcmVkaXJlY3Qgb3V0
cHV0Iik7Cit9CisKICNkZWZpbmUgT1BUX19DT01QUihzLCB2LCBoLCBwKSBcCiAJeyBPUFRJT05f
U0VUX0lOVCwgKHMpLCBOVUxMLCAodiksIE5VTEwsIChoKSwgXAogCSAgUEFSU0VfT1BUX05PQVJH
IHwgUEFSU0VfT1BUX05PTkVHLCBOVUxMLCAocCkgfQpAQCAtMjUzLDYgKzI2Myw3IEBAIHN0YXRp
YyBpbnQgcGFyc2VfYXJjaGl2ZV9hcmdzKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwKIAlj
b25zdCBjaGFyICpiYXNlID0gTlVMTDsKIAljb25zdCBjaGFyICpyZW1vdGUgPSBOVUxMOwogCWNv
bnN0IGNoYXIgKmV4ZWMgPSBOVUxMOworCWNvbnN0IGNoYXIgKm91dHB1dCA9IE5VTEw7CiAJaW50
IGNvbXByZXNzaW9uX2xldmVsID0gLTE7CiAJaW50IHZlcmJvc2UgPSAwOwogCWludCBpOwpAQCAt
MjYyLDYgKzI3Myw4IEBAIHN0YXRpYyBpbnQgcGFyc2VfYXJjaGl2ZV9hcmdzKGludCBhcmdjLCBj
b25zdCBjaGFyICoqYXJndiwKIAkJT1BUX1NUUklORygwLCAiZm9ybWF0IiwgJmZvcm1hdCwgImZt
dCIsICJhcmNoaXZlIGZvcm1hdCIpLAogCQlPUFRfU1RSSU5HKDAsICJwcmVmaXgiLCAmYmFzZSwg
InByZWZpeCIsCiAJCQkicHJlcGVuZCBwcmVmaXggdG8gZWFjaCBwYXRobmFtZSBpbiB0aGUgYXJj
aGl2ZSIpLAorCQlPUFRfU1RSSU5HKDAsICJvdXRwdXQiLCAmb3V0cHV0LCAiZmlsZSIsIAorCQkJ
IndyaXRlIHRoZSBhcmNoaXZlIHRvIHRoaXMgZmlsZSIpLAogCQlPUFRfX1ZFUkJPU0UoJnZlcmJv
c2UpLAogCQlPUFRfX0NPTVBSKCcwJywgJmNvbXByZXNzaW9uX2xldmVsLCAic3RvcmUgb25seSIs
IDApLAogCQlPUFRfX0NPTVBSKCcxJywgJmNvbXByZXNzaW9uX2xldmVsLCAiY29tcHJlc3MgZmFz
dGVyIiwgMSksCkBAIC0yOTQsNiArMzA3LDkgQEAgc3RhdGljIGludCBwYXJzZV9hcmNoaXZlX2Fy
Z3MoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LAogCWlmICghYmFzZSkKIAkJYmFzZSA9ICIi
OwogCisJaWYgKG91dHB1dCkKKwkJY3JlYXRlX291dHB1dF9maWxlKG91dHB1dCk7CisKIAlpZiAo
bGlzdCkgewogCQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShhcmNoaXZlcnMpOyBpKyspCiAJ
CQlwcmludGYoIiVzXG4iLCBhcmNoaXZlcnNbaV0ubmFtZSk7CmRpZmYgLS1naXQgYS90L3QwMDI0
LWNybGYtYXJjaGl2ZS5zaCBiL3QvdDAwMjQtY3JsZi1hcmNoaXZlLnNoCmluZGV4IGU1MzMwMzku
LjIzN2E4ZjYgMTAwNzU1Ci0tLSBhL3QvdDAwMjQtY3JsZi1hcmNoaXZlLnNoCisrKyBiL3QvdDAw
MjQtY3JsZi1hcmNoaXZlLnNoCkBAIC0yNiw2ICsyNiwxNSBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNz
ICd0YXIgYXJjaGl2ZScgJwogCiAnCiAKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ3RhciBhcmNoaXZl
IG91dHB1dCByZWRpcmVjdGVkJyAnCisKKwlnaXQgYXJjaGl2ZSAtLWZvcm1hdD10YXIgLS1vdXRw
dXQ9dGVzdC50YXIgSEVBRCAmJgorCSggbWtkaXIgdW50YXJyZWQyICYmIGNkIHVudGFycmVkMiAm
JiAiJFRBUiIgLXhmIC4uL3Rlc3QudGFyICkKKworCXRlc3RfY21wIHNhbXBsZSB1bnRhcnJlZDIv
c2FtcGxlCisKKycKKwogIiRVTlpJUCIgLXYgPi9kZXYvbnVsbCAyPiYxCiBpZiBbICQ/IC1lcSAx
MjcgXTsgdGhlbgogCWVjaG8gIlNraXBwaW5nIFpJUCB0ZXN0LCBiZWNhdXNlIHVuemlwIHdhcyBu
b3QgZm91bmQiCkBAIC00Myw0ICs1MiwxNCBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzICd6aXAgYXJj
aGl2ZScgJwogCiAnCiAKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ3ppcCBhcmNoaXZlIG91dHB1dCBy
ZWRpcmVjdGVkJyAnCisKKwlnaXQgYXJjaGl2ZSAtLWZvcm1hdD16aXAgLS1vdXRwdXQ9dGVzdC56
aXAgSEVBRCAmJgorCisJKCBta2RpciB1bnppcHBlZDIgJiYgY2QgdW56aXBwZWQyICYmIHVuemlw
IC4uL3Rlc3QuemlwICkgJiYKKworCXRlc3RfY21wIHNhbXBsZSB1bnppcHBlZDIvc2FtcGxlCisK
KycKKwogdGVzdF9kb25lCmRpZmYgLS1naXQgYS90L3Q1MDAwLXRhci10cmVlLnNoIGIvdC90NTAw
MC10YXItdHJlZS5zaAppbmRleCBjOTQyYzhiLi5hNzRkZDRhIDEwMDc1NQotLS0gYS90L3Q1MDAw
LXRhci10cmVlLnNoCisrKyBiL3QvdDUwMDAtdGFyLXRyZWUuc2gKQEAgLTY2LDYgKzY2LDExIEBA
IHRlc3RfZXhwZWN0X3N1Y2Nlc3MgXAogICAgICdyZW1vdmUgaWdub3JlZCBmaWxlJyBcCiAgICAg
J3JtIGEvaWdub3JlZCcKIAorCisjCisjIFRhciB0ZXN0cworIworCiB0ZXN0X2V4cGVjdF9zdWNj
ZXNzIFwKICAgICAnZ2l0IGFyY2hpdmUnIFwKICAgICAnZ2l0IGFyY2hpdmUgSEVBRCA+Yi50YXIn
CkBAIC0xNTksNiArMTY0LDkgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyBcCiAgICAgICBkaWZmIGcv
cHJlZml4L2Evc3Vic3RmaWxlMS5leHBlY3RlZCBnL3ByZWZpeC9hL3N1YnN0ZmlsZTEgJiYKICAg
ICAgIGRpZmYgYS9zdWJzdGZpbGUyIGcvcHJlZml4L2Evc3Vic3RmaWxlMgogJworIworIyBaaXAg
dGVzdHMKKyMKIAogdGVzdF9leHBlY3Rfc3VjY2VzcyBcCiAgICAgJ2dpdCBhcmNoaXZlIC0tZm9y
bWF0PXppcCcgXAotLSAKMS42LjIucmMwLjYzLmc3Y2JkMC5kaXJ0eQoK

--_002_599636D7828020419E3AB2DE5CCC8130036BF8B1DCNOKEUMSG02mgd_--
