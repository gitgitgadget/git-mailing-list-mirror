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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1501F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKKV2Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:28:25 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37527 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfKKV2P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:28:15 -0500
Received: by mail-wr1-f52.google.com with SMTP id t1so16267405wrv.4
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eaxNcLZkc1xRmA03IP/qM005OiNcCoEXuCQFwEvdCY8=;
        b=g/BjSFOcCi64aPaNlRfZwFU1rLLpTkzGRnJtQesBoj9RAaeEld3p+ILFqIgLFt97Pl
         P4rHIvuxVJlMlfpZ+TfmcM6fE/UgTA5xg/6geJbyPX4lQnu1MMVsuwxXtRXKbwtlyxqA
         2rjpVmofmKoFmGapFFZtnj4mXxT7/9KpzLxolATqr8BiEpYRSMVOqwWB81ktz2oxibsF
         PIUOboXH5wVM3F5UH1A7FzplOJeCV/woEzqnocbtglwL0Ih261l6YOHB407Q6QRpUbwG
         EbqnK3iqsgixoaO0RA99dfNyQy1cBhEVXvP7xWl9+Ggon+yotVbfKy3r0oKuDQY/8A2h
         aYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eaxNcLZkc1xRmA03IP/qM005OiNcCoEXuCQFwEvdCY8=;
        b=DaAO+or/YKWNumMvZkDEJM/QGgjHXp0Bm09Cr/t1WzUfsKh21HMqmidyhDYuaQG3EQ
         apYT5jtlr17y2tAphrF+DEKlvAp/OnUm8NMFSLzRq8fNyP8k7pYB/JqZrSWbFUA2GSha
         42KcrFYepGm6iMPxYBy9wfwzoYE9w8CEOv4pyCq5CtWu2UepnUgFhEWVs//WQSJkqcjp
         32m03UQsDQ2rs1D/NFRtBRYLA+tlyf2XTl0BIxuT4kKRfQMF5ap4iNCzSYc9Td4mqtCk
         LEfHcmOX2xf4IvhDq7NZfBoNLifonzESya4AYSahj6fyKYK1EAYQYFaQAFfcpctaG40g
         Vb+w==
X-Gm-Message-State: APjAAAV8miviVZOXn8teF2bSvCbj9tRQjluz0PRfPhC6TXZLdQeLZgbV
        GOyhtMrEOc9IMuuFW1zCEb1++Jrd
X-Google-Smtp-Source: APXvYqzMXtqooobDu5gwJYOEUZqgRC8Yudhn7kCBDueCF/yXYyzVY/1lzl5h89ISAnAP+9Ki0oiasg==
X-Received: by 2002:a05:6000:1612:: with SMTP id u18mr23190836wrb.306.1573507693517;
        Mon, 11 Nov 2019 13:28:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5sm17839811wrv.56.2019.11.11.13.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:28:13 -0800 (PST)
Message-Id: <6463c7565b2dcd90944d0f0008609df64eaaed0e.1573507684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 21:27:52 +0000
Subject: [PATCH v3 09/21] revision: move doc to revision.h
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

Move the documentation from Documentation/technical/api-revision-walking.txt
to revision.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-revision-walking.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt           |  2 +-
 .../technical/api-revision-walking.txt        | 72 -------------------
 revision.h                                    | 59 +++++++++++++++
 3 files changed, 60 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/technical/api-revision-walking.txt

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index 4d24daeb9f..321c0ba6a4 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -17,7 +17,7 @@ revision walk is used for operations like `git log`.
 
 - `Documentation/user-manual.txt` under "Hacking Git" contains some coverage of
   the revision walker in its various incarnations.
-- `Documentation/technical/api-revision-walking.txt`
+- `revision.h`
 - https://eagain.net/articles/git-for-computer-scientists/[Git for Computer Scientists]
   gives a good overview of the types of objects in Git and what your object
   walk is really describing.
diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
deleted file mode 100644
index 03f9ea6ac4..0000000000
--- a/Documentation/technical/api-revision-walking.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-revision walking API
-====================
-
-The revision walking API offers functions to build a list of revisions
-and then iterate over that list.
-
-Calling sequence
-----------------
-
-The walking API has a given calling sequence: first you need to
-initialize a rev_info structure, then add revisions to control what kind
-of revision list do you want to get, finally you can iterate over the
-revision list.
-
-Functions
----------
-
-`repo_init_revisions`::
-
-	Initialize a rev_info structure with default values. The third
-	parameter may be NULL or can be prefix path, and then the `.prefix`
-	variable will be set to it. This is typically the first function you
-	want to call when you want to deal with a revision list. After calling
-	this function, you are free to customize options, like set
-	`.ignore_merges` to 0 if you don't want to ignore merges, and so on. See
-	`revision.h` for a complete list of available options.
-
-`add_pending_object`::
-
-	This function can be used if you want to add commit objects as revision
-	information. You can use the `UNINTERESTING` object flag to indicate if
-	you want to include or exclude the given commit (and commits reachable
-	from the given commit) from the revision list.
-+
-NOTE: If you have the commits as a string list then you probably want to
-use setup_revisions(), instead of parsing each string and using this
-function.
-
-`setup_revisions`::
-
-	Parse revision information, filling in the `rev_info` structure, and
-	removing the used arguments from the argument list. Returns the number
-	of arguments left that weren't recognized, which are also moved to the
-	head of the argument list. The last parameter is used in case no
-	parameter given by the first two arguments.
-
-`prepare_revision_walk`::
-
-	Prepares the rev_info structure for a walk. You should check if it
-	returns any error (non-zero return code) and if it does not, you can
-	start using get_revision() to do the iteration.
-
-`get_revision`::
-
-	Takes a pointer to a `rev_info` structure and iterates over it,
-	returning a `struct commit *` each time you call it. The end of the
-	revision list is indicated by returning a NULL pointer.
-
-`reset_revision_walk`::
-
-	Reset the flags used by the revision walking api. You can use
-	this to do multiple sequential revision walks.
-
-Data structures
----------------
-
-Talk about <revision.h>, things like:
-
-* two diff_options, one for path limiting, another for output;
-* remaining functions;
-
-(Linus, JC, Dscho)
diff --git a/revision.h b/revision.h
index 4134dc6029..983ffc0f12 100644
--- a/revision.h
+++ b/revision.h
@@ -9,6 +9,19 @@
 #include "diff.h"
 #include "commit-slab-decl.h"
 
+/**
+ * The revision walking API offers functions to build a list of revisions
+ * and then iterate over that list.
+ *
+ * Calling sequence
+ * ----------------
+ *
+ * The walking API has a given calling sequence: first you need to initialize
+ * a rev_info structure, then add revisions to control what kind of revision
+ * list do you want to get, finally you can iterate over the revision list.
+ *
+ */
+
 /* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
@@ -306,11 +319,29 @@ struct setup_revision_opt {
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define init_revisions(revs, prefix) repo_init_revisions(the_repository, revs, prefix)
 #endif
+
+/**
+ * Initialize a rev_info structure with default values. The third parameter may
+ * be NULL or can be prefix path, and then the `.prefix` variable will be set
+ * to it. This is typically the first function you want to call when you want
+ * to deal with a revision list. After calling this function, you are free to
+ * customize options, like set `.ignore_merges` to 0 if you don't want to
+ * ignore merges, and so on.
+ */
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix);
+
+/**
+ * Parse revision information, filling in the `rev_info` structure, and
+ * removing the used arguments from the argument list. Returns the number
+ * of arguments left that weren't recognized, which are also moved to the
+ * head of the argument list. The last parameter is used in case no
+ * parameter given by the first two arguments.
+ */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
+
 void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const struct option *options,
 			const char * const usagestr[]);
@@ -319,9 +350,26 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 int handle_revision_arg(const char *arg, struct rev_info *revs,
 			int flags, unsigned revarg_opt);
 
+/**
+ * Reset the flags used by the revision walking api. You can use this to do
+ * multiple sequential revision walks.
+ */
 void reset_revision_walk(void);
+
+/**
+ * Prepares the rev_info structure for a walk. You should check if it returns
+ * any error (non-zero return code) and if it does not, you can start using
+ * get_revision() to do the iteration.
+ */
 int prepare_revision_walk(struct rev_info *revs);
+
+/**
+ * Takes a pointer to a `rev_info` structure and iterates over it, returning a
+ * `struct commit *` each time you call it. The end of the revision list is
+ * indicated by returning a NULL pointer.
+ */
 struct commit *get_revision(struct rev_info *revs);
+
 char *get_revision_mark(const struct rev_info *revs,
 			const struct commit *commit);
 void put_revision_mark(const struct rev_info *revs,
@@ -333,8 +381,19 @@ void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees)
 
 void show_object_with_name(FILE *, struct object *, const char *);
 
+/**
+ * This function can be used if you want to add commit objects as revision
+ * information. You can use the `UNINTERESTING` object flag to indicate if
+ * you want to include or exclude the given commit (and commits reachable
+ * from the given commit) from the revision list.
+ *
+ * NOTE: If you have the commits as a string list then you probably want to
+ * use setup_revisions(), instead of parsing each string and using this
+ * function.
+ */
 void add_pending_object(struct rev_info *revs,
 			struct object *obj, const char *name);
+
 void add_pending_oid(struct rev_info *revs,
 		     const char *name, const struct object_id *oid,
 		     unsigned int flags);
-- 
gitgitgadget

