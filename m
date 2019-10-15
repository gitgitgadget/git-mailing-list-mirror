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
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF5E1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfJON4X (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39501 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbfJON4S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so24016065wrj.6
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ips6wWu7Xdah4SBzOLvtoLKr422mshCSp/ecYyPpC+c=;
        b=WSjx8MSbr6ps16PET3/SfRZ5Ijsb5l8/eu+3IKTMAHM0kZL+d6O7V9X6U7t3fH328Q
         m2aNbZWQPPaQJhpbL2k0ebiCNfhSEgvphz+/51c1kYoyVtgD1ca7iL1bSXKWd1lHQrX8
         0yHaBJ+353rEajkdUpQWAzXs5jglAlMM5k61g5ck2Q1P04gUxhKu6ShmAiGtizz/LeQ6
         mg1vkHIetNGNvZ9PSop7BSa2EecZqfobhuZw4BhAJIKHdp0EuMRCQ63DGtY9WH73Kwee
         x/MPSio4CdcjQnLCeWrY43pKCMNGQZSFLZvO+ussmqDEG3NuobxvdWtoayLwV5rJDfzs
         zd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ips6wWu7Xdah4SBzOLvtoLKr422mshCSp/ecYyPpC+c=;
        b=IyutqXeeVS7EuAiBdyC+mZC4Ui0E+DEuJ1HLCkaKjHekNqfI3mPtu99jODwtWHEmHa
         vkyzB1w/V2vOYfLuE8YZcYqciyr1vpusNdbL7Zmo823kInTXrcKM9oXLuUZ5iPGw0Wc9
         0InYnO3QNr8vFgzmoNDm/IllWVid6ypAaLObqd/Bi40/K9tUiImR1UeuL5LjN3bhSv9c
         nO3/KHNkvKzAHnrfhzI7xsT1k0bNA1qCpAm4CbDtRArxBkFbDNmdQBgOlBL0w932hFK2
         fyf3w0LHKhc1mbYS0uPAD8iYbKBCLMu8hV/qzwkRsD0K/7VQrhsRN+GFBCY+Ubzbj4ky
         BcTg==
X-Gm-Message-State: APjAAAWxR29TtplHLaHY6+LydbkVKbr2oyWFk6F/HyAvopzDJAnE0qYW
        /Pn8xuQbZ3uvo9NZefDpGWj2PPYi
X-Google-Smtp-Source: APXvYqx0H8UBeFTPF6gNf7ObAwroTAnVgIgO6VKDlu+yMswnJ5qL8BeWuTFR84p6UjHtwX3rO3CeyA==
X-Received: by 2002:a5d:5092:: with SMTP id a18mr28624411wrt.376.1571147776715;
        Tue, 15 Oct 2019 06:56:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9sm23669049wrp.26.2019.10.15.06.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:16 -0700 (PDT)
Message-Id: <fefd1e17447dae54d98db6412ed3484be6a2292e.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:55:58 +0000
Subject: [PATCH v4 11/17] unpack-trees: hash less in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
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

