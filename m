Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F04B1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 18:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfAPS0D (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 13:26:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39182 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfAPS0C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 13:26:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so6221834edt.6
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 10:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4DEBqdCRVwjep6I57BbIk3f4QzA+V2WCte1kUBq3GNE=;
        b=rug9X6rp4CiOzbuAYMoG5EhzC/Hl3dMWYwrMRZ4bGDArgqDwv6GpS8Ruuema6oBJkY
         Se/Uwm8RUh/veXc7kI4t2fcHTKwzh8Q9pYU+wgSKunbHgWDGJyZzQRzlmOCfF7SrKG2k
         zgadGeMVPfxH5R5VXUrnP1wv97Qs4Cdta9YoUSf2TAwqqQpJ0THYK+SU+o94GPTu8U6d
         hp2kpuZyfoGqNyCKJI1afQUZbM7vajOVFhivsvHdTiOFgBjesa75DGEduqGstHYGzS9M
         38tAGg0dxH/5QD+rf8jSDq8MHXWSqcubzqGC9NxqjpesN5KaXEj6s+Tvl/PU7Zg1gjnI
         WvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4DEBqdCRVwjep6I57BbIk3f4QzA+V2WCte1kUBq3GNE=;
        b=sku0XAMt6v9iuklSdyzrxDqicqALdWkrEMFa95XpjX3vltIwaea1QP31LP3kZ10NMt
         1BO83Cesuzwqh4OcvmfGkXvz6oWjlRSBBunDpA9nOXVaCiTNzv5EUDsoBXSEO+Q4FWhR
         vzqq/C8UfZBpftjcX9SnoKzbm0hpgZyoSHhDHu8ky7uUSfnI18t/jNOUfN1HVysuHaVP
         OWnk/yUqOorAZtSTh/i6Dz/BVS5kdCKTeq6Rc7+kLuGmu+By/giJ8/jbcFsABn3YlfSr
         YJepCbdAaAE4Cahf5RI6ry3eCv5KAbSQtkYUcXLlfqWefwTu0Q7N3wOzLlbyfKdE6oDN
         QfdA==
X-Gm-Message-State: AJcUukc5sfll0z0niWaciv8mFovRh0B+zQKQKDj09nSMChf5RTc6ZzlA
        j72Wvtxw3YE6EtW4perSOHYqF1TY
X-Google-Smtp-Source: ALg8bN5k4V7hSo0i+or8ISAtrWLZ1Mnj15ujrEGXxStQLLEXMx4gfDYNdQl41yORqQ9gSoF4CjVnfg==
X-Received: by 2002:a17:906:7f89:: with SMTP id f9-v6mr7590703ejr.51.1547663159530;
        Wed, 16 Jan 2019 10:25:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n29sm5873461edd.40.2019.01.16.10.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:25:58 -0800 (PST)
Date:   Wed, 16 Jan 2019 10:25:58 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 18:25:52 GMT
Message-Id: <0747f7494ef2be5e61bad610d2fe0b7db617bb49.1547663156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v5.git.gitgitgadget@gmail.com>
References: <pull.89.v4.git.gitgitgadget@gmail.com>
        <pull.89.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 2/5] list-objects: consume sparse tree walk
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

When creating a pack-file using 'git pack-objects --revs' we provide
a list of interesting and uninteresting commits. For example, a push
operation would make the local topic branch be interesting and the
known remote refs as uninteresting. We want to discover the set of
new objects to send to the server as a thin pack.

We walk these commits until we discover a frontier of commits such
that every commit walk starting at interesting commits ends in a root
commit or unintersting commit. We then need to discover which
non-commit objects are reachable from  uninteresting commits. This
commit walk is not changing during this series.

The mark_edges_uninteresting() method in list-objects.c iterates on
the commit list and does the following:

* If the commit is UNINTERSTING, then mark its root tree and every
  object it can reach as UNINTERESTING.

* If the commit is interesting, then mark the root tree of every
  UNINTERSTING parent (and all objects that tree can reach) as
  UNINTERSTING.

At the very end, we repeat the process on every commit directly
given to the revision walk from stdin. This helps ensure we properly
cover shallow commits that otherwise were not included in the
frontier.

The logic to recursively follow trees is in the
mark_tree_uninteresting() method in revision.c. The algorithm avoids
duplicate work by not recursing into trees that are already marked
UNINTERSTING.

Add a new 'sparse' option to the mark_edges_uninteresting() method
that performs this logic in a slightly different way. As we iterate
over the commits, we add all of the root trees to an oidset. Then,
call mark_trees_uninteresting_sparse() on that oidset. Note that we
include interesting trees in this process. The current implementation
of mark_trees_unintersting_sparse() will walk the same trees as
the old logic, but this will be replaced in a later change.

Add a '--sparse' flag in 'git pack-objects' to call this new logic.
Add a new test script t/t5322-pack-objects-sparse.sh that tests this
option. The tests currently demonstrate that the resulting object
list is the same as the old algorithm. This includes a case where
both algorithms pack an object that is not needed by a remote due to
limits on the explored set of trees. When the sparse algorithm is
changed in a later commit, we will add a test that demonstrates a
change of behavior in some cases.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-pack-objects.txt |  11 ++-
 bisect.c                           |   2 +-
 builtin/pack-objects.c             |   5 +-
 builtin/rev-list.c                 |   2 +-
 http-push.c                        |   2 +-
 list-objects.c                     |  70 +++++++++++++++---
 list-objects.h                     |   4 +-
 t/t5322-pack-objects-sparse.sh     | 113 +++++++++++++++++++++++++++++
 8 files changed, 192 insertions(+), 17 deletions(-)
 create mode 100755 t/t5322-pack-objects-sparse.sh

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 40c825c381..e45f3e680d 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
 	[--stdout [--filter=<filter-spec>] | base-name]
-	[--shallow] [--keep-true-parents] < object-list
+	[--shallow] [--keep-true-parents] [--sparse] < object-list
 
 
 DESCRIPTION
@@ -196,6 +196,15 @@ depth is 4095.
 	Add --no-reuse-object if you want to force a uniform compression
 	level on all data no matter the source.
 
+--sparse::
+	Use the "sparse" algorithm to determine which objects to include in
+	the pack, when combined with the "--revs" option. This algorithm
+	only walks trees that appear in paths that introduce new objects.
+	This can have significant performance benefits when computing
+	a pack to send a small change. However, it is possible that extra
+	objects are added to the pack-file if the included commits contain
+	certain types of direct renames.
+
 --thin::
 	Create a "thin" pack by omitting the common objects between a
 	sender and a receiver in order to reduce network transfer. This
diff --git a/bisect.c b/bisect.c
index 487675c672..842f8b4b8f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -656,7 +656,7 @@ static void bisect_common(struct rev_info *revs)
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 	if (revs->tree_objects)
-		mark_edges_uninteresting(revs, NULL);
+		mark_edges_uninteresting(revs, NULL, 0);
 }
 
 static void exit_if_skipped_commits(struct commit_list *tried,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 411aefd687..7d5b0735e3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -84,6 +84,7 @@ static unsigned long pack_size_limit;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
+static int sparse;
 static int thin;
 static int num_preferred_base;
 static struct progress *progress_state;
@@ -3135,7 +3136,7 @@ static void get_object_list(int ac, const char **av)
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
-	mark_edges_uninteresting(&revs, show_edge);
+	mark_edges_uninteresting(&revs, show_edge, sparse);
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
@@ -3292,6 +3293,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, N_("time"),
 		  N_("unpack unreachable objects newer than <time>"),
 		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
+		OPT_BOOL(0, "sparse", &sparse,
+			 N_("use the sparse reachability algorithm")),
 		OPT_BOOL(0, "thin", &thin,
 			 N_("create thin packs")),
 		OPT_BOOL(0, "shallow", &shallow,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 2880ed37e3..9663cbfae0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -543,7 +543,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	if (revs.tree_objects)
-		mark_edges_uninteresting(&revs, show_edge);
+		mark_edges_uninteresting(&revs, show_edge, 0);
 
 	if (bisect_list) {
 		int reaches, all;
diff --git a/http-push.c b/http-push.c
index cd48590912..ea52d6f9f6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1933,7 +1933,7 @@ int cmd_main(int argc, const char **argv)
 		pushing = 0;
 		if (prepare_revision_walk(&revs))
 			die("revision walk setup failed");
-		mark_edges_uninteresting(&revs, NULL);
+		mark_edges_uninteresting(&revs, NULL, 0);
 		objects_to_send = get_delta(&revs, ref_lock);
 		finish_all_active_slots();
 
diff --git a/list-objects.c b/list-objects.c
index c41cc80db5..fb728f7842 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -222,25 +222,73 @@ static void mark_edge_parents_uninteresting(struct commit *commit,
 	}
 }
 
-void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
+static void add_edge_parents(struct commit *commit,
+			     struct rev_info *revs,
+			     show_edge_fn show_edge,
+			     struct oidset *set)
+{
+	struct commit_list *parents;
+
+	for (parents = commit->parents; parents; parents = parents->next) {
+		struct commit *parent = parents->item;
+		struct tree *tree = get_commit_tree(parent);
+
+		if (!tree)
+			continue;
+
+		oidset_insert(set, &tree->object.oid);
+
+		if (!(parent->object.flags & UNINTERESTING))
+			continue;
+		tree->object.flags |= UNINTERESTING;
+
+		if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
+			parent->object.flags |= SHOWN;
+			show_edge(parent);
+		}
+	}
+}
+
+void mark_edges_uninteresting(struct rev_info *revs,
+			      show_edge_fn show_edge,
+			      int sparse)
 {
 	struct commit_list *list;
 	int i;
 
-	for (list = revs->commits; list; list = list->next) {
-		struct commit *commit = list->item;
+	if (sparse) {
+		struct oidset set;
+		oidset_init(&set, 16);
 
-		if (commit->object.flags & UNINTERESTING) {
-			mark_tree_uninteresting(revs->repo,
-						get_commit_tree(commit));
-			if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
-				commit->object.flags |= SHOWN;
-				show_edge(commit);
+		for (list = revs->commits; list; list = list->next) {
+			struct commit *commit = list->item;
+			struct tree *tree = get_commit_tree(commit);
+
+			if (commit->object.flags & UNINTERESTING)
+				tree->object.flags |= UNINTERESTING;
+
+			oidset_insert(&set, &tree->object.oid);
+			add_edge_parents(commit, revs, show_edge, &set);
+		}
+
+		mark_trees_uninteresting_sparse(revs->repo, &set);
+		oidset_clear(&set);
+	} else {
+		for (list = revs->commits; list; list = list->next) {
+			struct commit *commit = list->item;
+			if (commit->object.flags & UNINTERESTING) {
+				mark_tree_uninteresting(revs->repo,
+							get_commit_tree(commit));
+				if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
+					commit->object.flags |= SHOWN;
+					show_edge(commit);
+				}
+				continue;
 			}
-			continue;
+			mark_edge_parents_uninteresting(commit, revs, show_edge);
 		}
-		mark_edge_parents_uninteresting(commit, revs, show_edge);
 	}
+
 	if (revs->edge_hint_aggressive) {
 		for (i = 0; i < revs->cmdline.nr; i++) {
 			struct object *obj = revs->cmdline.rev[i].item;
diff --git a/list-objects.h b/list-objects.h
index ad40762926..a952680e46 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -10,7 +10,9 @@ typedef void (*show_object_fn)(struct object *, const char *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
 typedef void (*show_edge_fn)(struct commit *);
-void mark_edges_uninteresting(struct rev_info *, show_edge_fn);
+void mark_edges_uninteresting(struct rev_info *revs,
+			      show_edge_fn show_edge,
+			      int sparse);
 
 struct oidset;
 struct list_objects_filter_options;
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
new file mode 100755
index 0000000000..30aef6498a
--- /dev/null
+++ b/t/t5322-pack-objects-sparse.sh
@@ -0,0 +1,113 @@
+#!/bin/sh
+
+test_description='pack-objects object selection using sparse algorithm'
+. ./test-lib.sh
+
+test_expect_success 'setup repo' '
+	test_commit initial &&
+	for i in $(test_seq 1 3)
+	do
+		mkdir f$i &&
+		for j in $(test_seq 1 3)
+		do
+			mkdir f$i/f$j &&
+			echo $j >f$i/f$j/data.txt
+		done
+	done &&
+	git add . &&
+	git commit -m "Initialized trees" &&
+	for i in $(test_seq 1 3)
+	do
+		git checkout -b topic$i master &&
+		echo change-$i >f$i/f$i/data.txt &&
+		git commit -a -m "Changed f$i/f$i/data.txt"
+	done &&
+	cat >packinput.txt <<-EOF &&
+	topic1
+	^topic2
+	^topic3
+	EOF
+	git rev-parse			\
+		topic1			\
+		topic1^{tree}		\
+		topic1:f1		\
+		topic1:f1/f1		\
+		topic1:f1/f1/data.txt | sort >expect_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp expect_objects.txt nonsparse_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
+test_expect_success 'duplicate a folder from f3 and commit to topic1' '
+	git checkout topic1 &&
+	echo change-3 >f3/f3/data.txt &&
+	git commit -a -m "Changed f3/f3/data.txt" &&
+	git rev-parse			\
+		topic1~1		\
+		topic1~1^{tree}		\
+		topic1^{tree}		\
+		topic1			\
+		topic1:f1		\
+		topic1:f1/f1		\
+		topic1:f1/f1/data.txt | sort >required_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	comm -1 -2 required_objects.txt nonsparse_objects.txt >nonsparse_required_objects.txt &&
+	test_cmp required_objects.txt nonsparse_required_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	comm -1 -2 required_objects.txt sparse_objects.txt >sparse_required_objects.txt &&
+	test_cmp required_objects.txt sparse_required_objects.txt
+'
+
+test_expect_success 'duplicate a folder from f1 into f3' '
+	mkdir f3/f4 &&
+	cp -r f1/f1/* f3/f4 &&
+	git add f3/f4 &&
+	git commit -m "Copied f1/f1 to f3/f4" &&
+	cat >packinput.txt <<-EOF &&
+	topic1
+	^topic1~1
+	EOF
+	git rev-parse		\
+		topic1		\
+		topic1^{tree}   \
+		topic1:f3 | sort >required_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	comm -1 -2 required_objects.txt nonsparse_objects.txt >nonsparse_required_objects.txt &&
+	test_cmp required_objects.txt nonsparse_required_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	comm -1 -2 required_objects.txt sparse_objects.txt >sparse_required_objects.txt &&
+	test_cmp required_objects.txt sparse_required_objects.txt
+'
+
+test_done
-- 
gitgitgadget

