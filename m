Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09900C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 20:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B73CA2222C
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 20:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgJHUYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 16:24:38 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:8796 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgJHUYi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 16:24:38 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:889b:81bb:28ab:56e7])
        by smtp6-g21.free.fr (Postfix) with ESMTP id 48B36780344;
        Thu,  8 Oct 2020 22:24:05 +0200 (CEST)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 2/4] doc: use linkgit macro where needed.
Date:   Thu,  8 Oct 2020 22:23:55 +0200
Message-Id: <20201008202357.15490-2-jn.avila@free.fr>
X-Mailer: git-send-email 2.28.0.rc0
In-Reply-To: <20201008202357.15490-1-jn.avila@free.fr>
References: <20201008202357.15490-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-grep.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index a7f9bc99ea..6077ff01a4 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -209,7 +209,7 @@ providing this option will cause it to die.
 	Use \0 as the delimiter for pathnames in the output, and print
 	them verbatim. Without this option, pathnames with "unusual"
 	characters are quoted as explained for the configuration
-	variable core.quotePath (see git-config(1)).
+	variable core.quotePath (see linkgit:git-config[1]).
 
 -o::
 --only-matching::
-- 
2.28.0.rc0

