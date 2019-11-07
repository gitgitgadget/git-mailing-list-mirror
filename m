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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E8971F454
	for <e@80x24.org>; Thu,  7 Nov 2019 17:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbfKGRrE (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 12:47:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36327 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbfKGRrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 12:47:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so4074084wrx.3
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/QyY279sZLZB4OrbtVh4TZ7H0m5WH572NfxLyQ1N6Zw=;
        b=GRXy0jKfVrrIXNJQ7Buh1c5TXh5mRifhKhZPiJnglNmFVcf110oXcDqC4P6oaqyFsN
         pmGpQEkJdWag+aX8grnsOaaYRjXGf+3YHTbTUDsy+gQWUpWkLzCi9PCTZqOLaLq7n18r
         1JMW1jFusYMB8Uvryx2hQc6/HD+8VUw31VtnzjWA1K02MIKP50l3ueLI48I9gzK81r0z
         Rvuk7W6jNGazOdpatsagFERMmFpk+i7C69Vy3kFN89uG7ds522IMSwl+n+ScJh5MsQTU
         4ng8/DvjTd/2oyWfEV+xPjhBQR68BXVw+I3lo+EImDBAQahrqvZ3Fw5afbgBC8PHZW35
         JUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/QyY279sZLZB4OrbtVh4TZ7H0m5WH572NfxLyQ1N6Zw=;
        b=P20sK77ia4YoSlLkirm/QCGKCSMPJFJ3Zmpwcc1+EkR9iEiM+bEC8lO5tCUbKgGzlE
         k2mUCJFussO6MuYA1D5s1v0HmkSJ6N2jobzL7QVmp93kdrCsLzjNaq1JdFE8rXdh66wD
         U17YiMU9nW6FPzI+HuhKduy5uZlW44Svktgro7ipVqMt8zPr9LiAjbz0W2zszBJzo1oJ
         J7kjtazzqhSKsSeoJ+x9linW4/Kz4A+gfbpYr5iovhb6usF+HEqaD2ThhrqD5/TyxACq
         4an37avnGF7oAIcisnf8F/8n6MR828NrkqOimyAhn+AdCK5bHInZpw7PzNynyjQzZLqe
         gMIw==
X-Gm-Message-State: APjAAAX+5mw+bKLvPv8j3faaKm3Mu+YyhSOMKwBUneA00GojLxlBcOX3
        vplgaFdStZkKCgmwaxQJSe7mil79
X-Google-Smtp-Source: APXvYqz4mIrp55bEKrFvd7Dq7vpOTRq6M9Zv8jYrW35rAzGk/FrdbAYHl4q+DB6neNyyObTltxxKNQ==
X-Received: by 2002:adf:8088:: with SMTP id 8mr4023741wrl.230.1573148821205;
        Thu, 07 Nov 2019 09:47:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm2946122wrr.65.2019.11.07.09.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 09:47:00 -0800 (PST)
Message-Id: <3c0c9675e125f9357aeadd76f290413aaa09e4cf.1573148818.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
References: <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
        <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 17:46:58 +0000
Subject: [PATCH v3 2/2] commit-graph: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ryenus@gmail.com, stolee@gmail.com, peff@peff.net,
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

The tests that check for the progress output have already been updated
to use GIT_PROGRESS_DELAY=0 to force the expected output. However, there
is one test in t6500-gc.sh that uses the test_terminal method. This
mechanism does not preserve the GIT_PROGRESS_DELAY environment variable,
so we need to modify check on the output. We still watch for the
"Enumerating objects" progress but no longer look for "Computing
commit graph generation numbers".

Reported-by: ryenus <ryenus@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 2 +-
 t/t6500-gc.sh  | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

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
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 7f79eedd1c..c68177510b 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -111,8 +111,7 @@ test_expect_success 'gc --no-quiet' '
 test_expect_success TTY 'with TTY: gc --no-quiet' '
 	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
 	test_must_be_empty stdout &&
-	test_i18ngrep "Enumerating objects" stderr &&
-	test_i18ngrep "Computing commit graph generation numbers" stderr
+	test_i18ngrep "Enumerating objects" stderr
 '
 
 test_expect_success 'gc --quiet' '
-- 
gitgitgadget
