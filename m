Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431D720A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbdBAXI1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:08:27 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:22245 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbdBAXI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:08:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 528821E308A;
        Thu,  2 Feb 2017 00:08:24 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ceJyqojsh9b5; Thu,  2 Feb 2017 00:08:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 06EC01E3089;
        Thu,  2 Feb 2017 00:08:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DY2o5JL5OxgY; Thu,  2 Feb 2017 00:08:23 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-21.dynamic.mnet-online.de [185.17.206.21])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 9E4C51E308C;
        Thu,  2 Feb 2017 00:08:23 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     bmwill@google.com, sbeller@google.com,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH 2/2] completion: add completion for --recurse-submodules=only
Date:   Thu,  2 Feb 2017 00:07:53 +0100
Message-Id: <20170201230753.19462-2-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170201230753.19462-1-cornelius.weig@tngtech.com>
References: <20170201230753.19462-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Command completion for 'git-push --recurse-submodules' already knows to
complete some modes. However, the recently added mode 'only' is missing.

Adding 'only' to the recognized modes completes the list of non-trivial
modes.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ff7072a..fe3b0f8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1675,7 +1675,7 @@ _git_pull ()
 	__git_complete_remote_or_refspec
 }
 
-__git_push_recurse_submodules="check on-demand"
+__git_push_recurse_submodules="check on-demand only"
 
 __git_complete_force_with_lease ()
 {
-- 
2.10.2

