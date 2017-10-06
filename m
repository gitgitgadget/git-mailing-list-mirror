Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 763351FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 18:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbdJFSDK (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 14:03:10 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:59720 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752428AbdJFSDJ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Oct 2017 14:03:09 -0400
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=localhost.localdomain); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1e0Wxn-0004j6-CN; Fri, 06 Oct 2017 20:03:07 +0200
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v2 1/1] completion: add --broken and --dirty to describe
Date:   Fri,  6 Oct 2017 20:02:47 +0200
Message-Id: <20171006180247.26718-1-thomas.braun@virtuell-zuhause.de>
X-Mailer: git-send-email 2.14.2.746.g8fb8a945bc.dirty
In-Reply-To: <20171005212344.22887-1-thomas.braun@virtuell-zuhause.de>
References: <20171005212344.22887-1-thomas.braun@virtuell-zuhause.de>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1507312989;0a9a4bea;
X-HE-SMSGID: 1e0Wxn-0004j6-CN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the flags for broken and dirty were implemented in
b0176ce6b5 (builtin/describe: introduce --broken flag, 2017-03-21)
and 9f67d2e827 (Teach "git describe" --dirty option, 2009-10-21)
the completion was not updated, although these flags are useful
completions. Add them.

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Helped-by: Stefan Beller <sbeller@google.com>
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

