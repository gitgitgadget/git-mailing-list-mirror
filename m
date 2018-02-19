Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CF41F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeBSL3Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:29:25 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:37361 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbeBSL3W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:29:22 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njdCe9qQuoNnDnjdJeU695; Mon, 19 Feb 2018 11:29:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519039761;
        bh=TbauM4dHxglNuGSOOESIWaYX5IMhFVS2XGO1SVludZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=AO1dvoZ/pN+nMMqEGBLvTEPMebUkmuvTs3e3F556ffNQP/SrJ/rrAc8f7Nuuccd/M
         H+A5LV1bhlTTRAwpsTBcjqz0ON7UzEwYwaeR28CVbgcDkNJ5P/dnM2WfeW80nMhz1g
         dOBT3c1Kg8U12hHafblYNkpoBxOyvYA11WZv7G6I=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=ZpYhuD8HQQMfiMRHhdEA:9
 a=V-gH8fRLYUzYlpmJ:21 a=vDFRbOw37tGq5QCt:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/9] t3701: indent here documents
Date:   Mon, 19 Feb 2018 11:29:03 +0000
Message-Id: <20180219112910.24471-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180219112910.24471-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfN6vtXpXV1RQCVqFVLQXW57ndRjguPt5j4AKRCi8SUEP2SUHkmgJX5qWxY6W4jsO8QGuqNuOgLqIKrE8yMFC72gXDnkh4OvuNoYzuzF0nYUjztXqke+y
 5/so/8TbxYfjv5TFD/KLZtlfaFfBgaGcnXqvhnq9ZFmn4MSctO+dCOpQKLxOGgpKG9xYV+GrM67L0wOk4rMeAb3oiyBCrPPb5BuOJuBaf8F0sMN+84u7mzJD
 SgvE4BZiX+FlXjA9fRY1oPQ05/3mKPmwQh47xgeEYtNwO7huZ1z3dqP5E2s5hvtb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Indent here documents in line with the current style for tests.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3701-add-interactive.sh | 174 ++++++++++++++++++++++-----------------------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 058698df6a4a9811b9db84fb5900472c47c61798..861ea2e08cce750515f59fc424b3f8336fd9b1a9 100755
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
+	cat >expected <<-EOF
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
+	cat >expected <<-EOF
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
+	cat >expected <<-EOF
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
+	cat >patch <<-EOF
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
+	cat >patch <<-EOF
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
+	cat >patch <<-EOF
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
+	cat >expected <<-EOF
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
+	cat >patch <<-EOF
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
+	cat >expected <<-EOF
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
+	cat >expected <<-EOF
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
+	cat >expected <<-EOF
+	diff --git a/empty b/empty
+	deleted file mode 100644
+	index e69de29..0000000
+	EOF
 '
 
 test_expect_success 'deleting an empty file' '
-- 
2.16.1

