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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ACF91F5A2
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfKQVFJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:09 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53381 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfKQVFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:09 -0500
Received: by mail-wm1-f49.google.com with SMTP id u18so15310833wmc.3
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a5qdORUuBoi+ThJumqy61+gTvzn+Egf3+Ckn+v1c3Ug=;
        b=VhwPNvGYqYdD8/Jn22i+OAfNcNN8lmxeecG5k+o3f+L0VFMuHYQfXfOflAPz2J8C0G
         EINtUmpGhqFdhSgBrMKtq66/2wMF6TrVS4PJ5oj8d+tmvLyQLAW2dHlP5X8cTfGsRk6g
         tzgS3R6oC9bdilMr6orJv1vsYBNWSkATUYkQPcghnDNdnM93pU1C7YQbno7ZwEBqSPCT
         NWZsNA5DgPFpmgggNqpJ6DprsBoZpLARh8/H+lFiM/zXjnzLrD2Z1nbwiaCjk6EkKxC5
         eDrbpCPmowe2L+VtKRCK8K9b7dAAWnQ09yzDnuv+6iMd7eoDo3oebx2e9QyXXAQvyUcM
         1xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a5qdORUuBoi+ThJumqy61+gTvzn+Egf3+Ckn+v1c3Ug=;
        b=UHt/53i/etdRyiC4qA2haOOuBABJKPmU9HwluVvk3RIvCTfv4GeY60q5EhLkD+44uR
         t7sxFAMiKyOTuYnEKHgzgmyQkwK+zH0q7S4j0SG81DYypLPkiZ9ggVX2HmLWuUKrxgAj
         nG++4lmN3gst19uzIajrQ3kCGlPr5Yz6bB1QF1BfaXvYAJKgyxBBM96mtWJ7qHdk1pU5
         fPPIWNcq3W5UiltcvoMxNdXqhoEAwwdtDkovmqKFrq2SDFlInaz3sDdpm13mBFdAOtlC
         hsq2AYu3EaBAE51T/OBLZtuWKCqy0UHTXPVnkPTwWgnnRVACDhe80UlRljOsF8MXrpXS
         FuHw==
X-Gm-Message-State: APjAAAUj/5qXMNXiLs++TEDd4r0suADbIyn7HXstm7luUvla0olymhOE
        oLeoDiKIOmBRGzTeavhmRf/w9s6n
X-Google-Smtp-Source: APXvYqygJeYffloEHTIZiSHdpivznM8Lm1r/mPZk2Q9f/YKqz/qImrGCBlTW5yU5Hox0iRxJR5nSXw==
X-Received: by 2002:a1c:dc44:: with SMTP id t65mr26702926wmg.169.1574024705675;
        Sun, 17 Nov 2019 13:05:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm17059985wmi.39.2019.11.17.13.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:05 -0800 (PST)
Message-Id: <90baf409ecaa2d26f72e6d2e79e1708bebbce06c.1574024700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:43 +0000
Subject: [PATCH v5 04/21] merge: move doc to ll-merge.h
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

Move the related documentation from Documentation/technical/api-merge.txt
to ll-merge.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Only the ll-merge related doc is removed from
documentation/technical/api-merge.txt because this information will be
redundant and it'll be hard to keep it up to date and synchronized with
the documentation in ll-merge.h.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-merge.txt | 72 +-------------------------
 ll-merge.h                            | 73 ++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 71 deletions(-)

diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.txt
index 9dc1bed768..487d4d83ff 100644
--- a/Documentation/technical/api-merge.txt
+++ b/Documentation/technical/api-merge.txt
@@ -28,77 +28,9 @@ and `diff.c` for examples.
 
 * `struct ll_merge_options`
 
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
+Check ll-merge.h for details.
 
 Low-level (single file) merge
 -----------------------------
 
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
+Check ll-merge.h for details.
diff --git a/ll-merge.h b/ll-merge.h
index e78973dd55..aceb1b2413 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -7,16 +7,87 @@
 
 #include "xdiff/xdiff.h"
 
+/**
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
+	/**
+	 * Behave as though this were part of a merge between common ancestors in
+	 * a recursive merge (merges of binary files may need to be handled
+	 * differently in such cases, for example). If a helper program is
+	 * specified by the `[merge "<driver>"] recursive` configuration, it will
+	 * be used.
+	 */
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
+	/**
+	 * Increase the length of conflict markers so that nested conflicts
+	 * can be differentiated.
+	 */
 	unsigned extra_marker_size;
+
+	/* Extra xpparam_t flags as defined in xdiff/xdiff.h. */
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

