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
	by dcvr.yhbt.net (Postfix) with ESMTP id D9F691F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfKFEyU (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:54:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33302 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbfKFEyU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:54:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so637908wmb.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 20:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PJ97ZRhhC47tDTu7TOCFVWrskeMNMY7/eTwEa7Vx+No=;
        b=jPYyw+3fKkfnnkZlrnwbAoqsfHDA8+X6YsvC3yQI0gr88eG+xoXpo10Lc7qIfN+RP4
         KS93wHtgBHHoTdVQGdJxLzFsQ6KI4qcHJkNXZsZg49qiHi4S7YeMN+/IwCmTMsHfrPrO
         HVHp8LTNhFPlFrS3X7o8QZLDBZPKU5lQjqTT0cFZRiSRhl+G3CZlkFUgdx2fl6CsCgDx
         hcDv/Jc/5Ctv0akBaMlANaasJISbUANeZAV/NP0xnHDGQ8kJEP4crgi3e/OU5scPDPMB
         2cBmHOs9GbaU02LsHnwFJ6ly6V2MOpAYsvWqT9otyyti97o/qf0AKeBoMQKLr/XbCrdc
         1Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PJ97ZRhhC47tDTu7TOCFVWrskeMNMY7/eTwEa7Vx+No=;
        b=Iv9Hq2spz/jFx8bDe1DNsfV2JL2hKqzABvFx7VA8LnL1atNcK7kRzxuLrZRvgvOevl
         dE3osKtmWro9wK3etq1TD+HKx6POmVx8/bL+9fH7l63ekLSF3XMBKslbbcv/Fp1KQylt
         OFT1J0IKT9iJ57ekQb98Ck++ltqQrRTZ4HAv/ML0vGuYaL+bVWPsZ6ycpCj8+6zcC8PV
         Fnu99D+g6TxaJ9AEHwM/Zqr57B6vFNH7ejbYRk6wYrYGceFg0SMi4Y0gJiU+UowH25Sh
         M5nr9xLoAuSkwwbAyY3356UIBKE9KBRGIYBnMpvmmfSVnsiuTI7N2eMeor9ABvTkBzsb
         ePUQ==
X-Gm-Message-State: APjAAAUP3gqsOK6zj+eJXvOpeVHlbuZlj8zlvoXSuF9DkS6PQCPd95G0
        hsHonB47xyRo8TdCp/JY+qmDj2/m
X-Google-Smtp-Source: APXvYqwPv+n8/CkCJYVg8glMSxLowfPxGMv38sax2ABL4MToLm3wgS7R1EMRgOc802e3lhyBIckkVQ==
X-Received: by 2002:a1c:814b:: with SMTP id c72mr609687wmd.167.1573016057357;
        Tue, 05 Nov 2019 20:54:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm17964398wrw.20.2019.11.05.20.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 20:54:16 -0800 (PST)
Message-Id: <4bea7075cfcac013f5947cd3e9254d38e86e675c.1573016055.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.424.v3.git.1573016055.gitgitgadget@gmail.com>
References: <pull.424.v2.git.1572967644.gitgitgadget@gmail.com>
        <pull.424.v3.git.1573016055.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 04:54:15 +0000
Subject: [PATCH v3 1/1] unpack-trees: skip stat on fsmonitor-valid files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Utsav Shah <utsav@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Utsav Shah <utsav@dropbox.com>

The index might be aware that a file hasn't modified via fsmonitor, but
unpack-trees did not pay attention to it and checked via ie_match_stat
which can be inefficient on certain filesystems. This significantly slows
down commands that run oneway_merge, like checkout and reset --hard.

This patch makes oneway_merge check whether a file is considered
unchanged through fsmonitor and skips ie_match_stat on it. unpack-trees
also now correctly copies over fsmonitor validity state from the source
index. Finally, for correctness, we force a refresh of fsmonitor state in
tweak_fsmonitor.

After this change, commands like stash (that use reset --hard
internally) go from 8s or more to ~2s on a 250k file repository on a
mac.

Signed-off-by: Utsav Shah <utsav@dropbox.com>
---
 fsmonitor.c                 | 39 ++++++++++++++++++++++++-------------
 t/t7519-status-fsmonitor.sh |  9 +++++++--
 unpack-trees.c              |  6 +++++-
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 1f4aa1b150..04d6232531 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -18,7 +18,7 @@ static void fsmonitor_ewah_callback(size_t pos, void *is)
 
 	if (pos >= istate->cache_nr)
 		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
-		    (uintmax_t)pos, istate->cache_nr);
+			(uintmax_t)pos, istate->cache_nr);
 
 	ce = istate->cache[pos];
 	ce->ce_flags &= ~CE_FSMONITOR_VALID;
@@ -55,9 +55,10 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	}
 	istate->fsmonitor_dirty = fsmonitor_dirty;
 
-	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
-		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
-		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
+	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
+			(uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
+
 
 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
 	return 0;
@@ -83,9 +84,9 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 	uint32_t ewah_size = 0;
 	int fixup = 0;
 
-	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
-		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
-		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
+	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
+			(uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
 
 	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
 	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
@@ -189,13 +190,25 @@ void refresh_fsmonitor(struct index_state *istate)
 		}
 		if (bol < query_result.len)
 			fsmonitor_refresh_callback(istate, buf + bol);
+
+		if (istate->untracked)
+			istate->untracked->use_fsmonitor = 1;
 	} else {
+
+		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
+		 * if we actually changed entries or not */
+		int is_cache_changed = 0;
 		/* Mark all entries invalid */
-		for (i = 0; i < istate->cache_nr; i++)
-			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		for (i = 0; i < istate->cache_nr; i++) {
+			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) {
+				is_cache_changed = 1;
+				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+			}
+		}
 
 		/* If we're going to check every file, ensure we save the results */
-		istate->cache_changed |= FSMONITOR_CHANGED;
+		if (is_cache_changed)
+			istate->cache_changed |= FSMONITOR_CHANGED;
 
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 0;
@@ -254,12 +267,10 @@ void tweak_fsmonitor(struct index_state *istate)
 			/* Mark all previously saved entries as dirty */
 			if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
 				BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
-				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
+					(uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
 
-			/* Now mark the untracked cache for fsmonitor usage */
-			if (istate->untracked)
-				istate->untracked->use_fsmonitor = 1;
+			refresh_fsmonitor(istate);
 		}
 
 		ewah_free(istate->fsmonitor_dirty);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index d8df990972..69908b6a9b 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -106,6 +106,8 @@ EOF
 
 # test that "update-index --fsmonitor-valid" sets the fsmonitor valid bit
 test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor valid bit' '
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	EOF
 	git update-index --fsmonitor &&
 	git update-index --fsmonitor-valid dir1/modified &&
 	git update-index --fsmonitor-valid dir2/modified &&
@@ -164,6 +166,8 @@ EOF
 
 # test that newly added files are marked valid
 test_expect_success 'newly added files are marked valid' '
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	EOF
 	git add new &&
 	git add dir1/new &&
 	git add dir2/new &&
@@ -218,11 +222,12 @@ test_expect_success '*only* files returned by the integration script get flagged
 # Ensure commands that call refresh_index() to move the index back in time
 # properly invalidate the fsmonitor cache
 test_expect_success 'refresh_index() invalidates fsmonitor cache' '
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
-	EOF
 	clean_repo &&
 	dirty_repo &&
+	write_integration_script &&
 	git add . &&
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	EOF
 	git commit -m "to reset" &&
 	git reset HEAD~1 &&
 	git status >actual &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 33ea7810d8..fc5ceb932c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1504,6 +1504,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->merge_size = len;
 	mark_all_ce_unused(o->src_index);
 
+	if (o->src_index->fsmonitor_last_update)
+		o->result.fsmonitor_last_update = o->src_index->fsmonitor_last_update;
+
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
@@ -2384,7 +2387,8 @@ int oneway_merge(const struct cache_entry * const *src,
 
 	if (old && same(old, a)) {
 		int update = 0;
-		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
+		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
+			!(old->ce_flags & CE_FSMONITOR_VALID)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
-- 
gitgitgadget
