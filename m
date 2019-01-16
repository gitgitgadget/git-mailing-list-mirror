Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5DDA1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 18:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfAPS0E (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 13:26:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42315 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbfAPS0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 13:26:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so6202366edw.9
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 10:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K7KT+CMA3W+4Sv67O1J84SFMphM0SYB58GFUvOE70jE=;
        b=KUX4co2T6liwToFRvPvGAv8scFtwTb+0I5ilS2QUuOFGbk88LyB873RkUlS48Vzllf
         JuPWtDx3rmDNu2O3qnKnVt41q6Bxh+cajscoyTjZoc/7Pqo9RzEagMnK/5+dLmdvF4cV
         jROkrIZwFjep7q0seEKNQ5+ok7qVyJTlvgoCZol1ZF1ATyBKerRm21TD4qfUsevYvoaj
         OBs8KjJGsO8/NwLbHMlz1Z1vZgPadHiUZzt7YWERUnUUCqdf4b/i2oEpE06IAcRuM7zy
         GfXgLw+Y4kcCoxybp7d/6H4Sk/Bs48FIxPk8EOOvLOuotK2RXQcBNTB6/hUOMGefa7kb
         h0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K7KT+CMA3W+4Sv67O1J84SFMphM0SYB58GFUvOE70jE=;
        b=DQR+vNm79Gqoh2xXIKWJ+NYaf3BSc7ApQ/8uodm5XgHNnn7plKpFUcfnK/3M5CNknn
         ROq0IPOpXz/piRFdG0RiLPthfujRSu67PBv/nC5xnea6zfGEvzp3767QyxGAtbymXzwW
         7C6Ys3qBEXAbFez2FPbRAk/smZvbAiTETvj9El9TBCOhbI6A4OtyQV0Des6N1PXJ7W4r
         BJkSSWy0aocxHnuR6WA6BHr7maq8LfqZK8AxnAKiuiF3hVZ3Zdbok1zwABKUdCsnckuu
         mEwPI301mv1ixvgQFYuytbg9DPgvkkyHg982ZaRVmf/Uldxby9QQNAx4NaN8gQjj+YIC
         11Gg==
X-Gm-Message-State: AJcUukcyZfXnH1hRvK5aTDFend4NIDIQ9f1ifUreI/lDaMZvu5+eGkaG
        2OAnQYl3fBxRmeso4jRkF+1XjcNF
X-Google-Smtp-Source: ALg8bN45gHVQaqTRhR9befZwU64+JIYfqj/oUq70J/ozMMU5CqG3jWNfxherka4IJXHgqQLXGR7xWw==
X-Received: by 2002:a17:906:d054:: with SMTP id bo20-v6mr7785616ejb.239.1547663160421;
        Wed, 16 Jan 2019 10:26:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e51sm5698522edd.35.2019.01.16.10.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:25:59 -0800 (PST)
Date:   Wed, 16 Jan 2019 10:25:59 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 18:25:53 GMT
Message-Id: <327c10247748c33edd9c18d0388f22a0289b12d9.1547663156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v5.git.gitgitgadget@gmail.com>
References: <pull.89.v4.git.gitgitgadget@gmail.com>
        <pull.89.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 3/5] revision: implement sparse algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        ramsay@ramsayjones.plus.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When enumerating objects to place in a pack-file during 'git
pack-objects --revs', we discover the "frontier" of commits
that we care about and the boundary with commit we find
uninteresting. From that point, we walk trees to discover which
trees and blobs are uninteresting. Finally, we walk trees from the
interesting commits to find the interesting objects that are
placed in the pack.

This commit introduces a new, "sparse" way to discover the
uninteresting trees. We use the perspective of a single user trying
to push their topic to a large repository. That user likely changed
a very small fraction of the paths in their working directory, but
we spend a lot of time walking all reachable trees.

The way to switch the logic to work in this sparse way is to start
caring about which paths introduce new trees. While it is not
possible to generate a diff between the frontier boundary and all
of the interesting commits, we can simulate that behavior by
inspecting all of the root trees as a whole, then recursing down
to the set of trees at each path.

We already had taken the first step by passing an oidset to
mark_trees_uninteresting_sparse(). We now create a dictionary
whose keys are paths and values are oidsets. We consider the set
of trees that appear at each path. While we inspect a tree, we
add its subtrees to the oidsets corresponding to the tree entry's
path. We also mark trees as UNINTERESTING if the tree we are
parsing is UNINTERESTING.

To actually improve the performance, we need to terminate our
recursion. If the oidset contains only UNINTERESTING trees, then
we do not continue the recursion. This avoids walking trees that
are likely to not be reachable from interesting trees. If the
oidset contains only interesting trees, then we will walk these
trees in the final stage that collects the intersting objects to
place in the pack. Thus, we only recurse if the oidset contains
both interesting and UNINITERESTING trees.

There are a few ways that this is not a universally better option.

First, we can pack extra objects. If someone copies a subtree
from one tree to another, the first tree will appear UNINTERESTING
and we will not recurse to see that the subtree should also be
UNINTERESTING. We will walk the new tree and see the subtree as
a "new" object and add it to the pack. A test is modified to
demonstrate this behavior and to verify that the new logic is
being exercised.

Second, we can have extra memory pressure. If instead of being a
single user pushing a small topic we are a server sending new
objects from across the entire working directory, then we will
gain very little (the recursion will rarely terminate early) but
will spend extra time maintaining the path-oidset dictionaries.

Despite these potential drawbacks, the benefits of the algorithm
are clear. By adding a counter to 'add_children_by_path' and
'mark_tree_contents_uninteresting', I measured the number of
parsed trees for the two algorithms in a variety of repos.

For git.git, I used the following input:

	v2.19.0
	^v2.19.0~10

 Objects to pack: 550
Walked (old alg): 282
Walked (new alg): 130

For the Linux repo, I used the following input:

	v4.18
	^v4.18~10

 Objects to pack:   518
Walked (old alg): 4,836
Walked (new alg):   188

The two repos above are rather "wide and flat" compared to
other repos that I have used in the past. As a comparison,
I tested an old topic branch in the Azure DevOps repo, which
has a much deeper folder structure than the Linux repo.

 Objects to pack:    220
Walked (old alg): 22,804
Walked (new alg):    129

I used the number of walked trees the main metric above because
it is consistent across multiple runs. When I ran my tests, the
performance of the pack-objects command with the same options
could change the end-to-end time by 10x depending on the file
system being warm. However, by repeating the same test on repeat
I could get more consistent timing results. The git.git and
Linux tests were too fast overall (less than 0.5s) to measure
an end-to-end difference. The Azure DevOps case was slow enough
to see the time improve from 15s to 1s in the warm case. The
cold case was 90s to 9s in my testing.

These improvements will have even larger benefits in the super-
large Windows repository. In our experiments, we see the
"Enumerate objects" phase of pack-objects taking 60-80% of the
end-to-end time of non-trivial pushes, taking longer than the
network time to send the pack and the server time to verify the
pack.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c                     | 138 ++++++++++++++++++++++++++++++---
 t/t5322-pack-objects-sparse.sh |  14 +++-
 2 files changed, 139 insertions(+), 13 deletions(-)

diff --git a/revision.c b/revision.c
index 60421f3a10..5de739384a 100644
--- a/revision.c
+++ b/revision.c
@@ -27,6 +27,7 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "prio-queue.h"
+#include "hashmap.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -99,29 +100,146 @@ void mark_tree_uninteresting(struct repository *r, struct tree *tree)
 	mark_tree_contents_uninteresting(r, tree);
 }
 
+struct path_and_oids_entry {
+	struct hashmap_entry ent;
+	char *path;
+	struct oidset trees;
+};
+
+static int path_and_oids_cmp(const void *hashmap_cmp_fn_data,
+			     const struct path_and_oids_entry *e1,
+			     const struct path_and_oids_entry *e2,
+			     const void *keydata)
+{
+	return strcmp(e1->path, e2->path);
+}
+
+static void paths_and_oids_init(struct hashmap *map)
+{
+	hashmap_init(map, (hashmap_cmp_fn) path_and_oids_cmp, NULL, 0);
+}
+
+static void paths_and_oids_clear(struct hashmap *map)
+{
+	struct hashmap_iter iter;
+	struct path_and_oids_entry *entry;
+	hashmap_iter_init(map, &iter);
+
+	while ((entry = (struct path_and_oids_entry *)hashmap_iter_next(&iter))) {
+		oidset_clear(&entry->trees);
+		free(entry->path);
+	}
+
+	hashmap_free(map, 1);
+}
+
+static void paths_and_oids_insert(struct hashmap *map,
+				  const char *path,
+				  const struct object_id *oid)
+{
+	int hash = strhash(path);
+	struct path_and_oids_entry key;
+	struct path_and_oids_entry *entry;
+
+	hashmap_entry_init(&key, hash);
+
+	/* use a shallow copy for the lookup */
+	key.path = (char *)path;
+	oidset_init(&key.trees, 0);
+
+	if (!(entry = (struct path_and_oids_entry *)hashmap_get(map, &key, NULL))) {
+		entry = xcalloc(1, sizeof(struct path_and_oids_entry));
+		hashmap_entry_init(entry, hash);
+		entry->path = xstrdup(key.path);
+		oidset_init(&entry->trees, 16);
+		hashmap_put(map, entry);
+	}
+
+	oidset_insert(&entry->trees, oid);
+}
+
+static void add_children_by_path(struct repository *r,
+				 struct tree *tree,
+				 struct hashmap *map)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+
+	if (!tree)
+		return;
+
+	if (parse_tree_gently(tree, 1) < 0)
+		return;
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	while (tree_entry(&desc, &entry)) {
+		switch (object_type(entry.mode)) {
+		case OBJ_TREE:
+			paths_and_oids_insert(map, entry.path, entry.oid);
+
+			if (tree->object.flags & UNINTERESTING) {
+				struct tree *child = lookup_tree(r, entry.oid);
+				if (child)
+					child->object.flags |= UNINTERESTING;
+			}
+			break;
+		case OBJ_BLOB:
+			if (tree->object.flags & UNINTERESTING) {
+				struct blob *child = lookup_blob(r, entry.oid);
+				if (child)
+					child->object.flags |= UNINTERESTING;
+			}
+			break;
+		default:
+			/* Subproject commit - not in this repository */
+			break;
+		}
+	}
+
+	free_tree_buffer(tree);
+}
+
 void mark_trees_uninteresting_sparse(struct repository *r,
 				     struct oidset *trees)
 {
+	unsigned has_interesting = 0, has_uninteresting = 0;
+	struct hashmap map;
+	struct hashmap_iter map_iter;
+	struct path_and_oids_entry *entry;
 	struct object_id *oid;
 	struct oidset_iter iter;
 
 	oidset_iter_init(trees, &iter);
-	while ((oid = oidset_iter_next(&iter))) {
+	while ((!has_interesting || !has_uninteresting) &&
+	       (oid = oidset_iter_next(&iter))) {
 		struct tree *tree = lookup_tree(r, oid);
 
 		if (!tree)
 			continue;
 
-		if (tree->object.flags & UNINTERESTING) {
-			/*
-			 * Remove the flag so the next call
-			 * is not a no-op. The flag is added
-			 * in mark_tree_unintersting().
-			 */
-			tree->object.flags ^= UNINTERESTING;
-			mark_tree_uninteresting(r, tree);
-		}
+		if (tree->object.flags & UNINTERESTING)
+			has_uninteresting = 1;
+		else
+			has_interesting = 1;
+	}
+
+	/* Do not walk unless we have both types of trees. */
+	if (!has_uninteresting || !has_interesting)
+		return;
+
+	paths_and_oids_init(&map);
+
+	oidset_iter_init(trees, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct tree *tree = lookup_tree(r, oid);
+		add_children_by_path(r, tree, &map);
 	}
+
+	hashmap_iter_init(&map, &map_iter);
+	while ((entry = hashmap_iter_next(&map_iter)))
+		mark_trees_uninteresting_sparse(r, &entry->trees);
+
+	paths_and_oids_clear(&map);
 }
 
 struct commit_stack {
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 30aef6498a..9f2a6e5d31 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -79,6 +79,9 @@ test_expect_success 'sparse pack-objects' '
 	test_cmp required_objects.txt sparse_required_objects.txt
 '
 
+# Demonstrate that the algorithms differ when we copy a tree wholesale
+# from one folder to another.
+
 test_expect_success 'duplicate a folder from f1 into f3' '
 	mkdir f3/f4 &&
 	cp -r f1/f1/* f3/f4 &&
@@ -95,7 +98,7 @@ test_expect_success 'duplicate a folder from f1 into f3' '
 '
 
 test_expect_success 'non-sparse pack-objects' '
-	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git pack-objects --stdout --revs --no-sparse <packinput.txt >nonsparse.pack &&
 	git index-pack -o nonsparse.idx nonsparse.pack &&
 	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
 	comm -1 -2 required_objects.txt nonsparse_objects.txt >nonsparse_required_objects.txt &&
@@ -103,11 +106,16 @@ test_expect_success 'non-sparse pack-objects' '
 '
 
 test_expect_success 'sparse pack-objects' '
+	git rev-parse			\
+		topic1			\
+		topic1^{tree}		\
+		topic1:f3		\
+		topic1:f3/f4		\
+		topic1:f3/f4/data.txt | sort >expect_sparse_objects.txt &&
 	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
 	git index-pack -o sparse.idx sparse.pack &&
 	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
-	comm -1 -2 required_objects.txt sparse_objects.txt >sparse_required_objects.txt &&
-	test_cmp required_objects.txt sparse_required_objects.txt
+	test_cmp expect_sparse_objects.txt sparse_objects.txt
 '
 
 test_done
-- 
gitgitgadget

