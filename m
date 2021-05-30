Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91775C47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510A36100B
	for <git@archiver.kernel.org>; Sun, 30 May 2021 12:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhE3MKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 08:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhE3MKo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 08:10:44 -0400
X-Greylist: delayed 2242 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 May 2021 05:09:06 PDT
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45130C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 05:09:06 -0700 (PDT)
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=thomas.baccab.home.arpa); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpa
        id 1lnJfP-0002GI-Mn; Sun, 30 May 2021 13:31:39 +0200
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH] git-completion.bash: Add --anchored
Date:   Sun, 30 May 2021 13:31:35 +0200
Message-Id: <20210530113135.5778-1-thomas.braun@virtuell-zuhause.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1622376546;a0f77901;
X-HE-SMSGID: 1lnJfP-0002GI-Mn
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This flag was introduced in 2477ab2e (diff: support anchoring line(s),
2017-11-27) but back then, the bash completion script did not learn
about the new flag. Add it.

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3c5739b905..4dd268470a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1729,6 +1729,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--indent-heuristic --no-indent-heuristic
 			--textconv --no-textconv
 			--patch --no-patch
+			--anchored=
 "
 
 __git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
-- 
2.31.1

