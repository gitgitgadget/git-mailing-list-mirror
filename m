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
	by dcvr.yhbt.net (Postfix) with ESMTP id 64BD41F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfKQVFU (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46583 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfKQVFS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so17097073wrs.13
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6p+RDsXs7xCRlpZG6AO3gcVN02EJA9I1/+CYJJM9jLI=;
        b=VXGANGgiZ4bYKJzAoip+HtRsOo79TpWJN8vk3l2kf/8S9gxmU4sueZNsUG7LPcotyE
         KyR4uTZIRNOIIT2TuBn7mYb85O2bT6uewhz/3GV0XL/728GotJgSTXlJtkKcMxChsymy
         eHMcDZnyYzjdziijeH6yqFf+xP8EDf4m6QZiZN5Vdx47BOmaOwRBEaY4gOleZRh+08Pz
         zECaQN2y8jHrl4QZAHPCy4u5p+3pZGwEFunF0dcChoSfEIcG8apighwOukvAJWLtqOZo
         tb3odxjB/DuX0i2kO0mZ6+K7SDBNZIK9FvDxRRPlRdURUAKUKpm+ijIa52dsPecMZcKd
         jcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6p+RDsXs7xCRlpZG6AO3gcVN02EJA9I1/+CYJJM9jLI=;
        b=A6vKopS9kheKbFxw9hp40yIWBDv+Ejd3AQ1QQ0AUa2YeXfo14q3UAaUvOw1V3NFj3M
         QD4ZWP0znQFLkS6669dTqT2YFkEQYLPVbtgjmWGouM8u9l60i4yG1CoW5kBfcvUQEd8g
         C2it2jVnjwQ8tRfXFhXtMyu2cVOSYqjbGCk+vmI2MotOhSUhPoJsQK0WUr5ddzveUq9f
         0/pOQORs5Ti43jk6w+jmF2q5A7SC2Sgd2l5KpJM0O/B/ji2gmqL7mM12qdX7nmR1aJK6
         tiq0BhjfQ4sRwP/yGYlWfQ/yHeFlSab+BiAFlmQFIdBnq04F5Yyq+/fMFAfedT5Z3uyk
         gB2A==
X-Gm-Message-State: APjAAAVnMO3rAZfUhvKaAjXTfmKK6+f6WkEBgWHAmCCEpsn61FrnWm/t
        03QLcR6qIneqapL9Hs5ar4mRcVaK
X-Google-Smtp-Source: APXvYqw0VALDctPm8bi/wbrgriqnd0DMPwRuhxDXTyDABrvYsObZNwTXyAHM81uxvOGc51Fy5Kc3nQ==
X-Received: by 2002:adf:9381:: with SMTP id 1mr12955313wrp.10.1574024715665;
        Sun, 17 Nov 2019 13:05:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm22298747wro.54.2019.11.17.13.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:15 -0800 (PST)
Message-Id: <9063c2fad2f680e180cf516cc33989d4ad6058df.1574024701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:57 +0000
Subject: [PATCH v5 18/21] tree-walk: move doc to tree-walk.h
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

Move the documentation from Documentation/technical/api-tree-walking.txt
to tree-walk.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Documentation/technical/api-tree-walking.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-tree-walking.txt | 149 -------------------
 tree-walk.h                                  | 122 ++++++++++++++-
 2 files changed, 120 insertions(+), 151 deletions(-)
 delete mode 100644 Documentation/technical/api-tree-walking.txt

diff --git a/Documentation/technical/api-tree-walking.txt b/Documentation/technical/api-tree-walking.txt
deleted file mode 100644
index 7962e32854..0000000000
--- a/Documentation/technical/api-tree-walking.txt
+++ /dev/null
@@ -1,149 +0,0 @@
-tree walking API
-================
-
-The tree walking API is used to traverse and inspect trees.
-
-Data Structures
----------------
-
-`struct name_entry`::
-
-	An entry in a tree. Each entry has a sha1 identifier, pathname, and
-	mode.
-
-`struct tree_desc`::
-
-	A semi-opaque data structure used to maintain the current state of the
-	walk.
-+
-* `buffer` is a pointer into the memory representation of the tree. It always
-points at the current entry being visited.
-
-* `size` counts the number of bytes left in the `buffer`.
-
-* `entry` points to the current entry being visited.
-
-`struct traverse_info`::
-
-	A structure used to maintain the state of a traversal.
-+
-* `prev` points to the traverse_info which was used to descend into the
-current tree. If this is the top-level tree `prev` will point to
-a dummy traverse_info.
-
-* `name` is the entry for the current tree (if the tree is a subtree).
-
-* `pathlen` is the length of the full path for the current tree.
-
-* `conflicts` can be used by callbacks to maintain directory-file conflicts.
-
-* `fn` is a callback called for each entry in the tree. See Traversing for more
-information.
-
-* `data` can be anything the `fn` callback would want to use.
-
-* `show_all_errors` tells whether to stop at the first error or not.
-
-Initializing
-------------
-
-`init_tree_desc`::
-
-	Initialize a `tree_desc` and decode its first entry. The buffer and
-	size parameters are assumed to be the same as the buffer and size
-	members of `struct tree`.
-
-`fill_tree_descriptor`::
-
-	Initialize a `tree_desc` and decode its first entry given the
-	object ID of a tree. Returns the `buffer` member if the latter
-	is a valid tree identifier and NULL otherwise.
-
-`setup_traverse_info`::
-
-	Initialize a `traverse_info` given the pathname of the tree to start
-	traversing from.
-
-Walking
--------
-
-`tree_entry`::
-
-	Visit the next entry in a tree. Returns 1 when there are more entries
-	left to visit and 0 when all entries have been visited. This is
-	commonly used in the test of a while loop.
-
-`tree_entry_len`::
-
-	Calculate the length of a tree entry's pathname. This utilizes the
-	memory structure of a tree entry to avoid the overhead of using a
-	generic strlen().
-
-`update_tree_entry`::
-
-	Walk to the next entry in a tree. This is commonly used in conjunction
-	with `tree_entry_extract` to inspect the current entry.
-
-`tree_entry_extract`::
-
-	Decode the entry currently being visited (the one pointed to by
-	`tree_desc's` `entry` member) and return the sha1 of the entry. The
-	`pathp` and `modep` arguments are set to the entry's pathname and mode
-	respectively.
-
-`get_tree_entry`::
-
-	Find an entry in a tree given a pathname and the sha1 of a tree to
-	search. Returns 0 if the entry is found and -1 otherwise. The third
-	and fourth parameters are set to the entry's sha1 and mode
-	respectively.
-
-Traversing
-----------
-
-`traverse_trees`::
-
-	Traverse `n` number of trees in parallel. The `fn` callback member of
-	`traverse_info` is called once for each tree entry.
-
-`traverse_callback_t`::
-	The arguments passed to the traverse callback are as follows:
-+
-* `n` counts the number of trees being traversed.
-
-* `mask` has its nth bit set if something exists in the nth entry.
-
-* `dirmask` has its nth bit set if the nth tree's entry is a directory.
-
-* `entry` is an array of size `n` where the nth entry is from the nth tree.
-
-* `info` maintains the state of the traversal.
-
-+
-Returning a negative value will terminate the traversal. Otherwise the
-return value is treated as an update mask. If the nth bit is set the nth tree
-will be updated and if the bit is not set the nth tree entry will be the
-same in the next callback invocation.
-
-`make_traverse_path`::
-
-	Generate the full pathname of a tree entry based from the root of the
-	traversal. For example, if the traversal has recursed into another
-	tree named "bar" the pathname of an entry "baz" in the "bar"
-	tree would be "bar/baz".
-
-`traverse_path_len`::
-
-	Calculate the length of a pathname returned by `make_traverse_path`.
-	This utilizes the memory structure of a tree entry to avoid the
-	overhead of using a generic strlen().
-
-`strbuf_make_traverse_path`::
-
-	Convenience wrapper to `make_traverse_path` into a strbuf.
-
-Authors
--------
-
-Written by Junio C Hamano <gitster@pobox.com> and Linus Torvalds
-<torvalds@linux-foundation.org>
diff --git a/tree-walk.h b/tree-walk.h
index abe2caf4e0..826396c8ed 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -3,6 +3,13 @@
 
 #include "cache.h"
 
+/**
+ * The tree walking API is used to traverse and inspect trees.
+ */
+
+/**
+ * An entry in a tree. Each entry has a sha1 identifier, pathname, and mode.
+ */
 struct name_entry {
 	struct object_id oid;
 	const char *path;
@@ -10,12 +17,29 @@ struct name_entry {
 	unsigned int mode;
 };
 
+/**
+ * A semi-opaque data structure used to maintain the current state of the walk.
+ */
 struct tree_desc {
+	/*
+	 * pointer into the memory representation of the tree. It always
+	 * points at the current entry being visited.
+	 */
 	const void *buffer;
+
+	/* points to the current entry being visited. */
 	struct name_entry entry;
+
+	/* counts the number of bytes left in the `buffer`. */
 	unsigned int size;
 };
 
+/**
+ * Decode the entry currently being visited (the one pointed to by
+ * `tree_desc's` `entry` member) and return the sha1 of the entry. The
+ * `pathp` and `modep` arguments are set to the entry's pathname and mode
+ * respectively.
+ */
 static inline const struct object_id *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned short *modep)
 {
 	*pathp = desc->entry.path;
@@ -23,6 +47,11 @@ static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
 	return &desc->entry.oid;
 }
 
+/**
+ * Calculate the length of a tree entry's pathname. This utilizes the
+ * memory structure of a tree entry to avoid the overhead of using a
+ * generic strlen().
+ */
 static inline int tree_entry_len(const struct name_entry *ne)
 {
 	return ne->pathlen;
@@ -33,52 +62,141 @@ static inline int tree_entry_len(const struct name_entry *ne)
  * corrupt tree entry rather than dying,
  */
 
+/**
+ * Walk to the next entry in a tree. This is commonly used in conjunction
+ * with `tree_entry_extract` to inspect the current entry.
+ */
 void update_tree_entry(struct tree_desc *);
+
 int update_tree_entry_gently(struct tree_desc *);
+
+/**
+ * Initialize a `tree_desc` and decode its first entry. The buffer and
+ * size parameters are assumed to be the same as the buffer and size
+ * members of `struct tree`.
+ */
 void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
+
 int init_tree_desc_gently(struct tree_desc *desc, const void *buf, unsigned long size);
 
 /*
- * Helper function that does both tree_entry_extract() and update_tree_entry()
- * and returns true for success
+ * Visit the next entry in a tree. Returns 1 when there are more entries
+ * left to visit and 0 when all entries have been visited. This is
+ * commonly used in the test of a while loop.
  */
 int tree_entry(struct tree_desc *, struct name_entry *);
+
 int tree_entry_gently(struct tree_desc *, struct name_entry *);
 
+/**
+ * Initialize a `tree_desc` and decode its first entry given the
+ * object ID of a tree. Returns the `buffer` member if the latter
+ * is a valid tree identifier and NULL otherwise.
+ */
 void *fill_tree_descriptor(struct repository *r,
 			   struct tree_desc *desc,
 			   const struct object_id *oid);
 
 struct traverse_info;
 typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
+
+/**
+ * Traverse `n` number of trees in parallel. The `fn` callback member of
+ * `traverse_info` is called once for each tree entry.
+ */
 int traverse_trees(struct index_state *istate, int n, struct tree_desc *t, struct traverse_info *info);
 
 enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r, struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned short *mode);
 
+/**
+ * A structure used to maintain the state of a traversal.
+ */
 struct traverse_info {
 	const char *traverse_path;
+
+	/*
+	 * points to the traverse_info which was used to descend into the
+	 * current tree. If this is the top-level tree `prev` will point to
+	 * a dummy traverse_info.
+	 */
 	struct traverse_info *prev;
+
+	/* is the entry for the current tree (if the tree is a subtree). */
 	const char *name;
+
 	size_t namelen;
 	unsigned mode;
 
+	/* is the length of the full path for the current tree. */
 	size_t pathlen;
+
 	struct pathspec *pathspec;
 
+	/* can be used by callbacks to maintain directory-file conflicts. */
 	unsigned long df_conflicts;
+
+	/* a callback called for each entry in the tree.
+	 *
+	 * The arguments passed to the traverse callback are as follows:
+	 *
+	 * - `n` counts the number of trees being traversed.
+	 *
+	 * - `mask` has its nth bit set if something exists in the nth entry.
+	 *
+	 * - `dirmask` has its nth bit set if the nth tree's entry is a directory.
+	 *
+	 * - `entry` is an array of size `n` where the nth entry is from the nth tree.
+	 *
+	 * - `info` maintains the state of the traversal.
+	 *
+	 * Returning a negative value will terminate the traversal. Otherwise the
+	 * return value is treated as an update mask. If the nth bit is set the nth tree
+	 * will be updated and if the bit is not set the nth tree entry will be the
+	 * same in the next callback invocation.
+	 */
 	traverse_callback_t fn;
+
+	/* can be anything the `fn` callback would want to use. */
 	void *data;
+
+	/* tells whether to stop at the first error or not. */
 	int show_all_errors;
 };
 
+/**
+ * Find an entry in a tree given a pathname and the sha1 of a tree to
+ * search. Returns 0 if the entry is found and -1 otherwise. The third
+ * and fourth parameters are set to the entry's sha1 and mode respectively.
+ */
 int get_tree_entry(struct repository *, const struct object_id *, const char *, struct object_id *, unsigned short *);
+
+/**
+ * Generate the full pathname of a tree entry based from the root of the
+ * traversal. For example, if the traversal has recursed into another
+ * tree named "bar" the pathname of an entry "baz" in the "bar"
+ * tree would be "bar/baz".
+ */
 char *make_traverse_path(char *path, size_t pathlen, const struct traverse_info *info,
 			 const char *name, size_t namelen);
+
+/**
+ * Convenience wrapper to `make_traverse_path` into a strbuf.
+ */
 void strbuf_make_traverse_path(struct strbuf *out,
 			       const struct traverse_info *info,
 			       const char *name, size_t namelen);
+
+/**
+ * Initialize a `traverse_info` given the pathname of the tree to start
+ * traversing from.
+ */
 void setup_traverse_info(struct traverse_info *info, const char *base);
 
+/**
+ * Calculate the length of a pathname returned by `make_traverse_path`.
+ * This utilizes the memory structure of a tree entry to avoid the
+ * overhead of using a generic strlen().
+ */
 static inline size_t traverse_path_len(const struct traverse_info *info,
 				       size_t namelen)
 {
-- 
gitgitgadget

