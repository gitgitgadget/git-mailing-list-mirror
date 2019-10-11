Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324781F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 20:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfJKUma (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 16:42:30 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44773 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfJKUm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 16:42:28 -0400
Received: by mail-wr1-f54.google.com with SMTP id z9so13265252wrl.11
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 13:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SR4EwMy7igyyjczd7dMth7+/eXUm9iko6FAHxV/uUc0=;
        b=foQ1IIItLuNXW1/IirlEsRp7GyYs6hq6ABMYY0YEx1w+cztsDpgdOHlUNE6cWweXJ1
         8TBvEV8JUGde0/WSCFZtrb5HO1D96dpSEUSTgll/f4S2cjmJ5J+EW67KSQCcXpqySoi5
         tTEvMzTwabGwbJRN17ro72+Vhm12+vqn9b0bvqnc5SVxA/sB74LtXs5Z5fFtrB1VIpl7
         gUe13Jb8ZnN/+1HlY0uMK250wUAVijPIDoE++2p5JjxKW183LPMGPW1LtJ4Lfv2izHie
         3+JkENjcEHHQC+lq6hIcnME7uyG4Hj+YZmYd9cLUwQkS5mMdG6m/x/yCZSLDXP9xmDMD
         95CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SR4EwMy7igyyjczd7dMth7+/eXUm9iko6FAHxV/uUc0=;
        b=GpakUX45IGasPqfvRMm/uJWnduaUl20cST+GbWXIm3XaDUbWjZ1qTKg6Cmtxj9qi88
         u5D5yw/nxnQGAO6CPGrUKOXor2TNERr6xx/ESZP4Q/1gGDe998+HRf6vPf5SIsyG3Ere
         hn4T10KViOd1Na1l/jF/3oRsFjIXrVY11aV06PLEHsMU2nkIodGbUZ6LgaJdstkvhp8d
         iiNoPlVyRJYN5uPwrxhrcJmWgp6PtY6fswlTpVYhPBtWh1f7VrHG+B43Yg4amB/nGPA3
         BKXnaiZ4f7+r88+s+dFAJSngvSyYDblBte+sVCLe+nbyIgcgwjfgkluw/DRTYaqUqdMe
         G5mQ==
X-Gm-Message-State: APjAAAXGW4rNyQ8e6lvUGWMQ2DI0bifJCK9m0ZTRXtRCa+haZJ7a626b
        YibQqgJGTZFeuFTMAYWIHRl5IlPB
X-Google-Smtp-Source: APXvYqzRNTtv7LV39zIUeVw2o7rBhUvsb1Z219PCEii0cypdJsPnYNYnMVR6H00yly7MZmVTuP7LQQ==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr349845wrq.9.1570826545789;
        Fri, 11 Oct 2019 13:42:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c132sm14604621wme.27.2019.10.11.13.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 13:42:25 -0700 (PDT)
Date:   Fri, 11 Oct 2019 13:42:25 -0700 (PDT)
X-Google-Original-Date: Fri, 11 Oct 2019 20:42:22 GMT
Message-Id: <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.390.git.gitgitgadget@gmail.com>
References: <pull.390.git.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] merge-recursive: fix merging a subdirectory into the root
 directory
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
 merge-recursive.c                   | 29 +++++++++++++++
 t/t6043-merge-rename-directories.sh | 56 +++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index f80e48f623..7bd4a7cf10 100644
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
@@ -1980,6 +1990,25 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	    *end_of_old == *end_of_new)
 		return; /* We haven't modified *old_dir or *new_dir yet. */
 
+	/*
+	 * If end_of_new got back to the beginning of its string, and
+	 * end_of_old got back to the beginning of some subdirectory, then
+	 * we have a rename/merge of a subdirectory into the root, which
+	 * needs slightly special handling.
+	 *
+	 * Note: There is no need to consider the opposite case, with a
+	 * rename/merge of the root directory into some subdirectory.
+	 * Our rule elsewhere that a directory which still exists is not
+	 * considered to have been renamed means the root directory can
+	 * never be renamed (because the root directory always exists).
+	 */
+	if (end_of_new == new_path &&
+	    end_of_old != old_path && end_of_old[-1] == '/') {
+		*old_dir = xstrndup(old_path, end_of_old-1 - old_path);
+		*new_dir = xstrndup(new_path, end_of_new - new_path);
+		return;
+	}
+
 	/*
 	 * We've found the first non-matching character in the directory
 	 * paths.  That means the current characters we were looking at
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index c966147d5d..b920bb0850 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -4051,6 +4051,62 @@ test_expect_success '12c-check: Moving one directory hierarchy into another w/ c
 	)
 '
 
+# Testcase 12d, Rename/merge of subdirectory into the root
+#   Commit O: a/b/{foo.c}
+#   Commit A: foo.c
+#   Commit B: a/b/{foo.c,bar.c}
+#   Expected: a/b/{foo.c,bar.c}
+
+test_expect_success '12d-setup: Rename (merge) of subdirectory into the root' '
+	test_create_repo 12d &&
+	(
+		cd 12d &&
+
+		mkdir -p a/b/subdir &&
+		test_commit a/b/subdir/foo.c &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		mkdir subdir &&
+		git mv a/b/subdir/foo.c.t subdir/foo.c.t &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		test_commit a/b/bar.c
+	)
+'
+
+test_expect_success '12d-check: Rename (merge) of subdirectory into the root' '
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
+			HEAD:subdir/foo.c.t   HEAD:bar.c.t &&
+		git rev-parse >expect \
+			O:a/b/subdir/foo.c.t  B:a/b/bar.c.t &&
+		test_cmp expect actual &&
+
+		git hash-object bar.c.t >actual &&
+		git rev-parse B:a/b/bar.c.t >expect &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse HEAD:a/b/subdir/foo.c.t &&
+		test_must_fail git rev-parse HEAD:a/b/bar.c.t &&
+		test_path_is_missing a/
+	)
+'
+
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #
-- 
gitgitgadget
