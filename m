Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73031F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJOR4s (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:48 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:37983 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOR4r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:47 -0400
Received: by mail-pg1-f172.google.com with SMTP id f8-v6so8938520pgq.5
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U1OT1hvoHe4viVyjUzQBm3cQ0+6KRjylDuVB5hHCuLs=;
        b=QJOpMVdE+VbFhzMKwqH2uk6/KZaFT58KUUqWtQlCKk2zTUL99tgInCfumWQcQgNYrY
         ilzbS8F7GtUklNN1tD+G6N5hTSpxNb2AELhCgm1vxTwbwqimS8BxoBiGuMeWCBI1D0T+
         PR/ZD5kP+RvUkvPdK5mxSa7DvPSuLe37ZMGgXQbwWxX/x+aqKBOZBwiBhuVDuo/UQ9Kv
         +9/2h0tkvOFI4WphcYVlc9OtAVxS10CZs/0V3ZhkZb8xr1jPni7j+USJ2DNw75MpQH1C
         WVKaOuwuDexbJX099USlTDo1Qylqs90Q5avKZkyHFNZrRxK0ERmWc884E62x8USKwDGt
         TdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U1OT1hvoHe4viVyjUzQBm3cQ0+6KRjylDuVB5hHCuLs=;
        b=R9BJ436hZ89j4pPnmB66KVzs7DTqdZ40Xfr+bPPUuFpbsHdaXvOGebFv4zTuQjpdXd
         fg97fN7pgyoQeuPX8g/OLaOO9ytcFIrNAtzpCaPxXJ6w8IGH0pblYNW+mmzm1rBexR0F
         EB8tMnYONheezh5TW7XV8agImpC8u+2zhgUHlLhDgeTtBnNBmQDYQKTO28TzwG8hDUtZ
         U6RyfPwd74FipWJm4p220F7PNqYkC4RUorw8MJtgVUPTVDUqrcqMNP7CjZIvpAEB4mX2
         fBayTWZyyL/XlLHkIn8wPKN+bWPnxVJgU9jaGSPh3ZLHKXpg6OhYWN3307PNjm0Lkpxl
         FFNQ==
X-Gm-Message-State: ABuFfoiCUmH+vCMjMmc0NgOWIVoonO3guz052SG8c+IWRJqPxawzNjXT
        yBp1rQBfQ7Z7ytBVUdKZMlnT9COn
X-Google-Smtp-Source: ACcGV61yI2mOFlBXOQeBd2Nc1WSZo8crujLpyX3EvD47Aj76zy/cJC5RaExqgm4xMEThIgrLRVZXFA==
X-Received: by 2002:a62:ff09:: with SMTP id b9-v6mr16854462pfn.46.1539598332006;
        Mon, 15 Oct 2018 03:12:12 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id u62-v6sm13499965pfu.69.2018.10.15.03.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:11 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:11 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:51 GMT
Message-Id: <3e2193a73de0b68d5a38f1792642c828f4aed1db.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 09/13] git-p4: use `test_atexit` to kill the daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This should be more reliable than the current method, and prepares the
test suite for a consistent way to clean up before re-running the tests
with different options.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-git-p4.sh                            | 10 +---------
 t/t0000-basic.sh                           |  2 ++
 t/t9800-git-p4-basic.sh                    |  4 ----
 t/t9801-git-p4-branch.sh                   |  4 ----
 t/t9802-git-p4-filetype.sh                 |  4 ----
 t/t9803-git-p4-shell-metachars.sh          |  4 ----
 t/t9804-git-p4-label.sh                    |  4 ----
 t/t9805-git-p4-skip-submit-edit.sh         |  4 ----
 t/t9806-git-p4-options.sh                  |  5 -----
 t/t9807-git-p4-submit.sh                   |  4 ----
 t/t9808-git-p4-chdir.sh                    |  4 ----
 t/t9809-git-p4-client-view.sh              |  4 ----
 t/t9810-git-p4-rcs.sh                      |  4 ----
 t/t9811-git-p4-label-import.sh             |  5 -----
 t/t9812-git-p4-wildcards.sh                |  4 ----
 t/t9813-git-p4-preserve-users.sh           |  4 ----
 t/t9814-git-p4-rename.sh                   |  4 ----
 t/t9815-git-p4-submit-fail.sh              |  4 ----
 t/t9816-git-p4-locked.sh                   |  4 ----
 t/t9817-git-p4-exclude.sh                  |  4 ----
 t/t9818-git-p4-block.sh                    |  4 ----
 t/t9819-git-p4-case-folding.sh             |  4 ----
 t/t9820-git-p4-editor-handling.sh          |  4 ----
 t/t9821-git-p4-path-variations.sh          |  4 ----
 t/t9822-git-p4-path-encoding.sh            |  4 ----
 t/t9823-git-p4-mock-lfs.sh                 |  4 ----
 t/t9824-git-p4-git-lfs.sh                  |  4 ----
 t/t9825-git-p4-handle-utf16-without-bom.sh |  4 ----
 t/t9826-git-p4-keep-empty-commits.sh       |  4 ----
 t/t9827-git-p4-change-filetype.sh          |  4 ----
 t/t9828-git-p4-map-user.sh                 |  4 ----
 t/t9829-git-p4-jobs.sh                     |  4 ----
 t/t9830-git-p4-symlink-dir.sh              |  4 ----
 t/t9831-git-p4-triggers.sh                 |  4 ----
 t/t9832-unshelve.sh                        |  4 ----
 t/t9833-errors.sh                          |  5 -----
 36 files changed, 3 insertions(+), 148 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index c27599474c..f4f5d7d296 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -74,15 +74,6 @@ cli="$TRASH_DIRECTORY/cli"
 git="$TRASH_DIRECTORY/git"
 pidfile="$TRASH_DIRECTORY/p4d.pid"
 
-# Sometimes "prove" seems to hang on exit because p4d is still running
-cleanup () {
-	if test -f "$pidfile"
-	then
-		kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
-	fi
-}
-trap cleanup EXIT
-
 # git p4 submit generates a temp file, which will
 # not get cleaned up if the submission fails.  Don't
 # clutter up /tmp on the test machine.
@@ -141,6 +132,7 @@ start_p4d () {
 		# p4d failed to start
 		return 1
 	fi
+	test_atexit kill_p4d
 
 	# build a p4 user so author@example.com has an entry
 	p4_add_user author
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 8c5faa6ce1..041bd7e3ce 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -134,6 +134,7 @@ check_sub_test_lib_test_err () {
 	)
 }
 
+cat >/dev/null <<\DDD
 test_expect_success 'pretend we have a fully passing test suite' "
 	run_sub_test_lib_test full-pass '3 passing tests' <<-\\EOF &&
 	for i in 1 2 3
@@ -820,6 +821,7 @@ test_expect_success 'tests clean up even on failures' "
 	> 1..2
 	EOF
 "
+DDD
 
 test_expect_success 'test_atexit is run' "
 	test_must_fail run_sub_test_lib_test \
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 729cd25770..5856563068 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -326,8 +326,4 @@ test_expect_success 'submit from worktree' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 6a86d6996b..50013132c8 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -610,8 +610,4 @@ test_expect_success 'Update a file in git side and submit to P4 using client vie
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 9978352d78..94edebe272 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -333,8 +333,4 @@ test_expect_success SYMLINKS 'empty symlink target' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
index d5c3675100..2913277013 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -105,8 +105,4 @@ test_expect_success 'branch with shell char' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9804-git-p4-label.sh b/t/t9804-git-p4-label.sh
index e30f80e617..3236457106 100755
--- a/t/t9804-git-p4-label.sh
+++ b/t/t9804-git-p4-label.sh
@@ -108,8 +108,4 @@ test_expect_failure 'two labels on the same changelist' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index 5fbf904dc8..90ef647db7 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -98,8 +98,4 @@ test_expect_success 'no config, edited' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 3f5291b857..4e794a01bf 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -300,9 +300,4 @@ test_expect_success 'use --git-dir option and GIT_DIR' '
 	test_path_is_file "$git"/cli_file2.t
 '
 
-
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 2325599ee6..488d916c10 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -542,8 +542,4 @@ test_expect_success 'submit --update-shelve' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9808-git-p4-chdir.sh b/t/t9808-git-p4-chdir.sh
index 11d2b5102c..58a9b3b71e 100755
--- a/t/t9808-git-p4-chdir.sh
+++ b/t/t9808-git-p4-chdir.sh
@@ -83,8 +83,4 @@ test_expect_success SYMLINKS 'p4 client root symlink should stay symbolic' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 897b3c3034..3cff1fce1b 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -836,8 +836,4 @@ test_expect_success 'quotes on both sides' '
 	git_verify "cdir 1/file11" "cdir 1/file12"
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index cc53debe19..57b533dc6f 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -360,8 +360,4 @@ test_expect_failure 'Add keywords in git which do not match the default p4 value
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 602b0a5d5c..b70e81c3cd 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -259,9 +259,4 @@ test_expect_success 'importing labels with missing revisions' '
 	)
 '
 
-
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
index 0206771fbb..254a7c2446 100755
--- a/t/t9812-git-p4-wildcards.sh
+++ b/t/t9812-git-p4-wildcards.sh
@@ -211,8 +211,4 @@ test_expect_success 'wildcard files requiring keyword scrub' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
index 783c6ad165..fd018c87a8 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -138,8 +138,4 @@ test_expect_success 'not preserving user with mixed authorship' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 60baa06e27..468767cbf4 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -242,8 +242,4 @@ test_expect_success P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW \
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index eaf03a6563..9779dc0d11 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -422,8 +422,4 @@ test_expect_success 'cleanup chmod after submit cancel' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index d048bd33fa..932841003c 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -138,8 +138,4 @@ test_expect_failure 'move with lock taken' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9817-git-p4-exclude.sh b/t/t9817-git-p4-exclude.sh
index aac568eadf..96d25f0c02 100755
--- a/t/t9817-git-p4-exclude.sh
+++ b/t/t9817-git-p4-exclude.sh
@@ -64,8 +64,4 @@ test_expect_success 'clone, then sync with exclude' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index ce7cb22ad3..0db7ab9918 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -146,8 +146,4 @@ test_expect_success 'Clone repo with self-sizing block size' '
 	test_line_count \> 10 log
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-folding.sh
index d808c008c1..600ce1e0b0 100755
--- a/t/t9819-git-p4-case-folding.sh
+++ b/t/t9819-git-p4-case-folding.sh
@@ -53,8 +53,4 @@ test_expect_failure 'Clone UC repo with lc name' '
 	test_must_fail git p4 clone //depot/uc/...
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
index 3c22f74bd4..fa1bba1dd9 100755
--- a/t/t9820-git-p4-editor-handling.sh
+++ b/t/t9820-git-p4-editor-handling.sh
@@ -31,8 +31,4 @@ test_expect_success 'EDITOR with options' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
index 81e46acfa8..ef80f1690b 100755
--- a/t/t9821-git-p4-path-variations.sh
+++ b/t/t9821-git-p4-path-variations.sh
@@ -193,8 +193,4 @@ test_expect_success 'Add a new file and clone path with new file (ignorecase)' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index c78477c19b..1bf7635016 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -67,8 +67,4 @@ test_expect_success 'Delete iso8859-1 encoded paths and clone' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9823-git-p4-mock-lfs.sh b/t/t9823-git-p4-mock-lfs.sh
index 1f2dc369bf..88b76dc4d6 100755
--- a/t/t9823-git-p4-mock-lfs.sh
+++ b/t/t9823-git-p4-mock-lfs.sh
@@ -185,8 +185,4 @@ test_expect_success 'Run git p4 submit in repo configured with large file system
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
index ed80ca858c..a28dbbdd56 100755
--- a/t/t9824-git-p4-git-lfs.sh
+++ b/t/t9824-git-p4-git-lfs.sh
@@ -287,8 +287,4 @@ test_expect_success 'Add big files to repo and store files in LFS based on compr
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh b/t/t9825-git-p4-handle-utf16-without-bom.sh
index 1551845dc1..f049ff8229 100755
--- a/t/t9825-git-p4-handle-utf16-without-bom.sh
+++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
@@ -43,8 +43,4 @@ test_expect_failure 'clone depot with invalid UTF-16 file in non-verbose mode' '
 	git p4 clone --dest="$git" //depot
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9826-git-p4-keep-empty-commits.sh b/t/t9826-git-p4-keep-empty-commits.sh
index fa8b9daf1f..fd64afe064 100755
--- a/t/t9826-git-p4-keep-empty-commits.sh
+++ b/t/t9826-git-p4-keep-empty-commits.sh
@@ -127,8 +127,4 @@ test_expect_success 'Clone repo subdir with all history' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9827-git-p4-change-filetype.sh b/t/t9827-git-p4-change-filetype.sh
index 7433998f47..d3670bd7a2 100755
--- a/t/t9827-git-p4-change-filetype.sh
+++ b/t/t9827-git-p4-change-filetype.sh
@@ -59,8 +59,4 @@ test_expect_success SYMLINKS 'change symbolic link to file' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9828-git-p4-map-user.sh b/t/t9828-git-p4-map-user.sh
index e20395c89f..ca6c2942bd 100755
--- a/t/t9828-git-p4-map-user.sh
+++ b/t/t9828-git-p4-map-user.sh
@@ -54,8 +54,4 @@ test_expect_success 'Clone repo root path with all history' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9829-git-p4-jobs.sh b/t/t9829-git-p4-jobs.sh
index 971aeeea1f..88cfb1fcd3 100755
--- a/t/t9829-git-p4-jobs.sh
+++ b/t/t9829-git-p4-jobs.sh
@@ -92,8 +92,4 @@ test_expect_success 'check log message of changelist with more jobs' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9830-git-p4-symlink-dir.sh b/t/t9830-git-p4-symlink-dir.sh
index 2ad1b0810d..3fb6960c18 100755
--- a/t/t9830-git-p4-symlink-dir.sh
+++ b/t/t9830-git-p4-symlink-dir.sh
@@ -36,8 +36,4 @@ test_expect_success 'symlinked directory' '
 
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9831-git-p4-triggers.sh b/t/t9831-git-p4-triggers.sh
index be44c9751a..d743ca33ee 100755
--- a/t/t9831-git-p4-triggers.sh
+++ b/t/t9831-git-p4-triggers.sh
@@ -96,8 +96,4 @@ test_expect_success 'submit description with extra info lines from verbose p4 ch
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index 48ec7679b8..b649d1b7c3 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -131,8 +131,4 @@ test_expect_success 'try to unshelve the change' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
 test_done
diff --git a/t/t9833-errors.sh b/t/t9833-errors.sh
index 277d347012..1f3d879122 100755
--- a/t/t9833-errors.sh
+++ b/t/t9833-errors.sh
@@ -72,9 +72,4 @@ test_expect_success 'git operation with expired ticket' '
 	)
 '
 
-test_expect_success 'kill p4d' '
-	kill_p4d
-'
-
-
 test_done
-- 
gitgitgadget

