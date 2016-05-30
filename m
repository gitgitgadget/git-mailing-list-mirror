From: tboegi@web.de
Subject: [PATCH v1 1/1] t6038: different eol for "Merge addition of text=auto"
Date: Mon, 30 May 2016 19:00:46 +0200
Message-ID: <1464627646-24041-1-git-send-email-tboegi@web.de>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 18:55:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7QT3-0002wj-PV
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 18:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161746AbcE3Qyy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 12:54:54 -0400
Received: from mout.web.de ([212.227.17.11]:56794 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161626AbcE3Qyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 12:54:53 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LetQh-1brRzh0Fpf-00qi0z; Mon, 30 May 2016 18:54:50
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:AEPLPHtTvskv8hxvJg3CRzhdAu0f3+PKGDlRJCXP4CRdpF9eGjQ
 +mU8GXYXe9H6cprxPyMx6X6axqVzQdLe5SZ+gISUKGbo11v/5G9aNjy1krrffc7Q62DrSMS
 7wSuTocWuUdvOoTlqy08EVBiuaJayquKMyYG0I8N2vAlmOl4e1OIYsjTTLmooGiPXbXIRpY
 4Dlpmuy1mT649RFxbH12A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YS/OPq66fGA=:QWYQiy3iagSyzGTzaA4q4c
 7REDgSr9s8yiug5AxpWwfow6w0DxIMi1VFMCbXT+D/Hy/HK+IefgA7bC4gfaOVkgndAQKxS3z
 OUh6TD8oYpbdMgmctbgcF4oqpXAzowKyQkuS3PC2AanuJMVi1UIh03uybkuRRX7gpeYUMGfD9
 8t7CjMJ6h3Tv534Kiha2b+bpvzAEvwreZ0DS69pSLRS2PCF5MFt0y1QGiVhje61L/L3b1XwOl
 SpQjD5Or5QpevuKqW2qWbgeBFT3Fy1TWOtHZZg/0UAiqmy/H5xytHGs7bS1hxV/IH340nrKmN
 nPkKeI3dbvkjFcbIrrqHBF+ofJOAm6aqNNF6FeYqxtG2I7A/IppePVH6o4q3esl/zrKdH9tsw
 MsWb2NYgzraXjqjkODZFgjh4O/3/rFLL9aSHRJoR8fjHMPSm6mE56l3Mj4nA5nUTstC41M5HY
 9D98PS7fZ34VepVGjkeE3Ioj22mGcBpdqIhD5gY1tWn+0PwoaLxmy46Hr4LlnZJ45WVeoObPI
 6sQ3KaNIPChAEAtpjrdoaXfw6r4AFNIf/zQaS6dtMItuCuWftnM7pIUuPlXABAG48IwGNR7ND
 I8Pal0pFPozBNXW58p7+984wJu1yjkQEVqYQZGqVrnH4RcFn1lfdock9IdE4edHZq37ZKBW2N
 cEKwrdvVShRzUyoCEMOy4VTg6PzW1O0jLWEy+xjzw/lkU6WShTVFE6NFXn9Ccaf8jfbvzg37M
 rU//uHd+Ce3k0BbzDEBVzuYnClu32df2kWj758CcRlsR+PrKKZmVkODawZcz/Fep9toG2Y1F 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295910>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

t6038 uses different code, depending if NATIVE_CRLF is set ot not.

Enhance the test coverage for cross-platform testing and run
"Merge addition of text=3Dauto" with both lf and crlf as core.eol.

It is important to be run this test with crlf under Linux,
the day when the "unified auto handling will be introduced.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t6038-merge-text-auto.sh | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 33b77ee..8846f5d 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -91,16 +91,13 @@ test_expect_success 'Merge after setting text=3Daut=
o' '
 	compare_files expected file
 '
=20
-test_expect_success 'Merge addition of text=3Dauto' '
+test_expect_success 'Merge addition of text=3Dauto eol=3DLF' '
+	git config core.eol lf &&
 	cat <<-\EOF >expected &&
 	first line
 	same line
 	EOF
=20
-	if test_have_prereq NATIVE_CRLF; then
-		append_cr <expected >expected.temp &&
-		mv expected.temp expected
-	fi &&
 	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
@@ -109,7 +106,28 @@ test_expect_success 'Merge addition of text=3Dauto=
' '
 	compare_files  expected file
 '
=20
+test_expect_success 'Merge addition of text=3Dauto eol=3DCRLF' '
+	git config core.eol crlf &&
+	cat <<-\EOF >expected &&
+	first line
+	same line
+	EOF
+
+	append_cr <expected >expected.temp &&
+	mv expected.temp expected &&
+	git config merge.renormalize true &&
+	git rm -fr . &&
+	rm -f .gitattributes &&
+	git reset --hard b &&
+	echo >&2 "After git reset --hard b" &&
+	git ls-files -s --eol >&2 &&
+	git merge a &&
+	compare_files  expected file
+'
+
+
 test_expect_success 'Detect CRLF/LF conflict after setting text=3Dauto=
' '
+	git config core.eol native &&
 	echo "<<<<<<<" >expected &&
 	if test_have_prereq NATIVE_CRLF; then
 		echo first line | append_cr >>expected &&
--=20
2.0.0.rc1.6318.g0c2c796
