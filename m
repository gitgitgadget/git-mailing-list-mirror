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
	by dcvr.yhbt.net (Postfix) with ESMTP id 850001F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbfISOnP (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:43:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33454 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732730AbfISOnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so3431961wrs.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CyN6B0PG/RFet48vvIge7p9pgKeLlQsSgSIu/Pw2ejw=;
        b=uNnkTEgR1cKo7aBGdR06KJDDdVtlJOAV6toXVO7For2p0qrV02mTRBjgHUxDDf1j67
         HeM8jSukkVNOiSOBktk2oD+YEVsWmfroLvPapmrW38EMT2x4IzgS3Mb+4jaDLq9+teb1
         LaXDacMbRVl2VUP/SYGMv9NHp7/e368vgrVHA+LPqK6atq2NlSbyC11mrnkC1+muoVdh
         wzhZ7zpZrgqoW3sz0aEb7YG5ZGMWNsaL+rbAEpexAJsjNFGxig06GiqL1NsF8dETgg4K
         vxZxPaWSqiC7gPSNWxiAtpAuUCKx5LuEIICYpWWoKQA0NfhkXGtFrZYAfcqjQCzskxLW
         J2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CyN6B0PG/RFet48vvIge7p9pgKeLlQsSgSIu/Pw2ejw=;
        b=bMU+HpNx2vazYyi5NZoKEZneSeDmgcUokeYEzLFKyZK9a8IQKNkb5aMRNAzWVCaKTD
         ez5ecWCUKqVs+VXkvrIFTvIEzU//w3JFg2atP+mQAJGh0AjwiGBe48V3w5VlyGVGllKY
         3s7S4/IneHwzD3RqvDPj8iGfP0yMlQPyhWusRqFkaqOXTCTzWZCwr8OZe5FjgpyR+gVy
         RRiEMotT0d0eBuxflMoFhRf0yQ2VE9layuPZ3vuwZFXpMkVrVzpP1ObvAYwen5nj80U7
         oIX7cWlG9+XtY52bW43EKiADbHkVIE5iM0mkeEGXw4nw/AeScXo1dcEkO5yXaGfKJEzS
         DWqw==
X-Gm-Message-State: APjAAAXyPZsasbvtElBE41QuYQ0BTl48kEspsfZeaqLTkhnspmY96VWP
        ALjh7I/6rCZQB+jTQ5piVB4BbIlo
X-Google-Smtp-Source: APXvYqx2UPfGue97VtzXvLuVYzHjY1ANonPWPG4TfZGXLyOIeDtcOyQolEuOJflWAKVk4pijerkLOg==
X-Received: by 2002:adf:c504:: with SMTP id q4mr8067032wrf.266.1568904192883;
        Thu, 19 Sep 2019 07:43:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10sm9741444wmf.48.2019.09.19.07.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:43:12 -0700 (PDT)
Date:   Thu, 19 Sep 2019 07:43:12 -0700 (PDT)
X-Google-Original-Date: Thu, 19 Sep 2019 14:43:00 GMT
Message-Id: <fef41b794a9886664616ce5e5c7902a82a474c2d.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
        <pull.316.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 03/11] clone: add --sparse mode
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
	!/*/

These patterns include every file in the root directory, but
no directories. This allows a repo to include files like a
README or a bootstrapping script to grow enlistments from that
point.

During the 'git sparse-checkout init' call, we must first look
to see if HEAD is valid, or else we will fail while trying to
update the working directory. The first checkout will actually
update the working directory correctly.

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
index 895479970d..656e6ebdd5 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -99,6 +99,7 @@ static int sparse_checkout_init(int argc, const char **argv)
 	char *sparse_filename;
 	FILE *fp;
 	int res;
+	struct object_id oid;
 
 	if (sc_enable_config())
 		return 1;
@@ -120,6 +121,11 @@ static int sparse_checkout_init(int argc, const char **argv)
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
index a6c6b336c9..26b4ce9acd 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -88,5 +88,18 @@ test_expect_success 'init with existing sparse-checkout' '
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

