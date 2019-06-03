Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E9A1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfFCUSa (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41489 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfFCUS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id x25so16405276eds.8
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l8yPqkdF8iTaCJCUUJvM02ZZbV/JY5rbFMA8lwv4SAQ=;
        b=XDUK744aTcm4pVV/M8IG9mEgoRokHFK4+V3LF7ZtAjSdCX4RK1QSHLi2exlmESb5++
         vV1zIOzvanB3Rey/6P/CHOj6XEXivO/0MvCIySElo+XmzQ2MRJTjoFfvtrhsDVftBbI5
         AASfAVVtFS6t39q4XotkD2aRJ5WrcbLzHjjuGrT/PckjcC+w9L3yuwgPkK2meBfyBHCr
         wUzG/oMUgCF6kmQEHrY0BmWuY6COP/UV1CCoQuKIaKG+hMS7yTVJ+QUHPcrSYCSFcunT
         6FTv6I27ynoLwnGsVZIDHmPR3ZxhBe+Lpa1z6jnAXSHtd3UYkdjS0INY1xOue/hwrwh7
         B0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l8yPqkdF8iTaCJCUUJvM02ZZbV/JY5rbFMA8lwv4SAQ=;
        b=AxqAuhWvDlDld/eXgBNPP0V7cKEm46+O/GrASMgJgpz5C9+DsWRT74bCQfrNP6kBE+
         8kKKkwP7SxiYdR2uKgGKjpaMwcpAg3tEqlT6KXl4ScRHucubUdDwiaqyIQH3KjZAQinY
         O5vTZjYSQPcIuq7VXYAzj+o5snXoKc/sDBIpjwjA+0E8s7SdyFQrJeeGnNFRglxZJHwk
         jcdHa4sfguu4HdLK1CDYZpfKORJBozWsUZRKuN5f5QxI3Aq3p8zha4N/bKtq6Kr0n8uo
         Yr6vlQIXjjSvTTfU8dLZYSLqIRmEMELjkPK/NXSWM3dby08ZBuuJjh44GoT70Ewhdaol
         efBg==
X-Gm-Message-State: APjAAAVnhYoPVYaFjf7LL7UK8AwBrZdwce3rufbP4vOl0qONNc5spzG8
        s9yo1XyFh2JA/ZRK/+F2qRxn1B7m
X-Google-Smtp-Source: APXvYqy525qslDMC6kFFzwkrCANvdJPCfhNAEkddJEFIp4nQRp9iGP96pePzTzOb/jk/4E8LfHYh+g==
X-Received: by 2002:a50:8934:: with SMTP id e49mr3441859ede.156.1559593107010;
        Mon, 03 Jun 2019 13:18:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm4098761eds.4.2019.06.03.13.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:26 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:26 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:17 GMT
Message-Id: <d4ff987ad950325ccae7b32571c4a66d5eecc851.1559593097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/11] repo-settings: fetch.showForcedUpdates=false
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

When a repo has many active contributors, the commit history can
grow very quickly and there can be many branches. During 'git fetch',
after downloading the pack from the remote, the default behavior
checks each remote ref for a forced update. This presents a
somewhat quadratic performance hit, as the time it takes to walk these
commits can be on the order of the number of branches times the
"commit velocity" per branch.

Set fetch.showForcedUpdates=false when core.size=large to enable
the --no-show-forced-updates option by default for fetch and pull
commands.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt  |  5 +++++
 Documentation/config/fetch.txt |  2 +-
 builtin/fetch.c                | 10 +++++-----
 repo-settings.c                |  6 ++++++
 repo-settings.h                |  1 +
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 6bed956a08..5733128d48 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -623,3 +623,8 @@ client machine.
 +
 * `status.aheadBehind=false` enables `--no-ahead-behind` by default during
 linkgit:git-status[1] calls, saving time in a fast-moving commit history.
++
+* `fetch.showForcedUpdates=false` enables `--no-show-forced-updates` by
+default during linkgit:git-fetch[1] and linkgit:git-pull[1] calls, saving
+time in a fast-moving commit history. This has a small side-effect of not
+updating the forced-update bit in the reflog.
diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index ba890b5884..b7a3b08854 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -67,4 +67,4 @@ See also the `--negotiation-tip` option for linkgit:git-fetch[1].
 fetch.showForcedUpdates::
 	Set to false to enable `--no-show-forced-updates` in
 	linkgit:git-fetch[1] and linkgit:git-pull[1] commands.
-	Defaults to true.
+	Defaults to true, unless `core.size=large`.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f8ff98fdaf..56683ece17 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -23,6 +23,7 @@
 #include "packfile.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
+#include "repo-settings.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -83,11 +84,6 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(k, "fetch.showforcedupdates")) {
-		fetch_show_forced_updates = git_config_bool(k, v);
-		return 0;
-	}
-
 	if (!strcmp(k, "submodule.recurse")) {
 		int r = git_config_bool(k, v) ?
 			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
@@ -1618,6 +1614,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	fetch_config_from_gitmodules(&max_children, &recurse_submodules);
 	git_config(git_fetch_config, NULL);
 
+	prepare_repo_settings(the_repository);
+	if (the_repository->settings->fetch_show_forced_updates != -1)
+		fetch_show_forced_updates = the_repository->settings->fetch_show_forced_updates;
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
diff --git a/repo-settings.c b/repo-settings.c
index b3d4b50b72..84e87913a5 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -16,6 +16,7 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
 			UPDATE_DEFAULT(rs->pack_use_sparse, 1);
 			UPDATE_DEFAULT(rs->status_ahead_behind, 1);
+			UPDATE_DEFAULT(rs->fetch_show_forced_updates, 1);
 			UPDATE_DEFAULT(rs->index_version, 4);
 		}
 		return 0;
@@ -36,6 +37,10 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		rs->status_ahead_behind = git_config_bool(key, value);
 		return 0;
 	}
+	if (!strcmp(key, "fetch.showforcedupdates")) {
+		rs->fetch_show_forced_updates = git_config_bool(key, value);
+		return 0;
+	}
 	if (!strcmp(key, "index.version")) {
 		rs->index_version = git_config_int(key, value);
 		return 0;
@@ -56,6 +61,7 @@ void prepare_repo_settings(struct repository *r)
 	r->settings->gc_write_commit_graph = -1;
 	r->settings->pack_use_sparse = -1;
 	r->settings->status_ahead_behind = -1;
+	r->settings->fetch_show_forced_updates = -1;
 	r->settings->index_version = -1;
 
 	repo_config(r, git_repo_config, r->settings);
diff --git a/repo-settings.h b/repo-settings.h
index cc358a083a..ea7d27138f 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -6,6 +6,7 @@ struct repo_settings {
 	char gc_write_commit_graph;
 	char pack_use_sparse;
 	char status_ahead_behind;
+	char fetch_show_forced_updates;
 	int index_version;
 };
 
-- 
gitgitgadget
