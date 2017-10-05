Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1851C1FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 21:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbdJEVpQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 17:45:16 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:51010 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751381AbdJEVpQ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Oct 2017 17:45:16 -0400
X-Greylist: delayed 1289 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Oct 2017 17:45:15 EDT
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=localhost.localdomain); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1e0DxC-0000AA-Qt; Thu, 05 Oct 2017 23:45:14 +0200
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH 1/1] completion: Add forgotten describe options
Date:   Thu,  5 Oct 2017 23:45:07 +0200
Message-Id: <20171005214507.3283-1-thomas.braun@virtuell-zuhause.de>
X-Mailer: git-send-email 2.14.2.746.g8fb8a945bc.dirty
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1507239916;3164b070;
X-HE-SMSGID: 1e0DxC-0000AA-Qt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d934417475..0e16f017a4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1385,7 +1385,7 @@ _git_describe ()
 		__gitcomp "
 			--all --tags --contains --abbrev= --candidates=
 			--exact-match --debug --long --match --always --first-parent
-			--exclude
+			--exclude --dirty --broken
 			"
 		return
 	esac
-- 
2.14.2.746.g8fb8a945bc.dirty

