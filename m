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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0193D1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 15:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389813AbfKEP15 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 10:27:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35838 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389689AbfKEP14 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 10:27:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id l10so21880423wrb.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 07:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UDl/QTSc5wivqAu3cifu0MtvONpNgx/V7Cslq7IZ+Zw=;
        b=vfebZY6f1/yNEfHm1SyyXaTttu7vb6Jd+VLQHVKXgNn9WNBjsl1GFVknvOfKgDpEws
         IOjxBJ/3GQ0A5D9MpNURa1n+0w0ISS1jA1lgNm+VaPT6TZfrWhDlWJsc2KwfaA7SDJ7D
         /kHavs73BZNu494114VyOblMEucsgzwwMexawZD4mlfsWbtMzYzcCkD5tjy8gXdP33HV
         IVD9P5yrT1R6jC9iBlbUlpKTrhe9M6zWdJKoGN+4pl9t55B2+XoZHn5D6tgwO7KIWhSd
         VMfc0cRX2wSE55Loaogls5aQguG/eXrcGIGZ9s23jWP0/oe71eURa4giKJMDDfCRZUX9
         Cvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UDl/QTSc5wivqAu3cifu0MtvONpNgx/V7Cslq7IZ+Zw=;
        b=jD/frSXnQnXsEPUud4GuIe77QEy9wcfRGeJ4BnC6j96H0r0aXgU3/G/qXaKtAEacwN
         XpVZRpIYBrHrWhkyGhrxqyOVsMiprUIrJ/3peFw6VQI6WBuJII5iBCcKjueuwJ+/DOMj
         hLvBdeNQwsPw6+MyrAKNyhRA9PjcXbJTZ4LQklGIyeVJ49xikqUuu0icK3osMvof4s3G
         cTL60+EWhO9x+4bzNl0f+uNWgDLbghMRY6RDA4/LzYpd4XR9VbiDCRf6b4KeNmT3UJR9
         VrSVS3RjtMd2ZFYC+Lf37pfMC3hMCGHGvrJcWeNis85X57JWtd3w9uBJ05gxGZRMFjAL
         sHBg==
X-Gm-Message-State: APjAAAWLtnMsc7NAaFJ2GC3SUXbutnP6kV60Sp58vg7ABhb0hm34B6eL
        iKTcgwfA0fJEsOyN4JY78fT6EG/R
X-Google-Smtp-Source: APXvYqzE6q2d9JKw7Be9lu+yecFviWVNBt5PAVbCivvZUW1qnb/21XhvqJ03qc1KdZMiNP06+1c2WQ==
X-Received: by 2002:adf:e50e:: with SMTP id j14mr1078531wrm.179.1572967674401;
        Tue, 05 Nov 2019 07:27:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v128sm27557681wmb.14.2019.11.05.07.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:27:25 -0800 (PST)
Message-Id: <f76ba554ed25fb9877a223ef6481834f1831c8ca.1572967644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.424.v2.git.1572967644.gitgitgadget@gmail.com>
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
        <pull.424.v2.git.1572967644.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 15:27:23 +0000
Subject: [PATCH v2 1/1] unpack-trees: skip stat on fsmonitor-valid files
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
 fsmonitor.c                       | 20 +++++++++++---------
 t/t7113-post-index-change-hook.sh |  3 ---
 t/t7519-status-fsmonitor.sh       |  9 +++++++--
 unpack-trees.c                    |  6 +++++-
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 1f4aa1b150..4362bc6ee9 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -55,9 +55,10 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	}
 	istate->fsmonitor_dirty = fsmonitor_dirty;
 
-	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
-		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
-		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
+	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
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
+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
 
 	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
 	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
@@ -189,6 +190,9 @@ void refresh_fsmonitor(struct index_state *istate)
 		}
 		if (bol < query_result.len)
 			fsmonitor_refresh_callback(istate, buf + bol);
+
+		if (istate->untracked)
+			istate->untracked->use_fsmonitor = 1;
 	} else {
 		/* Mark all entries invalid */
 		for (i = 0; i < istate->cache_nr; i++)
@@ -257,9 +261,7 @@ void tweak_fsmonitor(struct index_state *istate)
 				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
 
-			/* Now mark the untracked cache for fsmonitor usage */
-			if (istate->untracked)
-				istate->untracked->use_fsmonitor = 1;
+			refresh_fsmonitor(istate);
 		}
 
 		ewah_free(istate->fsmonitor_dirty);
diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
index f011ad7eec..5ca2279d0d 100755
--- a/t/t7113-post-index-change-hook.sh
+++ b/t/t7113-post-index-change-hook.sh
@@ -50,9 +50,6 @@ test_expect_success 'test status, add, commit, others trigger hook without flags
 	git checkout -- dir1/file1.txt &&
 	test_path_is_file testsuccess && rm -f testsuccess &&
 	test_path_is_missing testfailure &&
-	git update-index &&
-	test_path_is_missing testsuccess &&
-	test_path_is_missing testfailure &&
 	git reset --soft &&
 	test_path_is_missing testsuccess &&
 	test_path_is_missing testfailure
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index d8df990972..9cac3d3d8e 100755
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
+	write_integration_script &&
 	dirty_repo &&
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
