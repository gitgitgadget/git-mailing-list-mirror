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
	by dcvr.yhbt.net (Postfix) with ESMTP id 281481F462
	for <e@80x24.org>; Tue, 30 Jul 2019 19:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfG3Tfb (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 15:35:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50593 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfG3Tfa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 15:35:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so58312155wml.0
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wg1SIg+4fJFpQEJ4/F9vyLShuV8avZI8I/r/0z2Q6sM=;
        b=BqM2eow1sxekAqI2ppMNtTxRtd3BBPi7Be7DgEtwcy1FC+rEGTKfrUldvWCraDDFjz
         9PqekL8jv1/VfPhANKT3PMLysbPYHDvVbytC5Xz9f5n4E/fGz7aYyPNuMAKHxowIW75G
         e2jwFB0z/0SbaMZ6cKPJFT8fMgl6WrSPtP85G+75aHZZIj1f6tXsIhpdN+I05agpxGBD
         fVoPZV0bqrZAJymkQ7DEs7edWlDji1Z7D/C3exT2Pyr3fVxV9U/pF29gsXCQMY/16PDk
         eoAbCGnkaCijaCq5ZdYBVp6Wt4mwzDIY/qSZgH4VBSzNQCTHrKpDJARumMApnOmct7B9
         Vp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wg1SIg+4fJFpQEJ4/F9vyLShuV8avZI8I/r/0z2Q6sM=;
        b=C9mlMAoL0mGbnZZ+PvnUGgGY/4tst2X/QfKU6tPu2dLv2vjrnfSXHElcHiENHJtYAA
         zY3NoGXBpYBo+Ho78rVldgB35+wNMwNivX9D7suDxfGu+cpb1FfDRAC1BWLA+Ngnnt3p
         fBgMPakGwWYDlywOox21+VZj9jbIO0EvkG2+k6gM5dhNBqoD0R7uunCSAt+WARN5Ukzu
         ubkTlresVE9Nxi4tI1RW7JlROsmxwuptFIUTjJOlHactzCWBuzF6R8IMEZMf7gSciyQ4
         z/BOYbY3+ONVtyONucpGz7Optq1K3U17lqEc8JVCzaHthbKQIIH3kOq5Gvw96HLrX4Kv
         0oKw==
X-Gm-Message-State: APjAAAWTKHtP8NmeSzDLgAIE+Z40FqtJB/l9JN9R9vb38iIwEYCPeBCZ
        2lgtPXpQVnFBxmVZS0EYfybrh6ej
X-Google-Smtp-Source: APXvYqxRSL6Ay3JyES0jAbXGgtqsd5d5kHjBqFuVbg8Z39O7sHw4UI6pQN6DSvR3XTogCnCcBmdA3w==
X-Received: by 2002:a1c:3142:: with SMTP id x63mr9434150wmx.169.1564515327747;
        Tue, 30 Jul 2019 12:35:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 32sm57782317wrh.76.2019.07.30.12.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 12:35:27 -0700 (PDT)
Date:   Tue, 30 Jul 2019 12:35:27 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Jul 2019 19:35:21 GMT
Message-Id: <c0129066a02b39535110ae592c16ca0e5d6d6c24.1564515324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v3.git.gitgitgadget@gmail.com>
References: <pull.292.v2.git.gitgitgadget@gmail.com>
        <pull.292.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/5] repo-settings: add feature.manyCommits setting
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
index 309577f6bc..fc05f4fbc4 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -2,6 +2,8 @@
 #include "config.h"
 #include "repository.h"
 
+#define UPDATE_DEFAULT(s,v) do { if (s == -1) { s = v; } } while(0)
+
 void prepare_repo_settings(struct repository *r)
 {
 	int value;
@@ -22,4 +24,9 @@ void prepare_repo_settings(struct repository *r)
 
 	if (!repo_config_get_bool(r, "pack.usesparse", &value))
 		r->settings.pack_use_sparse = value;
+
+	if (!repo_config_get_bool(r, "feature.manycommits", &value) && value) {
+		UPDATE_DEFAULT(r->settings.core_commit_graph, 1);
+		UPDATE_DEFAULT(r->settings.gc_write_commit_graph, 1);
+	}
 }
-- 
gitgitgadget

