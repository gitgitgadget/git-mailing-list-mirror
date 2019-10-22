Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF33A1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 21:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfJVVW6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 17:22:58 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:38600 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbfJVVW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 17:22:58 -0400
Received: by mail-wm1-f51.google.com with SMTP id 3so17531068wmi.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ZAQ6X70ZB3YXMDo7rL/zSH2kdUdB7F2fHAj/Q/dk/0=;
        b=oexlp6nWusMQYJQESocNalM4nhZuVkOPVLP6JkIFlT7MLVfL7fZQ6eimQfv8U64yG4
         LnN1vJqWV/1GVhcU+9BrSUdsdMNBB+/5rI1mat6lOjR7vzqOHJV2ra2Hbr7sBd6O1+Rw
         X6LcJnV/NqxIZ9Ml49cN9OdqaAnbm4swtjhFcaQTjpmhLsRwve0M+Q45dZpGOnua7ydQ
         OkHYTopYFpAMv8PnHLeKNuoqde0VDIwrtUx2fYMpEi0G4G4ku/hc7uHUzsXsfSfnFeDy
         ezuZlJYHIFrRcdDfjrtrYnX070GlYeGT6BqKebWZ5y2aExq5E+zwLW9pF9WF4R7nH/aV
         jPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ZAQ6X70ZB3YXMDo7rL/zSH2kdUdB7F2fHAj/Q/dk/0=;
        b=ZgnGQSgup/FyuA2N9Q5FXUvNXijZZ9AH1CKP52BkUBNWhOi7yNpb31q9qDRW+4JyJf
         /iUqmwUXOtR0ZVpYZz76zsZidICAYkZoPIVip1UbrniVU4IILHGre+ZDwJcWfL6fJ2du
         CHX3+XeC4wTi2nc0Wry9X2V6QPzbs8RcpNyzMipv6I6TQnnBYsNHt0yacr+rz1duqqJw
         qEa7aa9vhhiRsqjhdNrapH1iC5p6gCOvZODkcLF+Hyant8WMlIIgSnmi+lAmVox2mhOI
         Nu+EM2cCHd+lVWpGhbTUAVK0E1GH934Qa7xAf6qIKfuaSodHZ6mutjQvu/xf13yHmWs2
         2AqQ==
X-Gm-Message-State: APjAAAUesxk0j0242iJMTMwk5MuHleGiE03vwX/g6WMr0EAJX7Es5wUG
        rkzj4dLVzUic9Bnta8RRLVLMJ1tE
X-Google-Smtp-Source: APXvYqx2b07jhJNeUc2gkdjBTVedU80cQ7O6VTpV16sm5z4pbxPhyDZHRrnP+RVqmdh1/fpHWo+RKg==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr4662503wmb.84.1571779374370;
        Tue, 22 Oct 2019 14:22:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm19942856wrm.61.2019.10.22.14.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 14:22:53 -0700 (PDT)
Message-Id: <a1e80e8fbbf4b62c83a4a082c1be03f7ab92541c.1571779371.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.390.v2.git.1571779371.gitgitgadget@gmail.com>
References: <pull.390.git.gitgitgadget@gmail.com>
        <pull.390.v2.git.1571779371.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 21:22:50 +0000
Subject: [PATCH v2 2/3] merge-recursive: fix merging a subdirectory into the
 root directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin Johannes.Schindelin@gmx.de,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     Johannes Schindelin Johannes.Schindelin@gmx.de
                        ^                           ^-missing end of address
                 \-extraneous tokens in address
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We allow renaming all entries in e.g. a directory named z/ into a
directory named y/ to be detected as a z/ -> y/ rename, so that if the
other side of history adds any files to the directory z/ in the mean
time, we can provide the hint that they should be moved to y/.

There is no reason to not allow 'y/' to be the root directory, but the
code did not handle that case correctly.  Add a testcase and the
necessary special checks to support this case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   |  52 ++++++++++++-
 t/t6043-merge-rename-directories.sh | 114 ++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f80e48f623..ec60715368 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1931,6 +1931,16 @@ static char *apply_dir_rename(struct dir_rename_entry *entry,
 		return NULL;
 
 	oldlen = strlen(entry->dir);
+	if (entry->new_dir.len == 0)
+		/*
+		 * If someone renamed/merged a subdirectory into the root
+		 * directory (e.g. 'some/subdir' -> ''), then we want to
+		 * avoid returning
+		 *     '' + '/filename'
+		 * as the rename; we need to make old_path + oldlen advance
+		 * past the '/' character.
+		 */
+		oldlen++;
 	newlen = entry->new_dir.len + (strlen(old_path) - oldlen) + 1;
 	strbuf_grow(&new_path, newlen);
 	strbuf_addbuf(&new_path, &entry->new_dir);
@@ -1963,8 +1973,26 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	 */
 	end_of_old = strrchr(old_path, '/');
 	end_of_new = strrchr(new_path, '/');
-	if (end_of_old == NULL || end_of_new == NULL)
-		return; /* We haven't modified *old_dir or *new_dir yet. */
+
+	/*
+	 * If end_of_old is NULL, old_path wasn't in a directory, so there
+	 * could not be a directory rename (our rule elsewhere that a
+	 * directory which still exists is not considered to have been
+	 * renamed means the root directory can never be renamed -- because
+	 * the root directory always exists).
+	 */
+	if (end_of_old == NULL)
+		return; /* Note: *old_dir and *new_dir are still NULL */
+
+	/*
+	 * If new_path contains no directory (end_of_new is NULL), then we
+	 * have a rename of old_path's directory to the root directory.
+	 */
+	if (end_of_new == NULL) {
+		*old_dir = xstrndup(old_path, end_of_old - old_path);
+		*new_dir = xstrdup("");
+		return;
+	}
 
 	/* Find the first non-matching character traversing backwards */
 	while (*--end_of_new == *--end_of_old &&
@@ -1978,7 +2006,25 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	 */
 	if (end_of_old == old_path && end_of_new == new_path &&
 	    *end_of_old == *end_of_new)
-		return; /* We haven't modified *old_dir or *new_dir yet. */
+		return; /* Note: *old_dir and *new_dir are still NULL */
+
+	/*
+	 * If end_of_new got back to the beginning of its string, and
+	 * end_of_old got back to the beginning of some subdirectory, then
+	 * we have a rename/merge of a subdirectory into the root, which
+	 * needs slightly special handling.
+	 *
+	 * Note: There is no need to consider the opposite case, with a
+	 * rename/merge of the root directory into some subdirectory
+	 * because as noted above the root directory always exists so it
+	 * cannot be considered to be renamed.
+	 */
+	if (end_of_new == new_path &&
+	    end_of_old != old_path && end_of_old[-1] == '/') {
+		*old_dir = xstrndup(old_path, --end_of_old - old_path);
+		*new_dir = xstrdup("");
+		return;
+	}
 
 	/*
 	 * We've found the first non-matching character in the directory
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index c966147d5d..32cdd1f493 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -4051,6 +4051,120 @@ test_expect_success '12c-check: Moving one directory hierarchy into another w/ c
 	)
 '
 
+# Testcase 12d, Rename/merge of subdirectory into the root
+#   Commit O: a/b/subdir/foo
+#   Commit A: subdir/foo
+#   Commit B: a/b/subdir/foo, a/b/bar
+#   Expected: subdir/foo, bar
+
+test_expect_success '12d-setup: Rename/merge subdir into the root, variant 1' '
+	test_create_repo 12d &&
+	(
+		cd 12d &&
+
+		mkdir -p a/b/subdir &&
+		test_commit a/b/subdir/foo &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir subdir &&
+		git mv a/b/subdir/foo.t subdir/foo.t &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		test_commit a/b/bar
+	)
+'
+
+test_expect_success '12d-check: Rename/merge subdir into the root, variant 1' '
+	(
+		cd 12d &&
+
+		git checkout A^0 &&
+
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+
+		git rev-parse >actual \
+			HEAD:subdir/foo.t   HEAD:bar.t &&
+		git rev-parse >expect \
+			O:a/b/subdir/foo.t  B:a/b/bar.t &&
+		test_cmp expect actual &&
+
+		git hash-object bar.t >actual &&
+		git rev-parse B:a/b/bar.t >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:a/b/subdir/foo.t &&
+		test_must_fail git rev-parse HEAD:a/b/bar.t &&
+		test_path_is_missing a/ &&
+		test_path_is_file bar.t
+	)
+'
+
+# Testcase 12e, Rename/merge of subdirectory into the root
+#   Commit O: a/b/foo
+#   Commit A: foo
+#   Commit B: a/b/foo, a/b/bar
+#   Expected: foo, bar
+
+test_expect_success '12e-setup: Rename/merge subdir into the root, variant 2' '
+	test_create_repo 12e &&
+	(
+		cd 12e &&
+
+		mkdir -p a/b &&
+		test_commit a/b/foo &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir subdir &&
+		git mv a/b/foo.t foo.t &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		test_commit a/b/bar
+	)
+'
+
+test_expect_success '12e-check: Rename/merge subdir into the root, variant 2' '
+	(
+		cd 12e &&
+
+		git checkout A^0 &&
+
+		git -c merge.directoryRenames=true merge -s recursive B^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+
+		git rev-parse >actual \
+			HEAD:foo.t   HEAD:bar.t &&
+		git rev-parse >expect \
+			O:a/b/foo.t  B:a/b/bar.t &&
+		test_cmp expect actual &&
+
+		git hash-object bar.t >actual &&
+		git rev-parse B:a/b/bar.t >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:a/b/foo.t &&
+		test_must_fail git rev-parse HEAD:a/b/bar.t &&
+		test_path_is_missing a/ &&
+		test_path_is_file bar.t
+	)
+'
+
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #
-- 
gitgitgadget

