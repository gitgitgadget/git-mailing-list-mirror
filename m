Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8D82036D
	for <e@80x24.org>; Tue, 21 Nov 2017 14:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdKUOjb (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 09:39:31 -0500
Received: from mail.kdab.com ([176.9.126.58]:38024 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbdKUOjb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 09:39:31 -0500
X-Virus-Scanned: amavisd-new at kdab.com
From:   Albert Astals Cid <albert.astals.cid@kdab.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] bash completion: Add --autostash and --no-autostash to pull
Date:   Tue, 21 Nov 2017 15:39:28 +0100
Message-ID: <94455771.5s97AYBuGd@yoga>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ideally we should only autocomplete if pull has --rebase since
they only work with it but could not figure out how to do that
and the error message of doing git pull --autostash points out
that you need --rebase so i guess it's good enough

Signed-off-by: Albert Astals Cid <albert.astals.cid@kdab.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-
completion.bash
index 539d7f84f..7ded58f38 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1923,6 +1923,7 @@ _git_pull ()
 	--*)
 		__gitcomp "
 			--rebase --no-rebase
+			--autostash --no-autostash
 			$__git_merge_options
 			$__git_fetch_options
 		"
-- 
2.15.0


