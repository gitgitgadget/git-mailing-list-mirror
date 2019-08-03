Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BA71F731
	for <e@80x24.org>; Sat,  3 Aug 2019 10:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388423AbfHCKTB (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 06:19:01 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:28472 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388371AbfHCKTB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 06:19:01 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id B609E2003C8;
        Sat,  3 Aug 2019 12:18:54 +0200 (CEST)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [RFC] l10n: fix some typos for v2.23.0
Date:   Sat,  3 Aug 2019 12:18:32 +0200
Message-Id: <20190803101832.30307-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730033512.7226-1-worldhello.net@gmail.com>
References: <20190730033512.7226-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/checkout.c | 2 +-
 builtin/fetch.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 91f8509f85..75efc37bc7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1769,7 +1769,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	struct option *options;
 	struct option restore_options[] = {
 		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
-			   N_("where the checkout from")),
+			   N_("where to checkout from")),
 		OPT_BOOL('S', "staged", &opts.checkout_index,
 			   N_("restore the index")),
 		OPT_BOOL('W', "worktree", &opts.checkout_worktree,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 53ce99d2bb..3422e6bdf7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1005,12 +1005,12 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 
 	if (advice_fetch_show_forced_updates) {
 		if (!fetch_show_forced_updates) {
-			warning(_("Fetch normally indicates which branches had a forced update, but that check has been disabled."));
-			warning(_("To re-enable, use '--show-forced-updates' flag or run 'git config fetch.showForcedUpdates true'."));
+			warning(_("Fetch normally indicates which branches had a forced update, but that check has been disabled."
+				"To re-enable, use '--show-forced-updates' flag or run 'git config fetch.showForcedUpdates true'."));
 		} else if (forced_updates_ms > FORCED_UPDATES_DELAY_WARNING_IN_MS) {
-			warning(_("It took %.2f seconds to check forced updates. You can use '--no-show-forced-updates'\n"),
+			warning(_("It took %.2f seconds to check forced updates. You can use '--no-show-forced-updates'\n"
+				"or run 'git config fetch.showForcedUpdates false' to avoid this check.\n"),
 				forced_updates_ms / 1000.0);
-			warning(_("or run 'git config fetch.showForcedUpdates false' to avoid this check.\n"));
 		}
 	}
 
-- 
2.22.0

