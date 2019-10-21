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
	by dcvr.yhbt.net (Postfix) with ESMTP id 769F71F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfJUN4n (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39695 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfJUN4l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id c6so1903228wrm.6
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T4b8TadolwlSOZvHpfmF35nObWmTrbh1mpJa/MQa9ds=;
        b=CKhZ/5xbU6hxSGJw55XhDmpAMkAiFr6eX6YdLo7yRhRxSIR1zdscCQo33OQIxTnFq3
         de4KS1BPncnMdj21XS2Z0O6nC9yY9+rWx6mjHRgSQ5aCwyd9Z5mRm3ySk69n/PHmC1ST
         R5EKAC2tQyLZH50hbcUgarBJoREgZH3DnzEMsFtfnFG9At7EfTD85yg2r1y5YyohhzM7
         1CquIRAWpki1D73glkoj4ogRUAzKj+9ya9v7mJWlrgO5IViWX4SbbYkEE/QvHkTi6iJP
         msr99k8g9ad5OVfDWRUIVzAGAXhlWtjTn2ZjHK5avV3Tdxl9zpcdoCxidDMllYDT+IQk
         0V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T4b8TadolwlSOZvHpfmF35nObWmTrbh1mpJa/MQa9ds=;
        b=Q3cB3uAKtBn0yXdMgSw97M+EpPplJI2EhrRW3d1InDlWApMfyrkG6fD+5y0OyZxogg
         PGh6A41lmqXVWfpt8MwUxXcaReEaWVd1Xn+MbhbmsxrD2SE6U2ZWzZI2VsgNrvieeNSm
         FEIVu/mWtQfkukBH1/od/f2Xp0Sm5dnUx1JXQiUNVo5robs7hGXmXTCwS652Hm4/eOtF
         HVPetbs3Sd+sycC1N8rDxnj+V2euv1zqxH73BI1mkW4JLTEraq2H1SHyxiX99UTb/u49
         BmV9f4zplFPBiSfeIP3hGWLtxZhYTT7pGZ46c6jMM27WhevyEkJfS33D8/zDPfYjfEd7
         65WA==
X-Gm-Message-State: APjAAAVJeXl/DDnmk0iCZlMw+XJUbrKbjlKCMtjF1uHX/s8zd5eT3UAJ
        9F9xGQITWBSYCRQRK+3JB+UQAH7r
X-Google-Smtp-Source: APXvYqz9y3/h/sDRNG2N5p1dSiN5T177vyShFGaxhXlPB4u9bKC+CHbilqDl6Wj8jFj6rzzPbplWzA==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr428635wrl.235.1571666198129;
        Mon, 21 Oct 2019 06:56:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm1363835wrw.32.2019.10.21.06.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:37 -0700 (PDT)
Message-Id: <386f4f8eb5d12d9d089684841d57ea66447cf675.1571666187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:21 +0000
Subject: [PATCH v5 12/17] unpack-trees: add progress to clear_ce_flags()
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

When a large repository has many sparse-checkout patterns, the
process for updating the skip-worktree bits can take long enough
that a user gets confused why nothing is happening. Update the
clear_ce_flags() method to write progress.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h        |  2 ++
 unpack-trees.c | 56 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index 4980ee198e..d3c89e7a53 100644
--- a/cache.h
+++ b/cache.h
@@ -304,6 +304,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 
 struct split_index;
 struct untracked_cache;
+struct progress;
 
 struct index_state {
 	struct cache_entry **cache;
@@ -326,6 +327,7 @@ struct index_state {
 	uint64_t fsmonitor_last_update;
 	struct ewah_bitmap *fsmonitor_dirty;
 	struct mem_pool *ce_mem_pool;
+	struct progress *progress;
 };
 
 /* Name hashing */
diff --git a/unpack-trees.c b/unpack-trees.c
index c0dca20865..8bb684ad62 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1269,7 +1269,8 @@ static int clear_ce_flags_1(struct index_state *istate,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct pattern_list *pl,
-			    enum pattern_match_result default_match);
+			    enum pattern_match_result default_match,
+			    int progress_nr);
 
 /* Whole directory matching */
 static int clear_ce_flags_dir(struct index_state *istate,
@@ -1278,7 +1279,8 @@ static int clear_ce_flags_dir(struct index_state *istate,
 			      char *basename,
 			      int select_mask, int clear_mask,
 			      struct pattern_list *pl,
-			      enum pattern_match_result default_match)
+			      enum pattern_match_result default_match,
+			      int progress_nr)
 {
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
@@ -1315,7 +1317,8 @@ static int clear_ce_flags_dir(struct index_state *istate,
 		rc = clear_ce_flags_1(istate, cache, cache_end - cache,
 				      prefix,
 				      select_mask, clear_mask,
-				      pl, ret);
+				      pl, ret,
+				      progress_nr);
 	}
 
 	strbuf_setlen(prefix, prefix->len - 1);
@@ -1342,7 +1345,8 @@ static int clear_ce_flags_1(struct index_state *istate,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct pattern_list *pl,
-			    enum pattern_match_result default_match)
+			    enum pattern_match_result default_match,
+			    int progress_nr)
 {
 	struct cache_entry **cache_end = cache + nr;
 
@@ -1356,8 +1360,11 @@ static int clear_ce_flags_1(struct index_state *istate,
 		int len, dtype;
 		enum pattern_match_result ret;
 
+		display_progress(istate->progress, progress_nr);
+
 		if (select_mask && !(ce->ce_flags & select_mask)) {
 			cache++;
+			progress_nr++;
 			continue;
 		}
 
@@ -1378,20 +1385,26 @@ static int clear_ce_flags_1(struct index_state *istate,
 						       prefix,
 						       prefix->buf + prefix->len - len,
 						       select_mask, clear_mask,
-						       pl, default_match);
+						       pl, default_match,
+						       progress_nr);
 
 			/* clear_c_f_dir eats a whole dir already? */
 			if (processed) {
 				cache += processed;
+				progress_nr += processed;
 				strbuf_setlen(prefix, prefix->len - len);
 				continue;
 			}
 
 			strbuf_addch(prefix, '/');
-			cache += clear_ce_flags_1(istate, cache, cache_end - cache,
-						  prefix,
-						  select_mask, clear_mask, pl,
-						  default_match);
+			processed = clear_ce_flags_1(istate, cache, cache_end - cache,
+						     prefix,
+						     select_mask, clear_mask, pl,
+						     default_match, progress_nr);
+
+			cache += processed;
+			progress_nr += processed;
+
 			strbuf_setlen(prefix, prefix->len - len - 1);
 			continue;
 		}
@@ -1406,19 +1419,27 @@ static int clear_ce_flags_1(struct index_state *istate,
 		if (ret == MATCHED)
 			ce->ce_flags &= ~clear_mask;
 		cache++;
+		progress_nr++;
 	}
+
+	display_progress(istate->progress, progress_nr);
 	return nr - (cache_end - cache);
 }
 
 static int clear_ce_flags(struct index_state *istate,
 			  int select_mask, int clear_mask,
-			  struct pattern_list *pl)
+			  struct pattern_list *pl,
+			  int show_progress)
 {
 	static struct strbuf prefix = STRBUF_INIT;
 	char label[100];
 	int rval;
 
 	strbuf_reset(&prefix);
+	if (show_progress)
+		istate->progress = start_delayed_progress(
+					_("Updating index flags"),
+					istate->cache_nr);
 
 	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
 		  (unsigned long)select_mask, (unsigned long)clear_mask);
@@ -1428,9 +1449,10 @@ static int clear_ce_flags(struct index_state *istate,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
-				pl, 0);
+				pl, 0, 0);
 	trace2_region_leave("unpack_trees", label, the_repository);
 
+	stop_progress(&istate->progress);
 	return rval;
 }
 
@@ -1439,7 +1461,8 @@ static int clear_ce_flags(struct index_state *istate,
  */
 static void mark_new_skip_worktree(struct pattern_list *pl,
 				   struct index_state *istate,
-				   int select_flag, int skip_wt_flag)
+				   int select_flag, int skip_wt_flag,
+				   int show_progress)
 {
 	int i;
 
@@ -1463,7 +1486,7 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(istate, select_flag, skip_wt_flag, pl);
+	clear_ce_flags(istate, select_flag, skip_wt_flag, pl, show_progress);
 }
 
 static int verify_absent(const struct cache_entry *,
@@ -1525,7 +1548,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
 	if (!o->skip_sparse_checkout)
-		mark_new_skip_worktree(o->pl, o->src_index, 0, CE_NEW_SKIP_WORKTREE);
+		mark_new_skip_worktree(o->pl, o->src_index, 0,
+				       CE_NEW_SKIP_WORKTREE, o->verbose_update);
 
 	if (!dfc)
 		dfc = xcalloc(1, cache_entry_size(0));
@@ -1590,7 +1614,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		 * If the will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
 		 * so apply_sparse_checkout() won't attempt to remove it from worktree
 		 */
-		mark_new_skip_worktree(o->pl, &o->result, CE_ADDED, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
+		mark_new_skip_worktree(o->pl, &o->result,
+				       CE_ADDED, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE,
+				       o->verbose_update);
 
 		ret = 0;
 		for (i = 0; i < o->result.cache_nr; i++) {
-- 
gitgitgadget

