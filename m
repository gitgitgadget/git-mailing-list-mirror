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
	by dcvr.yhbt.net (Postfix) with ESMTP id 961C61F4C3
	for <e@80x24.org>; Fri,  8 Nov 2019 07:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfKHHJ0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 02:09:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45395 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfKHHJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 02:09:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so453790wrs.12
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 23:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=24Jia8xSfdCh5FRqpDxapOe8wtjG96D92RxgFogt4GU=;
        b=B1pBDBDhJ0xb9+BV8KI7irFKtf7pG2SNTTeRXj125RzjtMML/e44RUN0pxWoxxjUdP
         Wy3es479Sg7HtO+3X1/VBLZZVDKVghBUftvt3YjmJENw3YYnxiK5mJTmOgj/gYPi7eFm
         KlX+nc6kzGQfTpMkalV0MlNFhSzQHg7tb4QflhJ7nOaKZHVpMbce2FqvOS7c3E8dMhZ/
         UxRxTvfaBA0uFco0ta4zFQM1YmzI5limNkEGhzCKZzVDuFhoBcCwPCMwS6bckz+GQvJg
         ubFVoVGFxeOf+Ck5rPKFuNG8XfHg8vll2vbRO3x6WnQXq6T0MJf+BoI5zTkZOtyrwVT3
         SpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=24Jia8xSfdCh5FRqpDxapOe8wtjG96D92RxgFogt4GU=;
        b=frX1GmUHzeB2YpQQIoa8Wg5UBn4SUxtFApZyvNbEeR/XUN2gN40/9f+3F+qUtsKEjY
         0oMNDiFwYxvirUp8Hcivcy15lqMRqtL+KiriiaZ+/YdXyL90U8XkbNm3BfIrZ0bwl0hx
         vA/JAI8sGpoZl/veaatp7UgJ5WQSho0qcXJo6dmZIoDdCbxOTOMrq0grnb3Zcn4BLgjn
         vjDoFgzjAEbdYIK2NVm4+K8H4+smecRWbAWZz4L3yhUwi9im3OcFvYAUx8VbiFqhAhA5
         BpMSJNoVCO9ysImn+VJ5B98Xu1x3WdXYCX8gQeIFD42N4glklJuBVm4E97J8vCAmx2m9
         kRtw==
X-Gm-Message-State: APjAAAWOt25PnNas+l084K4lsjYwrFXWcNE/B+kbHXs/GfmSdsX6sCcN
        s9FVnEsYtlxztP3Sj2qCyKz/bK9W
X-Google-Smtp-Source: APXvYqxJxLUSM3M96L6P6FCQO+yZh8HJ6dPpAm+9aoQZaqEnqfHSKJU7nQrkDPAHQI5a6aGZD7P8rw==
X-Received: by 2002:a5d:444b:: with SMTP id x11mr6853805wrr.207.1573196962874;
        Thu, 07 Nov 2019 23:09:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g8sm4845433wmk.23.2019.11.07.23.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 23:09:22 -0800 (PST)
Message-Id: <8d69ba362261690e58b3879c33ac01c8888dc473.1573196960.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.458.git.1573196960.gitgitgadget@gmail.com>
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Nov 2019 07:09:20 +0000
Subject: [PATCH 1/1] fsmonitor: skip sanity check if the index is split
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

The checks added in 3444ec2eb2 ("fsmonitor: don't fill bitmap with
entries to be removed", 2019-10-11), to ensure that the
fsmonitor_dirty bitmap does not have more bits than the index
do not play well with the split index.

git update-index --fsmonitor --split-index calls write_locked_index
which calls write_shared_index as well as write_split_index.
The first call fills up the fsmonitor_dirty bitmap,
and the second modifies the index such that istate->cache_nr is zero and
this assert is hit.

The test written does reproduce the error, but only flakily. There is
limited difference with GIT_TEST_FSMONITOR=fsmonitor-all or
GIT_TEST_FSMONITOR=fsmonitor-watchman, so the flakiness might come from
somewhere else, which I haven't tracked down.

The test also requires checkout of a new branch, and checking out back
to master. It's clear that the index gets into some poor state through
these operations, and there is a deeper bug somewhere.

At the very least, this patch mitigates an over-eager check for split
index users while maintaining good invariants for the standard case.
Also, I haven't been able to reproduce this with "standard" user
commands, like status/checkout/stash, so the blast radius seems limited.

Helped-by: Kevin Willford <kewillf@microsoft.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Utsav Shah <utsav@dropbox.com>
---
 fsmonitor.c                 |  8 ++++----
 t/t7519-status-fsmonitor.sh | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 1f4aa1b150..01cba22b38 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -16,7 +16,7 @@ static void fsmonitor_ewah_callback(size_t pos, void *is)
 	struct index_state *istate = (struct index_state *)is;
 	struct cache_entry *ce;
 
-	if (pos >= istate->cache_nr)
+	if (!istate->split_index && pos >= istate->cache_nr)
 		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
 		    (uintmax_t)pos, istate->cache_nr);
 
@@ -55,7 +55,7 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	}
 	istate->fsmonitor_dirty = fsmonitor_dirty;
 
-	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
 		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
 		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 
@@ -83,7 +83,7 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 	uint32_t ewah_size = 0;
 	int fixup = 0;
 
-	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
 		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
 		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 
@@ -252,7 +252,7 @@ void tweak_fsmonitor(struct index_state *istate)
 			}
 
 			/* Mark all previously saved entries as dirty */
-			if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+			if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
 				BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
 				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index d8df990972..b5029eff3e 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -371,4 +371,27 @@ test_expect_success 'status succeeds after staging/unstaging ' '
 	)
 '
 
+# Git will only split indices if we have a bunch of files created,
+# so that prep work of creating a few hundred files is required.
+# Note that this test doesn't fail determinstically without
+# its corresponding bugfix.
+test_expect_success 'update-index succeeds after staging with split index' '
+	test_create_repo fsmonitor-stage-split &&
+	(
+		cd fsmonitor-stage-split &&
+		test_commit initial &&
+		files=$(test_seq 1 100) &&
+		echo "hello world" > file &&
+		touch $files &&
+		git add -A &&
+		git commit -m "next" &&
+		git config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-watchman" &&
+		echo "hello world" > file &&
+		git checkout -b new-branch &&
+		git checkout master &&
+		echo hello >> file &&
+		git update-index --split-index --untracked-cache --fsmonitor
+	)
+'
+
 test_done
-- 
gitgitgadget
