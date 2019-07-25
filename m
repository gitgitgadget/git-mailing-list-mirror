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
	by dcvr.yhbt.net (Postfix) with ESMTP id D16141F462
	for <e@80x24.org>; Thu, 25 Jul 2019 02:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbfGYCXT (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 22:23:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38773 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbfGYCXT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 22:23:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so48957273wrr.5
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 19:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6ZlBC78mwHouVI+oKBj3adbBX91NbubjtF0qo50X5oY=;
        b=fQSE71mIti5RnU3A085brbW0zimDzzvJd29Fa12CZLgP0IRZgmjAYGeO4CpZtG4aZR
         pu0ARYARMoKnffwy2bswLZJ3bD2jRCGftW7eMBQkNe1h7CrwZBzKvEjEE/wqUf2CCQWZ
         5IhUAd4EOplcQ4k59wlCX1SC3voMYwI8DmVufZy7Y2UyXOSE7njX1bOFLtwD+NuPtC9+
         zWLa0dYndK034oKZ3G1doN7H8MhPnleA2FgC8M39YOj7o045yJTme61iN0Og75zwviGJ
         2HkTkzMR15BiPoRFkgGr+TyBVn7FujdaqPiIelXMvTEWzIUkmgAeLkCYfN8mbAeXubLJ
         4DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6ZlBC78mwHouVI+oKBj3adbBX91NbubjtF0qo50X5oY=;
        b=jcNEA1VVQ6cnvablYlY8DKOPWP6MKDKPut8/KPXVwVHusaZHW05I8JqqUvCZV1UWdb
         8KkXphAOYaF7mkP3chWZ0mfkVPZtdTIMraN09o/icOmiqbSolN0v2mzE+2TqFarFhOy7
         m9/7bE0rHrrpiToqHm+o8LfxFpKcY/hBzVBeC9I24jf8wgcGhW59KIR+/ouFd1Ns73qX
         0INEX+QAODAGMpL6UOFMBSVWedKEf+x5pEMv+k+Jz/XJtaOP394UosZCJQy9f1ZivD8l
         UkBub+QHD+UuKdPYuJClgUKyleew9eB73EbEifBXmRoezE4fyoIOP7BmFVxUUzZnCcfy
         eykg==
X-Gm-Message-State: APjAAAVE4wcIIhKOB4DfvmvKAwr6MdZSSpbIYVRqDIxoK2ooPULWqY5i
        /9UvR5qaNos7XCcb7A2rep/JT148
X-Google-Smtp-Source: APXvYqy30GYBSF+m8J+zBoPc4rh3+Pc0xDbw+tn8ulswUf+BlzrRlnMII2ZmV+52W4X9s/8KYM6ZhQ==
X-Received: by 2002:adf:f6d2:: with SMTP id y18mr15469592wrp.102.1564021396209;
        Wed, 24 Jul 2019 19:23:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm48169376wrm.16.2019.07.24.19.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 19:23:15 -0700 (PDT)
Date:   Wed, 24 Jul 2019 19:23:15 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 02:23:09 GMT
Message-Id: <86380c78321528221c6b0dd6520e714104dbcd18.1564021393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v2.git.gitgitgadget@gmail.com>
References: <pull.292.git.gitgitgadget@gmail.com>
        <pull.292.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/5] repo-settings: add feature.manyCommits setting
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
settings that are beneficial in this scenario.

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
index 2c33810cc6..3face7d8b9 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -3,6 +3,8 @@
 #include "config.h"
 #include "repo-settings.h"
 
+#define UPDATE_DEFAULT(s,v) do { if (s == -1) { s = v; } } while(0)
+
 void prepare_repo_settings(struct repository *r)
 {
 	int value;
@@ -24,5 +26,10 @@ void prepare_repo_settings(struct repository *r)
 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
 		r->settings.pack_use_sparse = value;
 
+	if (!repo_config_get_bool(r, "feature.manycommits", &value) && value) {
+		UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
+		UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
+	}
+
 	r->settings_initialized = 1;
 }
-- 
gitgitgadget

