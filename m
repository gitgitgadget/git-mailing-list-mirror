Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEDB1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfJUN4l (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39696 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbfJUN4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id c6so1903183wrm.6
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ips6wWu7Xdah4SBzOLvtoLKr422mshCSp/ecYyPpC+c=;
        b=lil45SBwGHR/6ZNLZ/boqj11zNyVrEDbzwwghZdE/QqNxNttON0Y3bEx71vymtfCFw
         jYOFqz73WrLXyFBWRQQCLoH2SKH5eG4NBgZeBCKVgc2H5+JNEoVMNxGjD1XzQWXinuV3
         7TvDQVdcfSoZGJEP0jL1qT8+rDjGjkvfcwrnlGuBcnJnJhiBFsDl02430xYYov38qUEk
         Tv+bUNDA+/2GS/xt/YnyASmCDGWlvG4jbPfxKiLCpbsN4bxaROuiD8NkOKpiyDxJmIsU
         sTnEV/tTH9yxD0qgVU4DR1hPvnsj/ngpXTebQFIg6cQDQYX0IgOQUw0P5Z98c30Lg43i
         sVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ips6wWu7Xdah4SBzOLvtoLKr422mshCSp/ecYyPpC+c=;
        b=M4XASQAoYvWqYryJK3bSO7fAjXWgwmpzCGk6bvj/rRWx4kspxR6u1/5PGhefaQsO5S
         ggI7bqOasXFcu8soK1jTsTVUHMm4adCNLWz9B8908jpjJPfwN4HxvG+yHWOsK3Wv4UOe
         z8oTtJ8td9/Jrr1/LGJlDnCVjoXg0dTQCKefzvn0GrO7Qmv0fdqDwgUmOdKGahzV7rIO
         lL/3V+uaX8xc44P5bC9LGKUK6L0d9GDNv4fjBm5RfbRu9K5+JAj/t/fEcURTMwJdoyve
         IlQ3djWglbGA4dT3FlxQm5mZkO5L5vwH0s+PUjJGDublobbcF8bCjNSsCSdJtn77akBl
         wUyQ==
X-Gm-Message-State: APjAAAUgTInpxMVLKFM5Fa3pUkn/AhOrZZB2eorvrtReVixFCgGOE7R2
        OhJxE5M9FNUT3nPklRQHKeCOYLVu
X-Google-Smtp-Source: APXvYqy+0rBLL53CDkKyK8hLq57+etr9Uzgu6UgDSexPCI9PkOL6dauIs3n4hGjdYEy3b1upP9jtJw==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr19259704wrt.36.1571666197456;
        Mon, 21 Oct 2019 06:56:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w22sm1449966wmi.7.2019.10.21.06.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:37 -0700 (PDT)
Message-Id: <7b5c5bad2d58041f634690e2e5581feaa4d0fd02.1571666187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:20 +0000
Subject: [PATCH v5 11/17] unpack-trees: hash less in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
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
index 35c1ca9e24..2ef92a50a0 100644
--- a/dir.c
+++ b/dir.c
@@ -1270,7 +1270,7 @@ enum pattern_match_result path_matches_pattern_list(
 
 	if (hashmap_contains_path(&pl->recursive_hashmap,
 				  &parent_pathname)) {
-		result = MATCHED;
+		result = MATCHED_RECURSIVE;
 		goto done;
 	}
 
@@ -1292,7 +1292,7 @@ enum pattern_match_result path_matches_pattern_list(
 	if (hashmap_contains_parent(&pl->recursive_hashmap,
 				    pathname,
 				    &parent_pathname))
-		result = MATCHED;
+		result = MATCHED_RECURSIVE;
 
 done:
 	strbuf_release(&parent_pathname);
diff --git a/dir.h b/dir.h
index 8e232085cd..77a43dbf89 100644
--- a/dir.h
+++ b/dir.h
@@ -264,6 +264,7 @@ enum pattern_match_result {
 	UNDECIDED = -1,
 	NOT_MATCHED = 0,
 	MATCHED = 1,
+	MATCHED_RECURSIVE = 2,
 };
 
 /*
diff --git a/unpack-trees.c b/unpack-trees.c
index a90d71845d..c0dca20865 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1283,15 +1283,17 @@ static int clear_ce_flags_dir(struct index_state *istate,
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
@@ -1299,17 +1301,23 @@ static int clear_ce_flags_dir(struct index_state *istate,
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

