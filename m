From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v4 1/6] t7401: make indentation consistent
Date: Sun, 16 Jun 2013 15:18:13 +0100
Message-ID: <30d8ca8ceafca970c9028b751761393f3e2ded90.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 16:19:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoDnK-00015l-0x
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 16:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209Ab3FPOSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 10:18:55 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:37816 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3FPOSv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 10:18:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 47D536064D5;
	Sun, 16 Jun 2013 15:18:51 +0100 (BST)
X-Quarantine-ID: <PEHGFz30scMr>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PEHGFz30scMr; Sun, 16 Jun 2013 15:18:50 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 8B8C36064CE;
	Sun, 16 Jun 2013 15:18:49 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 7C230161E2DC;
	Sun, 16 Jun 2013 15:18:49 +0100 (BST)
X-Quarantine-ID: <AEf-OQvbOxND>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AEf-OQvbOxND; Sun, 16 Jun 2013 15:18:48 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A93B5161E3F9;
	Sun, 16 Jun 2013 15:18:38 +0100 (BST)
X-Mailer: git-send-email 1.8.3.779.g691e267
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228009>

Only leading whitespace is changed in this patch.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t7401-submodule-summary.sh | 80 ++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 30b429e..c328726 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -76,8 +76,8 @@ head3=$(
 )
 
 test_expect_success 'modified submodule(backward)' "
-    git submodule summary >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary >actual &&
+	cat >expected <<-EOF &&
 * sm1 $head2...$head3 (2):
   < Add foo3
   < Add foo2
@@ -89,8 +89,8 @@ EOF
 head4=$(add_file sm1 foo4 foo5) &&
 head4_full=$(GIT_DIR=sm1/.git git rev-parse --verify HEAD)
 test_expect_success 'modified submodule(backward and forward)' "
-    git submodule summary >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary >actual &&
+	cat >expected <<-EOF &&
 * sm1 $head2...$head4 (4):
   > Add foo5
   > Add foo4
@@ -102,15 +102,15 @@ EOF
 "
 
 test_expect_success '--summary-limit' "
-    git submodule summary -n 3 >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary -n 3 >actual &&
+	cat >expected <<-EOF &&
 * sm1 $head2...$head4 (4):
   > Add foo5
   > Add foo4
   < Add foo3
 
 EOF
-    test_cmp expected actual
+	test_cmp expected actual
 "
 
 commit_file sm1 &&
@@ -122,8 +122,8 @@ rm -f sm1 &&
 mv sm1-bak sm1
 
 test_expect_success 'typechanged submodule(submodule->blob), --cached' "
-    git submodule summary --cached >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary --cached >actual &&
+	cat >expected <<-EOF &&
 * sm1 $head4(submodule)->$head5(blob) (3):
   < Add foo5
 
@@ -132,59 +132,59 @@ EOF
 "
 
 test_expect_success 'typechanged submodule(submodule->blob), --files' "
-    git submodule summary --files >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary --files >actual &&
+	cat >expected <<-EOF &&
 * sm1 $head5(blob)->$head4(submodule) (3):
   > Add foo5
 
 EOF
-    test_i18ncmp actual expected
+	test_i18ncmp actual expected
 "
 
 rm -rf sm1 &&
 git checkout-index sm1
 test_expect_success 'typechanged submodule(submodule->blob)' "
-    git submodule summary >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary >actual &&
+	cat >expected <<-EOF &&
 * sm1 $head4(submodule)->$head5(blob):
 
 EOF
-    test_i18ncmp actual expected
+	test_i18ncmp actual expected
 "
 
 rm -f sm1 &&
 test_create_repo sm1 &&
 head6=$(add_file sm1 foo6 foo7)
 test_expect_success 'nonexistent commit' "
-    git submodule summary >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary >actual &&
+	cat >expected <<-EOF &&
 * sm1 $head4...$head6:
   Warn: sm1 doesn't contain commit $head4_full
 
 EOF
-    test_i18ncmp actual expected
+	test_i18ncmp actual expected
 "
 
 commit_file
 test_expect_success 'typechanged submodule(blob->submodule)' "
-    git submodule summary >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary >actual &&
+	cat >expected <<-EOF &&
 * sm1 $head5(blob)->$head6(submodule) (2):
   > Add foo7
 
 EOF
-    test_i18ncmp expected actual
+	test_i18ncmp expected actual
 "
 
 commit_file sm1 &&
 rm -rf sm1
 test_expect_success 'deleted submodule' "
-    git submodule summary >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary >actual &&
+	cat >expected <<-EOF &&
 * sm1 $head6...0000000:
 
 EOF
-    test_cmp expected actual
+	test_cmp expected actual
 "
 
 test_create_repo sm2 &&
@@ -192,43 +192,43 @@ head7=$(add_file sm2 foo8 foo9) &&
 git add sm2
 
 test_expect_success 'multiple submodules' "
-    git submodule summary >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary >actual &&
+	cat >expected <<-EOF &&
 * sm1 $head6...0000000:
 
 * sm2 0000000...$head7 (2):
   > Add foo9
 
 EOF
-    test_cmp expected actual
+	test_cmp expected actual
 "
 
 test_expect_success 'path filter' "
-    git submodule summary sm2 >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary sm2 >actual &&
+	cat >expected <<-EOF &&
 * sm2 0000000...$head7 (2):
   > Add foo9
 
 EOF
-    test_cmp expected actual
+	test_cmp expected actual
 "
 
 commit_file sm2
 test_expect_success 'given commit' "
-    git submodule summary HEAD^ >actual &&
-    cat >expected <<-EOF &&
+	git submodule summary HEAD^ >actual &&
+	cat >expected <<-EOF &&
 * sm1 $head6...0000000:
 
 * sm2 0000000...$head7 (2):
   > Add foo9
 
 EOF
-    test_cmp expected actual
+	test_cmp expected actual
 "
 
 test_expect_success '--for-status' "
-    git submodule summary --for-status HEAD^ >actual &&
-    test_i18ncmp actual - <<EOF
+	git submodule summary --for-status HEAD^ >actual &&
+	test_i18ncmp actual - <<EOF
 # Submodule changes to be committed:
 #
 # * sm1 $head6...0000000:
@@ -240,14 +240,14 @@ EOF
 "
 
 test_expect_success 'fail when using --files together with --cached' "
-    test_must_fail git submodule summary --files --cached
+	test_must_fail git submodule summary --files --cached
 "
 
 test_expect_success 'should not fail in an empty repo' "
-    git init xyzzy &&
-    cd xyzzy &&
-    git submodule summary >output 2>&1 &&
-    test_cmp output /dev/null
+	git init xyzzy &&
+	cd xyzzy &&
+	git submodule summary >output 2>&1 &&
+	test_cmp output /dev/null
 "
 
 test_done
-- 
1.8.3.779.g691e267
