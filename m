Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3330320248
	for <e@80x24.org>; Mon, 15 Apr 2019 20:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfDOUju (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 16:39:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37078 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfDOUjt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 16:39:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id f53so14324057ede.4
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CvkHYwybWMLmqCpofAtLBI5feF1IPZB3rdQguZg52VY=;
        b=WhUrLyxk1qa5od4mG70sOAwY9Nh3/mljVNRmqI/ztt62jVTZOOxmbF0tcmyRU0eTsI
         1ZZJk2AxItP0SLehUR9XosGlU9vhi///8ngsV4VjK4ov82+saIsSUGTjaluV7OWKtRO9
         cBiogIhms3FnJKCUeHP2Ybhemoh3vZkF0j/B/+nL35za3Lukmw6QIynWdC24ShuJn8YZ
         Bk/SaZWD/UtHD8cyBFNxFL/vrivDa2Oy+ghYL2DnccCoah395/Y1PE+e8hKrcAI8oucG
         RInv8XHqDTWnce6I/VGA6QGOQwdryhYv9CUl3MNs3GkZlImyLq6xaj4wT1upmn1TI4eo
         S6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CvkHYwybWMLmqCpofAtLBI5feF1IPZB3rdQguZg52VY=;
        b=TyBOYii9hvwhCnYyTwdovbdv70rQ6F0VXZteK2HPMVfyGZb13+L3wlBVCZcttcY1Qe
         dJUy2jgvXgWj42Y1x/hAt05SkJkMc4LI3u5oc1Q4+vkD4ZaXf2hvzQm4DnMVdgBsg+vE
         uaJh5a0osPJtLpAJRzVHzyBdKPlIOYBHcyJjnNfXylrb94YX/oPsmGo2GmaXk/txFXsq
         AFlXbSJXvUgMwH3u5QXsArlrh4ds925EpX0x7n2Pua4bCuwYQxAGyy0F7U1x4ohwLH2r
         bPdghLvZ5phwyuHQi6PdFPH7VXYn9ak0C3ATQ3fZ0QNyo4NDLVC4oJlkNklkKYRffbIL
         bOug==
X-Gm-Message-State: APjAAAUfVfwskG0qd4OqilMYsDAv84WeyiYgl/p9slAGuFugZyE0snV5
        UhbxomHM5USzn7tzeKbvC7VOylOh
X-Google-Smtp-Source: APXvYqzdxvdocqxCbK7Rg+E//+SSUWuWiXsUbzW+nFUAhHXOAFDrMNhRXb76C1WwV+FGRU8Sv+UXuw==
X-Received: by 2002:a17:906:b202:: with SMTP id p2mr41532906ejz.266.1555360786924;
        Mon, 15 Apr 2019 13:39:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm7346660eja.23.2019.04.15.13.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 13:39:46 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:39:46 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Apr 2019 20:39:35 GMT
Message-Id: <b0fe1385f1a96efbcab38fe02a3d5b3c1b6eaa37.1555360780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v4.git.gitgitgadget@gmail.com>
References: <pull.169.v3.git.gitgitgadget@gmail.com>
        <pull.169.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 05/10] config: add read_very_early_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Created an even lighter version of read_early_config() that
only looks at system and global config settings.  It omits
repo-local, worktree-local, and command-line settings.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 config.c | 23 ++++++++++++++++++++---
 config.h |  4 ++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index c809f76219..d7a08713a8 100644
--- a/config.c
+++ b/config.c
@@ -1688,14 +1688,15 @@ static int do_git_config_sequence(const struct config_options *opts,
 		ret += git_config_from_file(fn, user_config, data);
 
 	current_parsing_scope = CONFIG_SCOPE_REPO;
-	if (repo_config && !access_or_die(repo_config, R_OK, 0))
+	if (!opts->ignore_repo && repo_config &&
+	    !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file(fn, repo_config, data);
 
 	/*
 	 * Note: this should have a new scope, CONFIG_SCOPE_WORKTREE.
 	 * But let's not complicate things before it's actually needed.
 	 */
-	if (repository_format_worktree_config) {
+	if (!opts->ignore_worktree && repository_format_worktree_config) {
 		char *path = git_pathdup("config.worktree");
 		if (!access_or_die(path, R_OK, 0))
 			ret += git_config_from_file(fn, path, data);
@@ -1703,7 +1704,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 	}
 
 	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
-	if (git_config_from_parameters(fn, data) < 0)
+	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
 	current_parsing_scope = CONFIG_SCOPE_UNKNOWN;
@@ -1794,6 +1795,22 @@ void read_early_config(config_fn_t cb, void *data)
 	strbuf_release(&gitdir);
 }
 
+/*
+ * Read config but only enumerate system and global settings.
+ * Omit any repo-local, worktree-local, or command-line settings.
+ */
+void read_very_early_config(config_fn_t cb, void *data)
+{
+	struct config_options opts = { 0 };
+
+	opts.respect_includes = 1;
+	opts.ignore_repo = 1;
+	opts.ignore_worktree = 1;
+	opts.ignore_cmdline = 1;
+
+	config_with_options(cb, data, NULL, &opts);
+}
+
 static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
 {
 	struct config_set_element k;
diff --git a/config.h b/config.h
index ee5d3fa7b4..6a58d61d22 100644
--- a/config.h
+++ b/config.h
@@ -55,6 +55,9 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 
 struct config_options {
 	unsigned int respect_includes : 1;
+	unsigned int ignore_repo : 1;
+	unsigned int ignore_worktree : 1;
+	unsigned int ignore_cmdline : 1;
 	const char *commondir;
 	const char *git_dir;
 	config_parser_event_fn_t event_fn;
@@ -83,6 +86,7 @@ extern int git_config_from_blob_oid(config_fn_t fn, const char *name,
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern void read_early_config(config_fn_t cb, void *data);
+extern void read_very_early_config(config_fn_t cb, void *data);
 extern void git_config(config_fn_t fn, void *);
 extern int config_with_options(config_fn_t fn, void *,
 			       struct git_config_source *config_source,
-- 
gitgitgadget

