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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3957F1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 10:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfJ2KAx (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 06:00:53 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:36039 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJ2KAx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 06:00:53 -0400
Received: by mail-wr1-f48.google.com with SMTP id w18so12932679wrt.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C4tdvHrsbIUd/BqwlbGvevZdwEQqmIVmLeZz7+YyZvE=;
        b=qh+fkHZMnNhzRuV2xE7C+Gsy4tSauMSohO22diDeATcr+HWM9TNE0WGVJyTDkLxIKl
         m1fzQg8fBSmtMM/oDTw8PRV8+Mzq5YvbJmDIU8jvASR4GeHNdFpfdNidTmXEL4dNLvsm
         EsquirSeYT7qbi7sQh1vITQPCP5SHgD2A+krGic1E61nxrNiEi/LKHA+ES3Uo7sSqMc0
         c3mgUqfUje2GXDEzjykxc8eNxKbTjKIncMuA/UR1r+qlakthJggPe8wW1JQsIWwkZMD3
         RuIHii312Tj/IRYUXoA09JMlES4of4mlYPVeG3jBHzXNpiMlH01diC8YMOuJ/1Ieqkau
         D1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C4tdvHrsbIUd/BqwlbGvevZdwEQqmIVmLeZz7+YyZvE=;
        b=IdL9GdwvD6tEuk/6Bao8njVkQ3Ya+E/0SjB+rP+v5Foar+0oj0ZNij7lWGNdeyjLHg
         w/H4lv4HwQ/SAMPaZn/JuKCVfjabaH3lKvcL8pXoy88nlyFuQYV90PT/VCZ+UHh2DqaH
         53YMPYLKm0L3axA1zzaGDoN3pZqde9MECgOog25M/lkA8H5uHyjqVAKbv0XLOz/LKK27
         CZ8TjDC9jlq5NZ2yuJK1l71q6qrvFAsKXKfhyb2JRPxuEafom/b4RXUxPjjTHB3exr8t
         4SXK+O0aeyYwWMFNJPFwkSgISxaiM1u47MAuuaolQURAfVWX4IYxBRS/dmwztjxsLWgf
         awLw==
X-Gm-Message-State: APjAAAWeYSnk41LSiRZAYPX62YVT+MDS+5EjBfDzP0g6ZrQkSGkDdNmk
        Gz5qt/tejZmzLiUKt9om0ECsuF9q
X-Google-Smtp-Source: APXvYqy8Qdm5kvPYrrAC5B/aw3OPHT9H9TPDLcdlZq3hmHlGy+2+WFW6X5lSbSz5YENTrpmYCiXijw==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr2566163wrn.57.1572343249893;
        Tue, 29 Oct 2019 03:00:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm18509297wra.74.2019.10.29.03.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:00:49 -0700 (PDT)
Message-Id: <290935e846f6e1758bdf0eb1518bfa01662764ca.1572343246.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.git.1572343246.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 10:00:38 +0000
Subject: [PATCH 02/10] dir: move doc to dir.h
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

Move the documentation from Documentation/technical/api-directory-listing.txt
to dir.h as it's easier for the developers to find the usage information
beside the code instead of looking for it in another doc file.

Also documentation/technical/api-directory-listing.txt is removed because
the information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header files.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 .../technical/api-directory-listing.txt       | 130 ------------------
 dir.h                                         | 118 +++++++++++++++-
 2 files changed, 113 insertions(+), 135 deletions(-)
 delete mode 100644 Documentation/technical/api-directory-listing.txt

diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
deleted file mode 100644
index 76b6e4f71b..0000000000
--- a/Documentation/technical/api-directory-listing.txt
+++ /dev/null
@@ -1,130 +0,0 @@
-directory listing API
-=====================
-
-The directory listing API is used to enumerate paths in the work tree,
-optionally taking `.git/info/exclude` and `.gitignore` files per
-directory into account.
-
-Data structure
---------------
-
-`struct dir_struct` structure is used to pass directory traversal
-options to the library and to record the paths discovered.  A single
-`struct dir_struct` is used regardless of whether or not the traversal
-recursively descends into subdirectories.
-
-The notable options are:
-
-`exclude_per_dir`::
-
-	The name of the file to be read in each directory for excluded
-	files (typically `.gitignore`).
-
-`flags`::
-
-	A bit-field of options:
-
-`DIR_SHOW_IGNORED`:::
-
-	Return just ignored files in `entries[]`, not untracked
-	files. This flag is mutually exclusive with
-	`DIR_SHOW_IGNORED_TOO`.
-
-`DIR_SHOW_IGNORED_TOO`:::
-
-	Similar to `DIR_SHOW_IGNORED`, but return ignored files in
-	`ignored[]` in addition to untracked files in
-	`entries[]`. This flag is mutually exclusive with
-	`DIR_SHOW_IGNORED`.
-
-`DIR_KEEP_UNTRACKED_CONTENTS`:::
-
-	Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is set, the
-	untracked contents of untracked directories are also returned in
-	`entries[]`.
-
-`DIR_SHOW_IGNORED_TOO_MODE_MATCHING`:::
-
-	Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if
-	this is set, returns ignored files and directories that match
-	an exclude pattern. If a directory matches an exclude pattern,
-	then the directory is returned and the contained paths are
-	not. A directory that does not match an exclude pattern will
-	not be returned even if all of its contents are ignored. In
-	this case, the contents are returned as individual entries.
-+
-If this is set, files and directories that explicitly match an ignore
-pattern are reported. Implicitly ignored directories (directories that
-do not match an ignore pattern, but whose contents are all ignored)
-are not reported, instead all of the contents are reported.
-
-`DIR_COLLECT_IGNORED`:::
-
-	Special mode for git-add. Return ignored files in `ignored[]` and
-	untracked files in `entries[]`. Only returns ignored files that match
-	pathspec exactly (no wildcards). Does not recurse into ignored
-	directories.
-
-`DIR_SHOW_OTHER_DIRECTORIES`:::
-
-	Include a directory that is not tracked.
-
-`DIR_HIDE_EMPTY_DIRECTORIES`:::
-
-	Do not include a directory that is not tracked and is empty.
-
-`DIR_NO_GITLINKS`:::
-
-	If set, recurse into a directory that looks like a Git
-	directory.  Otherwise it is shown as a directory.
-
-The result of the enumeration is left in these fields:
-
-`entries[]`::
-
-	An array of `struct dir_entry`, each element of which describes
-	a path.
-
-`nr`::
-
-	The number of members in `entries[]` array.
-
-`alloc`::
-
-	Internal use; keeps track of allocation of `entries[]` array.
-
-`ignored[]`::
-
-	An array of `struct dir_entry`, used for ignored paths with the
-	`DIR_SHOW_IGNORED_TOO` and `DIR_COLLECT_IGNORED` flags.
-
-`ignored_nr`::
-
-	The number of members in `ignored[]` array.
-
-Calling sequence
-----------------
-
-Note: index may be looked at for .gitignore files that are CE_SKIP_WORKTREE
-marked. If you to exclude files, make sure you have loaded index first.
-
-* Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
-  sizeof(dir))`.
-
-* To add single exclude pattern, call `add_pattern_list()` and then
-  `add_pattern()`.
-
-* To add patterns from a file (e.g. `.git/info/exclude`), call
-  `add_patterns_from_file()` , and/or set `dir.exclude_per_dir`.  A
-  short-hand function `setup_standard_excludes()` can be used to set
-  up the standard set of exclude settings.
-
-* Set options described in the Data Structure section above.
-
-* Call `read_directory()`.
-
-* Use `dir.entries[]`.
-
-* Call `clear_directory()` when none of the contained elements are no longer in use.
-
-(JC)
diff --git a/dir.h b/dir.h
index 2fbdef014f..1b41d29c07 100644
--- a/dir.h
+++ b/dir.h
@@ -1,11 +1,43 @@
 #ifndef DIR_H
 #define DIR_H
 
-/* See Documentation/technical/api-directory-listing.txt */
-
 #include "cache.h"
 #include "strbuf.h"
 
+/**
+ * The directory listing API is used to enumerate paths in the work tree,
+ * optionally taking `.git/info/exclude` and `.gitignore` files per directory
+ * into account.
+ */
+
+/**
+ * Calling sequence
+ * ----------------
+ *
+ * Note: index may be looked at for .gitignore files that are CE_SKIP_WORKTREE
+ * marked. If you to exclude files, make sure you have loaded index first.
+ *
+ * - Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
+ * sizeof(dir))`.
+ *
+ * - To add single exclude pattern, call `add_pattern_list()` and then
+ *   `add_pattern()`.
+ *
+ * - To add patterns from a file (e.g. `.git/info/exclude`), call
+ *   `add_patterns_from_file()` , and/or set `dir.exclude_per_dir`.  A
+ *   short-hand function `setup_standard_excludes()` can be used to set
+ *   up the standard set of exclude settings.
+ *
+ * - Set options described in the Data Structure section above.
+ *
+ * - Call `read_directory()`.
+ *
+ * - Use `dir.entries[]`.
+ *
+ * - Call `clear_directory()` when none of the contained elements are no longer in use.
+ *
+ */
+
 struct dir_entry {
 	unsigned int len;
 	char name[FLEX_ARRAY]; /* more */
@@ -144,25 +176,101 @@ struct untracked_cache {
 	unsigned int use_fsmonitor : 1;
 };
 
+/**
+ * pass directory traversal options to the library and to record the paths
+ * discovered. A single `struct dir_struct` is used regardless of whether or
+ * not the traversal recursively descends into subdirectories.
+ */
 struct dir_struct {
-	int nr, alloc;
-	int ignored_nr, ignored_alloc;
+
+    /* The number of members in `entries[]` array. */
+    int nr;
+
+    /* Internal use; keeps track of allocation of `entries[]` array.*/
+    int alloc;
+
+    /* The number of members in `ignored[]` array. */
+	int ignored_nr;
+
+	int ignored_alloc;
+
+	/* bit-field of options */
 	enum {
+
+	    /**
+	     * Return just ignored files in `entries[]`, not untracked files.
+	     * This flag is mutually exclusive with `DIR_SHOW_IGNORED_TOO`.
+	     */
 		DIR_SHOW_IGNORED = 1<<0,
+
+		/* Include a directory that is not tracked. */
 		DIR_SHOW_OTHER_DIRECTORIES = 1<<1,
+
+		/* Do not include a directory that is not tracked and is empty. */
 		DIR_HIDE_EMPTY_DIRECTORIES = 1<<2,
+
+		/**
+		 * If set, recurse into a directory that looks like a Git directory.
+		 * Otherwise it is shown as a directory.
+		 */
 		DIR_NO_GITLINKS = 1<<3,
+
+		/**
+		 * Special mode for git-add. Return ignored files in `ignored[]` and
+	     * untracked files in `entries[]`. Only returns ignored files that match
+	     * pathspec exactly (no wildcards). Does not recurse into ignored
+	     * directories.
+		 */
 		DIR_COLLECT_IGNORED = 1<<4,
+
+		/**
+		 * Similar to `DIR_SHOW_IGNORED`, but return ignored files in
+		 * `ignored[]` in addition to untracked files in `entries[]`.
+		 * This flag is mutually exclusive with `DIR_SHOW_IGNORED`.
+		 */
 		DIR_SHOW_IGNORED_TOO = 1<<5,
+
 		DIR_COLLECT_KILLED_ONLY = 1<<6,
+
+        /**
+         * Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is
+         * set, the untracked contents of untracked directories are also
+         * returned in `entries[]`.
+         */
 		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7,
+
+		/**
+		 * Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is
+		 * set, returns ignored files and directories that match an exclude
+		 * pattern. If a directory matches an exclude pattern, then the
+		 * directory is returned and the contained paths are not. A directory
+		 * that does not match an exclude pattern will not be returned even if
+		 * all of its contents are ignored. In this case, the contents are
+		 * returned as individual entries.
+		 *
+		 * If this is set, files and directories that explicitly match an ignore
+         * pattern are reported. Implicitly ignored directories (directories that
+         * do not match an ignore pattern, but whose contents are all ignored)
+         * are not reported, instead all of the contents are reported.
+		 */
 		DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8,
+
 		DIR_SKIP_NESTED_GIT = 1<<9
 	} flags;
+
+	/* An array of `struct dir_entry`, each element of which describes a path. */
 	struct dir_entry **entries;
+
+	/**
+	 * used for ignored paths with the `DIR_SHOW_IGNORED_TOO` and
+	 * `DIR_COLLECT_IGNORED` flags.
+	 */
 	struct dir_entry **ignored;
 
-	/* Exclude info */
+	/**
+	 * The name of the file to be read in each directory for excluded files
+	 * (typically `.gitignore`).
+	 */
 	const char *exclude_per_dir;
 
 	/*
-- 
gitgitgadget

