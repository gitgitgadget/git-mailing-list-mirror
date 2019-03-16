Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9782420248
	for <e@80x24.org>; Sat, 16 Mar 2019 09:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfCPJtJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 05:49:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33293 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfCPJtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 05:49:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id q3so2965842edg.0
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 02:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xwoLhNt8mcE+FN2e+t63DUPxgpdTQXnSE2JK5vBUT2E=;
        b=jijjAhMtuLQaTTL45DFv9tJzTw/GF8QBgnhH5evN6d/kTTkDufn5sSoVz6qQnbeRTD
         f8USgPTnrH+9kPc2+rbEx7a+NgWGQ3wO5bm0HAx7gRuDCfkOfSbJBxbNrzOPFFr2vcS7
         mZnaLu4vAIWuvSXzpfMOhQjmgqtP0ZLlTGMmEG7yBv4u4vV72mrQeHSTK/Op/GRMniWa
         ZwRbPBMILB0vQj57QkWxnIAtE6xYcg5C29Y8id4KDNIpQrLZPZd90jowt5vsrWbds6Sl
         fKqX6bdVuPhickb0gMJMC3O7C6b24ZWnwtENTjvMnyya3bhw7kfs6LpYkD47VUC/T4Jv
         +wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xwoLhNt8mcE+FN2e+t63DUPxgpdTQXnSE2JK5vBUT2E=;
        b=S7q8BJuwbJiw3mw2zs3lkPoUfppg4Hic9kLg1UR75le+XMNDhfj4/BMMlWkQQOUf8N
         HLhfNcAGGXo6o7+sMWpUdPkxdfIkMZkZwqXeKHuTN5DtEKc8L3IkmZk1VCbqQrZQVz84
         YXJ/stEJ68qS084ECRgzHxenLoTO1Xhzcbh5yJhzu4yZ8MSz7Af6BJcPs7/ISLNuYsev
         N/7Bk/3RNM+QMkNipekGJbrdaiwZDNBSoSplJyX2xr/AJbIv3ZYc5K3Hc+eRDXrlRbSU
         4OO10X2rUEhCcKfQs14jONXGtIh/+v99SS3I8XEaGkWic4GkGROhAxd/UcPiG/+BES1R
         A/ew==
X-Gm-Message-State: APjAAAWifpmGL6MX6LBMuqt2FRcm4t63rQgyAPnPmM84UhMGI1zvI2Nx
        eWYQ3UtHvgzpQIayTS33PkRSiGDZ
X-Google-Smtp-Source: APXvYqyGE6CFR8zOje3lQ2+o0PTX4VnEVJwPg5dHQrGf3LsI+HARurtIvOG207n2z9yL42EcSaiUXg==
X-Received: by 2002:a17:906:54b:: with SMTP id k11mr4958006eja.131.1552729747816;
        Sat, 16 Mar 2019 02:49:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm962360ejn.77.2019.03.16.02.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 02:49:07 -0700 (PDT)
Date:   Sat, 16 Mar 2019 02:49:07 -0700 (PDT)
X-Google-Original-Date: Sat, 16 Mar 2019 09:49:05 GMT
Message-Id: <1d626237762f29d6f617f706a06a024811993185.1552729745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.165.git.gitgitgadget@gmail.com>
References: <pull.165.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] fsmonitor: force a refresh after the index was discarded
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With this change, the `index_state` struct becomes the new home for the
flag that says whether the fsmonitor hook has been run, i.e. it is now
per-index.

It also gets re-set when the index is discarded, fixing the bug where
fsmonitor-enabled Git would miss updates under certain circumstances.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h                     | 3 ++-
 fsmonitor.c                 | 5 ++---
 read-cache.c                | 1 +
 t/t7519-status-fsmonitor.sh | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index abd518a9a2..8d07c29c2a 100644
--- a/cache.h
+++ b/cache.h
@@ -339,7 +339,8 @@ struct index_state {
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1,
-		 drop_cache_tree : 1;
+		 drop_cache_tree : 1,
+		 fsmonitor_has_run_once : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	struct object_id oid;
diff --git a/fsmonitor.c b/fsmonitor.c
index 665bd2d425..1dee0aded1 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -129,7 +129,6 @@ static void fsmonitor_refresh_callback(struct index_state *istate, const char *n
 
 void refresh_fsmonitor(struct index_state *istate)
 {
-	static int has_run_once = 0;
 	struct strbuf query_result = STRBUF_INIT;
 	int query_success = 0;
 	size_t bol; /* beginning of line */
@@ -137,9 +136,9 @@ void refresh_fsmonitor(struct index_state *istate)
 	char *buf;
 	int i;
 
-	if (!core_fsmonitor || has_run_once)
+	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
 		return;
-	has_run_once = 1;
+	istate->fsmonitor_has_run_once = 1;
 
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
 	/*
diff --git a/read-cache.c b/read-cache.c
index 4dc6de1b55..0bf39e177a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2335,6 +2335,7 @@ int discard_index(struct index_state *istate)
 	free_name_hash(istate);
 	cache_tree_free(&(istate->cache_tree));
 	istate->initialized = 0;
+	istate->fsmonitor_has_run_once = 0;
 	FREE_AND_NULL(istate->cache);
 	istate->cache_alloc = 0;
 	discard_split_index(istate);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 918bc323ab..72b9ed3e45 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -346,7 +346,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 	test_cmp before after
 '
 
-test_expect_failure 'discard_index() also discards fsmonitor info' '
+test_expect_success 'discard_index() also discards fsmonitor info' '
 	test_when_finished \
 		"git config core.monitor .git/hooks/fsmonitor-test" &&
 	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
-- 
gitgitgadget
