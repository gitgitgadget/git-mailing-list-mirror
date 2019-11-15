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
	by dcvr.yhbt.net (Postfix) with ESMTP id F086E1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfKOJx6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:53:58 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:38460 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfKOJxz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:53:55 -0500
Received: by mail-wr1-f47.google.com with SMTP id i12so10251200wro.5
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 01:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Bt16nrzcP9zwZOeYqqF1fvI/jDdS02cTNIlVAPiGPq4=;
        b=gkHaJEjmmkUyiHtZ2nzyARX17JbGJKPKYIvKT7L89vWUk5uDn2eIBgHY168sxGM66A
         IMgl4bXBhjvj5QKlweXk+bRc+jJVa4I2Ua0QHmMwJOqEdXfmNCIAZafM2rm0iVrdvqcF
         jrxqfLcC5ESZdUO9IbevIC2L9cfKfZYNVF+nrdQDfDWxXVVXHd3dlUlqlXtUYMx1carV
         f7qgya9ZoKSxkOmJYPZ2DNSyNqpJ+OzCBmMYqPLpT87+r3rDM5fOz6r/7iqWxCzZq3O+
         rUV3sE2FyzSjps3okix61+tKBtYXhRaLh5Eu/KRdex7Pa3pGCVDNiXFeaqskFncoJVsF
         rrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Bt16nrzcP9zwZOeYqqF1fvI/jDdS02cTNIlVAPiGPq4=;
        b=UihAF4LEsc8IKIeY7aiefDHEXaIezNsn7ZvYl2N1Np9VLQb+xsliOwUnMNuQArf6AK
         ZsOfh1zPYyXbq4Ac3HV3ySFuWF2hxQEOjAfoEv/PnsIDHklBAl4Fy54p+x6Qc+xnki/e
         gMJewkK16tUAUctGQIBqNaQtxiC6HIfatlwzBAM5xP2KhGbohGm48XgF9ZtC/ItPb5xg
         TV3MFIFJ6+wsns8ne3lHye9+uU6dMr3eMfFQ8j8Stlj+fE8ZHskzysAfFaNl611+l04N
         syJIxBNRQhg1mWyZ5EcIUIfWZRmFYY2RxrJr+oXliQw8aLmIo8gv3gQrBcNEApF6BW2j
         ba0g==
X-Gm-Message-State: APjAAAWmBhRLW5iIR5gpW/N4aIWwhWQZmBp64FETAwT/jrEgTDLaZn+2
        Y5Z1Z8qwb+9oQ6OeUkwf6YQO6n4E
X-Google-Smtp-Source: APXvYqzAbaJIb7rGnw+hunkxOQ5vQhHE+qWKgCAmYaMeSxKezXnN/aIJbRmIOlMkNLgk3C0cjel6OA==
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr14125228wrx.113.1573811630333;
        Fri, 15 Nov 2019 01:53:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm8984970wme.11.2019.11.15.01.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:53:49 -0800 (PST)
Message-Id: <f87ca0228e16cff133e063d24f19fd96622b74b1.1573811626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
References: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
        <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 09:53:27 +0000
Subject: [PATCH v4 02/21] dir: move doc to dir.h
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
 dir.c                                         |   2 -
 dir.h                                         | 119 +++++++++++++++-
 3 files changed, 114 insertions(+), 137 deletions(-)
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
diff --git a/dir.c b/dir.c
index 61f559f980..12d454b89d 100644
--- a/dir.c
+++ b/dir.c
@@ -2,8 +2,6 @@
  * This handles recursive filename detection with exclude
  * files, index knowledge etc..
  *
- * See Documentation/technical/api-directory-listing.txt
- *
  * Copyright (C) Linus Torvalds, 2005-2006
  *		 Junio Hamano, 2005-2006
  */
diff --git a/dir.h b/dir.h
index 2fbdef014f..c575f941dc 100644
--- a/dir.h
+++ b/dir.h
@@ -1,11 +1,44 @@
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
+ * Note: The index may be checked for .gitignore files that are
+ * CE_SKIP_WORKTREE marked. If you want to exclude files, make sure you have
+ * loaded the index first.
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
@@ -144,25 +177,101 @@ struct untracked_cache {
 	unsigned int use_fsmonitor : 1;
 };
 
+/**
+ * structure is used to pass directory traversal options to the library and to
+ * record the paths discovered. A single `struct dir_struct` is used regardless
+ * of whether or not the traversal recursively descends into subdirectories.
+ */
 struct dir_struct {
-	int nr, alloc;
-	int ignored_nr, ignored_alloc;
+
+	/* The number of members in `entries[]` array. */
+	int nr;
+
+	/* Internal use; keeps track of allocation of `entries[]` array.*/
+	int alloc;
+
+	/* The number of members in `ignored[]` array. */
+	int ignored_nr;
+
+	int ignored_alloc;
+
+	/* bit-field of options */
 	enum {
+
+		/**
+		 * Return just ignored files in `entries[]`, not untracked files.
+		 * This flag is mutually exclusive with `DIR_SHOW_IGNORED_TOO`.
+		 */
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
+		 * untracked files in `entries[]`. Only returns ignored files that match
+		 * pathspec exactly (no wildcards). Does not recurse into ignored
+		 * directories.
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
+		/**
+		 * Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is
+		 * set, the untracked contents of untracked directories are also
+		 * returned in `entries[]`.
+		 */
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
+		 * pattern are reported. Implicitly ignored directories (directories that
+		 * do not match an ignore pattern, but whose contents are all ignored)
+		 * are not reported, instead all of the contents are reported.
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

