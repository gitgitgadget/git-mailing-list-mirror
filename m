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
	by dcvr.yhbt.net (Postfix) with ESMTP id CABEF1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbfISOnX (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:43:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54509 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388938AbfISOnV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so4880537wmp.4
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ii8l9QJmOK8nEwZpzJEAoSJ7ZiZsOkJW8Ov4mayBw2M=;
        b=EpN1XAMeyiFCjLmCUFSzsSBNjzUmiw7WZEv1PR4QnOtANgRdyWPsVnFsAMSzWAuKmF
         HB5q+WGx1pvk2g6X/JFwJj94BgGuKdvxKi5AtZYTqMCKn6bhy7Sw6O91/vaxyRfU7wmK
         4tWLWkK/Ehh4bp1H6fCfQxh8GbqafB3bafnnl0+auguWuX+bDfEIdUaM1/A23X8F2pmy
         pH4cSHoXfEvJjFAHPvxMZ4PkmZjIoIeDGRyKHdoNjoXgnvRG+U4NQrWZD+Vb7YbuyDgP
         aQTYlbNONb6DHAlzozLNfUA+1nU0Te2EATeUVnjM9N5LxDGh4RDkAd3r7xMwLwMS0b4K
         cSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ii8l9QJmOK8nEwZpzJEAoSJ7ZiZsOkJW8Ov4mayBw2M=;
        b=W/gV7tx7pwACU7uHt5U8y0kuylFm2/kyMBTreFlr1KF7Ih2zE0pZOr7L8pK+Dvs4MA
         3rK3l7GKgDvlcDt9ZGu5doUsyMPlsse5j5BH6jlcnku7C3dh6QOMoqrjWpIt9Y3R1Wtd
         RcRqUy5AKMEuWxVhv/ve5KUU2lcGLYIZ30zKRE+A9d6F8u9XJe3ATbk4tchznrFsX/M+
         J7/z0ag1I4x9SZ9YZ7TCYEJov6hRp/sYHJmKc64YzxdesJDdeI2j2Y/3IxcaRzJzElzp
         B9qkrJlYTKUZpThYmDS6JGQ8+9I79dzcS6mkd046Y8xXvBg9mhOWBJqtLGwh6ofEnyC2
         RjXA==
X-Gm-Message-State: APjAAAUpjI8B9CemTGpjTfodzMHqmwBylCO/7KDnZLjsqeVMgqYkuFGD
        4Jqon4th9b2Y72atlyvPA56X4cZi
X-Google-Smtp-Source: APXvYqzeKOj0vpVKrdarQifvAHZpJAEwkT6fmZb+vKlisoz5kcY17aBhfiiKyKT2SPuN5q58gRCBMw==
X-Received: by 2002:a1c:f317:: with SMTP id q23mr3074606wmq.33.1568904199013;
        Thu, 19 Sep 2019 07:43:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm13865624wrg.97.2019.09.19.07.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:43:18 -0700 (PDT)
Date:   Thu, 19 Sep 2019 07:43:18 -0700 (PDT)
X-Google-Original-Date: Thu, 19 Sep 2019 14:43:08 GMT
Message-Id: <1d4321488ef4edbd4b19a8e26b329d0b54755bf4.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
        <pull.316.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 11/11] unpack-trees: hash less in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse-checkout feature in "cone mode" can use the fact that
the recursive patterns are "connected" to the root via parent
patterns to decide if a directory is entirely contained in the
sparse-checkout or entirely removed.

In these cases, we can skip hashing the paths within those
directories and simply set the skipworktree bit to the correct
value.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c          |  4 ++--
 dir.h          |  1 +
 unpack-trees.c | 38 +++++++++++++++++++++++---------------
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/dir.c b/dir.c
index 298a4539ec..35fd60d487 100644
--- a/dir.c
+++ b/dir.c
@@ -1215,7 +1215,7 @@ enum pattern_match_result path_matches_pattern_list(
 
 	if (hashmap_contains_path(&pl->recursive_hashmap,
 					&parent_pathname)) {
-		result = MATCHED;
+		result = MATCHED_RECURSIVE;
 		goto done;
 	}
 
@@ -1237,7 +1237,7 @@ enum pattern_match_result path_matches_pattern_list(
 	while (parent_pathname.len) {
 		if (hashmap_contains_path(&pl->recursive_hashmap,
 					  &parent_pathname)) {
-			result = UNDECIDED;
+			result = MATCHED_RECURSIVE;
 			goto done;
 		}
 
diff --git a/dir.h b/dir.h
index 7c76a2d55e..5f410eedbb 100644
--- a/dir.h
+++ b/dir.h
@@ -261,6 +261,7 @@ enum pattern_match_result {
 	UNDECIDED = -1,
 	NOT_MATCHED = 0,
 	MATCHED = 1,
+	MATCHED_RECURSIVE = 2,
 };
 
 /*
diff --git a/unpack-trees.c b/unpack-trees.c
index 26be8f3569..43acc0ffd6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1280,15 +1280,17 @@ static int clear_ce_flags_dir(struct index_state *istate,
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
 	int rc;
-	enum pattern_match_result ret;
-	ret = path_matches_pattern_list(prefix->buf, prefix->len,
-					basename, &dtype, pl, istate);
+	enum pattern_match_result ret, orig_ret;
+	orig_ret = path_matches_pattern_list(prefix->buf, prefix->len,
+					     basename, &dtype, pl, istate);
 
 	strbuf_addch(prefix, '/');
 
 	/* If undecided, use matching result of parent dir in defval */
-	if (ret == UNDECIDED)
+	if (orig_ret == UNDECIDED)
 		ret = default_match;
+	else
+		ret = orig_ret;
 
 	for (cache_end = cache; cache_end != cache + nr; cache_end++) {
 		struct cache_entry *ce = *cache_end;
@@ -1296,17 +1298,23 @@ static int clear_ce_flags_dir(struct index_state *istate,
 			break;
 	}
 
-	/*
-	 * TODO: check pl, if there are no patterns that may conflict
-	 * with ret (iow, we know in advance the incl/excl
-	 * decision for the entire directory), clear flag here without
-	 * calling clear_ce_flags_1(). That function will call
-	 * the expensive path_matches_pattern_list() on every entry.
-	 */
-	rc = clear_ce_flags_1(istate, cache, cache_end - cache,
-			      prefix,
-			      select_mask, clear_mask,
-			      pl, ret);
+	if (pl->use_cone_patterns && orig_ret == MATCHED_RECURSIVE) {
+		struct cache_entry **ce = cache;
+		rc = (cache_end - cache) / sizeof(struct cache_entry *);
+
+		while (ce < cache_end) {
+			(*ce)->ce_flags &= ~clear_mask;
+			ce++;
+		}
+	} else if (pl->use_cone_patterns && orig_ret == NOT_MATCHED) {
+		rc = (cache_end - cache) / sizeof(struct cache_entry *);
+	} else {
+		rc = clear_ce_flags_1(istate, cache, cache_end - cache,
+				      prefix,
+				      select_mask, clear_mask,
+				      pl, ret);
+	}
+
 	strbuf_setlen(prefix, prefix->len - 1);
 	return rc;
 }
-- 
gitgitgadget
