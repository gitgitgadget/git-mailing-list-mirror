Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C031A1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 13:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeKBWV5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 18:21:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39736 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeKBWV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 18:21:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so984195pgv.6
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GPhYaq+heCDb7TbygE+8+SqfEFWI0gLbUbkBgEqQOpY=;
        b=HvM9OKlqZFX5kk3sKi3EhAecCnY/Tali4YW/jw7p9GWloV41hHdE8L1sonLvA+HvM0
         sd6KlkZtpChkmhD4RNR7+febi2n1//Osw4j4kbsAaczf1Qcw8XcahJzbg/qLJS8ryqbb
         sUYACxTMoIT+uL2Kf7RsBpGDVYZyNoscjoL4bf++LdCv0sKxNDWFtudnr4AiOgzi3bo9
         k8fOVBpBWbeSmhKYrZqmX/MxINPrRPHSWpktujNYWzn36GPky5Z1kB66I0aQ77Vi4etp
         Olwk53zEBxX39DYJMsHpubPeqdKoPaxyvOXXAKX71e3ouL04Ut1iGD6isarqDK0MgiBi
         F5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GPhYaq+heCDb7TbygE+8+SqfEFWI0gLbUbkBgEqQOpY=;
        b=gRof8BOrg4T+BoDPm7Pv5N+aRwSs1yDZUgDydbaeLmMZaG/f7VglRyFFWOBt7chZC5
         LfGmWVJGW8y1td1keJdnhPPTnkytToylNsYGKwoHRIbIeBn0iESoBt3YKGk0HiAbKDz1
         p6/yVlhvlAnqkHOokwkSmMk0/jNECkZGXdSVM23xNo/GMylmWpgPjHDQPkDi3bhnDFpi
         AD7pI9ePNxcq7bZhmGW/M3T/UCWPVYfa2UZrzuJuQVC2OiPRs9W4gSFX0kEmzONsi6Zm
         cGIQmCmo/2fy46H/6Ihwf3OlyhL+KQ49KwAEt6VlMLQyLmmaFcF/Z0lGcnmWIa07BLb9
         29yQ==
X-Gm-Message-State: AGRZ1gIX1RUfKJJt2joc3Ojmjy/j66XzByzngp7hsKlyxl5UiNBmG8lt
        p03LiMnvq7BTSVpHv92byvJn1jQ5
X-Google-Smtp-Source: AJdET5fT6zxkj22OwzYP2hpS86r2DdmaHXUzgjFJi2BWzsavRWyLh5kpTfpVI5mqfaRJhSufa4x8qw==
X-Received: by 2002:a62:9c8c:: with SMTP id u12-v6mr11692642pfk.162.1541164488030;
        Fri, 02 Nov 2018 06:14:48 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id s13-v6sm85674606pgs.76.2018.11.02.06.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 06:14:47 -0700 (PDT)
Date:   Fri, 02 Nov 2018 06:14:47 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Nov 2018 13:14:41 GMT
Message-Id: <52e847b9288439f25a7e06abfe0c68bc1e6dc915.1541164482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.60.v2.git.gitgitgadget@gmail.com>
References: <pull.60.git.gitgitgadget@gmail.com>
        <pull.60.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/3] test-reach: test get_reachable_subset
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
index 08d2ea68e8..a0272178b7 100644
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
index ae94b27f70..a0c64e617a 100755
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

