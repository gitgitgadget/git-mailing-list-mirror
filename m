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
	by dcvr.yhbt.net (Postfix) with ESMTP id 834DA1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfJON4N (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36011 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731638AbfJON4M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so24018359wrd.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IDJLgUcuXx7kJKCn0IXiTlobAsQGl6O0L29bq/w2B5U=;
        b=BLjyeEIysB9nD51mk89jxyWcMJacvDtwsnc01YWucBJHZ0SDbXEtDOu33dOONvNB3Q
         Cle90u6Jsqg4SRMU/prKGWyvZI/j+JdC3qvc+P+eQE5Bx8RTIpMaiWMI0u7M4JMkzobK
         GB0CUTlt4d3TJFSRf8XwxyGG8uXIQ9bZ6q2mwVvr0wiFQoPU/Ri8bnUwdPOfX+AHHyWE
         hATadVpNh4Zdgogxj/dYEIDDpqico40jv1Rh7Ox9jXTgP2a3SyklJXzjhGUTgG+V8yJ4
         B/d3YwdhnOoEcWeM0iwg9gEIGaAJ3KmgakKLVDGOfflYTdAM36JhPTrw52hnnthe12Sf
         rGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IDJLgUcuXx7kJKCn0IXiTlobAsQGl6O0L29bq/w2B5U=;
        b=auXqcfI8j8Ze2a/ZVKVL5ymRg6+/V44QZcw0sIVBtOQARRiAKqOVnzWCQbMEX2T5lV
         5pSjhrufbD4eZvFP/ngKB2Tom4Y5shWFldJUPqswHCycwWr2NVRWz2P0T4/9HgftiMuU
         ssAiA2YNUqZ00BldMbY8akvvh1G75ha7xGez0YjgFPAfWLG588FtNE+UQ1ARWNCo6mL6
         1q6X9/8wZQtYOwlguGK2CflxRLVmMS1v/f8qv6AHMckWsXg4XHLb4AmPSsXLu6QFgw1U
         FBPGgxs0bybm/n4TwL9t0sJfLRCN3C8TAUMdeKVp5CywJJ1d4KWuU1M0RGRzFPG0rqG5
         XkAw==
X-Gm-Message-State: APjAAAXsQsNKYYoM32KvTMyODWfvoogrJmAAHxqORxIk1eUx1tPxTTB0
        nrPuMCE8mg2P3JFulpKb/US9PoQU
X-Google-Smtp-Source: APXvYqxG6wgIzjSYn63sy2WJwH9ipNpU6mYUqEyVgM86M619zlLthqDiiRyMMW743Eq9Ui9Wz/271A==
X-Received: by 2002:a5d:6608:: with SMTP id n8mr22276751wru.92.1571147769798;
        Tue, 15 Oct 2019 06:56:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d78sm29989560wmd.47.2019.10.15.06.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:09 -0700 (PDT)
Message-Id: <e59ed7128fe22c7662c57e36261cad68c0515308.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:55:50 +0000
Subject: [PATCH v4 03/17] clone: add --sparse mode
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
HEAD at the point where it initializes the sparse-checkout. The
following checkout within the clone command will create the HEAD
ref and update the working directory correctly.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-clone.txt        |  8 +++++++-
 builtin/clone.c                    | 27 +++++++++++++++++++++++++++
 builtin/sparse-checkout.c          |  6 ++++++
 t/t1091-sparse-checkout-builtin.sh | 13 +++++++++++++
 4 files changed, 53 insertions(+), 1 deletion(-)

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
index c46ee29f0a..4348d962c9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -59,6 +59,7 @@ static const char *real_git_dir;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
 static int option_progress = -1;
+static int option_sparse_checkout;
 static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
@@ -146,6 +147,8 @@ static struct option builtin_clone_options[] = {
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
 		    N_("any cloned submodules will use their remote-tracking branch")),
+	OPT_BOOL(0, "sparse", &option_sparse_checkout,
+		    N_("initialize sparse-checkout file to include only files at root")),
 	OPT_END()
 };
 
@@ -733,6 +736,27 @@ static void update_head(const struct ref *our, const struct ref *remote,
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
@@ -1106,6 +1130,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
+	if (option_sparse_checkout && git_sparse_checkout_init(repo))
+		return 1;
+
 	remote = remote_get(option_origin);
 
 	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 1d2327111a..4198995d46 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -109,6 +109,7 @@ static int sparse_checkout_init(int argc, const char **argv)
 	char *sparse_filename;
 	FILE *fp;
 	int res;
+	struct object_id oid;
 
 	if (sc_set_config(MODE_ALL_PATTERNS))
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

