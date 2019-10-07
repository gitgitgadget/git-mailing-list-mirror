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
	by dcvr.yhbt.net (Postfix) with ESMTP id D13041F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfJGUIc (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37852 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGUIc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so15830788wro.4
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9xaRfSPSp1KVSsHRsi1eCK8euya00RrOMUVtA6kzZsY=;
        b=IAwlwJWkKHfzQ4aKu66312uBVOR4ACYT439vdyH4AjEixvRpYUZzPTH9JPI0hXxlEX
         DLhWJSCy88WyhVgOfwi0mHfe2Nr6pEEKVEWZB32PSNPxNe27fZg9+2/dNC2Udexcga7K
         g+uJwRdCNPKy44JMRxEOJX97Xh4yTVex9HUqgbwHME1G/dw9tIwrL1NQE9HBsRWwVIEb
         WNhVjYHBazCMpF8ujkwW3nYNWfuNZRPjBl7rTFeg40MnT7lz9QP1P/MC7NOuociqzxTE
         f0u85JVNyhRhhQq8wBuZ5PV9XjiFy5DRHmBo97/Hz8yZyVBfX8fApzn9u1vAjuBtbi0c
         TG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9xaRfSPSp1KVSsHRsi1eCK8euya00RrOMUVtA6kzZsY=;
        b=LNMjACqDIJYAez0isZI3pSQy2HZvDwtj1aprrLnjOZ8LrEvnVYt9RjfhPV90J9jN96
         Xyz0YjHh0WXa+sGd7nrhlsjIpDcqmISJabemfSemninFXQuTDWRAVnO28HH7+ymMcOWe
         I3uxu/unD++66F/j6HVtc6lExlLU/Plf4JshKsWyMh91KB6w7AH2CSwup3SwdlM2Hsb7
         hPZZKGqQkFc6cn1xozlGRtVIu7/DQSMd31ZDFv8mCC8qcGD1ONiAGWSbMIeXhuRuiIdb
         aAEC0v2o0JY+Ypa5ClwsVClAF75nke8qcYP6hlJk0JRkIPWVYRt+e5AX4fgVaE3VkhKj
         AniQ==
X-Gm-Message-State: APjAAAWcP1H19+EE1ISZ8UZRYMb6oipcYkpRy2cxqLjEjm0383i1QYBL
        OVFHFLondsnz1R0s7pVGhLouScKg
X-Google-Smtp-Source: APXvYqwUMA/kww/idP3veXTIEp2tB9AT2QHwEPthGO5gYtjO0l1/GINaC/tLd3dmZcE6eQTFYywe+Q==
X-Received: by 2002:adf:f00d:: with SMTP id j13mr5718wro.140.1570478910177;
        Mon, 07 Oct 2019 13:08:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm35050217wrp.72.2019.10.07.13.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:29 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:29 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:11 GMT
Message-Id: <c8587a1fb0e335f9cbafdbb44b20d02a1e57886b.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 03/17] clone: add --sparse mode
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

When someone wants to clone a large repository, but plans to work
using a sparse-checkout file, they either need to do a full
checkout first and then reduce the patterns they included, or
clone with --no-checkout, set up their patterns, and then run
a checkout manually. This requires knowing a lot about the repo
shape and how sparse-checkout works.

Add a new '--sparse' option to 'git clone' that initializes the
sparse-checkout file to include the following patterns:

	/*
	!/*/

These patterns include every file in the root directory, but
no directories. This allows a repo to include files like a
README or a bootstrapping script to grow enlistments from that
point.

During the 'git sparse-checkout init' call, we must first look
to see if HEAD is valid, since 'git clone' does not have a valid
HEAD. The first checkout will create the HEAD ref and update the
working directory correctly.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-clone.txt        |  8 +++++++-
 builtin/clone.c                    | 27 +++++++++++++++++++++++++++
 builtin/sparse-checkout.c          |  6 ++++++
 t/t1091-sparse-checkout-builtin.sh | 13 +++++++++++++
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 5fc97f14de..03299a8adb 100644
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
index a693e6ca44..16f4e8b6fd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -58,6 +58,7 @@ static const char *real_git_dir;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
 static int option_progress = -1;
+static int option_sparse_checkout;
 static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
@@ -145,6 +146,8 @@ static struct option builtin_clone_options[] = {
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
 		    N_("any cloned submodules will use their remote-tracking branch")),
+	OPT_BOOL(0, "sparse", &option_sparse_checkout,
+		    N_("initialize sparse-checkout file to include only files at root")),
 	OPT_END()
 };
 
@@ -723,6 +726,27 @@ static void update_head(const struct ref *our, const struct ref *remote,
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
@@ -1096,6 +1120,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
+	if (option_sparse_checkout && git_sparse_checkout_init(repo))
+		return 1;
+
 	remote = remote_get(option_origin);
 
 	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 64b2bb2b8c..3ecb7ac2e7 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -109,6 +109,7 @@ static int sparse_checkout_init(int argc, const char **argv)
 	char *sparse_filename;
 	FILE *fp;
 	int res;
+	struct object_id oid;
 
 	if (sc_set_config(MODE_FULL))
 		return 1;
@@ -130,6 +131,11 @@ static int sparse_checkout_init(int argc, const char **argv)
 	fprintf(fp, "/*\n!/*/\n");
 	fclose(fp);
 
+	if (get_oid("HEAD", &oid)) {
+		/* assume we are in a fresh repo */
+		return 0;
+	}
+
 reset_dir:
 	return update_working_directory();
 }
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index c70085a759..d4c145a3af 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -88,4 +88,17 @@ test_expect_success 'init with existing sparse-checkout' '
 	test_cmp expect dir
 '
 
+test_expect_success 'clone --sparse' '
+	git clone --sparse repo clone &&
+	git -C clone sparse-checkout list >actual &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+	EOF
+	test_cmp expect actual &&
+	ls clone >dir &&
+	echo a >expect &&
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget

