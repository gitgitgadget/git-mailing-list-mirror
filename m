Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32AE1F404
	for <e@80x24.org>; Thu, 12 Apr 2018 22:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeDLW53 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 18:57:29 -0400
Received: from ao2.it ([92.243.12.208]:51128 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753223AbeDLW53 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 18:57:29 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6kZd-0008V4-Rv; Fri, 13 Apr 2018 00:20:09 +0200
Received: from ao2 by jcn with local (Exim 4.90_1)
        (envelope-from <ao2@ao2.it>)
        id 1f6kad-0001VL-RJ; Fri, 13 Apr 2018 00:21:11 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [RFC 06/10] completion: add 'core.submodulesfile' to the git-completion.bash file
Date:   Fri, 13 Apr 2018 00:20:43 +0200
Message-Id: <20180412222047.5716-7-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180412222047.5716-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a75707394..19beb6735 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2382,6 +2382,7 @@ _git_config ()
 		core.sparseCheckout
 		core.splitIndex
 		core.sshCommand
+		core.submodulesfile
 		core.symlinks
 		core.trustctime
 		core.untrackedCache
-- 
2.17.0

