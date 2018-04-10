Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A6F1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeDJSgG (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:36:06 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34955 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeDJScw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:32:52 -0400
Received: by mail-wr0-f195.google.com with SMTP id o3so1460299wri.2
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ewNTXA7CAZe30KDsKoicDZDkNyAWGd0zeaKmjTtytUM=;
        b=YHqTWa0Gg4KGcQ33LpQl5ec0f5KliWK3O24XrXJ3eWjXP8SNvQ6WtGK+3tJqjABtd8
         9lMb3S9O6hceqJwBLqqoFSKaMs7Go57pOmtJ8ARmsz2DvSdbnTUuAaN/tLlYhzfYNyJQ
         GCFKBBNb1CnFQYtrKuj7mWbOo8jkyOfXk20yqO1tf9PRaMzCZkKjdKmjhKt/1+2JLCM7
         A3uuaAUpIT9JPCnw/D6SBSIeoT6rSN1yOcoWWH/xbUUdXDVlEl7avMk5aXXe6iQb7d0c
         knEX9yZEEFrE+TrUW4euw9rtW0SHALa9Jof7Q9Q6xfE5n6iVz2wbU+8/gnlvDqfLyNy6
         Offw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ewNTXA7CAZe30KDsKoicDZDkNyAWGd0zeaKmjTtytUM=;
        b=VsgBMgHHiPITd1S3EI4yp4qCwRD8TnfVYXzSapS2oMGEHDpy8SnB0z+xYPrA79t32J
         qQSPJn9zxM4b4Hs3UDL4jl7WM8HUix+evGSO1pGGIKk2A1WB3iPDZXNEWdmXTqXShDUq
         aXHhsaCeoZ5A3riMniZ9VgKPq0emrzsmm+r0NIHXupcY/lLe1vt4Xloz2LEB/QF4bJn1
         x48CqKRpjiOX+acRDqIiFS79DYmFyJcL1De+X7XVxnS3JTZtcF1xjgL4R1qQtPdY4eiy
         UeCrKlvqC389S3h+EYIIlsr7gSHQB/fQnxGiPA+xbHplQ89OROBq/CEdjZQnMN5lB8Qe
         bu1Q==
X-Gm-Message-State: ALQs6tBE2Fw4I+bVg9esQZinozBazmFN3NzeLTqs44FDvNrMX7/NJUqt
        EOAnhpbHNxvDBn1SP1INgQviPw==
X-Google-Smtp-Source: AIpwx4/tyB280HXplNLX0YG0VpEElndbWEOMuisVL8D5PQ62VkTHURiLZ1RYpxzDKdr7HBTNtYs0mQ==
X-Received: by 10.223.226.205 with SMTP id d13mr1220247wrj.152.1523385171252;
        Tue, 10 Apr 2018 11:32:51 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:91e0:5390:d305:a939])
        by smtp.gmail.com with ESMTPSA id j21sm4426354wrb.49.2018.04.10.11.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Apr 2018 11:32:50 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 1/6] doc: fix formatting inconsistency in githooks.txt
Date:   Tue, 10 Apr 2018 20:32:19 +0200
Message-Id: <20180410183224.10780-2-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The section 'post-rewrite' in 'githooks.txt' renders only one command
using backticks (`git commit`) but the other commands using single quotes
('git-rebase'). Align this formatting to use single quotes.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/githooks.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index f877f7b7cd..070e745b41 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -417,8 +417,8 @@ to abort.
 post-rewrite
 ~~~~~~~~~~~~
 
-This hook is invoked by commands that rewrite commits (`git commit
---amend`, 'git-rebase'; currently 'git-filter-branch' does 'not' call
+This hook is invoked by commands that rewrite commits ('git commit
+--amend', 'git-rebase'; currently 'git-filter-branch' does 'not' call
 it!).  Its first argument denotes the command it was invoked by:
 currently one of `amend` or `rebase`.  Further command-dependent
 arguments may be passed in the future.
-- 
2.16.2

