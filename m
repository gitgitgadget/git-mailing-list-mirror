Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725A01F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfJGUIp (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52830 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfJGUIk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so773502wmh.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vSxY2/AV/uKAwbPZvrTS2ddJm3Q7YwRkcLQwX//7Weo=;
        b=t3/RfkFAmAHahV4AFFrcQEDX7pYyMfKB67ThR+glZh5RqDTFDv16B+tjfg7mPj1qPa
         YzWweE7M7Tf/tvzqTIcEdPARzqpATSBeb7yv83kSe2FfjdLQbdUALWqe/NV24M+ckNzO
         5iEUDk9gMJ88mmbpbblT804prs8N2loZ+XZKoMpHmxRawkeapilmz9z6BG7DimirTwlm
         4g8AD6fRwjz7qE93pI6mxjmizwUhFhdgDuguvYoXKpDntpr5nCiAmkKVHDkoHvD5RIW1
         +N/vx3v5V4XfK/DfZq0lyGgYgD/wJPgAHeNrGez+AcVaEu3yl/o87umNJfeicH1zLCck
         pEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vSxY2/AV/uKAwbPZvrTS2ddJm3Q7YwRkcLQwX//7Weo=;
        b=hIZgSRVTU3EVTVZOx6xeFrA7Xe0aLdo1GxCYPeyXQg9O3T2C9l7Mg8Nf7Vmstc9w06
         y+yecZRLyRhPf3+1PWTwQvFEeGiV78VqW/w2nOWyugX9NF2FSRN8zS9ij8/yFaFH1y9n
         mEO6wZKEWktaSoCK1HKl+WpyD70uZH78QDzzrgWfIgrZ3Iall/s9arkcxWrwfukecGc+
         /FUHbA9bONpW1KArUCRgI5I1NQD1TLq2toDDVV5MNEsAJo7ybsxX+jktOXhZNRhD1n+4
         1Ha8CYae8UQur4tPRONNq9Hw98CauUhQdKxsO3zK9OO9CQfpNHD87Eu6DVG6PVd/y5ir
         BfHg==
X-Gm-Message-State: APjAAAVIZT1zMGqin5kuLbP9Ytgg6M9+/5RPYj2zjpWOcvIGSUb5yhgR
        RFF5mYtNp3NOm16dmt4ovadr5zKh
X-Google-Smtp-Source: APXvYqwgnoju0ZDa3KVuqfyzpc2Wc4ydfzjGutfjIPZfXtOLRgObazOR0VZJp0rqcPA7vvCUG3XX8A==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr812020wmk.52.1570478918720;
        Mon, 07 Oct 2019 13:08:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b186sm1086396wmd.16.2019.10.07.13.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:38 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:38 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:19 GMT
Message-Id: <e06349fcec6612c74bed35cc7ca3a039017c2845.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 11/17] unpack-trees: hash less in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Junio C Hamano <gitster@pobox.com>,
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
index 2b240111aa..eb6b2913ef 100644
--- a/dir.c
+++ b/dir.c
@@ -1253,7 +1253,7 @@ enum pattern_match_result path_matches_pattern_list(
 
 	if (hashmap_contains_path(&pl->recursive_hashmap,
 				  &parent_pathname)) {
-		result = MATCHED;
+		result = MATCHED_RECURSIVE;
 		goto done;
 	}
 
@@ -1275,7 +1275,7 @@ enum pattern_match_result path_matches_pattern_list(
 	if (hashmap_contains_parent(&pl->recursive_hashmap,
 				    pathname,
 				    &parent_pathname))
-		result = MATCHED;
+		result = MATCHED_RECURSIVE;
 
 done:
 	strbuf_release(&parent_pathname);
diff --git a/dir.h b/dir.h
index f7a2f000c3..c868129a54 100644
--- a/dir.h
+++ b/dir.h
@@ -262,6 +262,7 @@ enum pattern_match_result {
 	UNDECIDED = -1,
 	NOT_MATCHED = 0,
 	MATCHED = 1,
+	MATCHED_RECURSIVE = 2,
 };
 
 /*
diff --git a/unpack-trees.c b/unpack-trees.c
index 566df11309..b5cf591c38 100644
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

