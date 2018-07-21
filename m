Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4D45208E9
	for <e@80x24.org>; Sat, 21 Jul 2018 12:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeGUNn4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 09:43:56 -0400
Received: from s019.cyon.net ([149.126.4.28]:34748 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeGUNn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 09:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zXfic6uY1MG67VwFXVPNp7HdvcInh0dstdbtmTV8p6k=; b=fP8gDQDqyfg7KsAML8TWhMt3CE
        IDAbxBEI9rRfF5lmW1pyVa6AiWWKFXn06nKWPJac2XgtUzEW9QCsWMbW6D0WF5naT6BYWTMjo8qTE
        m+UyLYzXswmPHP7HU0YyCTN2vsinJsaeC4858zz2fSJRFivGRUbwvDXcoSBozYL+cGsSUEN+9NOPs
        hIU0rRgV0Ty7noa9BubtHfGnsEUoivr5WspBbHtJbLpO1eGwBiibOqdCREk5Tbjemor1NAbaktdF/
        8MnqcDuZ5jgpnM4/9J6Yjwv3PXqkheqBcgKavXIrH9zU7exSVl5z+8H2cXtppg4awAJBwRzWWVd/f
        s3ZzBE8w==;
Received: from [10.20.10.232] (port=51618 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fgrLi-0051mu-FD; Sat, 21 Jul 2018 14:51:10 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id DC5C6205E8; Sat, 21 Jul 2018 14:51:01 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] fixup! builtin/rebase: support running "git rebase <upstream>"
Date:   Sat, 21 Jul 2018 14:49:52 +0200
Message-Id: <20180721124952.26347-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The macro GIT_PATH_FUNC expands to a function definition that ends with
a closing brace. The extra semicolon produces a warning when compiling
with -pedantic.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---

Junio, this applies on top of pk/rebase-in-c.

Thanks, Beat

 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e38ea80874..6aaae2436f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -14,8 +14,8 @@
 #include "refs.h"
 #include "quote.h"
 
-static GIT_PATH_FUNC(apply_dir, "rebase-apply");
-static GIT_PATH_FUNC(merge_dir, "rebase-merge");
+static GIT_PATH_FUNC(apply_dir, "rebase-apply")
+static GIT_PATH_FUNC(merge_dir, "rebase-merge")
 
 enum rebase_type {
 	REBASE_AM,
-- 
2.18.0.203.gfac676dfb9

