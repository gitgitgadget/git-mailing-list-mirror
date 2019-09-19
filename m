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
	by dcvr.yhbt.net (Postfix) with ESMTP id 288E91F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbfISOnS (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:43:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44547 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388953AbfISOnR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id i18so3349971wru.11
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NsKP+NJWULFzo+Nul6WMF/A63W/28C3bXfTdPlDK/1w=;
        b=bYlr8A5Qi1VJ6xMUb5Td7Fx8X7Ya2RJ4SQpM3ZmuYrUaNTd4PFv7d7TBqHMvD7iGCf
         Iwp5g84a3RPtntMq2UZ4z9ePuk/av/QdhbjhHu3ZO6sT9dle5OIBVBgJ27CMgXLcPURQ
         HuAQ3N0TkCML4ZYKL+gz9Yp9LlgQ9/5C9H0OQL6/VeCCDgFMFJQMvQH6ZNVyZ4rg17GS
         b0kT3ujndDbbTa3OHbQds5xbH7a6Hgag6SeNyW2ElrwZKlxAu4DZiIKi2VesD3s6mEP+
         PXuqfuiybUC394oLsvrwtO4Q61vwYVGcrU2e9XUjuGA/HZ3TJU6G3NHk/Brn/1JVgCqJ
         YHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NsKP+NJWULFzo+Nul6WMF/A63W/28C3bXfTdPlDK/1w=;
        b=MfvWd9eoeIbL6g33J+MP2aJbX7jY1slArsfab1bVIOLRRDqSQXP7/IrEP1QK7FIfMK
         9xz+k4aBXGke3qtel8AHOTKBhBEAEKASYhPZ3HzfOByB01vqU6HJNS1ZzvSvneGgUlaz
         m0lmWi7tIocRIgDtNEQLecMVpCZ1VyBgGIgbVBlV3Q9DO0mZJV2wepJ4xXsHZV1ZGgeN
         3VjRufjMGA8Tb6xuV2YMLCxbnRICJKzeR5OTaIHhkdNUYg94TQlzIv0bj7WWLisBBgo5
         nIl4fmCvFPyjRQgCJe5lBrM70llsAVShmTRj5NccPcwWb18++0xC1OXn+d2e3nTYQNds
         ZNAA==
X-Gm-Message-State: APjAAAVe3S1y1YiHLyd43mzKdi01DNTMCP8yiJ5vXLqBrYwUF0MOXwC6
        dpPvRMEw0Y14VYoGv76+6Pw4liKr
X-Google-Smtp-Source: APXvYqx0ZXBRc7jQXbKsbWkEt0+56Nq1Bbsdz4cIiDbJayeM75jktS4z97HeIgX7B5RB0NkGD7R0Ow==
X-Received: by 2002:a5d:500b:: with SMTP id e11mr7458233wrt.285.1568904194344;
        Thu, 19 Sep 2019 07:43:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm9943392wrm.52.2019.09.19.07.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:43:13 -0700 (PDT)
Date:   Thu, 19 Sep 2019 07:43:13 -0700 (PDT)
X-Google-Original-Date: Thu, 19 Sep 2019 14:43:02 GMT
Message-Id: <21a0165be73dccf25c2c83a37d506ec061fd1d07.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
        <pull.316.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 05/11] sparse-checkout: add '--stdin' option to set
 subcommand
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

The 'git sparse-checkout set' subcommand takes a list of patterns
and places them in the sparse-checkout file. Then, it updates the
working directory to match those patterns. For a large list of
patterns, the command-line call can get very cumbersome.

Add a '--stdin' option to instead read patterns over standard in.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 35 ++++++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh | 20 +++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 13333fba6a..f726fcd6b8 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -145,14 +145,45 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	return update_working_directory();
 }
 
+static char const * const builtin_sparse_checkout_set_usage[] = {
+	N_("git sparse-checkout set [--stdin|<patterns>]"),
+	NULL
+};
+
+static struct sparse_checkout_set_opts {
+	int use_stdin;
+} set_opts;
+
 static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct pattern_list pl;
+
+	static struct option builtin_sparse_checkout_set_options[] = {
+		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
+			 N_("read patterns from standard in")),
+		OPT_END(),
+	};
+
 	memset(&pl, 0, sizeof(pl));
 
-	for (i = 1; i < argc; i++)
-		add_pattern(argv[i], NULL, 0, &pl, 0);
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_set_options,
+			     builtin_sparse_checkout_set_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (set_opts.use_stdin) {
+		struct strbuf line = STRBUF_INIT;
+
+		while (!strbuf_getline(&line, stdin)) {
+			size_t len;
+			char *buf = strbuf_detach(&line, &len);
+			add_pattern(buf, buf, len, &pl, 0);
+		}
+	} else {
+		for (i = 0; i < argc; i++)
+			add_pattern(argv[i], argv[i], strlen(argv[i]), &pl, 0);
+	}
 
 	return write_patterns_and_update(&pl);
 }
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index f21ea61494..02ba9ec314 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -120,5 +120,25 @@ test_expect_success 'set sparse-checkout using builtin' '
 	test_cmp expect dir
 '
 
+test_expect_success 'set sparse-checkout using --stdin' '
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		/folder1/
+		/folder2/
+	EOF
+	git -C repo sparse-checkout set --stdin <expect &&
+	git -C repo sparse-checkout list >actual &&
+	test_cmp expect actual &&
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_done
 
-- 
gitgitgadget

