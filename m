Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4791F461
	for <e@80x24.org>; Tue, 20 Aug 2019 15:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbfHTPLM (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 11:11:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40942 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHTPLL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 11:11:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id c3so12798091wrd.7
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3VRcRVACOlgYlOQ/eADT+50ky+UXoPrUB8BgaS1SzMA=;
        b=XG1pXBwizSCbmAGh+nSZA1KJIKWmBzCP9aDmEaRnjJtIkL07Q1kzXtF3KdJ+hMaq0K
         72S50bSMNIFz17btiY4ZqgjL5twpBftlZag/36aZb4L3PmkevVb2kngJwxM7ZIjj5c9+
         uAjQUrUOYj6TEEqGdV/0sEH1/LMijps3X58ZQL8qOgFt/d0QtF6rjVVLtDE8mnjmf4zb
         xN9b0RagIj+Y60B8ClPuUCe8EMk3JEHmVYeKSfpfkMv/nYTwv7vKzKSSEopeA9deSrGg
         gfYyrR4RNDrFmIcilQ5evF3tVq9mws9VwrAsuEai3TCNnHRnRdm4A9MXj3jSZOCjDBN4
         HZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3VRcRVACOlgYlOQ/eADT+50ky+UXoPrUB8BgaS1SzMA=;
        b=okofiabtaYwjSyMB9voCzzjYF0XAPn1GW5f8dNLyNboFDJ3WUQs7hG76oCnxCnBaGT
         6EYaxcUfRfjvTiTNS7jbgBzcM2dOn5F3yL9y7MmVQcL5QzmZViQrsFjdYq3q9deyC+kq
         qFSjujniLc+OZD/8RnVckLNqYbrFs1XoHBiqCOrSuZyooZSlx4q5mPq9+SW1+eP16Nqa
         1+Hd0rP3kj31v7u6SMBJ9f9gSdqeahbTTbda53vDDsW/1TnhkRdAaG0ppzi1wmvBusaC
         TB5QAQ91U5so65FjOKEWyA39gMYgi2lU8merj994HXur6x2OsJIvqSZZUzCqZ4PcEI39
         QniQ==
X-Gm-Message-State: APjAAAWcTktqjQP4IFrTNtiCqllrwslNflEiVJS88bt8eM47Ev3JAoJ6
        JKJQ1FrZB9pEHZGxgTaSocVLZsN4
X-Google-Smtp-Source: APXvYqwozuHIxNJh251+BIixND7CQDJk59PT8szLvo+QsjXy51z+2NnyUMwB2PWkEPmWfz3A4LgPtg==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr33323509wrs.200.1566313869976;
        Tue, 20 Aug 2019 08:11:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm10267521wrq.49.2019.08.20.08.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:11:09 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:11:09 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 15:11:00 GMT
Message-Id: <0f095e85d5bf29346bdc5bf1707bb51eaf2202ae.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/9] sparse-checkout: 'add' subcommand
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

The 'git sparse-checkout add' subcommand takes a list of patterns
over stdin and writes them to the sparse-checkout file. Then, it
updates the working directory using 'git read-tree -mu HEAD'.

Note: if a user adds a negative pattern that would lead to the
removal of a non-empty directory, then Git may not delete that
directory (on Windows).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  4 ++++
 builtin/sparse-checkout.c             | 32 ++++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh    | 20 +++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 50c53ee60a..6f540a3443 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -34,6 +34,10 @@ COMMANDS
 	by Git. Add patterns to the sparse-checkout file to
 	repopulate the working directory.
 
+'add'::
+	Add a set of patterns to the sparse-checkout file, as given over
+	stdin. Updates the working directory to match the new patterns.
+
 SPARSE CHECKOUT
 ----------------
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 86d24e6295..ec6134fecc 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout [init|list]"),
+	N_("git sparse-checkout [init|add|list]"),
 	NULL
 };
 
@@ -166,6 +166,34 @@ static int sparse_checkout_init(int argc, const char **argv)
 	return sc_read_tree();
 }
 
+static int sparse_checkout_add(int argc, const char **argv)
+{
+	struct exclude_list el;
+	char *sparse_filename;
+	FILE *fp;
+	struct strbuf line = STRBUF_INIT;
+
+	memset(&el, 0, sizeof(el));
+
+	sparse_filename = get_sparse_checkout_filename();
+	add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);
+
+	fp = fopen(sparse_filename, "w");
+	write_excludes_to_file(fp, &el);
+
+	while (!strbuf_getline(&line, stdin)) {
+		strbuf_trim(&line);
+		fprintf(fp, "%s\n", line.buf);
+	}
+
+	fclose(fp);
+	free(sparse_filename);
+
+	clear_exclude_list(&el);
+
+	return sc_read_tree();
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -187,6 +215,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_list(argc, argv);
 		if (!strcmp(argv[0], "init"))
 			return sparse_checkout_init(argc, argv);
+		if (!strcmp(argv[0], "add"))
+			return sparse_checkout_add(argc, argv);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b7d5f15830..499bd8d6d0 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -100,4 +100,24 @@ test_expect_success 'clone --sparse' '
 	test_cmp expect dir
 '
 
+test_expect_success 'add to existing sparse-checkout' '
+	echo "/folder2/*" | git -C repo sparse-checkout add &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/*
+		/folder1/*
+		/folder2/*
+	EOF
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
\ No newline at end of file
-- 
gitgitgadget

