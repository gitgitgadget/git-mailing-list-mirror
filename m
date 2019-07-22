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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C4D41F461
	for <e@80x24.org>; Mon, 22 Jul 2019 17:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfGVRy1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 13:54:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42925 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbfGVRyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 13:54:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so25349920wrr.9
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cyAOMMH1whMqdnKFrzzpquQ2nXvUE88NdzKeW3RK24Q=;
        b=OX7FKUA9QNkRj6MqoFdPJq57rsLWFTvI1hl4hgK7UyvNpv36ZnTmF30Hz2wnTSATxc
         w/pMxgM9oYgFnWuLmEma+4X7FOKUxZtMZbbaotz4Au8kn1o2JzPJoCVCJYomDzACXD11
         UH2vq+DE9jTAa1W0wjPnOOmKPNeL1RozEIarv6KuIVrCPk3zKlv8M6Vm6hZuzJw1XyIo
         DKZ6flfJzF/JyWiBrqslUGw7Uyxkr1bCXJLlvj6941J5O4T1L1jSORFhzyOTr8ixhMok
         Kh2M4ieLAhOlgTUjgSoefTPUBc29VFHpO9Yr6HyxXX5Zt0PAmatGbuELfI5RXT3EWdHS
         vziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cyAOMMH1whMqdnKFrzzpquQ2nXvUE88NdzKeW3RK24Q=;
        b=Y6Jzj/jcocYFqEtWl+oii6rgdrATtI4Eh5yxKcfrTzXOwTMfQhKtRdhx+4E/bbhElD
         JCkviHUzpwx9EYEpXbSL7o6NPBV++7MHP/BlOELpRb8JDSivd0hkvX9wMtLFRcKV6Opu
         5D7OceeboR2AXm2JmIhb5t0GlXmgtgnYfSYf7COgGJ1GJVFfj8um6O8pojm42oJ2EZoc
         uitRY49kmfGT3QlAceS3C+IFguFtYe3UjJhIDGB7P8ByuuL4dxsUe4xQvrswddlR2cP+
         Z68cJ3hTXN9ZN62OfZwnKzVa22Qo8tvDnAjhSHKciRuknj7+K6o7cmrm/YwtOmpK1ij6
         887w==
X-Gm-Message-State: APjAAAXUVRVImoWoU4etOzPFPebYGTvKRxVl1A6429Qdi5CNYP/Kv9+B
        IqXnTVuUdsg2fARi4a/sld5Uxz0E
X-Google-Smtp-Source: APXvYqyFJNrIfhhm6GfXJ0YQmSovTUIqri7ChvuhURWkE1U7AHZ3ITjSROjE34UJHfLIZ8pl5Q2bxg==
X-Received: by 2002:adf:ca0f:: with SMTP id o15mr75917364wrh.135.1563818062862;
        Mon, 22 Jul 2019 10:54:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i13sm36139825wrr.73.2019.07.22.10.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 10:54:22 -0700 (PDT)
Date:   Mon, 22 Jul 2019 10:54:22 -0700 (PDT)
X-Google-Original-Date: Mon, 22 Jul 2019 17:54:16 GMT
Message-Id: <e00a1be75b410694374b0d9bd60ab16d67ef6d20.1563818059.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.git.gitgitgadget@gmail.com>
References: <pull.292.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/5] repo-settings: add feature.manyCommits setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When a repo has many commits, it is helpful to write and read the
commit-graph file. Future changes to Git may include new config
settings that are benefitial in this scenario.

Create the 'feature.manyCommits' config setting that changes the
default values of 'core.commitGraph' and 'gc.writeCommitGraph' to
true.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt         |  2 ++
 Documentation/config/core.txt    |  3 ++-
 Documentation/config/feature.txt | 15 +++++++++++++++
 Documentation/config/gc.txt      |  4 ++--
 repo-settings.c                  |  7 +++++++
 5 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/feature.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e3f5bc3396..77f3b1486b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -345,6 +345,8 @@ include::config/difftool.txt[]
 
 include::config/fastimport.txt[]
 
+include::config/feature.txt[]
+
 include::config/fetch.txt[]
 
 include::config/format.txt[]
diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 75538d27e7..d80162681a 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -577,7 +577,8 @@ the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
 core.commitGraph::
 	If true, then git will read the commit-graph file (if it exists)
-	to parse the graph structure of commits. Defaults to false. See
+	to parse the graph structure of commits. Defaults to false, unless
+	`feature.manyCommits` is enabled. See
 	linkgit:git-commit-graph[1] for more information.
 
 core.useReplaceRefs::
diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
new file mode 100644
index 0000000000..f74314ae90
--- /dev/null
+++ b/Documentation/config/feature.txt
@@ -0,0 +1,15 @@
+feature.*::
+	The config settings that start with `feature.` modify the defaults of
+	a group of other config settings. These groups are created by the Git
+	developer community as recommended defaults and are subject to change.
+	In particular, new config options may be added with different defaults.
+
+feature.manyCommits::
+	Enable config options that optimize for repos with many commits. This
+	setting is recommended for repos with at least 100,000 commits. The
+	new default values are:
++
+* `core.commitGraph=true` enables reading the commit-graph file.
++
+* `gc.writeCommitGraph=true` enables writing the commit-graph file during
+garbage collection.
\ No newline at end of file
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 02b92b18b5..31a5fc4f75 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -63,8 +63,8 @@ gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
 	linkgit:git-gc[1] is run. When using `git gc --auto`
 	the commit-graph will be updated if housekeeping is
-	required. Default is false. See linkgit:git-commit-graph[1]
-	for details.
+	required. Default is false, unless `feature.manyCommits`
+	is enabled. See linkgit:git-commit-graph[1] for details.
 
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` will print
diff --git a/repo-settings.c b/repo-settings.c
index 13a9128f62..f328602fd7 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -3,10 +3,17 @@
 #include "config.h"
 #include "repo-settings.h"
 
+#define UPDATE_DEFAULT(s,v) do { if (s == -1) { s = v; } } while(0)
+
 static int git_repo_config(const char *key, const char *value, void *cb)
 {
 	struct repo_settings *rs = (struct repo_settings *)cb;
 
+	if (!strcmp(key, "feature.manycommits")) {
+		UPDATE_DEFAULT(rs->core_commit_graph, 1);
+		UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
+		return 0;
+	}
 	if (!strcmp(key, "core.commitgraph")) {
 		rs->core_commit_graph = git_config_bool(key, value);
 		return 0;
-- 
gitgitgadget

