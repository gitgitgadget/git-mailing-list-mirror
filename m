Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611211F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbfJON4U (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42850 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732229AbfJON4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so23955641wrw.9
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sbqfr14ljiQdEHzoxIMfYq8TVI0ccHxQcsgVJEgnitI=;
        b=eg8MKP6cqQZNRGX1nH3WLTnnOncgIFIbT9QbIJ9KxhKGpghfClNxCRZqL2mWsT3i6U
         zzimS7aiC3rJYWnRype57EAC0GRyPSfuSENMw/hwzkQp99HlJTStO/JPYK57Jhc/n9on
         PEWgcJt8p/PZMxSOMHVjHQi2H62oP7pVw5CKZBwo3kPqq/GzG/j4DMUcZscsPxggmto2
         4F36AzH17VBMQSoiTYUOnSB7qnV1yUbYE/SbX8C4fs9U8cAiqtaZvfgm8xQeqBv72N++
         tUFLKWPkTsbbDp43NfGgnv511LhDfkrSb9ECTGycQAHEDNIAuxgXdu8W+UvGU6w66Vfe
         GxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sbqfr14ljiQdEHzoxIMfYq8TVI0ccHxQcsgVJEgnitI=;
        b=gajY7Jlc4a39mg8eo+Khg8e8ICV4njrUzhBSZJdyAPG6bwiM6SZvnUYVjYDEYf04uO
         X3vvZA7QZTFQLhN9b4Uu8Agk3+iUFd9W4xHi2BE4iO1fsu7w20fvU7SS79e3KA2usx0Y
         YQnkF4UAaA07bQ4Vrlc07i9eyJ659MixZN9QdsmP65srM8P1Ccm7OatiIEuLflOoEinr
         lZglYc0CHesCTJr7FRAvtyX285v4e+iINaw4zbCxmrfkwmaizjNK6pU3SkqQiXrXwhED
         UGV1gbQTHF6jitK1E2hibYRw8IP0uNV3AxSMQM8Vu46tJ2ZFLH6jADEDYhc24DzsQGDu
         rSuw==
X-Gm-Message-State: APjAAAXB2z4ggkrMwpGTfbOMi6+1yOH1FCsbJNvj/YoXANTYv/qmY7VT
        2sAkSZgoIR4SfJHgumbvoc0Bm8yZ
X-Google-Smtp-Source: APXvYqyD6DMk9Sn7XKQUmee54kHNui53IRf8ozoVhTNguPJ0ABkf0eMbYX+InPOd/IW1iMGRYmK2hQ==
X-Received: by 2002:adf:f508:: with SMTP id q8mr25908838wro.98.1571147771605;
        Tue, 15 Oct 2019 06:56:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o70sm29821016wme.29.2019.10.15.06.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:11 -0700 (PDT)
Message-Id: <2852cf8e11c73b1537cbfec969d1026a389fedc6.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:55:52 +0000
Subject: [PATCH v4 05/17] sparse-checkout: add '--stdin' option to set
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
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
 builtin/sparse-checkout.c          | 40 ++++++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh | 27 ++++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 2103cbe00c..b747b78d34 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -145,6 +145,11 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	char *sparse_filename;
 	FILE *fp;
 
+	if (!core_apply_sparse_checkout) {
+		warning(_("core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect"));
+		warning(_("run 'git sparse-checkout init' to enable the sparse-checkout feature"));
+	}
+
 	sparse_filename = get_sparse_checkout_filename();
 	fp = fopen(sparse_filename, "w");
 	write_patterns_to_file(fp, pl);
@@ -154,16 +159,47 @@ static int write_patterns_and_update(struct pattern_list *pl)
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
 	int i;
 	struct pattern_list pl;
 	int result;
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
 
 	result = write_patterns_and_update(&pl);
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 19e8673c6b..2a0137fde3 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -101,6 +101,13 @@ test_expect_success 'clone --sparse' '
 	test_cmp expect dir
 '
 
+test_expect_success 'warn if core.sparseCheckout is disabled' '
+	test_when_finished git -C repo config --worktree core.sparseCheckout true &&
+	git -C repo config --worktree core.sparseCheckout false &&
+	git -C repo sparse-checkout set folder1 2>err &&
+	test_i18ngrep "core.sparseCheckout is disabled" err
+'
+
 test_expect_success 'set sparse-checkout using builtin' '
 	git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
 	cat >expect <<-EOF &&
@@ -120,4 +127,24 @@ test_expect_success 'set sparse-checkout using builtin' '
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

