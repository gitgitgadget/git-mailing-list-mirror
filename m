Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63ABD1F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfEHPyH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:54:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36075 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfEHPyD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:54:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so22554565edx.3
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WsRNcJK8GGBuJ90Z6b3C1CG5jx2U4VhncZjrHtsrf+U=;
        b=BL9isbYgaoTWDE1FV1G+J6bibYEzvHzyzzBB+ko1hCYYjNAqY4wPuVw72DlRk2V3HS
         ui6fSobdLqBRtGVe+oiQwGI8XJUy4yojV/znXVqK2tUl5WKIk+xSvEPNB4Xfo4eV0ATN
         VO9mAKj92GOwCADt/qvDPG5mjZkK1sQYTl2TJHRvglsPuRrOqBo2nkJ7TuqmDeHljikB
         V04syPfZ4lBOonSarfO4j4w3nRr5znfZ1kN9Q5FfVBCWmCerE1CaPBm+VfismdfaQbnJ
         XhgnP4ujk6avr8c8FZqH0Z9wR1TtjRtc1BWovxuOo1DikDLGXMI03yx3zOF/9HSKCKgl
         2tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WsRNcJK8GGBuJ90Z6b3C1CG5jx2U4VhncZjrHtsrf+U=;
        b=jqDYpXKMiaR1wIDwRo2qqBDlIQqKZzvvGqTq5JvWtIjFn4kfc8QQYUwub1ocPklicr
         qYm2jfWklG8OtA6Ed+KKElbVhg6RasBlvJX8kD5g5mEXRG2FV/Ct1H1k8MSJlYKq75NV
         nDZcvzaaPx+Zn1midmUfVcm9ZaZvCt7j2U6srKeOqXiGQ20sM3L0XKfXDj4UrHsu138K
         pM+Q/yjPDLlCiAlaJWhfymy1sZDX2W8t0N1nLXSc7d/5G7knmjRgXWPctjKY4Q65bvaH
         0Zd2p9k68euTI5cFJ5ALOkjHZpjq0ApaQRcYucMOOyb8Q4T4gUacrCjtdITaX0LG/W4E
         pTow==
X-Gm-Message-State: APjAAAW+MX2Ie6o1H5i80Z06p7NLGDG2Rve+zcFTC+8S7JmxRo4CDJdg
        RCz7v4QRv0ZKlg3qwBmQdOuo6vZ54ko=
X-Google-Smtp-Source: APXvYqxpJyANhJYyGoKu/Gjbib1qGKz77NDh4+a/+bAn4sGsGzfWetoGtV46DAkppfQwGa6Ejr+jBQ==
X-Received: by 2002:a50:ce06:: with SMTP id y6mr40706519edi.160.1557330841735;
        Wed, 08 May 2019 08:54:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm2774236eja.61.2019.05.08.08.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:54:01 -0700 (PDT)
Date:   Wed, 08 May 2019 08:54:01 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:45 GMT
Message-Id: <7c5bc06d14b6c500c3e08f3366da4e1d8ca6133f.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 16/17] commit-graph: add --split option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c  | 10 +++++++---
 t/t5318-commit-graph.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 828b1a713f..c2c07d3917 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,7 +10,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph verify [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -25,7 +25,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -35,9 +35,9 @@ static struct opts_commit_graph {
 	int stdin_packs;
 	int stdin_commits;
 	int append;
+	int split;
 } opts;
 
-
 static int graph_verify(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
@@ -156,6 +156,8 @@ static int graph_write(int argc, const char **argv)
 			N_("start walk at commits listed by stdin")),
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
+		OPT_BOOL(0, "split", &opts.split,
+			N_("allow writing an incremental commit-graph file")),
 		OPT_END(),
 	};
 
@@ -169,6 +171,8 @@ static int graph_write(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 	if (opts.append)
 		flags |= COMMIT_GRAPH_APPEND;
+	if (opts.split)
+		flags |= COMMIT_GRAPH_SPLIT;
 
 	read_replace_refs = 0;
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d621608500..9dfd4cc9b1 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -260,6 +260,32 @@ test_expect_success 'check that gc computes commit-graph' '
 	test_cmp_bin commit-graph-after-gc $objdir/info/commit-graph
 '
 
+test_expect_success 'write split commit-graph' '
+	cd "$TRASH_DIRECTORY" &&
+	git clone full split &&
+	cd split &&
+	git config core.commitGraph true &&
+	for i in $(test_seq 1 20); do
+		test_commit padding-$i
+	done &&
+	git commit-graph write --reachable &&
+	test_commit split-commit &&
+	git branch -f split-commit &&
+	git commit-graph write --reachable --split &&
+	test_path_is_file .git/objects/info/commit-graphs/commit-graph-1
+'
+
+graph_git_behavior 'split graph, split-commit vs merge 1' bare split-commit merge/1
+
+test_expect_success 'collapse split commit-graph' '
+	cd "$TRASH_DIRECTORY/split" &&
+	git commit-graph write --reachable &&
+	test_path_is_missing .git/objects/info/commit-graphs/commit-graph-1 &&
+	test_path_is_file .git/objects/info/commit-graph
+'
+
+graph_git_behavior 'collapsed graph, split-commit vs merge 1' bare split-commit merge/1
+
 test_expect_success 'replace-objects invalidates commit-graph' '
 	cd "$TRASH_DIRECTORY" &&
 	test_when_finished rm -rf replace &&
-- 
gitgitgadget

