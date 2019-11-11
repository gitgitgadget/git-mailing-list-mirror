Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601C11F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfKKV2R (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:28:17 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53925 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfKKV2M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:28:12 -0500
Received: by mail-wm1-f48.google.com with SMTP id u18so856737wmc.3
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a5qdORUuBoi+ThJumqy61+gTvzn+Egf3+Ckn+v1c3Ug=;
        b=FB0B7L6mr6ToIlyZ4biIptUYVmpq2n83xLJs606hUIsk9B/HR5duZbfqHlEE3gC06J
         YjOh5iiOCYTJl4JcWstH8erc9k4Zgf44pJR755zmzZHtPKdz9cr9kRw5aBFxpoDxdupt
         X0H4hjqd+tPmHy5tlL8Ehdr4iuOVVFUyTFO9G8UFNFZ0bXMGsztf4+PMuozGX+qYubyR
         cq5dNlKkrhLPNarLMR2pXaeLzKUaaeeiMp4stpK3ikCjV6WKSvj4ltUw5aLDLPLAgoum
         NPA5TkZelRYGQi3EZjoukKXPhlw6Sx4B5CACwKoLUMoXmLcrpVpBNFHi3cobCC5cIzrp
         1vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a5qdORUuBoi+ThJumqy61+gTvzn+Egf3+Ckn+v1c3Ug=;
        b=G4FOQuINAv8ArZn5+/u5WRhlg8Lr4afOlehrzhjEM7XIjJzHsLleFBB29wCvcpu/No
         e3+H38CIRbHMOZ2sBMpLnIQ5s03838E4Dy2JLNYKgKRhZGOYJNOY9zMl6PsvZDp/EwUq
         Kc2drZ2S78r5IbfNJ1tBtnV+NXuT0lAk53GtOStXOe9ZDD5U2R9ZZndL8rRipLiMnfOv
         cpxfW5M/QxrrkEZtN6lzGbHHGS53BN83lqyUVxSgSMb3ABplFADAaOgxxNeg92bXfMYO
         11el/ynlRTO51Q87FPmXOEw6rOlyWbaYsg0oq7iiV7mVXcONGmzBCunBSFmsMP0KbnL+
         E3IQ==
X-Gm-Message-State: APjAAAXc799OKkXSyCxLQPrpZLwqoimx7yVE+GE8pOOnS2l1nuFSHKNw
        Z5F8T+4t6tpgcGJjdykLI3A3/qId
X-Google-Smtp-Source: APXvYqxVVBHEE1336thtSOEDnQyWq+o62K08toa+22JbfUuZ5XBz1yup2tx0UuBVkiXuMtUh1FqHtg==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr803355wmc.37.1573507689635;
        Mon, 11 Nov 2019 13:28:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm5631518wrs.48.2019.11.11.13.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:28:09 -0800 (PST)
Message-Id: <39f25de85f94871e660de152b4d43dbfb97b7caf.1573507684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 21:27:47 +0000
Subject: [PATCH v3 04/21] merge: move doc to ll-merge.h
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

