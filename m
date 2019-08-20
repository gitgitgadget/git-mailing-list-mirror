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
	by dcvr.yhbt.net (Postfix) with ESMTP id CEFA21F461
	for <e@80x24.org>; Tue, 20 Aug 2019 15:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfHTPLN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 11:11:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33644 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbfHTPLM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 11:11:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so12796736wrr.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 08:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XW4yOBVxxnnTC4E5oeBcGg2phElMq0bBPlgm2gjgFp0=;
        b=H1OmHdNhJN0qNSM9rRdlMgGOVsP/P8N6FSFe0B9F/U3+4pRsOaaUZXZZYf39caCJ3i
         7QspssE6e25q09BwC3vP9ipndxnd4isuEvcIUnFVJaFR4PDvdcjg7GwbjPG5CK3EqsPC
         KtDyN/suwxljoI2kB8FFUuAA6MM0Pj6DA0s9xQnuHFBKkZDWMhIcEbhRrHZguBza//4o
         xhU+MYKapRTiyyEYWKVwblPck42ydFysIg3eujaQVQZSlcJcewwWGKtQdBjCTjeq5pkM
         KopYAW0KnuEdxTrsCGwTS697Eh2ypxx9u5Om2mmhX6u7nuQPXDKzsTPGrOC3zu6qe04T
         zQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XW4yOBVxxnnTC4E5oeBcGg2phElMq0bBPlgm2gjgFp0=;
        b=GxoiMfpjYtpcglJy0Fy++NL9cHPA8xAWJQs90fvkv7b3FQqSjEhLaHpYRZzVUxGymT
         ROUMzhuIV8KIpx7ex7+0czdYhsLxuNBo1LDqdg1f96hY8xjEC5UoSDAu7U2hrJg4srDE
         JTPWYrRuXrmmc0vcQpPlQs9qHfDDlDiFx00C8Bm1ScX9bvswUeCuHEjFPcfEJLlrzfd4
         62a7Y/y2DZWa57EKHs+Q1YXgV20iwKWkIZi5MsQ7s4HWFzIixlIdulgdStj9VFihoSCo
         30i0GuwbWkEYk3DfFrIlh5cYo5IO8jacpnf7IWIxXZw0OrYwco4No8mn2kUQDnpZc/cB
         RAEA==
X-Gm-Message-State: APjAAAUlfQ6ConbaOIs24vPUyDq+bEq3NQKIwS3RP4cjEeyPrWdztzFG
        2vVV7jUnO9x+1ig7c51jZOAkYuO4
X-Google-Smtp-Source: APXvYqzuRxlIEKRuQvZQ0CPkm6otkQ/noRSWouUsWGaG2V/fd2P9HVQ7BzfqFaeiFB+mq8NewkVPrg==
X-Received: by 2002:a5d:66c8:: with SMTP id k8mr29326576wrw.7.1566313869244;
        Tue, 20 Aug 2019 08:11:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm14466239wru.56.2019.08.20.08.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:11:08 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:11:08 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 15:10:59 GMT
Message-Id: <4ccd36b3966b62934cfbb0ec65e2851b50dfa1e3.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/9] clone: add --sparse mode
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

When someone wants to clone a large repository, but plans to work
using a sparse-checkout file, they either need to do a full
checkout first and then reduce the patterns they included, or
clone with --no-checkout, set up their patterns, and then run
a checkout manually. This requires knowing a lot about the repo
shape and how sparse-checkout works.

Add a new '--sparse' option to 'git clone' that initializes the
sparse-checkout file to include the following patterns:

	/*
	!/*/*

These patterns include every file in the root directory, but
no directories. This allows a repo to include files like a
README or a bootstrapping script to grow enlistments from that
point.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-clone.txt        |  8 +++++++-
 builtin/clone.c                    | 27 +++++++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 13 +++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 34011c2940..0fe91d2f04 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
-	  [--[no-]remote-submodules] [--jobs <n>] [--] <repository>
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -156,6 +156,12 @@ objects from the source repository into a pack in the cloned repository.
 	used, neither remote-tracking branches nor the related
 	configuration variables are created.
 
+--sparse::
+	Initialize the sparse-checkout file so the working
+	directory starts with only the files in the root
+	of the repository. The sparse-checkout file can be
+	modified to grow the working directory as needed.
+
 --mirror::
 	Set up a mirror of the source repository.  This implies `--bare`.
 	Compared to `--bare`, `--mirror` not only maps local branches of the
diff --git a/builtin/clone.c b/builtin/clone.c
index f665b28ccc..d6d49a73ff 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -60,6 +60,7 @@ static const char *real_git_dir;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
 static int option_progress = -1;
+static int option_sparse_checkout;
 static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
@@ -147,6 +148,8 @@ static struct option builtin_clone_options[] = {
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
 		    N_("any cloned submodules will use their remote-tracking branch")),
+	OPT_BOOL(0, "sparse", &option_sparse_checkout,
+		    N_("initialize sparse-checkout file to include only files at root")),
 	OPT_END()
 };
 
@@ -734,6 +737,27 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	}
 }
 
+static int git_sparse_checkout_init(const char *repo)
+{
+	struct argv_array argv = ARGV_ARRAY_INIT;
+	int result = 0;
+	argv_array_pushl(&argv, "-C", repo, "sparse-checkout", "init", NULL);
+
+	/*
+	 * We must apply the setting in the current process
+	 * for the later checkout to use the sparse-checkout file.
+	 */
+	core_apply_sparse_checkout = 1;
+
+	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+		error(_("failed to initialize sparse-checkout"));
+		result = 1;
+	}
+
+	argv_array_clear(&argv);
+	return result;
+}
+
 static int checkout(int submodule_progress)
 {
 	struct object_id oid;
@@ -1107,6 +1131,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
+	if (option_sparse_checkout && git_sparse_checkout_init(repo))
+		return 1;
+
 	remote = remote_get(option_origin);
 
 	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 35ab84aabd..b7d5f15830 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -87,4 +87,17 @@ test_expect_success 'init with existing sparse-checkout' '
 	test_cmp expect dir
 '
 
+test_expect_success 'clone --sparse' '
+	git clone --sparse repo clone &&
+	git -C clone sparse-checkout list >actual &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/*
+	EOF
+	test_cmp expect actual &&
+	ls clone >dir &&
+	echo a >expect &&
+	test_cmp expect dir
+'
+
 test_done
\ No newline at end of file
-- 
gitgitgadget

