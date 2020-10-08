Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D19C433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 20:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5E22222D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 20:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgJHUYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 16:24:17 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:5528 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730278AbgJHUYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 16:24:16 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:889b:81bb:28ab:56e7])
        by smtp6-g21.free.fr (Postfix) with ESMTP id E5008780375;
        Thu,  8 Oct 2020 22:24:12 +0200 (CEST)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 4/4] doc: fix the bnf like style of some commands
Date:   Thu,  8 Oct 2020 22:23:57 +0200
Message-Id: <20201008202357.15490-4-jn.avila@free.fr>
X-Mailer: git-send-email 2.28.0.rc0
In-Reply-To: <20201008202357.15490-1-jn.avila@free.fr>
References: <20201008202357.15490-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In command line options, variables are entered between < and >

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-init.txt  | 2 +-
 builtin/submodule--helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index f35f70f13d..59ecda6c17 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -70,7 +70,7 @@ repository.
 +
 If this is reinitialization, the repository will be moved to the specified path.
 
--b <branch-name::
+-b <branch-name>::
 --initial-branch=<branch-name>::
 
 Use the specified name for the initial branch in the newly created repository.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index de5ad73bb8..c30896c897 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1308,7 +1308,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper summary [<options>] [commit] [--] [<path>]"),
+		N_("git submodule--helper summary [<options>] [<commit>] [--] [<path>]"),
 		NULL
 	};
 
-- 
2.28.0.rc0

