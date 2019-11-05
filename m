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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFA91F454
	for <e@80x24.org>; Tue,  5 Nov 2019 20:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKEUOH (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 15:14:07 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33368 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfKEUOG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 15:14:06 -0500
Received: by mail-wr1-f43.google.com with SMTP id w30so299827wra.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 12:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Tfga2ZIOaQmecJLtOonLYGEQXi2C7ktGHqLjiXgGd8=;
        b=Lz1yidtpcSFBccjcog6sQ3BhHf3Df/YVuB5yCHuNEoVhhksgIXbB0Ly9bn5j1L2IS8
         6zfUFHN3jANkjOdSgzAqwIWxUJwA/a8ULOFLWiHZVtLYwjRPscinjlwQQU2Mw5dR6DCo
         9FmEdkSq32QKDsLM640SkbfKlTUF/KWAzMJwgJEpmlhpf2PrD0JZvO2vRhviNtcQHfIT
         blf19Ou1/W0SbSIYTIIIL+nieWrItEQwysb72Sy55L4hytIfuqR1uP06Y4UjRqGTZJkB
         XeqQMXQwDF0LLzS2hZseFKdzLK4p7HumiSC7PbN66/L5ekGqdEH1IRZCmMCtm3atJiqz
         9/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Tfga2ZIOaQmecJLtOonLYGEQXi2C7ktGHqLjiXgGd8=;
        b=kjljZSGO/4YW1wup8gOvDmzHeOj6Id2ay00mKlmcD/qOqsg67pvvzqXU7ptr61zgD6
         CVGJprixPngbLK+kQ6lAz4q+iX+rS8qZ7MdZ5Md5vyFTkeg2JKEgxwMxuy8wKS8hk57g
         p51pOvodmOaxL12A4rqJVWkqM8eWRfEraH1P9FpPCAC71sosXqVyiVBipwnD5sbWgZlm
         HoaCU1IJDlOqaDjWI/1rtaYZa52hm/GzuWNBE0GJBqIGn4+b7VP6IWfATZyTTefiuTYJ
         /jAoOSA4nRu+CcSTwmtm5viVeaSTaa0+OyUXqFYATjHYyyVHBmSCG0mgE6ASDN5sMtZ7
         MVcQ==
X-Gm-Message-State: APjAAAWUpcjZ6wtG/eVr+qRAl2O8rhKSBCdsp8GB6tBedY7hO2D/OflI
        OQfwZMADt9fAIv6bpDlB9coZ17sF
X-Google-Smtp-Source: APXvYqxBm44HCYsoyRZICqffpTSKXt96pXr+A8jekkIHp0DjST8RSJ8rhhWU4v6uZLiqpxl0pnjqZw==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr9930462wrr.72.1572984844689;
        Tue, 05 Nov 2019 12:14:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm645044wmd.29.2019.11.05.12.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 12:14:04 -0800 (PST)
Message-Id: <78bd6bc2c02f1daf13938a738d8eae56b5f6b74c.1572984842.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
References: <pull.450.git.1572969955.gitgitgadget@gmail.com>
        <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 20:14:02 +0000
Subject: [PATCH v2 1/1] commit-graph: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rynus@gmail.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When writing a commit-graph, we show progress along several commit
walks. When we use start_delayed_progress(), the progress line will
only appear if that step takes a decent amount of time.

However, one place was missed: computing generation numbers. This is
normally a very fast operation as all commits have been parsed in a
previous step. But, this is showing up for all users no matter how few
commits are being added.

Now that we changed this method, very fast commands show no progess at
all. This means we need to stop testing for seeing these progress lines
in the test suite.

Reported-by: ryenus <ryenus@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          |  2 +-
 t/t5318-commit-graph.sh |  6 ------
 t/t6500-gc.sh           | 14 --------------
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0aea7b2ae5..071e1c6e9b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1103,7 +1103,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	struct commit_list *list = NULL;
 
 	if (ctx->report_progress)
-		ctx->progress = start_progress(
+		ctx->progress = start_delayed_progress(
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d42b3efe39..8759ff0f3a 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -130,12 +130,6 @@ test_expect_success 'commit-graph write progress off for redirected stderr' '
 	test_line_count = 0 err
 '
 
-test_expect_success 'commit-graph write force progress on for stderr' '
-	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write --progress 2>err &&
-	test_file_not_empty err
-'
-
 test_expect_success 'commit-graph write with the --no-progress option' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write --no-progress 2>err &&
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index c0f04dc6b0..23faa5345f 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -102,20 +102,6 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_line_count = 2 new # There is one new pack and its .idx
 '
 
-test_expect_success 'gc --no-quiet' '
-	git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
-	test_must_be_empty stdout &&
-	test_line_count = 1 stderr &&
-	test_i18ngrep "Computing commit graph generation numbers" stderr
-'
-
-test_expect_success TTY 'with TTY: gc --no-quiet' '
-	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
-	test_must_be_empty stdout &&
-	test_i18ngrep "Enumerating objects" stderr &&
-	test_i18ngrep "Computing commit graph generation numbers" stderr
-'
-
 test_expect_success 'gc --quiet' '
 	git -c gc.writeCommitGraph=true gc --quiet >stdout 2>stderr &&
 	test_must_be_empty stdout &&
-- 
gitgitgadget
