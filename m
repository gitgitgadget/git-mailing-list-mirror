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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3512A1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfJGUIr (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34132 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfJGUIn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id j11so10984506wrp.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hSAN9Z1L6ML5R1EqiVbmimPFaQ5+PR5m57S9am4RReM=;
        b=Tnjk+KVksQkxrm2ttPtT7+oDIbZ914ZqO4XzmIWz8PEJtB3GKIQSHPH3+mJMbLhKzw
         XzUDzrnB9GaVaQB3B4TGxBN05+P0ZaLXzBY8RqJTVVkz0szHH8kFlT7ADWx/hQ0Y9vc8
         slIhZfd+3GdYqC2TCEfokk0ayAW+BkfZNw55BZUy8b0MpGQSLHe8Z8CTBed0dZocm7Vt
         sDIfkEsvquVt05Tqv4SBI45caj3kVXr5cJUAkGnfJK6okqIdGpi7VAyFJPfKWB6VY9Wt
         MhOprNvs2oX+h7EXBxjd0THZX/m7xZGd+C52076kIdY9QIVhnrC5g6cziFQ0ugDaltPP
         4E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hSAN9Z1L6ML5R1EqiVbmimPFaQ5+PR5m57S9am4RReM=;
        b=GkxkJUk69Ew6G7tglKQlqZAG3KCDlW4Su0FeP8MVOmeXOFgExoEzVDz2vVdcoRemML
         xPZq/1TZ03dXj78Kapfhc+daeEfzn3kYOILY3kqQKglaVteSYj/CifJ4PXXdpVIZxf8O
         W3nIYtzstyhlb41GNx5sjx0fGaIWWyXWw8tnfHjymB7PVMZhXiVjcsuBGM+grOcpUu6y
         6RWAavRsxWL3JEQnuZz0MZHL0ODnIMQmwbEyY99Q1gLXXhfFcN0mO4UY8fgpo365iUdA
         jdo+OdTtINv4VYq2fpA1Aor1p+8cCJlSc7Zu/YUfsxWmiXHavILVFdug/2WXxxkrc7fs
         bQxw==
X-Gm-Message-State: APjAAAUywFe6c49khE2aAVgbVtu5ch/qApV3ERobBwaMjT8M8Ys1ty2o
        AC+sghh805BqXFpMgXMUoMGEoqC6
X-Google-Smtp-Source: APXvYqwHAgtT2dkITPFVeZAqgRsbnqgKLORpB0Ep7TSxpVVma4xc/aff0J/xd+Y8KIBED6+G5lZvZw==
X-Received: by 2002:adf:f081:: with SMTP id n1mr8445228wro.273.1570478919680;
        Mon, 07 Oct 2019 13:08:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm14499295wro.16.2019.10.07.13.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:39 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:39 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:20 GMT
Message-Id: <3ef32084f5ff55ddf56d241b26883e04b98296c9.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 12/17] unpack-trees: add progress to clear_ce_flags()
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
index 8e8ea67efa..9d9d88a0f0 100644
--- a/cache.h
+++ b/cache.h
@@ -328,6 +328,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 
 struct split_index;
 struct untracked_cache;
+struct progress;
 
 struct index_state {
 	struct cache_entry **cache;
@@ -350,6 +351,7 @@ struct index_state {
 	uint64_t fsmonitor_last_update;
 	struct ewah_bitmap *fsmonitor_dirty;
 	struct mem_pool *ce_mem_pool;
+	struct progress *progress;
 };
 
 /* Name hashing */
diff --git a/unpack-trees.c b/unpack-trees.c
index b5cf591c38..edf0fb4673 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1266,7 +1266,8 @@ static int clear_ce_flags_1(struct index_state *istate,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct pattern_list *pl,
-			    enum pattern_match_result default_match);
+			    enum pattern_match_result default_match,
+			    int progress_nr);
 
 /* Whole directory matching */
 static int clear_ce_flags_dir(struct index_state *istate,
@@ -1275,7 +1276,8 @@ static int clear_ce_flags_dir(struct index_state *istate,
 			      char *basename,
 			      int select_mask, int clear_mask,
 			      struct pattern_list *pl,
-			      enum pattern_match_result default_match)
+			      enum pattern_match_result default_match,
+			      int progress_nr)
 {
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
@@ -1312,7 +1314,8 @@ static int clear_ce_flags_dir(struct index_state *istate,
 		rc = clear_ce_flags_1(istate, cache, cache_end - cache,
 				      prefix,
 				      select_mask, clear_mask,
-				      pl, ret);
+				      pl, ret,
+				      progress_nr);
 	}
 
 	strbuf_setlen(prefix, prefix->len - 1);
@@ -1339,7 +1342,8 @@ static int clear_ce_flags_1(struct index_state *istate,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct pattern_list *pl,
-			    enum pattern_match_result default_match)
+			    enum pattern_match_result default_match,
+			    int progress_nr)
 {
 	struct cache_entry **cache_end = cache + nr;
 
@@ -1353,8 +1357,11 @@ static int clear_ce_flags_1(struct index_state *istate,
 		int len, dtype;
 		enum pattern_match_result ret;
 
+		display_progress(istate->progress, progress_nr);
+
 		if (select_mask && !(ce->ce_flags & select_mask)) {
 			cache++;
+			progress_nr++;
 			continue;
 		}
 
@@ -1375,20 +1382,26 @@ static int clear_ce_flags_1(struct index_state *istate,
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
@@ -1403,19 +1416,27 @@ static int clear_ce_flags_1(struct index_state *istate,
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
@@ -1425,9 +1446,10 @@ static int clear_ce_flags(struct index_state *istate,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
-				pl, 0);
+				pl, 0, 0);
 	trace2_region_leave("unpack_trees", label, the_repository);
 
+	stop_progress(&istate->progress);
 	return rval;
 }
 
@@ -1436,7 +1458,8 @@ static int clear_ce_flags(struct index_state *istate,
  */
 static void mark_new_skip_worktree(struct pattern_list *pl,
 				   struct index_state *istate,
-				   int select_flag, int skip_wt_flag)
+				   int select_flag, int skip_wt_flag,
+				   int show_progress)
 {
 	int i;
 
@@ -1460,7 +1483,7 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(istate, select_flag, skip_wt_flag, pl);
+	clear_ce_flags(istate, select_flag, skip_wt_flag, pl, show_progress);
 }
 
 static int verify_absent(const struct cache_entry *,
@@ -1522,7 +1545,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
 	if (!o->skip_sparse_checkout)
-		mark_new_skip_worktree(o->pl, o->src_index, 0, CE_NEW_SKIP_WORKTREE);
+		mark_new_skip_worktree(o->pl, o->src_index, 0,
+				       CE_NEW_SKIP_WORKTREE, o->verbose_update);
 
 	if (!dfc)
 		dfc = xcalloc(1, cache_entry_size(0));
@@ -1587,7 +1611,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
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

