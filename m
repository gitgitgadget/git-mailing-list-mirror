Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58FF01F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfKKV2M (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:28:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42855 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfKKV2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:28:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so16219884wrf.9
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VrQStvd94J1IkU20n21exX2k920DVU2oBpbfGDeKd3g=;
        b=p5hFIn07rWKhS8wtiTfl4iFHIo3zVUCZSlYSTCxlxdTQraXkmW7CxPxLlNGBF8WSXg
         MOhKyWUNym4Dx61FV/t20aDHF2lECJxXtxG0Y8p4exkRVLIN0Hr7n3drYX+hlAfx2Ytl
         lUEE7UjvL/kKcJoBJbQSsAzeI/7iNUOhIcI7Kl16/EyJ+Rcp8Ea1+OHnQaAKeJAV5dNy
         YFfO+FkV2HYXW8VFwcMasjorNPQQ3iYmZ3vbXHe90l87XGR845tR0YvcoYIetwxFN+mZ
         7ttQmFASFya4cDk5mvCphK+7Byg9YwVqgTiTqo0Bb60Jtcd38w1qDfQdWloeb5lg+3Dp
         8Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VrQStvd94J1IkU20n21exX2k920DVU2oBpbfGDeKd3g=;
        b=DH2s1hSToaLn5oftzgfFZscNdVSqLcbhKJQccpbqxdOcQneGAIAo9c7jDeJTV4KKpr
         eEgsM0Qa39GCBF8mKH8JO+ouZE6YOO5nvLDWFDuG2cG4py2lFV8kTGqF1cKtP7+z7LIh
         Lw4FnoQuMo3fvm2mA6au83kiVfe08E0zLpWwm4ZHZEFmbHWdNkPNgs61/YkBgF16dPLM
         slrDpjSKxUrNu0sc74AkK6aJjygfRqjEOW7jQDq6Jlc3ljDSs+2KupaIW+Ue0Pm9VeWV
         XUhBq1HfcGbku7vM/LT4l8Zrp0YZQj9hCs7gaX5GsRjMVT5UNYOHqAEyMkckutYKEgjw
         ke1w==
X-Gm-Message-State: APjAAAVhzTPtsl0poLQe0cJvAJzkcaHPlUEksTMhdA9SuVB0mJVizODN
        UqWMtAxD9hgUaHFoRUcjBAI1xI6f
X-Google-Smtp-Source: APXvYqwJe36gaMGY5kfvjbxh/d2i4mHBY6hCOgU2f5f2Xdd910FcARCr8VPDKVG+B4RoV2eot7hHPA==
X-Received: by 2002:a5d:448a:: with SMTP id j10mr24262884wrq.79.1573507686188;
        Mon, 11 Nov 2019 13:28:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k125sm1376685wmf.2.2019.11.11.13.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:28:05 -0800 (PST)
Message-Id: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 21:27:43 +0000
Subject: [PATCH v3 00/21] [Outreachy] Move doc to header files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the documentation from Documentation/technical/api-*.txt to the
corresponding header file, as it's easier for the developers to find the
usage information beside the code instead of looking for it in another doc
file.

Also documentation/technical/api-*.txt is removed because the information it
has is will be redundant and it'll be hard to keep it up to date and
synchronized with the documentation in the header files.

api-trace2.txt is not removed because it has lots of valuable information
that seems more appropriate to be in a separate doc file not in the trace2.h
although the functions documentation is moved to the trace2.h

api-error-handling.txt is not removed as well because no other file seemed
to be more suitable for the doc it contains. I'm open to suggestions though.

The ll-merge related doc was removed from api-merge.txt to ll-merge.h, while
the rest of the file is left as is.

Signed-off-by: Heba Waly heba.waly@gmail.com

Heba Waly (21):
  diff: move doc to diff.h and diffcore.h
  dir: move doc to dir.h
  graph: move doc to graph.h and graph.c
  merge: move doc to ll-merge.h
  sha1-array: move doc to sha1-array.h
  remote: move doc to remote.h and refspec.h
  refs: move doc to refs.h
  attr: move doc to attr.h
  revision: move doc to revision.h
  pathspec: move doc to pathspec.h
  sigchain: move doc to sigchain.h
  cache: move doc to cache.h
  argv-array: move doc to argv-array.h
  credential: move doc to credential.h
  parse-options: move doc to parse-options.h
  run-command: move doc to run-command.h
  trace: move doc to trace.h
  tree-walk: move doc to tree-walk.h
  submodule-config: move doc to submodule-config.h
  trace2: move doc to trace2.h
  api-index: remove api doc index files

 Documentation/Makefile                        |  11 +-
 Documentation/MyFirstContribution.txt         |   2 +-
 Documentation/MyFirstObjectWalk.txt           |   7 +-
 Documentation/git-credential.txt              |   3 +-
 Documentation/git.txt                         |   3 -
 Documentation/gitcredentials.txt              |   3 +-
 Documentation/technical/.gitignore            |   1 -
 .../technical/api-allocation-growing.txt      |  39 ---
 Documentation/technical/api-argv-array.txt    |  65 ----
 Documentation/technical/api-credentials.txt   | 271 ---------------
 Documentation/technical/api-diff.txt          | 174 ---------
 .../technical/api-directory-listing.txt       | 130 -------
 Documentation/technical/api-gitattributes.txt | 154 --------
 Documentation/technical/api-history-graph.txt | 173 ---------
 Documentation/technical/api-index-skel.txt    |  13 -
 Documentation/technical/api-index.sh          |  28 --
 Documentation/technical/api-merge.txt         |  72 +---
 Documentation/technical/api-oid-array.txt     |  90 -----
 Documentation/technical/api-parse-options.txt | 313 -----------------
 Documentation/technical/api-ref-iteration.txt |  78 -----
 Documentation/technical/api-remote.txt        | 127 -------
 .../technical/api-revision-walking.txt        |  72 ----
 Documentation/technical/api-run-command.txt   | 264 --------------
 Documentation/technical/api-setup.txt         |  47 ---
 Documentation/technical/api-sigchain.txt      |  41 ---
 .../technical/api-submodule-config.txt        |  66 ----
 Documentation/technical/api-trace.txt         | 140 --------
 Documentation/technical/api-trace2.txt        | 262 +-------------
 Documentation/technical/api-tree-walking.txt  | 149 --------
 argv-array.h                                  |  62 ++++
 attr.c                                        |   3 +-
 attr.h                                        | 141 +++++++-
 cache.h                                       |  41 ++-
 credential.h                                  | 236 +++++++++++++
 diff.h                                        | 127 +++++++
 diffcore.h                                    |  32 ++
 dir.c                                         |   2 -
 dir.h                                         | 119 ++++++-
 graph.c                                       |   1 +
 graph.h                                       | 121 +++++++
 ll-merge.h                                    |  73 +++-
 parse-options.h                               | 329 ++++++++++++++++++
 pathspec.h                                    |  35 +-
 refs.h                                        |  51 +++
 refspec.h                                     |  16 +
 remote.h                                      |  57 ++-
 revision.h                                    |  59 ++++
 run-command.h                                 | 252 +++++++++++++-
 sha1-array.c                                  |   2 +-
 sha1-array.h                                  |  80 +++++
 sigchain.h                                    |  45 +++
 submodule-config.h                            |  38 +-
 trace.h                                       | 133 ++++++-
 trace2.h                                      | 146 ++++++--
 tree-walk.h                                   | 122 ++++++-
 55 files changed, 2275 insertions(+), 2846 deletions(-)
 delete mode 100644 Documentation/technical/.gitignore
 delete mode 100644 Documentation/technical/api-allocation-growing.txt
 delete mode 100644 Documentation/technical/api-argv-array.txt
 delete mode 100644 Documentation/technical/api-credentials.txt
 delete mode 100644 Documentation/technical/api-diff.txt
 delete mode 100644 Documentation/technical/api-directory-listing.txt
 delete mode 100644 Documentation/technical/api-gitattributes.txt
 delete mode 100644 Documentation/technical/api-history-graph.txt
 delete mode 100644 Documentation/technical/api-index-skel.txt
 delete mode 100755 Documentation/technical/api-index.sh
 delete mode 100644 Documentation/technical/api-oid-array.txt
 delete mode 100644 Documentation/technical/api-parse-options.txt
 delete mode 100644 Documentation/technical/api-ref-iteration.txt
 delete mode 100644 Documentation/technical/api-remote.txt
 delete mode 100644 Documentation/technical/api-revision-walking.txt
 delete mode 100644 Documentation/technical/api-run-command.txt
 delete mode 100644 Documentation/technical/api-setup.txt
 delete mode 100644 Documentation/technical/api-sigchain.txt
 delete mode 100644 Documentation/technical/api-submodule-config.txt
 delete mode 100644 Documentation/technical/api-trace.txt
 delete mode 100644 Documentation/technical/api-tree-walking.txt


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-434%2FHebaWaly%2Fmove-doc-to-header-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-434/HebaWaly/move-doc-to-header-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/434

Range-diff vs v2:

  1:  6cd5f75315 !  1:  60e80b545f diff: move doc to diff.h and diffcore.h
     @@ -255,10 +255,10 @@
       #define DIFF_FLAGS_INIT { 0 }
       struct diff_flags {
      +
     -+    /**
     -+     * Tells if tree traversal done by tree-diff should recursively descend
     -+     * into a tree object pair that are different in preimage and postimage set.
     -+     */
     ++	/**
     ++	 * Tells if tree traversal done by tree-diff should recursively descend
     ++	 * into a tree object pair that are different in preimage and postimage set.
     ++	 */
       	unsigned recursive;
       	unsigned tree_in_recursive;
      +
     @@ -372,9 +372,9 @@
      +
       	unsigned pickaxe_opts;
      +
     -+    /* Affects the way detection logic for complete rewrites, renames and
     -+     * copies.
     -+     */
     ++	/* Affects the way detection logic for complete rewrites, renames and
     ++	 * copies.
     ++	 */
       	int rename_score;
       	int rename_limit;
      +
  2:  cdb32c159a !  2:  7539f11bce dir: move doc to dir.h
     @@ -148,6 +148,19 @@
      -
      -(JC)
      
     + diff --git a/dir.c b/dir.c
     + --- a/dir.c
     + +++ b/dir.c
     +@@
     +  * This handles recursive filename detection with exclude
     +  * files, index knowledge etc..
     +  *
     +- * See Documentation/technical/api-directory-listing.txt
     +- *
     +  * Copyright (C) Linus Torvalds, 2005-2006
     +  *		 Junio Hamano, 2005-2006
     +  */
     +
       diff --git a/dir.h b/dir.h
       --- a/dir.h
       +++ b/dir.h
     @@ -170,8 +183,9 @@
      + * Calling sequence
      + * ----------------
      + *
     -+ * Note: index may be looked at for .gitignore files that are CE_SKIP_WORKTREE
     -+ * marked. If you to exclude files, make sure you have loaded index first.
     ++ * Note: The index may be checked for .gitignore files that are
     ++ * CE_SKIP_WORKTREE marked. If you want to exclude files, make sure you have
     ++ * loaded the index first.
      + *
      + * - Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
      + * sizeof(dir))`.
     @@ -202,21 +216,21 @@
       };
       
      +/**
     -+ * pass directory traversal options to the library and to record the paths
     -+ * discovered. A single `struct dir_struct` is used regardless of whether or
     -+ * not the traversal recursively descends into subdirectories.
     ++ * structure is used to pass directory traversal options to the library and to
     ++ * record the paths discovered. A single `struct dir_struct` is used regardless
     ++ * of whether or not the traversal recursively descends into subdirectories.
      + */
       struct dir_struct {
      -	int nr, alloc;
      -	int ignored_nr, ignored_alloc;
      +
     -+    /* The number of members in `entries[]` array. */
     -+    int nr;
     ++	/* The number of members in `entries[]` array. */
     ++	int nr;
      +
     -+    /* Internal use; keeps track of allocation of `entries[]` array.*/
     -+    int alloc;
     ++	/* Internal use; keeps track of allocation of `entries[]` array.*/
     ++	int alloc;
      +
     -+    /* The number of members in `ignored[]` array. */
     ++	/* The number of members in `ignored[]` array. */
      +	int ignored_nr;
      +
      +	int ignored_alloc;
     @@ -224,10 +238,10 @@
      +	/* bit-field of options */
       	enum {
      +
     -+	    /**
     -+	     * Return just ignored files in `entries[]`, not untracked files.
     -+	     * This flag is mutually exclusive with `DIR_SHOW_IGNORED_TOO`.
     -+	     */
     ++		/**
     ++		 * Return just ignored files in `entries[]`, not untracked files.
     ++		 * This flag is mutually exclusive with `DIR_SHOW_IGNORED_TOO`.
     ++		 */
       		DIR_SHOW_IGNORED = 1<<0,
      +
      +		/* Include a directory that is not tracked. */
     @@ -244,9 +258,9 @@
      +
      +		/**
      +		 * Special mode for git-add. Return ignored files in `ignored[]` and
     -+	     * untracked files in `entries[]`. Only returns ignored files that match
     -+	     * pathspec exactly (no wildcards). Does not recurse into ignored
     -+	     * directories.
     ++		 * untracked files in `entries[]`. Only returns ignored files that match
     ++		 * pathspec exactly (no wildcards). Does not recurse into ignored
     ++		 * directories.
      +		 */
       		DIR_COLLECT_IGNORED = 1<<4,
      +
     @@ -259,11 +273,11 @@
      +
       		DIR_COLLECT_KILLED_ONLY = 1<<6,
      +
     -+        /**
     -+         * Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is
     -+         * set, the untracked contents of untracked directories are also
     -+         * returned in `entries[]`.
     -+         */
     ++		/**
     ++		 * Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is
     ++		 * set, the untracked contents of untracked directories are also
     ++		 * returned in `entries[]`.
     ++		 */
       		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7,
      +
      +		/**
     @@ -276,9 +290,9 @@
      +		 * returned as individual entries.
      +		 *
      +		 * If this is set, files and directories that explicitly match an ignore
     -+         * pattern are reported. Implicitly ignored directories (directories that
     -+         * do not match an ignore pattern, but whose contents are all ignored)
     -+         * are not reported, instead all of the contents are reported.
     ++		 * pattern are reported. Implicitly ignored directories (directories that
     ++		 * do not match an ignore pattern, but whose contents are all ignored)
     ++		 * are not reported, instead all of the contents are reported.
      +		 */
       		DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8,
      +
  3:  fd89383a46 =  3:  370f42114e graph: move doc to graph.h and graph.c
  4:  a70ed4b79b !  4:  39f25de85f merge: move doc to ll-merge.h
     @@ -145,13 +145,13 @@
      + */
       struct ll_merge_options {
      +
     -+    /**
     -+     * Behave as though this were part of a merge between common ancestors in
     -+     * a recursive merge (merges of binary files may need to be handled
     -+     * differently in such cases, for example). If a helper program is
     -+     * specified by the `[merge "<driver>"] recursive` configuration, it will
     -+     * be used.
     -+     */
     ++	/**
     ++	 * Behave as though this were part of a merge between common ancestors in
     ++	 * a recursive merge (merges of binary files may need to be handled
     ++	 * differently in such cases, for example). If a helper program is
     ++	 * specified by the `[merge "<driver>"] recursive` configuration, it will
     ++	 * be used.
     ++	 */
       	unsigned virtual_ancestor : 1;
      -	unsigned variant : 2;	/* favor ours, favor theirs, or union merge */
      +
     @@ -172,11 +172,11 @@
      +
      +	/**
      +	 * Increase the length of conflict markers so that nested conflicts
     -+     * can be differentiated.
     ++	 * can be differentiated.
      +	 */
       	unsigned extra_marker_size;
      +
     -+    /* Extra xpparam_t flags as defined in xdiff/xdiff.h. */
     ++	/* Extra xpparam_t flags as defined in xdiff/xdiff.h. */
       	long xdl_opts;
       };
       
  5:  fc81758644 !  5:  3a8f93de3d sha1-array: move doc to sha1-array.h
     @@ -108,6 +108,19 @@
      -}
      ------------------------------------------
      
     + diff --git a/sha1-array.c b/sha1-array.c
     + --- a/sha1-array.c
     + +++ b/sha1-array.c
     +@@
     + {
     + 	int i;
     + 
     +-	/* No oid_array_sort() here! See the api-oid-array.txt docs! */
     ++	/* No oid_array_sort() here! See sha1-array.h */
     + 
     + 	for (i = 0; i < array->nr; i++) {
     + 		int ret = fn(array->oid + i, data);
     +
       diff --git a/sha1-array.h b/sha1-array.h
       --- a/sha1-array.h
       +++ b/sha1-array.h
  6:  eb7adbcbcc !  6:  52ba427514 remote: move doc to remote.h and refspec.h
     @@ -278,7 +278,7 @@
      + */
       struct branch {
      +
     -+    /* The short name of the branch. */
     ++	/* The short name of the branch. */
       	const char *name;
      +
      +	/* The full path for the branch ref. */
  7:  24d0765df9 =  7:  6a9a0f77b3 refs: move doc to refs.h
  8:  4ea49f76c7 !  8:  b1aedd025e attr: move doc to attr.h
     @@ -172,6 +172,19 @@
      -
      -* Free the `attr_check` struct by calling `attr_check_free()`.
      
     + diff --git a/attr.c b/attr.c
     + --- a/attr.c
     + +++ b/attr.c
     +@@
     + /*
     +  * Handle git attributes.  See gitattributes(5) for a description of
     +- * the file syntax, and Documentation/technical/api-gitattributes.txt
     +- * for a description of the API.
     ++ * the file syntax, and attr.h for a description of the API.
     +  *
     +  * One basic design decision here is that we are not going to support
     +  * an insanely large number of attributes.
     +
       diff --git a/attr.h b/attr.h
       --- a/attr.h
       +++ b/attr.h
  9:  acd6287ced !  9:  6463c7565b revision: move doc to revision.h
     @@ -12,6 +12,19 @@
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
     + diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
     + --- a/Documentation/MyFirstObjectWalk.txt
     + +++ b/Documentation/MyFirstObjectWalk.txt
     +@@
     + 
     + - `Documentation/user-manual.txt` under "Hacking Git" contains some coverage of
     +   the revision walker in its various incarnations.
     +-- `Documentation/technical/api-revision-walking.txt`
     ++- `revision.h`
     + - https://eagain.net/articles/git-for-computer-scientists/[Git for Computer Scientists]
     +   gives a good overview of the types of objects in Git and what your object
     +   walk is really describing.
     +
       diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
       deleted file mode 100644
       --- a/Documentation/technical/api-revision-walking.txt
 10:  dcb78b6708 ! 10:  fa450e27a8 pathspec: move doc to pathspec.h
     @@ -73,6 +73,7 @@
       #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
       
      +/**
     ++ * See glossary-context.txt for the syntax of pathspec.
      + * In memory, a pathspec set is represented by "struct pathspec" and is
      + * prepared by parse_pathspec().
      + */
 11:  3499b99538 ! 11:  0e1663c039 sigchain: move doc to sigchain.h
     @@ -111,7 +111,10 @@
       int sigchain_push(int sig, sigchain_fun f);
       int sigchain_pop(int sig);
       
     -+/* push the handler onto the stack for many common signals. */
     ++/**
     ++ * push the handler onto the stack for the common signals:
     ++ * SIGINT, SIGHUP, SIGTERM, SIGQUIT and SIGPIPE.
     ++ */
       void sigchain_push_common(sigchain_fun f);
      +
       void sigchain_pop_common(void);
 12:  a280cf7f90 ! 12:  1eca7099ef cache: move doc to cache.h
     @@ -12,6 +12,22 @@
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
     + diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
     + --- a/Documentation/MyFirstObjectWalk.txt
     + +++ b/Documentation/MyFirstObjectWalk.txt
     +@@
     + 
     + `nr` represents the number of `rev_cmdline_entry` present in the array.
     + 
     +-`alloc` is used by the `ALLOC_GROW` macro. Check
     +-`Documentation/technical/api-allocation-growing.txt` - this variable is used to
     +-track the allocated size of the list.
     ++`alloc` is used by the `ALLOC_GROW` macro. Check `cache.h` - this variable is 
     ++used to track the allocated size of the list.
     + 
     + Per entry, we find:
     + 
     +
       diff --git a/Documentation/technical/api-allocation-growing.txt b/Documentation/technical/api-allocation-growing.txt
       deleted file mode 100644
       --- a/Documentation/technical/api-allocation-growing.txt
 13:  314864e42c = 13:  debc035d40 argv-array: move doc to argv-array.h
 14:  8fd1fa98a8 ! 14:  2e79afe7b8 credential: move doc to credential.h
     @@ -520,14 +520,14 @@
      + */
       struct credential {
      +
     -+    /**
     -+     * A `string_list` of helpers. Each string specifies an external
     -+     * helper which will be run, in order, to either acquire or store
     -+     * credentials. This list is filled-in by the API functions
     -+     * according to the corresponding configuration variables before
     -+     * consulting helpers, so there usually is no need for a caller to
     -+     * modify the helpers field at all.
     -+     */
     ++	/**
     ++	 * A `string_list` of helpers. Each string specifies an external
     ++	 * helper which will be run, in order, to either acquire or store
     ++	 * credentials. This list is filled-in by the API functions
     ++	 * according to the corresponding configuration variables before
     ++	 * consulting helpers, so there usually is no need for a caller to
     ++	 * modify the helpers field at all.
     ++	 */
       	struct string_list helpers;
      +
       	unsigned approved:1,
 15:  3d1e7e72ef ! 15:  1dca77cd27 parse-options: move doc to parse-options.h
     @@ -460,9 +460,9 @@
       
       enum parse_opt_flags {
      +
     -+    /**
     -+     * Keep the `--` that usually separates options from non-option arguments.
     -+     */
     ++	/**
     ++	 * Keep the `--` that usually separates options from non-option arguments.
     ++	 */
       	PARSE_OPT_KEEP_DASHDASH = 1,
      +
      +	/**
 16:  5d93cab5d9 ! 16:  1a9a6ca42d run-command: move doc to run-command.h
     @@ -326,23 +326,22 @@
      + *		redirected.
      + */
       struct child_process {
     --	const char **argv;
      +
     -+    /**
     -+     * The .argv member is set up as an array of string pointers (NULL
     -+     * terminated), of which .argv[0] is the program name to run (usually
     -+     * without a path). If the command to run is a git command, set argv[0] to
     -+     * the command name without the 'git-' prefix and set .git_cmd = 1.
     -+     *
     -+     * Note that the ownership of the memory pointed to by .argv stays with the
     -+     * caller, but it should survive until `finish_command` completes. If the
     -+     * .argv member is NULL, `start_command` will point it at the .args
     -+     * `argv_array` (so you may use one or the other, but you must use exactly
     -+     * one). The memory in .args will be cleaned up automatically during
     -+     * `finish_command` (or during `start_command` when it is unsuccessful).
     -+     *
     -+     */
     -+    const char **argv;
     ++	/**
     ++	 * The .argv member is set up as an array of string pointers (NULL
     ++	 * terminated), of which .argv[0] is the program name to run (usually
     ++	 * without a path). If the command to run is a git command, set argv[0] to
     ++	 * the command name without the 'git-' prefix and set .git_cmd = 1.
     ++	 *
     ++	 * Note that the ownership of the memory pointed to by .argv stays with the
     ++	 * caller, but it should survive until `finish_command` completes. If the
     ++	 * .argv member is NULL, `start_command` will point it at the .args
     ++	 * `argv_array` (so you may use one or the other, but you must use exactly
     ++	 * one). The memory in .args will be cleaned up automatically during
     ++	 * `finish_command` (or during `start_command` when it is unsuccessful).
     ++	 *
     ++	 */
     + 	const char **argv;
      +
       	struct argv_array args;
       	struct argv_array env_array;
     @@ -365,25 +364,25 @@
      +
      +	/**
      +	 * To specify a new initial working directory for the sub-process,
     -+     * specify it in the .dir member.
     ++	 * specify it in the .dir member.
      +	 */
       	const char *dir;
      +
      +	/**
      +	 * To modify the environment of the sub-process, specify an array of
     -+     * string pointers (NULL terminated) in .env:
     -+     *
     -+     * - If the string is of the form "VAR=value", i.e. it contains '='
     -+     *   the variable is added to the child process's environment.
     -+     *
     -+     * - If the string does not contain '=', it names an environment
     -+     *   variable that will be removed from the child process's environment.
     -+     *
     -+     * If the .env member is NULL, `start_command` will point it at the
     -+     * .env_array `argv_array` (so you may use one or the other, but not both).
     -+     * The memory in .env_array will be cleaned up automatically during
     -+     * `finish_command` (or during `start_command` when it is unsuccessful).
     -+     */
     ++	 * string pointers (NULL terminated) in .env:
     ++	 *
     ++	 * - If the string is of the form "VAR=value", i.e. it contains '='
     ++	 *   the variable is added to the child process's environment.
     ++	 *
     ++	 * - If the string does not contain '=', it names an environment
     ++	 *   variable that will be removed from the child process's environment.
     ++	 *
     ++	 * If the .env member is NULL, `start_command` will point it at the
     ++	 * .env_array `argv_array` (so you may use one or the other, but not both).
     ++	 * The memory in .env_array will be cleaned up automatically during
     ++	 * `finish_command` (or during `start_command` when it is unsuccessful).
     ++	 */
       	const char *const *env;
      +
       	unsigned no_stdin:1;
     @@ -392,12 +391,12 @@
      -	unsigned git_cmd:1; /* if this is to be git sub-command */
      +    unsigned git_cmd:1; /* if this is to be git sub-command */
      +
     -+    /**
     -+     * If the program cannot be found, the functions return -1 and set
     -+     * errno to ENOENT. Normally, an error message is printed, but if
     -+     * .silent_exec_failure is set to 1, no message is printed for this
     -+     * special error condition.
     -+     */
     ++	/**
     ++	 * If the program cannot be found, the functions return -1 and set
     ++	 * errno to ENOENT. Normally, an error message is printed, but if
     ++	 * .silent_exec_failure is set to 1, no message is printed for this
     ++	 * special error condition.
     ++	 */
       	unsigned silent_exec_failure:1;
      +
       	unsigned stdout_to_stderr:1;
     @@ -543,22 +542,22 @@
      +
      +	/**
      +	 * The function pointer in .proc has the following signature:
     -+     *
     -+     *	int proc(int in, int out, void *data);
     -+     *
     -+     * - in, out specifies a set of file descriptors to which the function
     -+     *  must read/write the data that it needs/produces.  The function
     -+     *  *must* close these descriptors before it returns.  A descriptor
     -+     *  may be -1 if the caller did not configure a descriptor for that
     -+     *  direction.
     -+     *
     -+     * - data is the value that the caller has specified in the .data member
     -+     *  of struct async.
     -+     *
     -+     * - The return value of the function is 0 on success and non-zero
     -+     *  on failure. If the function indicates failure, finish_async() will
     -+     *  report failure as well.
     -+     *
     ++	 *
     ++	 *	int proc(int in, int out, void *data);
     ++	 *
     ++	 * - in, out specifies a set of file descriptors to which the function
     ++	 *  must read/write the data that it needs/produces.  The function
     ++	 *  *must* close these descriptors before it returns.  A descriptor
     ++	 *  may be -1 if the caller did not configure a descriptor for that
     ++	 *  direction.
     ++	 *
     ++	 * - data is the value that the caller has specified in the .data member
     ++	 *  of struct async.
     ++	 *
     ++	 * - The return value of the function is 0 on success and non-zero
     ++	 *  on failure. If the function indicates failure, finish_async() will
     ++	 *  report failure as well.
     ++	 *
       	 */
       	int (*proc)(int in, int out, void *data);
      +
     @@ -566,32 +565,32 @@
      +
      +	/**
      +	 * The members .in, .out are used to provide a set of fd's for
     -+     * communication between the caller and the callee as follows:
     -+     *
     -+     * - Specify 0 to have no file descriptor passed.  The callee will
     -+     *   receive -1 in the corresponding argument.
     -+     *
     -+     * - Specify < 0 to have a pipe allocated; start_async() replaces
     -+     *   with the pipe FD in the following way:
     -+     *
     -+     * 	.in: Returns the writable pipe end into which the caller
     -+     * 	writes; the readable end of the pipe becomes the function's
     -+     * 	in argument.
     -+     *
     -+     * 	.out: Returns the readable pipe end from which the caller
     -+     * 	reads; the writable end of the pipe becomes the function's
     -+     * 	out argument.
     -+     *
     -+     *   The caller of start_async() must close the returned FDs after it
     -+     *   has completed reading from/writing from them.
     -+     *
     -+     * - Specify a file descriptor > 0 to be used by the function:
     -+     *
     -+     * 	.in: The FD must be readable; it becomes the function's in.
     -+     * 	.out: The FD must be writable; it becomes the function's out.
     -+     *
     -+     *   The specified FD is closed by start_async(), even if it fails to
     -+     *   run the function.
     ++	 * communication between the caller and the callee as follows:
     ++	 *
     ++	 * - Specify 0 to have no file descriptor passed.  The callee will
     ++	 *   receive -1 in the corresponding argument.
     ++	 *
     ++	 * - Specify < 0 to have a pipe allocated; start_async() replaces
     ++	 *   with the pipe FD in the following way:
     ++	 *
     ++	 * 	.in: Returns the writable pipe end into which the caller
     ++	 * 	writes; the readable end of the pipe becomes the function's
     ++	 * 	in argument.
     ++	 *
     ++	 * 	.out: Returns the readable pipe end from which the caller
     ++	 * 	reads; the writable end of the pipe becomes the function's
     ++	 * 	out argument.
     ++	 *
     ++	 *   The caller of start_async() must close the returned FDs after it
     ++	 *   has completed reading from/writing from them.
     ++	 *
     ++	 * - Specify a file descriptor > 0 to be used by the function:
     ++	 *
     ++	 * 	.in: The FD must be readable; it becomes the function's in.
     ++	 * 	.out: The FD must be writable; it becomes the function's out.
     ++	 *
     ++	 *   The specified FD is closed by start_async(), even if it fails to
     ++	 *   run the function.
      +	 */
       	int in;		/* caller writes here and closes it */
       	int out;	/* caller reads from here and closes it */
 17:  9b02b44cc8 = 17:  f4df8e16ed trace: move doc to trace.h
 18:  9c8f5c1cbe ! 18:  ee9b74018b tree-walk: move doc to tree-walk.h
     @@ -192,10 +192,10 @@
      + * A semi-opaque data structure used to maintain the current state of the walk.
      + */
       struct tree_desc {
     -+    /*
     -+     * pointer into the memory representation of the tree. It always
     -+     * points at the current entry being visited.
     -+     */
     ++	/*
     ++	 * pointer into the memory representation of the tree. It always
     ++	 * points at the current entry being visited.
     ++	 */
       	const void *buffer;
      +
      +	/* points to the current entry being visited. */
     @@ -286,8 +286,8 @@
      +
      +	/*
      +	 * points to the traverse_info which was used to descend into the
     -+     * current tree. If this is the top-level tree `prev` will point to
     -+     * a dummy traverse_info.
     ++	 * current tree. If this is the top-level tree `prev` will point to
     ++	 * a dummy traverse_info.
      +	 */
       	struct traverse_info *prev;
      +
     @@ -308,21 +308,21 @@
      +	/* a callback called for each entry in the tree.
      +	 *
      +	 * The arguments passed to the traverse callback are as follows:
     -+     *
     -+     * - `n` counts the number of trees being traversed.
     -+     *
     -+     * - `mask` has its nth bit set if something exists in the nth entry.
     -+     *
     -+     * - `dirmask` has its nth bit set if the nth tree's entry is a directory.
     -+     *
     -+     * - `entry` is an array of size `n` where the nth entry is from the nth tree.
     -+     *
     -+     * - `info` maintains the state of the traversal.
     -+     *
     -+     * Returning a negative value will terminate the traversal. Otherwise the
     -+     * return value is treated as an update mask. If the nth bit is set the nth tree
     -+     * will be updated and if the bit is not set the nth tree entry will be the
     -+     * same in the next callback invocation.
     ++	 *
     ++	 * - `n` counts the number of trees being traversed.
     ++	 *
     ++	 * - `mask` has its nth bit set if something exists in the nth entry.
     ++	 *
     ++	 * - `dirmask` has its nth bit set if the nth tree's entry is a directory.
     ++	 *
     ++	 * - `entry` is an array of size `n` where the nth entry is from the nth tree.
     ++	 *
     ++	 * - `info` maintains the state of the traversal.
     ++	 *
     ++	 * Returning a negative value will terminate the traversal. Otherwise the
     ++	 * return value is treated as an update mask. If the nth bit is set the nth tree
     ++	 * will be updated and if the bit is not set the nth tree entry will be the
     ++	 * same in the next callback invocation.
      +	 */
       	traverse_callback_t fn;
      +
 19:  7fa5cdf83f = 19:  9f34f3177d submodule-config: move doc to submodule-config.h
 20:  4c3215e92b ! 20:  a337f88a55 trace2: move doc to trace2.h
     @@ -3,13 +3,13 @@
          trace2: move doc to trace2.h
      
          Move the functions documentation from
     -    Documentation/technical/api-submodule-config.txt to submodule-config.h
     -    as it's easier for the developers to find the usage information beside
     -    the code instead of looking for it in another doc file.
     +    Documentation/technical/api-trace2.txt to trace2.h as it's easier for the
     +    developers to find the usage information beside the code instead of looking
     +    for it in another doc file.
      
          Only the functions documentation section is removed from
     -    Documentation/technical/api-submodule-config.txt as the file is full of
     -    more details that seemed more appropriate to be in a separate doc file
     +    Documentation/technical/api-trace2.txt as the file is full of
     +    details that seemed more appropriate to be in a separate doc file
          as it is, with a link to the doc file added in the trace2.h.
          Also the functions doc is removed to avoid having redundandt info which
          will be hard to keep syncronized with the documentation in the header file.
  -:  ---------- > 21:  e187c61371 api-index: remove api doc index files

-- 
gitgitgadget
