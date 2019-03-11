Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18DB520248
	for <e@80x24.org>; Mon, 11 Mar 2019 20:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfCKUL6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 16:11:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44511 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfCKULB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 16:11:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id b20so342955edw.11
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 13:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1r0hMZZiQ8dZb634MbbNdmKGZAO6RYEQoBw4HP1ARpQ=;
        b=lJZD8yj3KmBa2qiQd7TJFdOdUgrTNODbpi/R8Nd5kDDmHJAl1XBpPocBOrQhNlJscE
         H+GBGMobcQ2S6cxMJ/ACafB2uuYoDDLvNr2CjhMtg106ALrt2ZCVhImvTxs2IeqQ7Kyl
         JcrflEGOIYq2VQwOum+0+S5GEHq0sRkAWct1xKF74WgAIgf06aPGb4ryI1reXXFyohNH
         HWEkRmKWByJrGZcpZxaTJL/sosrXLCiTnFUrVKRnJMHjpsoB9pNcL0/Xd55bWbMUWelH
         HVplJunrQ+VianhE+lEykIaYFwEd8lJGkq8HElOLOb0FRZemoqUVD4QzFL5qm3yE5OWG
         F7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1r0hMZZiQ8dZb634MbbNdmKGZAO6RYEQoBw4HP1ARpQ=;
        b=cNjxfNi8b3/GYSH2nFYI01nH7lSpXn1eH/WQXO9f7zrvmszQGRGF2HyKPbIrlxOM4B
         SVjJzFZyITg2VdThpiQk0IbIGpCU+jODOkJzvf0ayR2gIJxtczqGvdRQnhg38zhWJsg4
         mhmnXFpiVsl8g4wQpliggBA8WkFt5YaZtfHp85uigsEpAnfmuPakH67wlK28c9Lo90OD
         6gToz5kLnc4tlxfCqBzTGXJAAv86MIlhHvIYBHwWHgHKMvxtBwJhorwMxHHG7Q511AuE
         MuR3l5NWRdxlEI1wY047ua0CDuPsgbv8hDKUehp3r3s4JKMSsh0tOiw8F+VyeZ4eTYhq
         85Cg==
X-Gm-Message-State: APjAAAVi9bWKTfkE0A69oBxhooSMsuoh4DsMByF1l+m/3Y3qBxXF62Qh
        kk2ZIKVBavbTZqkZVAotkUbOOBJ4
X-Google-Smtp-Source: APXvYqz0KWJ2H4QFBOjpxsApsRE6B7pMMuxkWQSsQuz6qTvrAUDYz6lM3edUsTLInUoOdCIwoiISRA==
X-Received: by 2002:a50:b574:: with SMTP id z49mr374329edd.283.1552335059085;
        Mon, 11 Mar 2019 13:10:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s6sm4927691eda.90.2019.03.11.13.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 13:10:58 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:10:58 -0700 (PDT)
X-Google-Original-Date: Mon, 11 Mar 2019 20:10:57 GMT
Message-Id: <f187d0d247bf0523b63c265cd01116646597eb28.1552335057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.131.v2.git.gitgitgadget@gmail.com>
References: <pull.131.git.gitgitgadget@gmail.com>
        <pull.131.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] mingw: respect core.hidedotfiles = false in git-init
 again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a brown paper bag. When adding the tests, we actually failed
to verify that the config variable is heeded in git-init at all. And
when changing the original patch that marked the .git/ directory as
hidden after reading the config, it was lost on this developer that
the new code would use the hide_dotfiles variable before the config
was read.

The fix is obvious: read the (limited, pre-init) config *before*
creating the .git/ directory.

Please note that we cannot remove the identical-looking `git_config()`
call from `create_default_files()`: we create the `.git/` directory
between those calls. If we removed it, and if the parent directory is
in a Git worktree, and if that worktree's `.git/config` contained any
`init.templatedir` setting, we would all of a sudden pick that up.

This fixes https://github.com/git-for-windows/git/issues/789

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/init-db.c |  7 +++++++
 t/t0001-init.sh   | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 93eff7618c..190754ba39 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -155,6 +155,9 @@ static int git_init_db_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "init.templatedir"))
 		return git_config_pathname(&init_db_template_dir, k, v);
 
+	if (starts_with(k, "core."))
+		return platform_core_config(k, v, cb);
+
 	return 0;
 }
 
@@ -185,6 +188,7 @@ static int create_default_files(const char *template_path,
 	struct strbuf err = STRBUF_INIT;
 
 	/* Just look for `init.templatedir` */
+	init_db_template_dir = NULL; /* re-set in case it was set before */
 	git_config(git_init_db_config, NULL);
 
 	/*
@@ -361,6 +365,9 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	}
 	startup_info->have_repository = 1;
 
+	/* Just look for `core.hidedotfiles` */
+	git_config(git_init_db_config, NULL);
+
 	safe_create_dir(git_dir, 0);
 
 	init_is_bare_repository = is_bare_repository();
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5e27604b24..1f462204ea 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -454,6 +454,17 @@ test_expect_success 're-init from a linked worktree' '
 	)
 '
 
+test_expect_success MINGW 'core.hidedotfiles = false' '
+	git config --global core.hidedotfiles false &&
+	rm -rf newdir &&
+	mkdir newdir &&
+	(
+		sane_unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
+		git -C newdir init
+	) &&
+	! is_hidden newdir/.git
+'
+
 test_expect_success MINGW 'redirect std handles' '
 	GIT_REDIRECT_STDOUT=output.txt git rev-parse --git-dir &&
 	test .git = "$(cat output.txt)" &&
-- 
gitgitgadget
