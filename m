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
	by dcvr.yhbt.net (Postfix) with ESMTP id E0ED41F461
	for <e@80x24.org>; Tue, 20 Aug 2019 15:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfHTPLS (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 11:11:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33650 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbfHTPLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 11:11:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so12796918wrr.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5F1JUne9InsFpct6kZDALXJPBlBbmWdK7lmzCoCM/gY=;
        b=jiP3Jnpwxvj0rks0IRq0PcLaJJ2keh1pi3WTYqqJdEwnZy5NNtiXCFVJxejQ0ooAz9
         vORkTCccPlmgcq3cxVX05ezR97xuuQytLmSgBAd/KuY6FpCC6aM6nyEq9pidh0S5WZUy
         OYlMF6i7ccnJXyVPLL34b+XzJ3b0mfxFpuh2OeRBnFRGC86/6bWBqgejTjENw4ckYiXS
         2V9FQNxtsF2aH2IHNO+y54xPPlbPlTkBpLaWCoOqzeJTgTR9FOhQvV9oQELteaOJUM6+
         CN7fc04aAi1z/vVc7zwcyGzV0RIZWId6JpKNIwGGgnRuHQiIEpCD4GbP/xdXwEUxkxxp
         T/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5F1JUne9InsFpct6kZDALXJPBlBbmWdK7lmzCoCM/gY=;
        b=HOB2JgP4XNr+mhNKIIXJQfC82YbTw/wTqCzsf4WJmhQJy8JarWfp8sKiXOv64sRGIL
         clvOM43oO7ZJKlsGHF+xfc07ca6AxmtAW6E4b1e5xCh/4owvX38UCXbrJCDyeHjqlse7
         RgklQ9EzfU590Tcrplro2LFBNbXp6slp01XgWpfcsT0oNTXfqDYAQKWs3EXv1JcbGfN4
         aO0ZT5sDqND7AqyUz9pu0NoiUUP4XwjFaAjxfFkT6gcC9P5ae0j/NOYLOhlUp1GBrAl9
         lUiT5kDudRqbYjiJGnjITzC8oK2fypmlOE2+XWn7peZW/3ge+tSP11tfEMb8TxdyIw0y
         VopQ==
X-Gm-Message-State: APjAAAVSGRKhngyiJCJGLRpTDznQqAh4WMok5yTdeZ579xfPlAcp/82N
        1bNqAoU9KXeM8fWH7/uvI2cFt3gE
X-Google-Smtp-Source: APXvYqyAx43ZSbaj0D0qkmHVpMGjwZkiEXrO+wXm6jcEvITwwDQVrKhFhnRJJZ/q5Zkf7KXECLUz2w==
X-Received: by 2002:adf:e750:: with SMTP id c16mr35510209wrn.199.1566313872374;
        Tue, 20 Aug 2019 08:11:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm29213785wrm.88.2019.08.20.08.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:11:11 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:11:11 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 15:11:03 GMT
Message-Id: <19d664a5dada87a9a8dcf18d7548582275593f10.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 7/9] sparse-checkout: add 'cone' mode
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

The sparse-checkout feature can have quadratic performance as
the number of patterns and number of entries in the index grow.
If there are 1,000 patterns and 1,000,000 entries, this time can
be very significant.

Create a new 'cone' mode for the core.sparseCheckout config
option, and adjust the parser to set an appropriate enum value.

While adjusting the type of this variable, rename it from
core_apply_sparse_checkout to core_sparse_checkout. This will
help avoid parallel changes from hitting type issues, and we
can guarantee that all uses now consider the enum values instead
of the int value.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt         |  7 ++--
 Documentation/git-sparse-checkout.txt | 50 +++++++++++++++++++++++++++
 builtin/clone.c                       |  2 +-
 builtin/sparse-checkout.c             | 16 +++++----
 cache.h                               |  8 ++++-
 config.c                              | 10 +++++-
 environment.c                         |  2 +-
 t/t1091-sparse-checkout-builtin.sh    | 14 ++++++++
 unpack-trees.c                        |  2 +-
 9 files changed, 98 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 75538d27e7..9b8ab2a6d4 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -591,8 +591,11 @@ core.multiPackIndex::
 	multi-pack-index design document].
 
 core.sparseCheckout::
-	Enable "sparse checkout" feature. See section "Sparse checkout" in
-	linkgit:git-read-tree[1] for more information.
+	Enable "sparse checkout" feature. If "false", then sparse-checkout
+	is disabled. If "true", then sparse-checkout is enabled with the full
+	.gitignore pattern set. If "cone", then sparse-checkout is enabled with
+	a restricted pattern set. See linkgit:git-sparse-checkout[1] for more
+	information.
 
 core.abbrev::
 	Set the length object names are abbreviated to.  If
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index de04b768ae..463319055b 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -86,6 +86,56 @@ negate patterns. For example, to remove the file `unwanted`:
 ----------------
 
 
+## CONE PATTERN SET
+
+The full pattern set allows for arbitrary pattern matches and complicated
+inclusion/exclusion rules. These can result in O(N*M) pattern matches when
+updating the index, where N is the number of patterns and M is the number
+of paths in the index. To combat this performance issue, a more restricted
+pattern set is allowed when `core.spareCheckout` is set to `cone`.
+
+The accepted patterns in the cone pattern set are:
+
+1. *Recursive:* All paths inside a directory are included.
+
+2. *Parent:* All files immediately inside a directory are included.
+
+In addition to the above two patterns, we also expect that all files in the
+root directory are included. If a recursive pattern is added, then all
+leading directories are added as parent patterns.
+
+By default, when running `git sparse-checkout init`, the root directory is
+added as a parent pattern. At this point, the sparse-checkout file contains
+the following patterns:
+
+```
+/*
+!/*/*
+```
+
+This says "include everything in root, but nothing two levels below root."
+If we then add the folder `A/B/C` as a recursive pattern, the folders `A` and
+`A/B` are added as parent patterns. The resulting sparse-checkout file is
+now
+
+```
+/*
+!/*/*
+/A/*
+!/A/*/*
+/A/B/*
+!/A/B/*/*
+/A/B/C/*
+```
+
+Here, order matters, so the negative patterns are overridden by the positive
+patterns that appear lower in the file.
+
+If `core.sparseCheckout=cone`, then Git will parse the sparse-checkout file
+expecting patterns of these types. Git will warn if the patterns do not match.
+If the patterns do match the expected format, then Git will use faster hash-
+based algorithms to compute inclusion in the sparse-checkout.
+
 SEE ALSO
 --------
 
diff --git a/builtin/clone.c b/builtin/clone.c
index d6d49a73ff..763898ada5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -747,7 +747,7 @@ static int git_sparse_checkout_init(const char *repo)
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
-	core_apply_sparse_checkout = 1;
+	core_sparse_checkout = SPARSE_CHECKOUT_FULL;
 
 	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
 		error(_("failed to initialize sparse-checkout"));
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8f97c27ec7..77e5235720 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -79,18 +79,22 @@ static int sc_read_tree(void)
 	return result;
 }
 
-static int sc_set_config(int mode)
+static int sc_set_config(enum sparse_checkout_mode mode)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	int result = 0;
 	argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", NULL);
 
 	switch (mode) {
-	case 1:
+	case SPARSE_CHECKOUT_FULL:
 		argv_array_pushl(&argv, "true", NULL);
 		break;
 
-	case 0:
+	case SPARSE_CHECKOUT_CONE:
+		argv_array_pushl(&argv, "cone", NULL);
+		break;
+
+	case SPARSE_CHECKOUT_NONE:
 		argv_array_pushl(&argv, "false", NULL);
 		break;
 
@@ -138,7 +142,7 @@ static int sparse_checkout_init(int argc, const char **argv)
 	FILE *fp;
 	int res;
 
-	if (sc_set_config(1))
+	if (sc_set_config(SPARSE_CHECKOUT_FULL))
 		return 1;
 
 	memset(&el, 0, sizeof(el));
@@ -212,7 +216,7 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	char *sparse_filename;
 	FILE *fp;
 
-	if (sc_set_config(1))
+	if (sc_set_config(SPARSE_CHECKOUT_FULL))
 		die(_("failed to change config"));
 
 	sparse_filename = get_sparse_checkout_filename();
@@ -226,7 +230,7 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	unlink(sparse_filename);
 	free(sparse_filename);
 
-	return sc_set_config(0);
+	return sc_set_config(SPARSE_CHECKOUT_NONE);
 }
 
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
diff --git a/cache.h b/cache.h
index b1da1ab08f..4426816ca1 100644
--- a/cache.h
+++ b/cache.h
@@ -865,12 +865,18 @@ extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
 extern int core_preload_index;
-extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 extern const char *core_fsmonitor;
 
+enum sparse_checkout_mode {
+	SPARSE_CHECKOUT_NONE = 0,
+	SPARSE_CHECKOUT_FULL = 1,
+	SPARSE_CHECKOUT_CONE = 2,
+};
+enum sparse_checkout_mode core_sparse_checkout;
+
 /*
  * Include broken refs in all ref iterations, which will
  * generally choke dangerous operations rather than letting
diff --git a/config.c b/config.c
index 3900e4947b..15b7a20dd9 100644
--- a/config.c
+++ b/config.c
@@ -1360,7 +1360,15 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "core.sparsecheckout")) {
-		core_apply_sparse_checkout = git_config_bool(var, value);
+		int result = git_parse_maybe_bool(value);
+
+		if (result < 0) {
+			core_sparse_checkout = SPARSE_CHECKOUT_NONE;
+
+			if (!strcasecmp(value, "cone"))
+				core_sparse_checkout = SPARSE_CHECKOUT_CONE;
+		} else
+			core_sparse_checkout = result;
 		return 0;
 	}
 
diff --git a/environment.c b/environment.c
index 89af47cb85..cc12e30bd6 100644
--- a/environment.c
+++ b/environment.c
@@ -68,7 +68,7 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
-int core_apply_sparse_checkout;
+enum sparse_checkout_mode core_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 68ca63a6f6..8cc377b839 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -120,6 +120,20 @@ test_expect_success 'add to existing sparse-checkout' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: match patterns' '
+	git -C repo config --replace-all core.sparseCheckout cone &&
+	rm -rf repo/a repo/folder1 repo/folder2 &&
+	git -C repo read-tree -mu HEAD &&
+	git -C repo reset --hard &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_expect_success 'sparse-checkout disable' '
 	git -C repo sparse-checkout disable &&
 	test_path_is_missing repo/.git/info/sparse-checkout &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 8c3b5e8849..289c62305f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1468,7 +1468,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	trace_performance_enter();
 	memset(&el, 0, sizeof(el));
-	if (!core_apply_sparse_checkout || !o->update)
+	if (!core_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		char *sparse = git_pathdup("info/sparse-checkout");
-- 
gitgitgadget

