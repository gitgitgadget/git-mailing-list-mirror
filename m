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
	by dcvr.yhbt.net (Postfix) with ESMTP id C5D6E1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 07:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfIZHme (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 03:42:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33378 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730670AbfIZHmd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 03:42:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so953306lfc.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 00:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ppm30Fw8VXNNVYkDmVIhV0RP2Bwtc5Ol/NFbZQSsOO4=;
        b=CjKgWepZIBWHz5VRycLjhMy2zFdCPCFbJPmcRP7xxDjgYycEFVG+R09pSxBKpnyMt6
         fwIBAR8Rq2V7auBfr9Hzp8FX4tXhzWQOs7Mhj/XHYh6MonsPZRioFuqjTzvP/V08bwt9
         yqPJ9VMqyzlGDZcrvj+xCGRLnSBoZcjFILYNCaqipMok4JcsYGqFN3ZbZCmakBwxjjBa
         dqPmyT16RPG+Bo6eqG6XJkfcG//+ibMLKnf/iMHb762PvZrygtYkvfJW47ttdT5FbL22
         q2sRseQWs60U1kJXf4IxXiXeNStUD/Ch2Yb6rHWoK3G713w3TEwCmzFME/UN8I/YyhFK
         w/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ppm30Fw8VXNNVYkDmVIhV0RP2Bwtc5Ol/NFbZQSsOO4=;
        b=EBvimZ0V3SxzoIt3Wb3AdVr0uD/m1+MwosEYAn7TT1zp6bEJHiJse+XY5ljnIbGCZI
         Vzt85Wv9NDekQARWmKiYbWlTBWvLWLBDdMfje0oRZMJmEg6LPOAexLXpajR3VCQ2okmn
         rNENPN250KYW4+Ffat4QqhBtRk44Ix1IBur52Fsbx83/icpRJkMmGmL2fzsmpUtjTYiO
         aPGFtm2spIj/43KUeYnG7RcnjYyOjk+tcUT8qvcWups4v2V/Wuwd5b53ZJ7ztTwPuBPQ
         nOKZAexJfPJHa/l15FWI7NBn8R1ilbUYcF/k0m3gcx5dqTTWgvvLsrYOzl8ggOP8l4/C
         0Mkg==
X-Gm-Message-State: APjAAAVfwE9qT21PDhMjdQkd4q9VlIicKNflR7cf7NG1oT9u80VEsFj1
        SW8vAxjnIEV2+3KfLgw1IHrDDNr5
X-Google-Smtp-Source: APXvYqwL9pspvlhB6kHhjldWzUZ5ClhIJZKmJFZI/15P6Sqb5iaqge0f0CbDpo10+eNaEL9063V/Fg==
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr1293802lfp.61.1569483751544;
        Thu, 26 Sep 2019 00:42:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm377749ljf.1.2019.09.26.00.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 00:42:31 -0700 (PDT)
Date:   Thu, 26 Sep 2019 00:42:31 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 07:42:26 GMT
Message-Id: <c263eb54b30b3e93abb74662d120d8bb882322bb.1569483748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.355.git.gitgitgadget@gmail.com>
References: <pull.355.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] update-index: optionally leave skip-worktree entries
 alone
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

While `git update-index` mostly ignores paths referring to index entries
whose skip-worktree bit is set, in b4d1690df11 (Teach Git to respect
skip-worktree bit (reading part), 2009-08-20), for reasons that are not
entirely obvious, the `--remove` option was made special: it _does_
remove index entries even if their skip-worktree bit is set.

Seeing as this behavior has been in place for a decade now, it does not
make sense to change it.

However, in preparation for fixing a bug in `git stash` where it
pretends that skip-worktree entries have actually been removed, we need
a mode where `git update-index` leaves all skip-worktree entries alone,
even if the `--remove` option was passed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-update-index.txt | 6 ++++++
 builtin/update-index.c             | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1c4d146a41..08393445e7 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	     [--chmod=(+|-)x]
 	     [--[no-]assume-unchanged]
 	     [--[no-]skip-worktree]
+	     [--[no-]ignore-skip-worktree-entries]
 	     [--[no-]fsmonitor-valid]
 	     [--ignore-submodules]
 	     [--[no-]split-index]
@@ -113,6 +114,11 @@ you will need to handle the situation manually.
 	set and unset the "skip-worktree" bit for the paths. See
 	section "Skip-worktree bit" below for more information.
 
+
+--[no-]ignore-skip-worktree-entries::
+	Do not remove skip-worktree (AKA "index-only") entries even when
+	the `--remove` option was specified.
+
 --[no-]fsmonitor-valid::
 	When one of these flags is specified, the object name recorded
 	for the paths are not updated. Instead, these options
diff --git a/builtin/update-index.c b/builtin/update-index.c
index dff2f4b837..074d563df0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -35,6 +35,7 @@ static int verbose;
 static int mark_valid_only;
 static int mark_skip_worktree_only;
 static int mark_fsmonitor_only;
+static int ignore_skip_worktree_entries;
 #define MARK_FLAG 1
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
@@ -381,7 +382,8 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 		 * so updating it does not make sense.
 		 * On the other hand, removing it from index should work
 		 */
-		if (allow_remove && remove_file_from_cache(path))
+		if (!ignore_skip_worktree_entries && allow_remove &&
+		    remove_file_from_cache(path))
 			return error("%s: cannot remove from the index", path);
 		return 0;
 	}
@@ -1013,6 +1015,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		{OPTION_SET_INT, 0, "no-skip-worktree", &mark_skip_worktree_only, NULL,
 			N_("clear skip-worktree bit"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
+		OPT_BOOL(0, "ignore-skip-worktree-entries", &ignore_skip_worktree_entries,
+			 N_("do not touch index-only entries")),
 		OPT_SET_INT(0, "info-only", &info_only,
 			N_("add to index only; do not add content to object database"), 1),
 		OPT_SET_INT(0, "force-remove", &force_remove,
-- 
gitgitgadget

