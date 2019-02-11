Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA111F453
	for <e@80x24.org>; Mon, 11 Feb 2019 06:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfBKGpB (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 01:45:01 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:19931 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfBKGpB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 01:45:01 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 1C0B12003DC;
        Mon, 11 Feb 2019 07:44:58 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] Fix typos in translatable strings for v2.21.0
Date:   Mon, 11 Feb 2019 07:44:53 +0100
Message-Id: <20190211064453.5205-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.21.0.rc0
In-Reply-To: <20190209213044.29539-1-jn.avila@free.fr>
References: <20190209213044.29539-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/bisect--helper.c | 4 ++--
 builtin/fetch.c          | 2 +-
 builtin/rebase.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c1cff32661..e7325fe37f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -173,7 +173,7 @@ static int bisect_reset(const char *commit)
 			argv_array_clear(&argv);
 			return error(_("could not check out original"
 				       " HEAD '%s'. Try 'git bisect"
-				       "reset <commit>'."), branch.buf);
+				       " reset <commit>'."), branch.buf);
 		}
 		argv_array_clear(&argv);
 	}
@@ -646,7 +646,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
-			 N_("no log for BISECT_WRITE ")),
+			 N_("no log for BISECT_WRITE")),
 		OPT_END()
 	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5a09fe24cd..b620fd54b4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1480,7 +1480,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	if (strcmp(remote->name, repository_format_partial_clone)) {
 		if (filter_options.choice)
 			die(_("--filter can only be used with the remote "
-			      "configured in extensions.partialclone"));
+			      "configured in extensions.partialClone"));
 		return;
 	}
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 96efd40901..7c7bc13e91 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1434,7 +1434,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (options.reschedule_failed_exec && !is_interactive(&options))
-		die(_("--reschedule-failed-exec requires an interactive rebase"));
+		die(_("%s requires an interactive rebase"), "--reschedule-failed-exec");
 
 	if (options.git_am_opts.argc) {
 		/* all am options except -q are compatible only with --am */
-- 
2.21.0.rc0

