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
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A731F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfJUN4i (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45824 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfJUN4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so9141540wrs.12
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2sEVfkTntbqY+8J1j4mT+2x+4jgWJVhxafMhzxse4CY=;
        b=EKXSoAjtWyIaClzwZ1lAQrXILzq7VHvUQUuA60kiAG6740DVUpLKnke6IKVI8NL1Ba
         lXEy3plx/v7QxrBUSQXgq/p4uZEuiCcVu3DiRDPGINWbyfDi6whS4ttbeiDVveM2ekSu
         z6nwCJb6+f4JEa9Ou8wcU756kMg8PcaqOeDEHPN75guIt+KUJHS5NUyY2tAxrEbvxKNw
         QnY/0jIb/qNBYbv0MRtO27FM8E+xbWV5kY8sIUe/YuvMZ8DJowuU2fK79ErQ9/tQSxkr
         XlgOe+i8ADueHHdajci4bftV06VuiTt47LZCtDm+9sV0AzvDpdEcmYEgzMvY/r4RzGAi
         q4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2sEVfkTntbqY+8J1j4mT+2x+4jgWJVhxafMhzxse4CY=;
        b=TQcl2mKgwwmjB5CcfMNnVt+zBvLKj5JAKqqO4lvYO5WjRtt9pL95o1h3UGtVEeOEE5
         IxgSWa4VxLSjcGthOjOmjyrDZNy8mnDjCh5YNI5w1UE9Lu19ciAMnWGBnrbx0lJIk8BQ
         8NVVAlVO4/Y/zk8P5IEaxVM2r2dLYNfniMSo+itaWiySkmGXSpDtAP6+1w1x2CRwpg0A
         RSJo59jeI7CPoginm0D49A9t0DYiyaD/JG+fKlAQ++/0ZcRY3jaA42hzoNmSZo116RC3
         Q/NVpzPP1d/YWUCzWf+b23OlNdZRb7KDezQPGtvK41rfgUtUsi4nKjSQmRqdk/iLTKFl
         OxLQ==
X-Gm-Message-State: APjAAAWnfipBWYhNR9HJq2t/9QhnFrZx/PHbt70C9wt4QtPeqA/dpQHA
        IJGI64nP4LVRafWNdPro+cVL60QY
X-Google-Smtp-Source: APXvYqzday6oS5zMeDKiv3tZcczN9e326v9FJyDiiZCTifjUj/ZIutRofcRDF7SiiYnnWZ0y223nTg==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr1421443wru.25.1571666193073;
        Mon, 21 Oct 2019 06:56:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1sm7330947wru.83.2019.10.21.06.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:32 -0700 (PDT)
Message-Id: <0e08898dcb42bd38ca3692b49a7e9f5763150c80.1571666186.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:14 +0000
Subject: [PATCH v5 05/17] sparse-checkout: add '--stdin' option to set
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
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
index 834ee421f0..f2e2bd772d 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -154,6 +154,15 @@ static int write_patterns_and_update(struct pattern_list *pl)
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
 	static const char *empty_base = "";
@@ -161,10 +170,32 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	struct pattern_list pl;
 	int result;
 	int set_config = 0;
+
+	static struct option builtin_sparse_checkout_set_options[] = {
+		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
+			 N_("read patterns from standard in")),
+		OPT_END(),
+	};
+
 	memset(&pl, 0, sizeof(pl));
 
-	for (i = 1; i < argc; i++)
-		add_pattern(argv[i], empty_base, 0, &pl, 0);
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
+			add_pattern(buf, empty_base, 0, &pl, 0);
+		}
+	} else {
+		for (i = 0; i < argc; i++)
+			add_pattern(argv[i], empty_base, 0, &pl, 0);
+	}
 
 	if (!core_apply_sparse_checkout) {
 		sc_set_config(MODE_ALL_PATTERNS);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index bf2dc55bb1..a9ff5eb9ec 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -128,4 +128,24 @@ test_expect_success 'set sparse-checkout using builtin' '
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

