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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD6F1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbfISOnQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:43:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35820 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732731AbfISOnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so3413279wrt.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tY9no7uCVYsWIVfnFrKCm9fkPc8W4i/uAAQr+UiOhA8=;
        b=o8v+nGO4PuKXgonNulbS99Jxdiw4xOfmy7uBkCjOv7FRVSxP2sbHq+yi/tCKBXaUYp
         ANQpV+vvb0G9+Xz/uh1sQBwcMHke+/Bmv0J7Z+0p1/u5E6W/kL88Bx/aQ2uqQ4ffRRNh
         4FPeRVBKKIpYKHqVulTBVzQYN8ADPoVxyh4iT1HyvBR/Sdi6vjbNo7JkVG/wAQtYqlM6
         MW0dBZfqF5U+mU/qx3f/zYNazZSwz/olGG+/rHTcaVNV65T9cxE74eKJhGCRXk8b9dvx
         bjp6uVIFYwVC+B8sdhxOwmyGNJYnIquW6v9sfty8oVwqjrpHBnprPbH3ElGFO8wLdln+
         zzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tY9no7uCVYsWIVfnFrKCm9fkPc8W4i/uAAQr+UiOhA8=;
        b=eq4BNHaRCF8FFSCh4GQrXCHlBp07/hkpqfY2PFkB+RxVOEtHo21hDSg1jagdGh+Wta
         lOgJcc8sgYpjsiZxYc0lSlXF5x41dmZTsQUka62ovM1V0/xz+wtRESZFepE+t60k42Tx
         gpxRDiHENz1ObcDpUYz6kUtOjGS53IXJL5+se/WIT9IoE6BkV3GmYX6zUi1AnjHbOwpL
         FuBhnOGknBuhfjdUXr/oReAl3lL8UDsOIGwNL2FulGNquZYn+j+o5J931I5knx4z5wRH
         ugMEGy798J+OAgL7cZ1v6/1xJUW/8S/EdtFAPy7IWyWPhCvcQHFcXoClHpqxExp4f0qa
         kOxw==
X-Gm-Message-State: APjAAAWMOtpVgQon39Urvt5l2KYwjuipi/PEM1qPNwAlOgC8mkEkQdWq
        SMz54z0zpUmYiGpTV5TY1ZMw7enm
X-Google-Smtp-Source: APXvYqwsOqviQcclOTfY4Ca2iw4/WM67uRZCftL3nsLimPPCCmlEeGTY86u8pkWku+W4yF9j/e716A==
X-Received: by 2002:a5d:6812:: with SMTP id w18mr7236777wru.250.1568904191917;
        Thu, 19 Sep 2019 07:43:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f143sm11058535wme.40.2019.09.19.07.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:43:11 -0700 (PDT)
Date:   Thu, 19 Sep 2019 07:43:11 -0700 (PDT)
X-Google-Original-Date: Thu, 19 Sep 2019 14:42:59 GMT
Message-Id: <412211f5dd6d4d995f258403bf377bc0cb6332b4.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
        <pull.316.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 02/11] sparse-checkout: create 'init' subcommand
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

Getting started with a sparse-checkout file can be daunting. Help
users start their sparse enlistment using 'git sparse-checkout init'.
This will set 'core.sparseCheckout=true' in their config, write
an initial set of patterns to the sparse-checkout file, and update
their working directory.

Using 'git read-tree' to clear directories does not work cleanly
on Windows, so manually delete directories that are tracked by Git
before running read-tree.

The use of running another process for 'git read-tree' is likely
suboptimal, but that can be improved in a later change, if valuable.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  7 +++
 builtin/sparse-checkout.c             | 69 ++++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh    | 41 ++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index cdef451642..9707ef93b1 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -26,6 +26,13 @@ COMMANDS
 'list'::
 	Provide a list of the contents in the sparse-checkout file.
 
+'init'::
+	Enable the `core.sparseCheckout` setting. If the
+	sparse-checkout file does not exist, then populate it with
+	patterns that match every file in the root directory and
+	no other directories, then will remove all directories tracked
+	by Git. Add patterns to the sparse-checkout file to
+	repopulate the working directory.
 
 SPARSE CHECKOUT
 ----------------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index eed9625a05..895479970d 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout [list]"),
+	N_("git sparse-checkout [init|list]"),
 	NULL
 };
 
@@ -59,6 +59,71 @@ static int sparse_checkout_list(int argc, const char **argv)
 	return 0;
 }
 
+static int update_working_directory(void)
+{
+	struct argv_array argv = ARGV_ARRAY_INIT;
+	int result = 0;
+	argv_array_pushl(&argv, "read-tree", "-m", "-u", "HEAD", NULL);
+
+	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+		error(_("failed to update index with new sparse-checkout paths"));
+		result = 1;
+	}
+
+	argv_array_clear(&argv);
+	return result;
+}
+
+static int sc_enable_config(void)
+{
+	struct argv_array argv = ARGV_ARRAY_INIT;
+
+	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
+		error(_("failed to set extensions.worktreeConfig setting"));
+		return 1;
+	}
+
+	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", "true", NULL);
+
+	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+		error(_("failed to enable core.sparseCheckout"));
+		return 1;
+	}
+
+	return 0;
+}
+
+static int sparse_checkout_init(int argc, const char **argv)
+{
+	struct pattern_list pl;
+	char *sparse_filename;
+	FILE *fp;
+	int res;
+
+	if (sc_enable_config())
+		return 1;
+
+	memset(&pl, 0, sizeof(pl));
+
+	sparse_filename = get_sparse_checkout_filename();
+	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
+
+	/* If we already have a sparse-checkout file, use it. */
+	if (res >= 0) {
+		free(sparse_filename);
+		goto reset_dir;
+	}
+
+	/* initial mode: all blobs at root */
+	fp = fopen(sparse_filename, "w");
+	free(sparse_filename);
+	fprintf(fp, "/*\n!/*/\n");
+	fclose(fp);
+
+reset_dir:
+	return update_working_directory();
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -79,6 +144,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 	if (argc > 0) {
 		if (!strcmp(argv[0], "list"))
 			return sparse_checkout_list(argc, argv);
+		if (!strcmp(argv[0], "init"))
+			return sparse_checkout_init(argc, argv);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 46e7b2dded..a6c6b336c9 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -47,5 +47,46 @@ test_expect_success 'git sparse-checkout list (populated)' '
 	test_cmp expect list
 '
 
+test_expect_success 'git sparse-checkout init' '
+	git -C repo sparse-checkout init &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	git -C repo config --list >config &&
+	test_i18ngrep "core.sparsecheckout=true" config &&
+	ls repo >dir  &&
+	echo a >expect &&
+	test_cmp expect dir
+'
+
+test_expect_success 'git sparse-checkout list after init' '
+	git -C repo sparse-checkout list >actual &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'init with existing sparse-checkout' '
+	echo "*folder*" >> repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout init &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		*folder*
+	EOF
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

