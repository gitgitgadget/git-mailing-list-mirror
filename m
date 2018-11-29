Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07028211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbeK3B3i (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 20:29:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39738 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732523AbeK3B3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so1110776pld.6
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 06:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ucCY9qrEN9WKY9iPyZ8T/2pNVm+tAxugDv6DJWMUAdU=;
        b=fFD9lb8Zt2SRsyHywS+li1t2QOm+xcnHJoA/ymebWc/cNMl7wZ+0RsoJxUkICTgL5w
         DKTdFUDQpsa5fTpQuFY4mDP9X0jYKcxM2euhDyI4BV9bfzvVPBYvmSzZpa5N+mEMhfWt
         S5UkZp2nxqXVGc68ouYJ7iTcnYdgowavhKtEzNqS8QPOVWgKMpa69OY36b6WH9B/d388
         WfXCBihB++Bn0APVTyGPxtBjMiz4UBf/gbrx9IvdBZsSeM6b3fGErefty1NPhyVNR1QA
         NkJj6lIw/iWctb+wNkJCOOfaE+j7kMcYs+k13nn68COEGS5TTPo9Av/uzRt7omdWNVKH
         7oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ucCY9qrEN9WKY9iPyZ8T/2pNVm+tAxugDv6DJWMUAdU=;
        b=b3LQA1pxL2CXqyWF7Atr4iiNL8Xu+OKeN8W7v/moFxJzLXDRfbvwdEwPRqonmFEuvm
         IdxLXh/LoFSLWfU4tKXfEbqP9OvUiUE8q9IexEk+0ToW+geCYvYX9mEN8Oc09/fB3mwf
         Hlg8PbIFOFOHGIX8hxXLz1LmjKBj0/9Icd5EPtKmQXuEehJR+4eUndlkOgIbU18wWHXC
         fvIMaB9luz6G/0jf1Wgz7FYoTUBA6U2kpFz8jOJeFD06h/7rcN0VBT8OdU+52fzPHwke
         zO2bOMXiORlMmoe/e4TQ39bwBOJ2Z2goIcWgsm7/0OyjtgjVX5gjg3WcpcLo9hJ41Wc8
         v2lw==
X-Gm-Message-State: AA+aEWaf1/mDrMbdb1EdKRokGYXu3d+WobkJMsuHIbmcXEVCdWGCunQ3
        xXF0o1AovrBR1tLUuf3MNgMujBGG
X-Google-Smtp-Source: AFSGD/XQvZnDLnMWpQ3bj2IFkts6p4wHjCBTYmMghMvk6rPDZNmre5szW41THmD/KvfHPW1J8ekyvg==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr1680966plr.15.1543501445333;
        Thu, 29 Nov 2018 06:24:05 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id a17sm2833987pgm.26.2018.11.29.06.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:24:04 -0800 (PST)
Date:   Thu, 29 Nov 2018 06:24:04 -0800 (PST)
X-Google-Original-Date: Thu, 29 Nov 2018 14:23:55 GMT
Message-Id: <9644f6ff0446e79c6840ccd5deba9ef6895ef82b.1543501438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v2.git.gitgitgadget@gmail.com>
References: <pull.89.git.gitgitgadget@gmail.com>
        <pull.89.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/6] pack-objects: add --sparse option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a '--sparse' option flag to the pack-objects builtin. This
allows the user to specify that they want to use the new logic
for walking trees. This logic currently does not differ from the
existing output, but will in a later change.

Create a new test script, t5322-pack-objects-sparse.sh, to ensure
the object list that is selected matches what we expect. When we
update the logic to walk in a sparse fashion, the final test will
be updated to show the extra objects that are added.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-pack-objects.txt |   9 ++-
 builtin/pack-objects.c             |   5 +-
 t/t5322-pack-objects-sparse.sh     | 115 +++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100755 t/t5322-pack-objects-sparse.sh

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 40c825c381..ced2630eb3 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
 	[--stdout [--filter=<filter-spec>] | base-name]
-	[--shallow] [--keep-true-parents] < object-list
+	[--shallow] [--keep-true-parents] [--sparse] < object-list
 
 
 DESCRIPTION
@@ -196,6 +196,13 @@ depth is 4095.
 	Add --no-reuse-object if you want to force a uniform compression
 	level on all data no matter the source.
 
+--sparse::
+	Use the "sparse" algorithm to determine which objects to include in
+	the pack. This can have significant performance benefits when computing
+	a pack to send a small change. However, it is possible that extra
+	objects are added to the pack-file if the included commits contain
+	certain types of direct renames.
+
 --thin::
 	Create a "thin" pack by omitting the common objects between a
 	sender and a receiver in order to reduce network transfer. This
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5f70d840a7..7d5b0735e3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -84,6 +84,7 @@ static unsigned long pack_size_limit;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
+static int sparse;
 static int thin;
 static int num_preferred_base;
 static struct progress *progress_state;
@@ -3135,7 +3136,7 @@ static void get_object_list(int ac, const char **av)
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
-	mark_edges_uninteresting(&revs, show_edge, 0);
+	mark_edges_uninteresting(&revs, show_edge, sparse);
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
@@ -3292,6 +3293,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, N_("time"),
 		  N_("unpack unreachable objects newer than <time>"),
 		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
+		OPT_BOOL(0, "sparse", &sparse,
+			 N_("use the sparse reachability algorithm")),
 		OPT_BOOL(0, "thin", &thin,
 			 N_("create thin packs")),
 		OPT_BOOL(0, "shallow", &shallow,
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
new file mode 100755
index 0000000000..81f6805bc3
--- /dev/null
+++ b/t/t5322-pack-objects-sparse.sh
@@ -0,0 +1,115 @@
+#!/bin/sh
+
+test_description='pack-objects object selection using sparse algorithm'
+. ./test-lib.sh
+
+test_expect_success 'setup repo' '
+	test_commit initial &&
+	for i in $(test_seq 1 3)
+	do
+		mkdir f$i &&
+		for j in $(test_seq 1 3)
+		do
+			mkdir f$i/f$j &&
+			echo $j >f$i/f$j/data.txt
+		done
+	done &&
+	git add . &&
+	git commit -m "Initialized trees" &&
+	for i in $(test_seq 1 3)
+	do
+		git checkout -b topic$i master &&
+		echo change-$i >f$i/f$i/data.txt &&
+		git commit -a -m "Changed f$i/f$i/data.txt"
+	done &&
+	cat >packinput.txt <<-EOF &&
+	topic1
+	^topic2
+	^topic3
+	EOF
+	git rev-parse			\
+		topic1			\
+		topic1^{tree}		\
+		topic1:f1		\
+		topic1:f1/f1		\
+		topic1:f1/f1/data.txt | sort >expect_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp expect_objects.txt nonsparse_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
+# Demonstrate that both algorithms send "extra" objects because
+# they are not in the frontier.
+
+test_expect_success 'duplicate a folder from f3 and commit to topic1' '
+	git checkout topic1 &&
+	echo change-3 >f3/f3/data.txt &&
+	git commit -a -m "Changed f3/f3/data.txt" &&
+	git rev-parse			\
+		topic1~1		\
+		topic1~1^{tree}		\
+		topic1^{tree}		\
+		topic1			\
+		topic1:f1		\
+		topic1:f1/f1		\
+		topic1:f1/f1/data.txt	\
+		topic1:f3		\
+		topic1:f3/f3		\
+		topic1:f3/f3/data.txt | sort >expect_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp expect_objects.txt nonsparse_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
+test_expect_success 'duplicate a folder from f1 into f3' '
+	mkdir f3/f4 &&
+	cp -r f1/f1/* f3/f4 &&
+	git add f3/f4 &&
+	git commit -m "Copied f1/f1 to f3/f4" &&
+	cat >packinput.txt <<-EOF &&
+	topic1
+	^topic1~1
+	EOF
+	git rev-parse		\
+		topic1		\
+		topic1^{tree}	\
+		topic1:f3 | sort >expect_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp expect_objects.txt nonsparse_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
+test_done
-- 
gitgitgadget

