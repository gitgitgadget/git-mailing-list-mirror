Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227651F453
	for <e@80x24.org>; Mon, 24 Sep 2018 20:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeIYDB6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:01:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36346 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeIYDB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:01:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id b7-v6so2210660pfo.3
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 13:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZLjBOcmepafBQmYC/m9k6eWAaJP6PnrT92ZFP06gVAY=;
        b=vD1w36DD1/76g0zBAYI6MOK4cMtqF6PozALtW08wGYNPjTmjNS8N/7nUHlWzmFdAUe
         yivuj5Xrzg2NjQVquCrYr+G556w5HhqkiDjvU343Akym0NW3b5Tkjq9qUPllg56WoYPp
         VGNM8/dHp7uSutHHOEcvXpX+lFLv1/0J/A/ENdbEmVcEjv1gbZp8J3g8j/a6MbuOw9Hi
         1ht1wi7Ods3EK/K91nuhc9vKP9IZooFzNCEe5BjE1mFGWtFr8+nETjI2LJZ3Icg0OYG0
         fNBXr2C/uj1UpNitwLehP2MGb8ksk11L9fFIV7xbvSZ2Hi99PFK+JyI8uujcJwijijCE
         fqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZLjBOcmepafBQmYC/m9k6eWAaJP6PnrT92ZFP06gVAY=;
        b=EmVEWD94+xGzIl0EWHPL8gzcAw1db0ljfbGSrRSFgrkLxX3Q1HoRZukxSoa7NoLR+K
         Dnh6nfCYwl5JXxwibWwP6PHzAspAQ1ItgDVEixrJ2jrctVnV63rrgt7uHV91Se6ThwUG
         e/LObnMJlc2U3z99J9FtUUDgEorv3hIcEF6gYWQoWuLxfcPpupJhwovst9WCUu9IIJ9n
         CP4KrWXR/eOUaj6kR+Os8KwQrNzcoJfxsu0R/Y9MPOvn6eWQsw3pZhiB4XEKXSLzhds/
         N1UjJ9z7d/cixShgG/LeHIQdftaKUj34i4xWKFFmhxRTHH3H1GNNxwdVwVbX3DQzaxT3
         ex6Q==
X-Gm-Message-State: ABuFfohd7wwW2ybVG3yQq2S2DdoxzbNQ3JfnMR7nZIgbtOGiCU0wBsIG
        LZYwO7DpmZ322Qu/i1R0UcAi4b88
X-Google-Smtp-Source: ACcGV63qynTwbAoYNNXNeM62wlDHOSgCCSsm04OTjmubpQPqjBAyMULedeTq+mmLnjUb2+iedF3aVQ==
X-Received: by 2002:a63:5ec5:: with SMTP id s188-v6mr463798pgb.126.1537822673184;
        Mon, 24 Sep 2018 13:57:53 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id z20-v6sm281872pfd.99.2018.09.24.13.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:57:52 -0700 (PDT)
Date:   Mon, 24 Sep 2018 13:57:52 -0700 (PDT)
X-Google-Original-Date: Mon, 24 Sep 2018 20:57:48 GMT
Message-Id: <a0a3cf01343381281554d0e175b2f4ec5fbe0abb.1537822669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.39.v4.git.gitgitgadget@gmail.com>
References: <pull.39.v3.git.gitgitgadget@gmail.com>
        <pull.39.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 1/1] commit-reach: properly peel tags and clear flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The can_all_from_reach_with_flag() algorithm was refactored in 4fbcca4e
"commit-reach: make can_all_from_reach... linear" but incorrectly
assumed that all objects provided were commits. During a fetch
negotiation, ok_to_give_up() in upload-pack.c may provide unpeeled tags
to the 'from' array. The current code creates a segfault.

Add a direct call to can_all_from_reach_with_flag() in 'test-tool reach'
and add a test in t6600-test-reach.sh that demonstrates this segfault.

Correct the issue by peeling tags when investigating the initial list
of objects in the 'from' array.

The can_all_from_reach_with_flag() method uses 'assign_flag' as a
value we can use to mark objects temporarily during our commit walk.
The intent is that these flags are removed from all objects before
returning. However, this is not the case.

The 'from' array could also contain objects that are not commits, and
we mark those objects with 'assign_flag'. Add a loop to the 'cleanup'
section that removes these markers.

Also, we forgot to free() the memory for 'list', so add that to the
'cleanup' section. Also, use a cleaner mechanism for clearing those
flags.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c        | 44 +++++++++++++++++++++++++++++++++----------
 t/helper/test-reach.c | 22 +++++++++++++++++-----
 t/t6600-test-reach.sh | 30 +++++++++++++++++++++++++++--
 3 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 86715c103c..db84f85986 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -544,20 +544,42 @@ int can_all_from_reach_with_flag(struct object_array *from,
 {
 	struct commit **list = NULL;
 	int i;
+	int nr_commits;
 	int result = 1;
 
 	ALLOC_ARRAY(list, from->nr);
+	nr_commits = 0;
 	for (i = 0; i < from->nr; i++) {
-		list[i] = (struct commit *)from->objects[i].item;
+		struct object *from_one = from->objects[i].item;
 
-		if (parse_commit(list[i]) ||
-		    list[i]->generation < min_generation)
-			return 0;
+		if (!from_one || from_one->flags & assign_flag)
+			continue;
+
+		from_one = deref_tag(the_repository, from_one,
+				     "a from object", 0);
+		if (!from_one || from_one->type != OBJ_COMMIT) {
+			/* no way to tell if this is reachable by
+			 * looking at the ancestry chain alone, so
+			 * leave a note to ourselves not to worry about
+			 * this object anymore.
+			 */
+			from->objects[i].item->flags |= assign_flag;
+			continue;
+		}
+
+		list[nr_commits] = (struct commit *)from_one;
+		if (parse_commit(list[nr_commits]) ||
+		    list[nr_commits]->generation < min_generation) {
+			result = 0;
+			goto cleanup;
+		}
+
+		nr_commits++;
 	}
 
-	QSORT(list, from->nr, compare_commits_by_gen);
+	QSORT(list, nr_commits, compare_commits_by_gen);
 
-	for (i = 0; i < from->nr; i++) {
+	for (i = 0; i < nr_commits; i++) {
 		/* DFS from list[i] */
 		struct commit_list *stack = NULL;
 
@@ -600,10 +622,12 @@ int can_all_from_reach_with_flag(struct object_array *from,
 	}
 
 cleanup:
-	for (i = 0; i < from->nr; i++) {
-		clear_commit_marks(list[i], RESULT);
-		clear_commit_marks(list[i], assign_flag);
-	}
+	clear_commit_marks_many(nr_commits, list, RESULT | assign_flag);
+	free(list);
+
+	for (i = 0; i < from->nr; i++)
+		from->objects[i].item->flags &= ~assign_flag;
+
 	return result;
 }
 
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index eb21103998..08d2ea68e8 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -31,6 +31,7 @@ int cmd__reach(int ac, const char **av)
 	struct object_id oid_A, oid_B;
 	struct commit *A, *B;
 	struct commit_list *X, *Y;
+	struct object_array X_obj = OBJECT_ARRAY_INIT;
 	struct commit **X_array;
 	int X_nr, X_alloc;
 	struct strbuf buf = STRBUF_INIT;
@@ -49,7 +50,8 @@ int cmd__reach(int ac, const char **av)
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
 		struct object_id oid;
-		struct object *o;
+		struct object *orig;
+		struct object *peeled;
 		struct commit *c;
 		if (buf.len < 3)
 			continue;
@@ -57,14 +59,14 @@ int cmd__reach(int ac, const char **av)
 		if (get_oid_committish(buf.buf + 2, &oid))
 			die("failed to resolve %s", buf.buf + 2);
 
-		o = parse_object(r, &oid);
-		o = deref_tag_noverify(o);
+		orig = parse_object(r, &oid);
+		peeled = deref_tag_noverify(orig);
 
-		if (!o)
+		if (!peeled)
 			die("failed to load commit for input %s resulting in oid %s\n",
 			    buf.buf, oid_to_hex(&oid));
 
-		c = object_as_type(r, o, OBJ_COMMIT, 0);
+		c = object_as_type(r, peeled, OBJ_COMMIT, 0);
 
 		if (!c)
 			die("failed to load commit for input %s resulting in oid %s\n",
@@ -85,6 +87,7 @@ int cmd__reach(int ac, const char **av)
 				commit_list_insert(c, &X);
 				ALLOC_GROW(X_array, X_nr + 1, X_alloc);
 				X_array[X_nr++] = c;
+				add_object_array(orig, NULL, &X_obj);
 				break;
 
 			case 'Y':
@@ -113,6 +116,15 @@ int cmd__reach(int ac, const char **av)
 		print_sorted_commit_ids(list);
 	} else if (!strcmp(av[1], "can_all_from_reach")) {
 		printf("%s(X,Y):%d\n", av[1], can_all_from_reach(X, Y, 1));
+	} else if (!strcmp(av[1], "can_all_from_reach_with_flag")) {
+		struct commit_list *iter = Y;
+
+		while (iter) {
+			iter->item->object.flags |= 2;
+			iter = iter->next;
+		}
+
+		printf("%s(X,_,_,0,0):%d\n", av[1], can_all_from_reach_with_flag(&X_obj, 2, 4, 0, 0));
 	} else if (!strcmp(av[1], "commit_contains")) {
 		struct ref_filter filter;
 		struct contains_cache cache;
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index d139a00d1d..ae94b27f70 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -31,7 +31,8 @@ test_expect_success 'setup' '
 	for i in $(test_seq 1 10)
 	do
 		test_commit "1-$i" &&
-		git branch -f commit-1-$i
+		git branch -f commit-1-$i &&
+		git tag -a -m "1-$i" tag-1-$i commit-1-$i
 	done &&
 	for j in $(test_seq 1 9)
 	do
@@ -39,11 +40,13 @@ test_expect_success 'setup' '
 		x=$(($j + 1)) &&
 		test_commit "$x-1" &&
 		git branch -f commit-$x-1 &&
+		git tag -a -m "$x-1" tag-$x-1 commit-$x-1 &&
 
 		for i in $(test_seq 2 10)
 		do
 			git merge commit-$j-$i -m "$x-$i" &&
-			git branch -f commit-$x-$i
+			git branch -f commit-$x-$i &&
+			git tag -a -m "$x-$i" tag-$x-$i commit-$x-$i
 		done
 	done &&
 	git commit-graph write --reachable &&
@@ -205,6 +208,29 @@ test_expect_success 'can_all_from_reach:miss' '
 	test_three_modes can_all_from_reach
 '
 
+test_expect_success 'can_all_from_reach_with_flag: tags case' '
+	cat >input <<-\EOF &&
+	X:tag-2-10
+	X:tag-3-9
+	X:tag-4-8
+	X:commit-5-7
+	X:commit-6-6
+	X:commit-7-5
+	X:commit-8-4
+	X:commit-9-3
+	Y:tag-1-9
+	Y:tag-2-8
+	Y:tag-3-7
+	Y:commit-4-6
+	Y:commit-5-5
+	Y:commit-6-4
+	Y:commit-7-3
+	Y:commit-8-1
+	EOF
+	echo "can_all_from_reach_with_flag(X,_,_,0,0):1" >expect &&
+	test_three_modes can_all_from_reach_with_flag
+'
+
 test_expect_success 'commit_contains:hit' '
 	cat >input <<-\EOF &&
 	A:commit-7-7
-- 
gitgitgadget
