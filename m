Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BEE3208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 12:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbdHUMxU (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 08:53:20 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55655 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbdHUMxT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 08:53:19 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Lg4uF-1dCO7403yd-00pazb; Mon, 21
 Aug 2017 14:53:17 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     hIpPy <hippy2981@gmail.com>
Subject: [PATCH v2 1/3] Documentation/git-merge: explain --continue
Date:   Mon, 21 Aug 2017 14:53:14 +0200
Message-Id: <ddd9c06813f8e2e9d8160f2ed965e728190bc573.1503319519.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.364.ge466dba5f7
In-Reply-To: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
References: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
In-Reply-To: <cover.1503319519.git.git@grubix.eu>
References: <cover.1503319519.git.git@grubix.eu>
X-Provags-ID: V03:K0:D6Pw0Tp0m884FoQElGAOtxL0MuHavR/k3tDd1Tb8VPrRUpDd4/M
 LvW5sAMe1fX+9Zu+RGebHq4xnNQfb9dr19H6Co9qulehf6muqXdOSmNkzGN6UjQkfdqM4XE
 a0mjb27GyT2eWZAQtdMkP29VNfMGGEEmpus+SVZ5h+kiOe67eWjaToel7olK+jno4wPjbm1
 XeQT0Hvv62583i4UwZQ+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B1dYEi8D5kE=:yAf8eCFeIh2unWFuCAvAXv
 +HdOmMLqYq0lAUlH0PjaYOBFnBAqBU2cYmqAZuD/UMWhd857XIsRcqSOhDz1aHhzFFnfaHi1P
 ySv3DUQlPOXXO7nQaOi1KbkynVZJfHpp7x51q4qic77ewq79BwLAlb+RK0FaOfSgM6xgnVULE
 xmyXoGCiANkQsliQmdrfblDMN31xjYAVkfKnnTQ9NQ1qUe4DNiZm4AfuZOo4OAtOY/XtQiA/E
 BOwOBTOz86ewoW6kehcQ2AycLug2KoFeSj6s4xfgtxZcW1GBz/RhD44nmjSV08Qo39JrZu+6Y
 3mrT6J4fuDZDNVVkslwVfOalCIcRsyacwRCoPBE+06D5uUTl7wmnbiHlr0IWHPpJo9mRjuHmd
 P/3unQLhMHjQER6i1iQrSFP40UkEGsOgaz8Cm3EvdnQasfhKSykDNjhOuu1PTA9D3KBcvY2El
 56DEDKnf5apu8FKpdEH6/YX7/E097XlBxH5i9h3zQTy9HnKx/VQ0bWN6KF5wANOWjE+6QyMss
 MzgKsYsncLdIePYRqcco7uvivkGWgGyJJZfKCqakHf5XK1HkQZ+9wAPys6jKu9xK84rkhRdzQ
 y2HuLRl9wONkNWztai8peEdEBr8D0BJlU7YRh8ZqJexnVX2xWl90ZrNEr08uerZipqTPxfBE1
 +A76aHflD1QkngdMzW7lPeHB/Y+VrSPtm7UnerCeBnJC9YcqPWxHA4HulSMS5a2iA4aR6e+M9
 SPJthlrxftvyzxIWz7HPA5wAc3Ooh3p66wR4Cg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, 'git merge --continue' is mentioned but not explained.

Explain it.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 Documentation/git-merge.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 6b308ab6d0..615e6bacde 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -288,7 +288,10 @@ After seeing a conflict, you can do two things:
 
  * Resolve the conflicts.  Git will mark the conflicts in
    the working tree.  Edit the files into shape and
-   'git add' them to the index.  Use 'git commit' to seal the deal.
+   'git add' them to the index.  Use 'git commit' or
+   'git merge --continue' to seal the deal. The latter command
+   checks whether there is a (interrupted) merge in progress
+   before calling 'git commit'.
 
 You can work through the conflict with a number of tools:
 
-- 
2.14.1.364.ge466dba5f7

