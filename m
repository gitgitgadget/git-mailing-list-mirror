Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A7B61F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 19:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeKTF2a (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 00:28:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39605 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeKTF2a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 00:28:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so15022260pla.6
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 11:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6kj5Yf2spfp66BEw1qKZyFVZq/yYqd1odKR0vjTR/wg=;
        b=RJ2awDdlJfRCG65mAHVv5puSRVCjtSFDLjPWAy8iGjAlvYvmPJaKKW/qN5FWB08dbP
         lexOgPUd/gNshNKQPBA6n9Rokp7YJ0aJOUGT2o803DI5UV/FfhYTutaYMZpjelfWdx9N
         EtqFLp/SNkn03hofwO+xlLAcMlfoN1fCpHspeVz6jWtgdGOfjb/kvwMxgwHqZ8duTB1Z
         IGAPOKTYzzZ1QCc5dlHuosHFgiB5fCxzbiJDpEx/j5KFSwSZGTcX2N0OwZTaLyo21lHY
         1SuMsp9adSUWXwdE8XkbhBl58glwmRuyB3ssi5HlomuK16Luke/TqtAcC6JUFW34FPT2
         gMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6kj5Yf2spfp66BEw1qKZyFVZq/yYqd1odKR0vjTR/wg=;
        b=UTATzqvarRtWEGvQyH4GLrY9QQhF0ePv45iAQqvyKLHItMnRHyjchoYmSe7lYCSzUD
         zV69a4Mfx6o+R8S0nFYFWQhHbyc2G7YmhLc5lLPiLSNHkK7VmIWMLraw6m/ic8R52Pzo
         MInjICYRlpcDLgPJlKuzngC66bE/XGgE4Nm0Nf/CRDGa8+LCCAQNK5/fyZXNobZaBCUA
         TB4ixaqMWozUlO1yrjEsKhhFgiMJWJe/0FQQbVNVJa9JkX3LcTeMTAF9xUDJDvkbW0nA
         u56WnufJ75RZUmTFU6cWWwXfgky4TLDS/uuJHjTYdm4yxEyC8jgFNrDMyFNwCWKJ+3dJ
         h76w==
X-Gm-Message-State: AGRZ1gIjNBgaHWBnAZ3iN8TJ7UPAC3RR3Mfhm6GzMV4VHX98rLnd2Dql
        gWYm3GK+qArqFrESvY2/t1r9BcVq
X-Google-Smtp-Source: AJdET5fxkEHvRGiSYm6RHBJz4CTakqduFCacTwFmDkea9ci2LuvxrcagVUzcZnZy5pJxl1xHC1hCuw==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59-v6mr23663016plb.61.1542654213615;
        Mon, 19 Nov 2018 11:03:33 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id j9sm7828968pfi.86.2018.11.19.11.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 11:03:33 -0800 (PST)
Date:   Mon, 19 Nov 2018 11:03:33 -0800 (PST)
X-Google-Original-Date: Mon, 19 Nov 2018 19:03:29 GMT
Message-Id: <ab7c2dd46fb72523b865ecf34204c7ae31dee416.1542654209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.83.git.gitgitgadget@gmail.com>
References: <pull.83.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] revision.c: use new topo-order logic in tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The revision-walk machinery is being rewritten to use generation
numbers in the commit-graph when availble. Due to some problematic
commit histories, the new logic can be slower than the previous
method due to how commit dates and generation numbers interact.
Thus, the new logic is not used in comparison queries, such as

	git log --topo-order A..B

The logic for these queries was implemented during the refactor,
but is unreachable due to the potential performance penalty. The
code came along with a larger block of code that was copied from
the old code. When generation numbers are updated to v2 (corrected
commit dates), then we will no longer have a performance penalty
and this logic is what we will want to use.

In the meantime, use the new logic when GIT_TEST_COMMIT_GRAPH is
enabled. This will demonstrate that the new logic works for all
comparison queries in the test suite, including these variants:

	git log --topo-order --ancestry-path A..B
	git log --topo-order A...B

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/revision.c b/revision.c
index 4ef47d2fb4..d52da6e24f 100644
--- a/revision.c
+++ b/revision.c
@@ -27,6 +27,7 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "prio-queue.h"
+#include "config.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -3143,6 +3144,9 @@ int prepare_revision_walk(struct rev_info *revs)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
 		return 0;
+	if (revs->limited &&
+	    git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
+		revs->limited = 0;
 	if (revs->limited) {
 		if (limit_list(revs) < 0)
 			return -1;
-- 
gitgitgadget
