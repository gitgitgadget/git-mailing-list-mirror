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
	by dcvr.yhbt.net (Postfix) with ESMTP id 811221F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfKQVFH (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36818 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfKQVFH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id c22so16551674wmd.1
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SoPm1cFRuVNOXgTvUq1oqThbMzIouvxn57iJ55LWUvI=;
        b=KAieWXragrwljAwVkF5TbSuBX/DaDZuYbeTKs51HN0uc1F6t77I0keeWtDpYJKkM1C
         HR0lWkoSpaaKgBKJBd84isDQc384uYnYFfM/ihaNIdPG2jRz7WXZQo5fwWt1mB63xFq8
         zArCXqs8fRSc1Big9IFDd57e5LYGQ5l6ysBNOxIqK+owSQra1PmG4yzOK2MGMMa3rA+Z
         iSM4yRdfL0lI+qoD5S6lbfujq4aBAYepjpGHvi5J7Sv27XHtwX4MhW2VjozBroEtEt7f
         d5IisYGIYgo4af1SAVkiFoljMLz+EV5cZUzj9o4WSpMQ+nt1Cc1nUb/1WuzzKQQ2GcPS
         K6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SoPm1cFRuVNOXgTvUq1oqThbMzIouvxn57iJ55LWUvI=;
        b=encVnho63lYJKFHaXoySiyv02JiGM5gM9LKNEbtdBagLauyzFVFTVkAgkU0RakxfTn
         ialj9D9P6mvL4ONZyEmAvTFxUqk47lF/7lGyrGdYee5C1WO5uFG+JwaZhs/nwmoburmR
         PpjNdS/vuMtqXZJq5aIBIRPvVIBWxEHrty5tRwaKrpk6zSPwhm165cgdR652yIvp+7hZ
         ZjsPNA79ngbcIgxPT2QrgjUmQv97pRaNm5juY22WyehFFmd+tu8xYEofgFpAhHyNKOEW
         ki5pOhIHxzneer+OQW16qFMbz1os82Rw+5KECsLLRf43B9p2MsNCtrYxLJbTDCvhbyvi
         gjBw==
X-Gm-Message-State: APjAAAWjrq011ENbCTrchwt+bYGIXDiCUZjqISw8n+x9W2kH8p1Zi3Mr
        QoiM3DAmO0STl9j8fvfdwHxmCIXN
X-Google-Smtp-Source: APXvYqxC+2fUWBTtr16S0Pjgmux8Q3PXwe2j6c77404IQrfdAiF85ziMVS4dT2tNqJJFmPVXxq4eRQ==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr23611412wmh.74.1574024703550;
        Sun, 17 Nov 2019 13:05:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1sm19129809wrs.74.2019.11.17.13.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:03 -0800 (PST)
Message-Id: <7f2f4c45a6141a9c9f3fd7aaff54fc3a7b7173ec.1574024700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:40 +0000
Subject: [PATCH v5 01/21] diff: move doc to diff.h and diffcore.h
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

Move the documentation from Documentation/technical/api-diff.txt to both
diff.h and diffcore.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-diff.txt is removed because the information
it has is now redundant and it'll be hard to keep it up to date and
synchronized with the documentation in the header files.

There are three members documented in the doc file that weren't found in
the header files, assuming the doc wasn't up to date and the members
no longer exist:
touched_flags, COLOR_DIFF_WORDS and QUIET.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-diff.txt | 174 ---------------------------
 diff.h                               | 126 +++++++++++++++++++
 diffcore.h                           |  32 +++++
 3 files changed, 158 insertions(+), 174 deletions(-)
 delete mode 100644 Documentation/technical/api-diff.txt

diff --git a/Documentation/technical/api-diff.txt b/Documentation/technical/api-diff.txt
deleted file mode 100644
index 30fc0e9c93..0000000000
--- a/Documentation/technical/api-diff.txt
+++ /dev/null
@@ -1,174 +0,0 @@
-diff API
-========
-
-The diff API is for programs that compare two sets of files (e.g. two
-trees, one tree and the index) and present the found difference in
-various ways.  The calling program is responsible for feeding the API
-pairs of files, one from the "old" set and the corresponding one from
-"new" set, that are different.  The library called through this API is
-called diffcore, and is responsible for two things.
-
-* finding total rewrites (`-B`), renames (`-M`) and copies (`-C`), and
-  changes that touch a string (`-S`), as specified by the caller.
-
-* outputting the differences in various formats, as specified by the
-  caller.
-
-Calling sequence
-----------------
-
-* Prepare `struct diff_options` to record the set of diff options, and
-  then call `repo_diff_setup()` to initialize this structure.  This
-  sets up the vanilla default.
-
-* Fill in the options structure to specify desired output format, rename
-  detection, etc.  `diff_opt_parse()` can be used to parse options given
-  from the command line in a way consistent with existing git-diff
-  family of programs.
-
-* Call `diff_setup_done()`; this inspects the options set up so far for
-  internal consistency and make necessary tweaking to it (e.g. if
-  textual patch output was asked, recursive behaviour is turned on);
-  the callback set_default in diff_options can be used to tweak this more.
-
-* As you find different pairs of files, call `diff_change()` to feed
-  modified files, `diff_addremove()` to feed created or deleted files,
-  or `diff_unmerge()` to feed a file whose state is 'unmerged' to the
-  API.  These are thin wrappers to a lower-level `diff_queue()` function
-  that is flexible enough to record any of these kinds of changes.
-
-* Once you finish feeding the pairs of files, call `diffcore_std()`.
-  This will tell the diffcore library to go ahead and do its work.
-
-* Calling `diff_flush()` will produce the output.
-
-
-Data structures
----------------
-
-* `struct diff_filespec`
-
-This is the internal representation for a single file (blob).  It
-records the blob object name (if known -- for a work tree file it
-typically is a NUL SHA-1), filemode and pathname.  This is what the
-`diff_addremove()`, `diff_change()` and `diff_unmerge()` synthesize and
-feed `diff_queue()` function with.
-
-* `struct diff_filepair`
-
-This records a pair of `struct diff_filespec`; the filespec for a file
-in the "old" set (i.e. preimage) is called `one`, and the filespec for a
-file in the "new" set (i.e. postimage) is called `two`.  A change that
-represents file creation has NULL in `one`, and file deletion has NULL
-in `two`.
-
-A `filepair` starts pointing at `one` and `two` that are from the same
-filename, but `diffcore_std()` can break pairs and match component
-filespecs with other filespecs from a different filepair to form new
-filepair.  This is called 'rename detection'.
-
-* `struct diff_queue`
-
-This is a collection of filepairs.  Notable members are:
-
-`queue`::
-
-	An array of pointers to `struct diff_filepair`.  This
-	dynamically grows as you add filepairs;
-
-`alloc`::
-
-	The allocated size of the `queue` array;
-
-`nr`::
-
-	The number of elements in the `queue` array.
-
-
-* `struct diff_options`
-
-This describes the set of options the calling program wants to affect
-the operation of diffcore library with.
-
-Notable members are:
-
-`output_format`::
-	The output format used when `diff_flush()` is run.
-
-`context`::
-	Number of context lines to generate in patch output.
-
-`break_opt`, `detect_rename`, `rename-score`, `rename_limit`::
-	Affects the way detection logic for complete rewrites, renames
-	and copies.
-
-`abbrev`::
-	Number of hexdigits to abbreviate raw format output to.
-
-`pickaxe`::
-	A constant string (can and typically does contain newlines to
-	look for a block of text, not just a single line) to filter out
-	the filepairs that do not change the number of strings contained
-	in its preimage and postimage of the diff_queue.
-
-`flags`::
-	This is mostly a collection of boolean options that affects the
-	operation, but some do not have anything to do with the diffcore
-	library.
-
-`touched_flags`::
-	Records whether a flag has been changed due to user request
-	(rather than just set/unset by default).
-
-`set_default`::
-	Callback which allows tweaking the options in diff_setup_done().
-
-BINARY, TEXT;;
-	Affects the way how a file that is seemingly binary is treated.
-
-FULL_INDEX;;
-	Tells the patch output format not to use abbreviated object
-	names on the "index" lines.
-
-FIND_COPIES_HARDER;;
-	Tells the diffcore library that the caller is feeding unchanged
-	filepairs to allow copies from unmodified files be detected.
-
-COLOR_DIFF;;
-	Output should be colored.
-
-COLOR_DIFF_WORDS;;
-	Output is a colored word-diff.
-
-NO_INDEX;;
-	Tells diff-files that the input is not tracked files but files
-	in random locations on the filesystem.
-
-ALLOW_EXTERNAL;;
-	Tells output routine that it is Ok to call user specified patch
-	output routine.  Plumbing disables this to ensure stable output.
-
-QUIET;;
-	Do not show any output.
-
-REVERSE_DIFF;;
-	Tells the library that the calling program is feeding the
-	filepairs reversed; `one` is two, and `two` is one.
-
-EXIT_WITH_STATUS;;
-	For communication between the calling program and the options
-	parser; tell the calling program to signal the presence of
-	difference using program exit code.
-
-HAS_CHANGES;;
-	Internal; used for optimization to see if there is any change.
-
-SILENT_ON_REMOVE;;
-	Affects if diff-files shows removed files.
-
-RECURSIVE, TREE_IN_RECURSIVE;;
-	Tells if tree traversal done by tree-diff should recursively
-	descend into a tree object pair that are different in preimage
-	and postimage set.
-
-(JC)
diff --git a/diff.h b/diff.h
index 7f8f024feb..1be4ca4e4a 100644
--- a/diff.h
+++ b/diff.h
@@ -9,6 +9,49 @@
 #include "object.h"
 #include "oidset.h"
 
+/**
+ * The diff API is for programs that compare two sets of files (e.g. two trees,
+ * one tree and the index) and present the found difference in various ways.
+ * The calling program is responsible for feeding the API pairs of files, one
+ * from the "old" set and the corresponding one from "new" set, that are
+ * different.
+ * The library called through this API is called diffcore, and is responsible
+ * for two things.
+ *
+ * - finding total rewrites (`-B`), renames (`-M`) and copies (`-C`), and
+ * changes that touch a string (`-S`), as specified by the caller.
+ *
+ * - outputting the differences in various formats, as specified by the caller.
+ *
+ * Calling sequence
+ * ----------------
+ *
+ * - Prepare `struct diff_options` to record the set of diff options, and then
+ * call `repo_diff_setup()` to initialize this structure.  This sets up the
+ * vanilla default.
+ *
+ * - Fill in the options structure to specify desired output format, rename
+ * detection, etc.  `diff_opt_parse()` can be used to parse options given
+ * from the command line in a way consistent with existing git-diff family
+ * of programs.
+ *
+ * - Call `diff_setup_done()`; this inspects the options set up so far for
+ * internal consistency and make necessary tweaking to it (e.g. if textual
+ * patch output was asked, recursive behaviour is turned on); the callback
+ * set_default in diff_options can be used to tweak this more.
+ *
+ * - As you find different pairs of files, call `diff_change()` to feed
+ * modified files, `diff_addremove()` to feed created or deleted files, or
+ * `diff_unmerge()` to feed a file whose state is 'unmerged' to the API.
+ * These are thin wrappers to a lower-level `diff_queue()` function that is
+ * flexible enough to record any of these kinds of changes.
+ *
+ * - Once you finish feeding the pairs of files, call `diffcore_std()`.
+ * This will tell the diffcore library to go ahead and do its work.
+ *
+ * - Calling `diff_flush()` will produce the output.
+ */
+
 struct combine_diff_path;
 struct commit;
 struct diff_filespec;
@@ -65,21 +108,66 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 
 #define DIFF_FLAGS_INIT { 0 }
 struct diff_flags {
+
+	/**
+	 * Tells if tree traversal done by tree-diff should recursively descend
+	 * into a tree object pair that are different in preimage and postimage set.
+	 */
 	unsigned recursive;
 	unsigned tree_in_recursive;
+
+	/* Affects the way how a file that is seemingly binary is treated. */
 	unsigned binary;
 	unsigned text;
+
+	/**
+	 * Tells the patch output format not to use abbreviated object names on the
+	 * "index" lines.
+	 */
 	unsigned full_index;
+
+	/* Affects if diff-files shows removed files. */
 	unsigned silent_on_remove;
+
+	/**
+	 * Tells the diffcore library that the caller is feeding unchanged
+	 * filepairs to allow copies from unmodified files be detected.
+	 */
 	unsigned find_copies_harder;
+
 	unsigned follow_renames;
 	unsigned rename_empty;
+
+	/* Internal; used for optimization to see if there is any change. */
 	unsigned has_changes;
+
 	unsigned quick;
+
+	/**
+	 * Tells diff-files that the input is not tracked files but files in random
+	 * locations on the filesystem.
+	 */
 	unsigned no_index;
+
+	/**
+	 * Tells output routine that it is Ok to call user specified patch output
+	 * routine.  Plumbing disables this to ensure stable output.
+	 */
 	unsigned allow_external;
+
+	/**
+	 * For communication between the calling program and the options parser;
+	 * tell the calling program to signal the presence of difference using
+	 * program exit code.
+	 */
 	unsigned exit_with_status;
+
+	/**
+	 * Tells the library that the calling program is feeding the filepairs
+	 * reversed; `one` is two, and `two` is one.
+	 */
 	unsigned reverse_diff;
+
 	unsigned check_failed;
 	unsigned relative_name;
 	unsigned ignore_submodules;
@@ -131,36 +219,72 @@ enum diff_submodule_format {
 	DIFF_SUBMODULE_INLINE_DIFF
 };
 
+/**
+ * the set of options the calling program wants to affect the operation of
+ * diffcore library with.
+ */
 struct diff_options {
 	const char *orderfile;
+
+	/**
+	 * A constant string (can and typically does contain newlines to look for
+	 * a block of text, not just a single line) to filter out the filepairs
+	 * that do not change the number of strings contained in its preimage and
+	 * postimage of the diff_queue.
+	 */
 	const char *pickaxe;
+
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	const char *line_prefix;
 	size_t line_prefix_length;
+
+	/**
+	 * collection of boolean options that affects the operation, but some do
+	 * not have anything to do with the diffcore library.
+	 */
 	struct diff_flags flags;
 
 	/* diff-filter bits */
 	unsigned int filter;
 
 	int use_color;
+
+	/* Number of context lines to generate in patch output. */
 	int context;
+
 	int interhunkcontext;
+
+	/* Affects the way detection logic for complete rewrites, renames and
+	 * copies.
+	 */
 	int break_opt;
 	int detect_rename;
+
 	int irreversible_delete;
 	int skip_stat_unmatch;
 	int line_termination;
+
+	/* The output format used when `diff_flush()` is run. */
 	int output_format;
+
 	unsigned pickaxe_opts;
+
+	/* Affects the way detection logic for complete rewrites, renames and
+	 * copies.
+	 */
 	int rename_score;
 	int rename_limit;
+
 	int needed_rename_limit;
 	int degraded_cc_to_c;
 	int show_rename_progress;
 	int dirstat_permille;
 	int setup;
+
+	/* Number of hexdigits to abbreviate raw format output to. */
 	int abbrev;
+
 	int ita_invisible_in_index;
 /* white-space error highlighting */
 #define WSEH_NEW (1<<12)
@@ -192,6 +316,7 @@ struct diff_options {
 	/* to support internal diff recursion by --follow hack*/
 	int found_follow;
 
+	/* Callback which allows tweaking the options in diff_setup_done(). */
 	void (*set_default)(struct diff_options *);
 
 	FILE *file;
@@ -270,6 +395,7 @@ enum color_diff {
 	DIFF_FILE_OLD_BOLD = 21,
 	DIFF_FILE_NEW_BOLD = 22,
 };
+
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
 	diff_get_color((o)->use_color, ix)
diff --git a/diffcore.h b/diffcore.h
index b651061c0e..7c07347e42 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -28,6 +28,12 @@ struct userdiff_driver;
 
 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
 
+/**
+ * the internal representation for a single file (blob).  It records the blob
+ * object name (if known -- for a work tree file it typically is a NUL SHA-1),
+ * filemode and pathname.  This is what the `diff_addremove()`, `diff_change()`
+ * and `diff_unmerge()` synthesize and feed `diff_queue()` function with.
+ */
 struct diff_filespec {
 	struct object_id oid;
 	char *path;
@@ -66,6 +72,17 @@ void diff_free_filespec_data(struct diff_filespec *);
 void diff_free_filespec_blob(struct diff_filespec *);
 int diff_filespec_is_binary(struct repository *, struct diff_filespec *);
 
+/**
+ * This records a pair of `struct diff_filespec`; the filespec for a file in
+ * the "old" set (i.e. preimage) is called `one`, and the filespec for a file
+ * in the "new" set (i.e. postimage) is called `two`.  A change that represents
+ * file creation has NULL in `one`, and file deletion has NULL in `two`.
+ *
+ * A `filepair` starts pointing at `one` and `two` that are from the same
+ * filename, but `diffcore_std()` can break pairs and match component filespecs
+ * with other filespecs from a different filepair to form new filepair. This is
+ * called 'rename detection'.
+ */
 struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
@@ -77,6 +94,7 @@ struct diff_filepair {
 	unsigned done_skip_stat_unmatch : 1;
 	unsigned skip_stat_unmatch_result : 1;
 };
+
 #define DIFF_PAIR_UNMERGED(p) ((p)->is_unmerged)
 
 #define DIFF_PAIR_RENAME(p) ((p)->renamed_pair)
@@ -94,11 +112,25 @@ void diff_free_filepair(struct diff_filepair *);
 
 int diff_unmodified_pair(struct diff_filepair *);
 
+/**
+ * This is a collection of filepairs.  Notable members are:
+ *
+ * - `queue`:
+ * An array of pointers to `struct diff_filepair`. This dynamically grows as
+ * you add filepairs;
+ *
+ * - `alloc`:
+ * The allocated size of the `queue` array;
+ *
+ * - `nr`:
+ * The number of elements in the `queue` array.
+ */
 struct diff_queue_struct {
 	struct diff_filepair **queue;
 	int alloc;
 	int nr;
 };
+
 #define DIFF_QUEUE_CLEAR(q) \
 	do { \
 		(q)->queue = NULL; \
-- 
gitgitgadget

