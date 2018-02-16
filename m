Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E4D1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 20:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeBPUpi (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 15:45:38 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:43232 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeBPUpa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 15:45:30 -0500
Received: by mail-io0-f194.google.com with SMTP id 72so5411705iom.10
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 12:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4nay9flsHYOpgs7gEw+YGy2Szmkd9wxudE+ycD+uXaw=;
        b=Zgqfkv2HC3iyz2ZMpMkuGxOSWw0ZpePEOyFDPSE2WO/h1dM/EMNo2bf6RWU5RdVHRM
         SC13HoB7r9fxbIxHEJ5P9dYk/boJsmrRQwP6sWUxwTIl158aNsq0teAkJx9+4zgJSEty
         PReRtS12ES+8pmjuqy+AVWkidueYOhuH6oGU53zpg76JLESMKilNtqsrs/FFc5zX7jI4
         zV80gpLCMn30jnQ+SGfn49jFcN9VFTAVuKETBBOCTHXGoqv/9UFubfJHfFIIt+CwgqRA
         ewmY4+voPSaNJvkgBMAsldc3NqtdEZiaUZVJySeEJG2KhZtXjrOw0+02yE1Yle7Xpo5U
         +qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4nay9flsHYOpgs7gEw+YGy2Szmkd9wxudE+ycD+uXaw=;
        b=SlBdEOh4kc8X9zLyP2RLJkwJ+sqoIX1c4FgbldM4HcPZn8rpaQVNO5kGtWJUW1/NQB
         QKwvxANEU4QXMqcoFM3okXuJ2eBk6zrDQe3bcpKLDSpPIZHjsHvqpFfkG2/jqzFYZ4BH
         UIe+BdEkxUU83n8PtzZzjJXTaIIGqovpmSg6mmd2zNtqfbDPItt57y/tq3kifiHH7O21
         75LHlxGWdUBKDVgmZXQoUZwMbrCO0JHktBWkNMadHV3ENHPKS8JX7Z38zKKYMxJVl1CR
         jQvwm60wykg8tsVwjqH0dcjCH55iXy7AlX1yjQgsoiA6lywfM7FmACVqTCdSZKWDRinA
         K0hA==
X-Gm-Message-State: APf1xPBR/SJVa/YNQZ9hvzY7E9oB8aZHhzwBRR6mmKFDNK+1uIg0Agz+
        sHOQsYMdfOE8Qg+v1fKRQDOD9w==
X-Google-Smtp-Source: AH8x227K4szs9Z3yzwxA9jdcAr9BjX3sKLTgvqo7/4UQZlGlTqlVHomYEfN9z0z0geKRwPKw+Q155w==
X-Received: by 10.107.12.213 with SMTP id 82mr3777495iom.48.1518813929271;
        Fri, 16 Feb 2018 12:45:29 -0800 (PST)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id z75sm2541844ita.3.2018.02.16.12.45.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 16 Feb 2018 12:45:28 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Mike Nordell <tamlin.thefirst@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] git-worktree.txt: fix missing ")" typo
Date:   Fri, 16 Feb 2018 15:44:51 -0500
Message-Id: <20180216204452.2153-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.16.1.374.g7648891022
In-Reply-To: <20180216204452.2153-1-sunshine@sunshineco.com>
References: <20180216204452.2153-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the closing ")" to a parenthetical phrase introduced by 4e85333197
(worktree: make add <path> <branch> dwim, 2017-11-26).

While at it, add a missing ":" at the end of the same sentence since
it precedes an example literal command block.

Reported-by: Mike Nordell <tamlin.thefirst@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 41585f535d..c941c48827 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -52,10 +52,10 @@ is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc. `-` may also be
 specified as `<commit-ish>`; it is synonymous with `@{-1}`.
 +
-If <commit-ish> is a branch name (call it `<branch>` and is not found,
+If <commit-ish> is a branch name (call it `<branch>`) and is not found,
 and neither `-b` nor `-B` nor `--detach` are used, but there does
 exist a tracking branch in exactly one remote (call it `<remote>`)
-with a matching name, treat as equivalent to
+with a matching name, treat as equivalent to:
 ------------
 $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
-- 
2.16.1.374.g7648891022

