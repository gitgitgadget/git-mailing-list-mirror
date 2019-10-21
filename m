Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D20E41F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfJUN4d (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37455 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbfJUN4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so12912550wmc.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Dtd3kEyatD2qmW8hj5YNKVLqty3loyNp8hGKo37c+A=;
        b=YERgy5PD0yPaxirKuYDNqvi/SHwBlx5Y/Cfn39U91wpFLFAssXsPo6Ellm+u191YRc
         nvscjXeMY9kRxxvTA3z9wu6jxvaA33yebEcXBVC1COF1ejHcgGcH6ZmkIfic8SI+hmj6
         Qgo8dyhVfftJcYLhiFdN364GnIuxsW+ucfkZsC5Lhqq704yxG3FVvnvKIFvEVgnJyjmG
         3+ReDLJD4NmTsMby/rvu/T4jEjmqTbLTDrLciXRqQLOTsVMv1kgHS0gzrcuO/3p93PJq
         AKsrEHz2ouKTROq14+oGuFWg8jkrbqGLRCd5+6FIckWV5mGkPJv5aDU/eJA45XTk6c4H
         K0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Dtd3kEyatD2qmW8hj5YNKVLqty3loyNp8hGKo37c+A=;
        b=gLXQkrB624A4bCoL23nkxj8P2LtECVzdUCmo+reNFtmEsverk0dbZxF9qUsYpneNo0
         Zd7TB7jYblLfR7S/FLBacswS7YIJnN7hlOa5S7VthO068GkpqN0RTlFIk1tZJ6iUBchw
         i2b7Dc04Vtp/9eWC2LVSG4vDs4ASred6sZWl0H3GLMbXAJpcOZKnOTSGF77QDgVYdvGh
         8sXoE6wGif4/oeotd8Gb0GJXAul7BcyWVNW1EGLy3xi8u9cDE69QuaF7mqnfw6l1p4pl
         nA42u6nHJr3Vz4+iLTv8zSp2YwmyDpt0CI2HwDGlI+XNpuk04+xC9RcZmcDPqD/YP1Fq
         uLZQ==
X-Gm-Message-State: APjAAAWewnrvA+COqJrSLHTFYo+8H282/Gc2u0l+aPAhpoN6ft0PG89l
        a66zD0GJAF7/QdWAXvWzt7A8si8X
X-Google-Smtp-Source: APXvYqwaATFgIbw7UceScGMz49CUGDnBBJRcNUJ1DzS+XZYuLHwX+xVf8uIMbmalAfUTPy/ck49ILQ==
X-Received: by 2002:a7b:cb0b:: with SMTP id u11mr135040wmj.125.1571666191146;
        Mon, 21 Oct 2019 06:56:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1sm7330874wru.83.2019.10.21.06.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:30 -0700 (PDT)
Message-Id: <cd150853b7e4323c0a471d016800e614b3a62679.1571666186.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:12 +0000
Subject: [PATCH v5 03/17] clone: add --sparse mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
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
index 77aa52ca01..6c336b7ab3 100644
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
index cd56cc384b..cb74715ca6 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -83,4 +83,17 @@ test_expect_success 'init with existing sparse-checkout' '
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

