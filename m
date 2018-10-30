Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5FE1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 14:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeJ3XJr (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 19:09:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36412 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbeJ3XJq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 19:09:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id j22-v6so2100170pfh.3
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZlRMzZ/RBQe6Pt54TTspNLG+YC8+I5sKPb3cl3F6FeM=;
        b=F1G2Ms8N+3aLGHF/pzn+E70wRAcr7RXdyPEzfkzeUSZ+FXB403ku9nteQLXkGBmVzV
         1uBB7uY1ozFzz0J6x/R00F99M23kodjSykMLaScOp/GIF9q87Gp+Qnd17LZsErovN6/S
         Ri+gZhTvyPTmK7/v9Vpj1CTWg7bCxIIUzZWJKl5PlOmlPlUYQewBJjyno8z/u3ZEI/je
         v5yhIyZ1TfTG9Bymu44IKf9aB+smJGv1tlaEU76T46BCB7rPpzsNKmx4U3QM6OMg2oAH
         9tdWndxQm6Ze764FX79vHFYK8aiOMgNS5v94glEpN0/3zBFyozD/ITrp3gnSJhdajc0k
         W7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZlRMzZ/RBQe6Pt54TTspNLG+YC8+I5sKPb3cl3F6FeM=;
        b=TxdU7lZZqfZgeXK9AtSowo53WgNlRqegkMbEIIoHlToMMY0HNaHNOQKYdIaijbTk/n
         0BVvE2MDrLUfaFiNTUblOBzpg4rCcwUKADHroQSlQeZ9FTKyLkUVuD7fnxZNH8x2yvii
         cbkK3nnmEhcmt5oOLGSb5YaFjxMU7UzVC48VG3774F6drTkxoxlHrmhvtUT51CV2inKp
         ei4fKyzHEB2bkVYIojJAOjn5IS7f/K+Iz5fHyVbl7V0bp3wLX9VNw9CaqGpSERGrRmZX
         jB+G6K/dUg+nWpRDLHVcdW60JpCVHUpEFQ7XYuE7vCweQQaK+bgwLQEqAgfeJIU1AMT8
         F5XQ==
X-Gm-Message-State: AGRZ1gI65fs95Wc9SrqH+rQCH2FO4S5E36s8d3fgRtikFTvAP1r2ASW7
        KpkDs++bokZ3S5uWTqnyq4D9aHL9
X-Google-Smtp-Source: AJdET5fw+Df7QkMaXjMjjIyGqXPoEQzp/BOTUu3m827zTSr3kpMeEyEb/MlXGYr7Yw9GzOfMxlydLg==
X-Received: by 2002:a63:d34f:: with SMTP id u15-v6mr18293133pgi.325.1540908966615;
        Tue, 30 Oct 2018 07:16:06 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id l26-v6sm43378210pfg.161.2018.10.30.07.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 07:16:05 -0700 (PDT)
Date:   Tue, 30 Oct 2018 07:16:05 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 14:15:59 GMT
Message-Id: <382f4f4a5b4671307530a34a60f9cc18c3b06443.1540908961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.60.git.gitgitgadget@gmail.com>
References: <pull.60.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] test-reach: test get_reachable_subset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, newren@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The get_reachable_subset() method returns the list of commits in
the 'to' array that are reachable from at least one commit in the
'from' array. Add tests that check this method works in a few
cases:

1. All commits in the 'to' list are reachable. This exercises the
   early-termination condition.

2. Some commits in the 'to' list are reachable. This exercises the
   loop-termination condition.

3. No commits in the 'to' list are reachable. This exercises the
   NULL return condition.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-reach.c | 34 ++++++++++++++++++++++++----
 t/t6600-test-reach.sh | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 08d2ea68e..a0272178b 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -32,8 +32,8 @@ int cmd__reach(int ac, const char **av)
 	struct commit *A, *B;
 	struct commit_list *X, *Y;
 	struct object_array X_obj = OBJECT_ARRAY_INIT;
-	struct commit **X_array;
-	int X_nr, X_alloc;
+	struct commit **X_array, **Y_array;
+	int X_nr, X_alloc, Y_nr, Y_alloc;
 	struct strbuf buf = STRBUF_INIT;
 	struct repository *r = the_repository;
 
@@ -44,9 +44,10 @@ int cmd__reach(int ac, const char **av)
 
 	A = B = NULL;
 	X = Y = NULL;
-	X_nr = 0;
-	X_alloc = 16;
+	X_nr = Y_nr = 0;
+	X_alloc = Y_alloc = 16;
 	ALLOC_ARRAY(X_array, X_alloc);
+	ALLOC_ARRAY(Y_array, Y_alloc);
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
 		struct object_id oid;
@@ -92,6 +93,8 @@ int cmd__reach(int ac, const char **av)
 
 			case 'Y':
 				commit_list_insert(c, &Y);
+				ALLOC_GROW(Y_array, Y_nr + 1, Y_alloc);
+				Y_array[Y_nr++] = c;
 				break;
 
 			default:
@@ -136,6 +139,29 @@ int cmd__reach(int ac, const char **av)
 			filter.with_commit_tag_algo = 0;
 
 		printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter, A, X, &cache));
+	} else if (!strcmp(av[1], "get_reachable_subset")) {
+		const int reachable_flag = 1;
+		int i, count = 0;
+		struct commit_list *current;
+		struct commit_list *list = get_reachable_subset(X_array, X_nr,
+								Y_array, Y_nr,
+								reachable_flag);
+		printf("get_reachable_subset(X,Y)\n");
+		for (current = list; current; current = current->next) {
+			if (!(list->item->object.flags & reachable_flag))
+				die(_("commit %s is not marked reachable"),
+				    oid_to_hex(&list->item->object.oid));
+			count++;
+		}
+		for (i = 0; i < Y_nr; i++) {
+			if (Y_array[i]->object.flags & reachable_flag)
+				count--;
+		}
+
+		if (count < 0)
+			die(_("too many commits marked reachable"));
+
+		print_sorted_commit_ids(list);
 	}
 
 	exit(0);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index ae94b27f7..a0c64e617 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -265,4 +265,56 @@ test_expect_success 'commit_contains:miss' '
 	test_three_modes commit_contains --tag
 '
 
+test_expect_success 'get_reachable_subset:all' '
+	cat >input <<-\EOF &&
+	X:commit-9-1
+	X:commit-8-3
+	X:commit-7-5
+	X:commit-6-6
+	X:commit-1-7
+	Y:commit-3-3
+	Y:commit-1-7
+	Y:commit-5-6
+	EOF
+	(
+		echo "get_reachable_subset(X,Y)" &&
+		git rev-parse commit-3-3 \
+			      commit-1-7 \
+			      commit-5-6 | sort
+	) >expect &&
+	test_three_modes get_reachable_subset
+'
+
+test_expect_success 'get_reachable_subset:some' '
+	cat >input <<-\EOF &&
+	X:commit-9-1
+	X:commit-8-3
+	X:commit-7-5
+	X:commit-1-7
+	Y:commit-3-3
+	Y:commit-1-7
+	Y:commit-5-6
+	EOF
+	(
+		echo "get_reachable_subset(X,Y)" &&
+		git rev-parse commit-3-3 \
+			      commit-1-7 | sort
+	) >expect &&
+	test_three_modes get_reachable_subset
+'
+
+test_expect_success 'get_reachable_subset:none' '
+	cat >input <<-\EOF &&
+	X:commit-9-1
+	X:commit-8-3
+	X:commit-7-5
+	X:commit-1-7
+	Y:commit-9-3
+	Y:commit-7-6
+	Y:commit-2-8
+	EOF
+	echo "get_reachable_subset(X,Y)" >expect &&
+	test_three_modes get_reachable_subset
+'
+
 test_done
-- 
gitgitgadget

