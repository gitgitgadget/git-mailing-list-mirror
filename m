Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CAA61F453
	for <e@80x24.org>; Wed, 24 Apr 2019 19:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfDXT6L (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 15:58:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35122 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbfDXT6I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 15:58:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id y67so17078469ede.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WUCE2p21O6NY7oJLvHV0+SqxBNUHByEeSgv0jTqy4mE=;
        b=YHbhf11VrZH8Ft5ukHezg4RHUf2ZTkjhJXzXXEXsu6LKGu5Yow9zemC8U9RnrCb7+V
         6AbkT9qKNWUtRsCOllSByzqNY5IhhHNV7SyP5sYfWbpzJxrvRWM5Q6v876RTdHpRLOGt
         LhqG/W/Lw9mLj4yuSIAfaBGhHvo9SYDHWIMKjaLiFGHyLGbxNVRNy5jcU+dmQx3waeuX
         gHW0zhGL+sz97ID9faCfBssp0MRnipqAojdw8TYfWPG9N0iHOynUC7qazktnqmFWviff
         otyuJtUf/la8+eWl2/AFatESp2vhJMkzASEnWU5+uI4bKAbdk41AoCiqFH4U1qwllEQU
         BfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WUCE2p21O6NY7oJLvHV0+SqxBNUHByEeSgv0jTqy4mE=;
        b=sQOFpgPbhKmovfRr5MuHKPAQZr7K6bxb9Ul1QpmQgG2AIG1CoMMF3xlC3hH0idh0u5
         Z0aSR//uArAJ1eNenESHcuVmr5zc6+M1c2vsSk7UMkppZBDbDCM0kakmW9Q8i6y67My4
         Q83DgveIblShmpS/RqkIrSn130G1G7rnJEBFAS4SSuKUozw/LbTsbhs5uvjUJrqMB/GJ
         MxAZM1D3yovGp2GsA5OEc99dJVEANn1iSNVdEHKj2dfw8XXEzwlMoWVfmrwu4nhJxhMJ
         f7MxANUPLQh5yK4fqsnoExjOW+BkmJlZQBYPrakEpR927O5uVK9PTmd6VRFzzd2UXV/Z
         fHdQ==
X-Gm-Message-State: APjAAAXQaTRZGjqXYKm0NfWkvU0Vvfvoez5pseUVkD36RrVn76Tel1o6
        8QZIXfEKqZMnl2dF7XTenOhoWbUG
X-Google-Smtp-Source: APXvYqwzSF8iOuxgupOyusdBsSS7uvuA0snrowrVYNJTU1oU6U34bifH+JqNI3aMWEtrWCfizAI+pg==
X-Received: by 2002:a17:906:3458:: with SMTP id d24mr17258215ejb.65.1556135886709;
        Wed, 24 Apr 2019 12:58:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d59sm1258223edc.34.2019.04.24.12.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:58:06 -0700 (PDT)
Date:   Wed, 24 Apr 2019 12:58:06 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Apr 2019 19:58:00 GMT
Message-Id: <b1b0c76eb494307a289caf63399a3450926bab9a.1556135881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v2.git.gitgitgadget@gmail.com>
References: <pull.112.git.gitgitgadget@gmail.com>
        <pull.112.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/5] commit-graph: add --version=<n> option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Allow the commit-graph builtin to specify the file format version
using the '--version=<n>' option. Specify the version exactly in
the verification tests as using a different version would change
the offsets used in those tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  3 +++
 builtin/commit-graph.c             | 13 +++++++++++--
 t/t5318-commit-graph.sh            |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 624470e198..1d1cc70de4 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -51,6 +51,9 @@ or `--stdin-packs`.)
 +
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
++
+With the `--version=<n>` option, specify the file format version. Used
+only for testing.
 
 'read'::
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 828b1a713f..65ceb7a141 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,7 +10,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph verify [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits] [--version=<n>]"),
 	NULL
 };
 
@@ -25,7 +25,7 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits] [--version=<n>]"),
 	NULL
 };
 
@@ -35,6 +35,7 @@ static struct opts_commit_graph {
 	int stdin_packs;
 	int stdin_commits;
 	int append;
+	int version;
 } opts;
 
 
@@ -156,6 +157,8 @@ static int graph_write(int argc, const char **argv)
 			N_("start walk at commits listed by stdin")),
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
+		OPT_INTEGER(0, "version", &opts.version,
+			N_("specify the file format version")),
 		OPT_END(),
 	};
 
@@ -170,6 +173,12 @@ static int graph_write(int argc, const char **argv)
 	if (opts.append)
 		flags |= COMMIT_GRAPH_APPEND;
 
+	switch (opts.version) {
+	case 1:
+		flags |= COMMIT_GRAPH_VERSION_1;
+		break;
+	}
+
 	read_replace_refs = 0;
 
 	if (opts.reachable)
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index e80c1cac02..4eb5a09ef3 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -328,7 +328,7 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 
 test_expect_success 'git commit-graph verify' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
+	git rev-parse commits/8 | git commit-graph write --stdin-commits --version=1 &&
 	git commit-graph verify >output
 '
 
-- 
gitgitgadget

