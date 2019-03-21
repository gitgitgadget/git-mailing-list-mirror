Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92DC20248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfCUN5i (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:57:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39662 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCUN5g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:57:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so5059833edc.6
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=11NPUdXTi2EePQMW70EiieyIjHrKBgs0TgAihzpRDOw=;
        b=IF04R6t9F9yIYuOBXQIETS7mN3PNUcCz2QZx2HTwzuLxL8Q2xqowHhSbhMon+LGSJo
         C/1M68pmgD/I1KwNn6T+GYVxiPxKsQ98joR1jd5sgYwJUtmPZbIjka6/fNZS8l4/SJYJ
         CHYSZ79UCnIQzD0GxXxfHNsCEydlrRYCXcn8SFJdAAfh4ohns0lqKJ0DInC3AMXQufI2
         zgmdAp0O8uzD/2Y2ASarTWNVTsm+ZH6+YFC6sxnRJSkqwyOKEFwCDK11aJEjFUhCFr5S
         ArsdFY8fkpDJwCUGtuo7PFxWgFfAwD22Ja81BuiQ773L9Jg/dBU9jRZhihZnSxrga7as
         I3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=11NPUdXTi2EePQMW70EiieyIjHrKBgs0TgAihzpRDOw=;
        b=q5Z+fDK+uxie1L5Q7Z4Wvjhqj3z4aElLLkId8PexU1cJiRDj/JFhfiEAkJa7wyRqen
         6iAsy4vgQqFYlFQQVlYAv/nAMRNarpuB4bI/O01LB8ltvY1ZTL0pp9wTeDRFkhM35QI3
         rbYK0fvuC2f7UGBFOdzceAbbW0FEG37QaQE4J4k9IlnlBxBvwdCUk1UXAW1Ddd6JKNUn
         Kjix14QRlQUmCNNqgEqpa1fFNlhPcgc9D8pneryrXabyLE2wUXrKmTQuvb+xBGDN7v7+
         J+JC3G+mAjMor3U3cvBn/pPPT1g5BZxrWA1IzCjBwXzMcAXO9UhmD9SQFr4zADftPH1D
         iddg==
X-Gm-Message-State: APjAAAVIPiDjmXPEqNZT4EIM8lJEyRxLIxhk9GBPaUYV5bLuyQFNr0ta
        USCijm0Bhi48mSBoPEsoyaJ0qX1K
X-Google-Smtp-Source: APXvYqw4pfmIDcFakprAHkU6P69N9JxiwKf/eFjeJS5kJWZslriD2m9/zex71tNUtM7y7Skc22NtLA==
X-Received: by 2002:a50:945a:: with SMTP id q26mr2661339eda.280.1553176654722;
        Thu, 21 Mar 2019 06:57:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 50sm1638851edz.73.2019.03.21.06.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:57:34 -0700 (PDT)
Date:   Thu, 21 Mar 2019 06:57:34 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Mar 2019 13:57:31 GMT
Message-Id: <79fdd0d586e9086b68af1b68dc5e194a566d2240.1553176651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.165.v2.git.gitgitgadget@gmail.com>
References: <pull.165.git.gitgitgadget@gmail.com>
        <pull.165.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] fsmonitor: force a refresh after the index was
 discarded
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
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
index ac92421f3a..7434740c99 100644
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
index afd8fa7532..81a375fa0f 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -346,7 +346,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 	test_cmp before after
 '
 
-test_expect_failure 'discard_index() also discards fsmonitor info' '
+test_expect_success 'discard_index() also discards fsmonitor info' '
 	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
 	test_might_fail git update-index --refresh &&
 	test-tool read-cache --print-and-refresh=tracked 2 >actual &&
-- 
gitgitgadget
