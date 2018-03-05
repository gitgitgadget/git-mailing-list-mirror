Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4BE01FAE2
	for <e@80x24.org>; Mon,  5 Mar 2018 10:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934453AbeCEK4x (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 05:56:53 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:44818 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933623AbeCEK4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 05:56:44 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id snnHeF8dCGrhCsnnNesOzU; Mon, 05 Mar 2018 10:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520247402;
        bh=/IX8W5JudjeqVAdKV2gK2C6QKUB5CD9t9jyoSDFWPsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Tr8+jrbDxXA8iUSaEnO2JPtA6TPMjttKwiIRJO0+C6tY4A9HHZqEKM9r0GtzqUgam
         UFGJKebK9dQVoPGdMKg0wgSfcVJ+9syhJgZuhVu2N1P8BS4J5Edp8Q/+U1fSRfk70P
         qEMSMdpcDUxAIxSNF+RF4BM4SSlwlGUXS8FGLrDM=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=SORsqtnH c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=ybZZDoGAAAAA:8
 a=m9P1KHptT8j4y7GEUCQA:9 a=1FcG3TVhpi1BvX5g:21 a=5lt285--O8hF2jho:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=0RhZnL1DYvcuLYC8JZ5M:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 2/9] t3701: indent here documents
Date:   Mon,  5 Mar 2018 10:56:23 +0000
Message-Id: <20180305105630.14407-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305105630.14407-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180305105630.14407-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfPm22772MvS1amKT3DV/4k7jYGSgUeaMX4vK8u38tKZksikag9rBFGic8ylxgBu6zSYn7DMpF2Y8GWvLtwF4VTOm3krH+5pFpLxhtd8GyrD2M/uQmd+w
 /ZFmjkhwth6rCW9UGXDyM7WtUDps4uV9Hn2FLFsjNkhDSoPYyQPZOTOMZs73tSt8iQ3FwkV3PJm427mZnQaJWM1YNQWSto0hIXScUwA/pgtKl2F1fT+wE66b
 2WYEOfAfaPMfS860ymQf1uXvN9pKiI+aCeuQ7pDpDC366nbWvCk1k61jkK/dLg9jA/Vs4IXqNo5Uy0xxEu268bIFatfzWwB6TB4PJBe1kf0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Indent here documents in line with the current style for tests.
While at it, quote the end marker of here-docs that do not use
variable interpolation.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Notes:
    changes since v3:
     - updated to match what was in pu

 t/t3701-add-interactive.sh | 174 ++++++++++++++++++++++-----------------------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 058698df6a..3130dafcf0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -22,14 +22,14 @@ test_expect_success 'status works (initial)' '
 '
 
 test_expect_success 'setup expected' '
-cat >expected <<EOF
-new file mode 100644
-index 0000000..d95f3ad
---- /dev/null
-+++ b/file
-@@ -0,0 +1 @@
-+content
-EOF
+	cat >expected <<-\EOF
+	new file mode 100644
+	index 0000000..d95f3ad
+	--- /dev/null
+	+++ b/file
+	@@ -0,0 +1 @@
+	+content
+	EOF
 '
 
 test_expect_success 'diff works (initial)' '
@@ -59,14 +59,14 @@ test_expect_success 'status works (commit)' '
 '
 
 test_expect_success 'setup expected' '
-cat >expected <<EOF
-index 180b47c..b6f2c08 100644
---- a/file
-+++ b/file
-@@ -1 +1,2 @@
- baseline
-+content
-EOF
+	cat >expected <<-\EOF
+	index 180b47c..b6f2c08 100644
+	--- a/file
+	+++ b/file
+	@@ -1 +1,2 @@
+	 baseline
+	+content
+	EOF
 '
 
 test_expect_success 'diff works (commit)' '
@@ -83,8 +83,8 @@ test_expect_success 'revert works (commit)' '
 
 
 test_expect_success 'setup expected' '
-cat >expected <<EOF
-EOF
+	cat >expected <<-\EOF
+	EOF
 '
 
 test_expect_success 'setup fake editor' '
@@ -100,21 +100,21 @@ test_expect_success 'dummy edit works' '
 '
 
 test_expect_success 'setup patch' '
-cat >patch <<EOF
-@@ -1,1 +1,4 @@
- this
-+patch
--does not
- apply
-EOF
+	cat >patch <<-\EOF
+	@@ -1,1 +1,4 @@
+	 this
+	+patch
+	-does not
+	 apply
+	EOF
 '
 
 test_expect_success 'setup fake editor' '
 	echo "#!$SHELL_PATH" >fake_editor.sh &&
-	cat >>fake_editor.sh <<\EOF &&
-mv -f "$1" oldpatch &&
-mv -f patch "$1"
-EOF
+	cat >>fake_editor.sh <<-\EOF &&
+	mv -f "$1" oldpatch &&
+	mv -f patch "$1"
+	EOF
 	chmod a+x fake_editor.sh &&
 	test_set_editor "$(pwd)/fake_editor.sh"
 '
@@ -126,10 +126,10 @@ test_expect_success 'bad edit rejected' '
 '
 
 test_expect_success 'setup patch' '
-cat >patch <<EOF
-this patch
-is garbage
-EOF
+	cat >patch <<-\EOF
+	this patch
+	is garbage
+	EOF
 '
 
 test_expect_success 'garbage edit rejected' '
@@ -139,28 +139,28 @@ test_expect_success 'garbage edit rejected' '
 '
 
 test_expect_success 'setup patch' '
-cat >patch <<EOF
-@@ -1,0 +1,0 @@
- baseline
-+content
-+newcontent
-+lines
-EOF
+	cat >patch <<-\EOF
+	@@ -1,0 +1,0 @@
+	 baseline
+	+content
+	+newcontent
+	+lines
+	EOF
 '
 
 test_expect_success 'setup expected' '
-cat >expected <<EOF
-diff --git a/file b/file
-index b5dd6c9..f910ae9 100644
---- a/file
-+++ b/file
-@@ -1,4 +1,4 @@
- baseline
- content
--newcontent
-+more
- lines
-EOF
+	cat >expected <<-\EOF
+	diff --git a/file b/file
+	index b5dd6c9..f910ae9 100644
+	--- a/file
+	+++ b/file
+	@@ -1,4 +1,4 @@
+	 baseline
+	 content
+	-newcontent
+	+more
+	 lines
+	EOF
 '
 
 test_expect_success 'real edit works' '
@@ -222,31 +222,31 @@ test_expect_success 'setup again' '
 
 # Write the patch file with a new line at the top and bottom
 test_expect_success 'setup patch' '
-cat >patch <<EOF
-index 180b47c..b6f2c08 100644
---- a/file
-+++ b/file
-@@ -1,2 +1,4 @@
-+firstline
- baseline
- content
-+lastline
-EOF
+	cat >patch <<-\EOF
+	index 180b47c..b6f2c08 100644
+	--- a/file
+	+++ b/file
+	@@ -1,2 +1,4 @@
+	+firstline
+	 baseline
+	 content
+	+lastline
+	EOF
 '
 
 # Expected output, similar to the patch but w/ diff at the top
 test_expect_success 'setup expected' '
-cat >expected <<EOF
-diff --git a/file b/file
-index b6f2c08..61b9053 100755
---- a/file
-+++ b/file
-@@ -1,2 +1,4 @@
-+firstline
- baseline
- content
-+lastline
-EOF
+	cat >expected <<-\EOF
+	diff --git a/file b/file
+	index b6f2c08..61b9053 100755
+	--- a/file
+	+++ b/file
+	@@ -1,2 +1,4 @@
+	+firstline
+	 baseline
+	 content
+	+lastline
+	EOF
 '
 
 # Test splitting the first patch, then adding both
@@ -259,15 +259,15 @@ test_expect_success 'add first line works' '
 '
 
 test_expect_success 'setup expected' '
-cat >expected <<EOF
-diff --git a/non-empty b/non-empty
-deleted file mode 100644
-index d95f3ad..0000000
---- a/non-empty
-+++ /dev/null
-@@ -1 +0,0 @@
--content
-EOF
+	cat >expected <<-\EOF
+	diff --git a/non-empty b/non-empty
+	deleted file mode 100644
+	index d95f3ad..0000000
+	--- a/non-empty
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-content
+	EOF
 '
 
 test_expect_success 'deleting a non-empty file' '
@@ -282,11 +282,11 @@ test_expect_success 'deleting a non-empty file' '
 '
 
 test_expect_success 'setup expected' '
-cat >expected <<EOF
-diff --git a/empty b/empty
-deleted file mode 100644
-index e69de29..0000000
-EOF
+	cat >expected <<-\EOF
+	diff --git a/empty b/empty
+	deleted file mode 100644
+	index e69de29..0000000
+	EOF
 '
 
 test_expect_success 'deleting an empty file' '
-- 
2.16.2

