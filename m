Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB941F404
	for <e@80x24.org>; Wed, 12 Sep 2018 14:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeILT1m (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 15:27:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44353 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeILT1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 15:27:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so1084715pff.11
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PXSUqSUfQSxZ4JoO/cdGLGGPc2MpwLr7WIyVRcOdESQ=;
        b=lY8peGWpqwkbiFoAayCRe40t/03v8PqfXmLcJ5I2DoLOo6S39NAqIDdSBUifbvPIDs
         em7D34LPEoH7RtnUMmBRWrqbl6DgOMqNLghktaJNnXrROk8PZg5i0xSLz3o+zjoWTEjZ
         Cq5WwtFQm0fZrnA6dCDfC1CQlJgIhAkZ5Xgex7svVKaeWyUW3mSNBSi9HpW6p87qIehY
         3WEN0qR+83hhlqo1E3/3bIoUJ7oNqwWFFH4g+cJrtwJtsEDWULSiYVSHq/L0O7AqdAcN
         Rw/qL8vNy5I3hYHwZl4BMopM5EQYR7GNBsmBhyYqQCUKlSSCQe9wS0GCadxpzp9l9eMt
         XqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PXSUqSUfQSxZ4JoO/cdGLGGPc2MpwLr7WIyVRcOdESQ=;
        b=R9dm9/qXEpDrmUh72wzgMa59ygyRxKzUF7yPee8Jpr0E0x1QmbpdO1ObbyXLlA8aql
         qE0UFLIQG7X0ybY3u0OisSN38wznc33WYoVG3hZAxyn6UqIcrTgwqn6fJwjsthSCUQWR
         mZ+LC5FrL/7ViDNnFsSUZnTGm5ci24mcokoGubXee0ecgFuTYIJXyY9dzzD6VNqYv6GS
         JtoahtyRCzcJkmHIoFrbWoQUYwTbntEn4e0OIE75L1sI6edsaZAiNs/CzCcqTTK4axxb
         DcPEXkq6SPaXIvA89ApFc9473pd9TNzIDlTH38WrD7kim9XwpOuJhrDGzBR4H+Y4iVkt
         +7kw==
X-Gm-Message-State: APzg51DCcqn7Vk7VdX19fHXTEniA/62wri5DtrfPXV9Bs0Koqeryt/im
        QtnoEOU49RC3gbMKAiO67i1uWpN0
X-Google-Smtp-Source: ANB0VdZQYXN+haK2MKYxgizKVcyAJKI0KI9E8OeI9z4kuwV+WYKv9QFsfsJNPwWR9m/PB6HwcHzPbQ==
X-Received: by 2002:a62:c60e:: with SMTP id m14-v6mr2713807pfg.40.1536762177111;
        Wed, 12 Sep 2018 07:22:57 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 83-v6sm3163506pft.40.2018.09.12.07.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:22:56 -0700 (PDT)
Date:   Wed, 12 Sep 2018 07:22:56 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Sep 2018 14:22:52 GMT
Message-Id: <948e222228d2f2868b85a425142382e63a17773a.1536762173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.39.git.gitgitgadget@gmail.com>
References: <pull.39.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] commit-reach: properly peel tags
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

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c        | 25 ++++++++++++++++++-------
 t/helper/test-reach.c | 22 +++++++++++++++++-----
 t/t6600-test-reach.sh | 30 ++++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 86715c103c..6de72c6e03 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -544,20 +544,31 @@ int can_all_from_reach_with_flag(struct object_array *from,
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
+		from_one = deref_tag(the_repository, from_one,
+				     "a from object", 0);
+		if (!from_one || from_one->type != OBJ_COMMIT) {
+			from->objects[i].item->flags |= assign_flag;
+			continue;
+		}
+
+		list[nr_commits] = (struct commit *)from_one;
+		if (parse_commit(list[nr_commits]) ||
+		    list[nr_commits]->generation < min_generation)
+			return 0; /* is this a leak? */
+		nr_commits++;
 	}
 
-	QSORT(list, from->nr, compare_commits_by_gen);
+	QSORT(list, nr_commits, compare_commits_by_gen);
 
-	for (i = 0; i < from->nr; i++) {
+	for (i = 0; i < nr_commits; i++) {
 		/* DFS from list[i] */
 		struct commit_list *stack = NULL;
 
@@ -600,7 +611,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 	}
 
 cleanup:
-	for (i = 0; i < from->nr; i++) {
+	for (i = 0; i < nr_commits; i++) {
 		clear_commit_marks(list[i], RESULT);
 		clear_commit_marks(list[i], assign_flag);
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
index d139a00d1d..f7bf82290b 100755
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
