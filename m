Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20AD31F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeB0LEn (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:04:43 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:2919 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeB0LE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:04:26 -0500
Received: from lindisfarne.localdomain ([89.242.176.20])
        by smtp.talktalk.net with SMTP
        id qd3QeQ4WdoNnDqd3YeXd0a; Tue, 27 Feb 2018 11:04:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519729464;
        bh=HFjreVa3542l95Zf5eSXsx7qyuNHCmI6CBk7Ua++V5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=SmPxsn6i705VrgkOtEE2M0TaAdh0iN/wDIqecfO0nGyUd2mGsZZ+blQRT+lIUedFo
         gmmVVwnBa3UNqzeso+q7n+lPuvJJJRYuS7qi3MVI47fCLzOxSB5RciwpyHnZUpUJDJ
         VCwc7bDTcH42AXG0XdkrkHAyyItaWIWvcjHM4iOY=
X-Originating-IP: [89.242.176.20]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=BZXIa/HMvEOrkAULb1ciZg==:117
 a=BZXIa/HMvEOrkAULb1ciZg==:17 a=evINK-nbAAAA:8 a=9D1bpbIqY77hJXHCPpUA:9
 a=V-gH8fRLYUzYlpmJ:21 a=vDFRbOw37tGq5QCt:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 2/9] t3701: indent here documents
Date:   Tue, 27 Feb 2018 11:03:57 +0000
Message-Id: <20180227110404.16816-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180227110404.16816-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180227110404.16816-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfNQAq7iSApLOxHuMk+ZDh+sk3k5LCxS8Yl5sEcMuWbTdV+VkbxtHeoHG2jaC4ZIisAeAcVtbZvwL/6vDRznNIsQITitUkFHwG3ACxFM290wQ4n7GDt77
 5Pi3cIZ5fUPq9S5qYQl3lVc79lDK35nrpy7CICmooB1BJx9RGrDWId7UUwctOc2IPj58dskMJS6KueL0iz7UgT0Qnwgd7j0INRi8b/+rboo6gTFk2VcWYufK
 Mzl+Pp3LZ7iAuzTne3MPpHuvJvuEn5siVIZ9H1N3KasO0r9bOym0AGzfZs0z4MPnDgGgRRFwtKESOPTua2qave83aXAKKJGn8zVNOnnVyoU=
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
index 058698df6a..861ea2e08c 100755
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

