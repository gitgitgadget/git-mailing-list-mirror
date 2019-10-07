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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAE01F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfJGUIk (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47056 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGUIe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so16723229wrv.13
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Je4CCmMQQzS0FTJ62kc7frHtPYGwAv6a1T2RQW3HDH4=;
        b=Hn/CoVtO2W5c1s38kaAl/NQp63avDUiM8eSTjayb8TPazsMp5LH5WmlmeW0CNza+vS
         AjR2wkn1o9FS0DPdaiLyrfXwsGFWugvdG168lT1upPYzftsn3MGs9w4csHuVSmJUw/Sx
         fnTZspw9tOsmix9PX7rOwO/iT1+Xorl9K2+PSk8gDqXAfKMyKfDFvmGlG87bQ72eljrN
         tz4Hed9COIz3Wc6eZ1+YQ7L+QhnIsdgxah6B/4Lf5jH83h860eQcG8gKPWO7MtQ76vvo
         3zSYbrj2E45y/rvZHXtBbaR2OygxqO27nqSEIIVboTXMrv/a34GRR/NBORXmQH0UrSiK
         12Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Je4CCmMQQzS0FTJ62kc7frHtPYGwAv6a1T2RQW3HDH4=;
        b=B8Ld5PPd1CFgF32lvvijb2/or0rIveaNBBh1J0cRNo2yYFyHNoun9Hb4uw/f30M8/n
         8soiBSBcMWh4aSEMMCQ9rtiMOMHvMPD+Qxktxy1qZGG4FXC81hkp1oPptdgAE0mQryMz
         vZhrtm5wt0usHiEWsZjNyek/9QTG/UExDNi0Wzg0BM1xcfsUX/mhQqJTWS6pbPjSzF9m
         UD4VG71RnZOZdX9zr38327K0VuNzInHtNBI6fvNbuaFp/625gPaQqcdd6Le3VuhgiRr3
         NfZx2QIxbWYPc3ZyxF56y69Db3hz68R07cxdGuhCLeax321tIKR3Q8d+GAT1zFn1N8Pq
         dWeQ==
X-Gm-Message-State: APjAAAWerAytgmZCj0+kDjTkGW6RGSzY/i6rn4FdaTYKQ9uMcjr/IRze
        5052j1tFjTU/Hs5jO4R+dgot8pT4
X-Google-Smtp-Source: APXvYqyXKbDwUEFS4+vhuCWWx6vIqDGiiofsYvs9ec32PuWovhGOuzm6PF8IsRUSht/obYwMxnidAg==
X-Received: by 2002:a5d:614c:: with SMTP id y12mr24913325wrt.392.1570478912122;
        Mon, 07 Oct 2019 13:08:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm1157255wma.1.2019.10.07.13.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:31 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:31 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:13 GMT
Message-Id: <0b1ed06bc8c27650086b10b587df943d3053b773.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 05/17] sparse-checkout: add '--stdin' option to set
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Junio C Hamano <gitster@pobox.com>,
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
index 52d4f832f3..68f3d8433e 100644
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

