Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C0B1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 10:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfJ2KA5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 06:00:57 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38494 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfJ2KAz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 06:00:55 -0400
Received: by mail-wr1-f49.google.com with SMTP id v9so12907572wrq.5
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 03:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZjbU42ohlXG4SEU8alLZNOejEwGyPxddDj3hVXSK4Wg=;
        b=VjKpDafG8SZ4REGmnKpCBvdMiLa19bSoJeP5HN48QfykEfFbhlcipCzcyH4+g3zhyb
         Q0ofvHFpIAtodmA9VK5G8xBsH88IDZWwMdP1TE8tMi8lKr0PPjd45g58i54OLzeCrTD8
         +Xq78gkKP/EMVMlpImjCmapFKGFIFvCyjpxSuH4GITgeDTGjMKj6qbn5HVMQV4c64Dq0
         /3mBZ9mTSzFq9gVNIj7+2h//zXWvHcOj8tgovV25pW+UZbx+yYjyuc6Jp1En65ulr4gt
         DJJhrpt7I9A0HcTNSBXeAXylkRc0nZm1ZDb/lH+wtwo6awlHVi4vYfkx2D00KdADCgcW
         WUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZjbU42ohlXG4SEU8alLZNOejEwGyPxddDj3hVXSK4Wg=;
        b=PzE6R3khycbOxzNx6V0IefVgGU6S0qpq0Wc+6Mq80pQFE/4rQwDtUlAaM7XPm4HFIg
         cjIpSiqPfIx/Spk7CRI/vJt/8HiAymHhyVNy9YzxpfKQxxZIG423Usln/51uqGC6YsgB
         xBACEb/+PBCreL5Kpqk/txdc9QO/yJQxpU2Ppj2RGcD5tMNveD0ozso7Fl5eSQp9DBJz
         GfI1To8L4Cbvr0n1tI/YXG2kJcDzjzrX+yN7PKZg+VblOfxEpwu/oZc+gYENU/A9ZQtp
         F4k74OyD36LTAMQEBLOcSHcn2O8ZxLgigJoXhoT0JfwQJSxeOVfnL1Ax5g9VUPsDK0NB
         yOTg==
X-Gm-Message-State: APjAAAXdJA9XjczU3MZfn3Tq/mhAYVQVeLsvTjOxPEdjUh0Y17V8NEnN
        visSxutrF5wsJbqoJFjo3XH4nz2i
X-Google-Smtp-Source: APXvYqwHfyLjZdFf/HXVu0VRDb7Dv9EAJEUwY6OEDo6Za4gxHTDwDoMIWqfXo1Yv++oUHMdUgOdlLg==
X-Received: by 2002:adf:f684:: with SMTP id v4mr17905696wrp.336.1572343251257;
        Tue, 29 Oct 2019 03:00:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 74sm17133519wrm.92.2019.10.29.03.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:00:50 -0700 (PDT)
Message-Id: <504f1f7c892c8bfc4774ac5fec912855e74e38a5.1572343246.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.git.1572343246.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 10:00:40 +0000
Subject: [PATCH 04/10] merge: move doc to ll-merge.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Move the documentation from Documentation/technical/api-merge.txt to
ll-merge.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-merge.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-merge.txt | 104 --------------------------
 ll-merge.h                            |  80 +++++++++++++++++++-
 2 files changed, 79 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/technical/api-merge.txt

diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.txt
deleted file mode 100644
index 9dc1bed768..0000000000
--- a/Documentation/technical/api-merge.txt
+++ /dev/null
@@ -1,104 +0,0 @@
-merge API
-=========
-
-The merge API helps a program to reconcile two competing sets of
-improvements to some files (e.g., unregistered changes from the work
-tree versus changes involved in switching to a new branch), reporting
-conflicts if found.  The library called through this API is
-responsible for a few things.
-
- * determining which trees to merge (recursive ancestor consolidation);
-
- * lining up corresponding files in the trees to be merged (rename
-   detection, subtree shifting), reporting edge cases like add/add
-   and rename/rename conflicts to the user;
-
- * performing a three-way merge of corresponding files, taking
-   path-specific merge drivers (specified in `.gitattributes`)
-   into account.
-
-Data structures
----------------
-
-* `mmbuffer_t`, `mmfile_t`
-
-These store data usable for use by the xdiff backend, for writing and
-for reading, respectively.  See `xdiff/xdiff.h` for the definitions
-and `diff.c` for examples.
-
-* `struct ll_merge_options`
-
-This describes the set of options the calling program wants to affect
-the operation of a low-level (single file) merge.  Some options:
-
-`virtual_ancestor`::
-	Behave as though this were part of a merge between common
-	ancestors in a recursive merge.
-	If a helper program is specified by the
-	`[merge "<driver>"] recursive` configuration, it will
-	be used (see linkgit:gitattributes[5]).
-
-`variant`::
-	Resolve local conflicts automatically in favor
-	of one side or the other (as in 'git merge-file'
-	`--ours`/`--theirs`/`--union`).  Can be `0`,
-	`XDL_MERGE_FAVOR_OURS`, `XDL_MERGE_FAVOR_THEIRS`, or
-	`XDL_MERGE_FAVOR_UNION`.
-
-`renormalize`::
-	Resmudge and clean the "base", "theirs" and "ours" files
-	before merging.  Use this when the merge is likely to have
-	overlapped with a change in smudge/clean or end-of-line
-	normalization rules.
-
-Low-level (single file) merge
------------------------------
-
-`ll_merge`::
-
-	Perform a three-way single-file merge in core.  This is
-	a thin wrapper around `xdl_merge` that takes the path and
-	any merge backend specified in `.gitattributes` or
-	`.git/info/attributes` into account.  Returns 0 for a
-	clean merge.
-
-Calling sequence:
-
-* Prepare a `struct ll_merge_options` to record options.
-  If you have no special requests, skip this and pass `NULL`
-  as the `opts` parameter to use the default options.
-
-* Allocate an mmbuffer_t variable for the result.
-
-* Allocate and fill variables with the file's original content
-  and two modified versions (using `read_mmfile`, for example).
-
-* Call `ll_merge()`.
-
-* Read the merged content from `result_buf.ptr` and `result_buf.size`.
-
-* Release buffers when finished.  A simple
-  `free(ancestor.ptr); free(ours.ptr); free(theirs.ptr);
-  free(result_buf.ptr);` will do.
-
-If the modifications do not merge cleanly, `ll_merge` will return a
-nonzero value and `result_buf` will generally include a description of
-the conflict bracketed by markers such as the traditional `<<<<<<<`
-and `>>>>>>>`.
-
-The `ancestor_label`, `our_label`, and `their_label` parameters are
-used to label the different sides of a conflict if the merge driver
-supports this.
-
-Everything else
----------------
-
-Talk about <merge-recursive.h> and merge_file():
-
- - merge_trees() to merge with rename detection
- - merge_recursive() for ancestor consolidation
- - try_merge_command() for other strategies
- - conflict format
- - merge options
-
-(Daniel, Miklos, Stephan, JC)
diff --git a/ll-merge.h b/ll-merge.h
index e78973dd55..ec3617c627 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -7,16 +7,94 @@
 
 #include "xdiff/xdiff.h"
 
+/**
+ * The merge API helps a program to reconcile two competing sets of
+ * improvements to some files (e.g., unregistered changes from the work
+ * tree versus changes involved in switching to a new branch), reporting
+ * conflicts if found.  The library called through this API is
+ * responsible for a few things.
+ *
+ *  - determining which trees to merge (recursive ancestor consolidation);
+ *
+ *  - lining up corresponding files in the trees to be merged (rename
+ *    detection, subtree shifting), reporting edge cases like add/add
+ *    and rename/rename conflicts to the user;
+ *
+ *  - performing a three-way merge of corresponding files, taking
+ *    path-specific merge drivers (specified in `.gitattributes`)
+ *    into account.
+ *
+ * Calling sequence:
+ * ----------------
+ *
+ * - Prepare a `struct ll_merge_options` to record options.
+ *   If you have no special requests, skip this and pass `NULL`
+ *   as the `opts` parameter to use the default options.
+ *
+ * - Allocate an mmbuffer_t variable for the result.
+ *
+ * - Allocate and fill variables with the file's original content
+ *   and two modified versions (using `read_mmfile`, for example).
+ *
+ * - Call `ll_merge()`.
+ *
+ * - Read the merged content from `result_buf.ptr` and `result_buf.size`.
+ *
+ * - Release buffers when finished.  A simple
+ *   `free(ancestor.ptr); free(ours.ptr); free(theirs.ptr);
+ *   free(result_buf.ptr);` will do.
+ *
+ * If the modifications do not merge cleanly, `ll_merge` will return a
+ * nonzero value and `result_buf` will generally include a description of
+ * the conflict bracketed by markers such as the traditional `<<<<<<<`
+ * and `>>>>>>>`.
+ *
+ * The `ancestor_label`, `our_label`, and `their_label` parameters are
+ * used to label the different sides of a conflict if the merge driver
+ * supports this.
+ */
+
+
 struct index_state;
 
+/**
+ * This describes the set of options the calling program wants to affect
+ * the operation of a low-level (single file) merge.
+ */
 struct ll_merge_options {
+
+    /**
+     * Behave as though this were part of a merge between common ancestors in
+     * a recursive merge. If a helper program is specified by the
+	 * `[merge "<driver>"] recursive` configuration, it will be used.
+     */
 	unsigned virtual_ancestor : 1;
-	unsigned variant : 2;	/* favor ours, favor theirs, or union merge */
+
+	/**
+	 * Resolve local conflicts automatically in favor of one side or the other
+	 * (as in 'git merge-file' `--ours`/`--theirs`/`--union`).  Can be `0`,
+	 * `XDL_MERGE_FAVOR_OURS`, `XDL_MERGE_FAVOR_THEIRS`,
+	 * or `XDL_MERGE_FAVOR_UNION`.
+	 */
+	unsigned variant : 2;
+
+	/**
+	 * Resmudge and clean the "base", "theirs" and "ours" files before merging.
+	 * Use this when the merge is likely to have overlapped with a change in
+	 * smudge/clean or end-of-line normalization rules.
+	 */
 	unsigned renormalize : 1;
+
 	unsigned extra_marker_size;
 	long xdl_opts;
 };
 
+/**
+ * Perform a three-way single-file merge in core.  This is a thin wrapper
+ * around `xdl_merge` that takes the path and any merge backend specified in
+ * `.gitattributes` or `.git/info/attributes` into account.
+ * Returns 0 for a clean merge.
+ */
 int ll_merge(mmbuffer_t *result_buf,
 	     const char *path,
 	     mmfile_t *ancestor, const char *ancestor_label,
-- 
gitgitgadget

