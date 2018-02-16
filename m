Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9DA21F404
	for <e@80x24.org>; Fri, 16 Feb 2018 20:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbeBPUpe (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 15:45:34 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:38324 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeBPUpa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 15:45:30 -0500
Received: by mail-io0-f193.google.com with SMTP id d13so5423335iog.5
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 12:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=46uSxSzeoM55SQZ8lGaVLwPPKNXl3jLfzwh9DiIuw5k=;
        b=GYszO/+5dxS1g3OMP4e+js93tI7wBmOCaAdv+MMgfOw5KoIOPcWYwKQaJnHmjtoOv7
         ka0E0dKk5DnPtYHgp6Pc3TnwIr4ZUOpYsWk4Rmz9pDnX3lg2kqXjZCW5we2SgK3niI9g
         3cBrkPp0MYjy3cJeMETvpBIC4W5JgxK9wRm3nSvop15cUt1LUoDpAWJj9j1OwuxxML2D
         MB7B8Qj+B0bq6mVOus3cq0blx4+SfiTdbrCeJg0zZDLRxhl/ZBtEIhis3mcVZM5Y5iYD
         RGZHeCeAxmKm8RFviWN+IXelFVlPdNa/tmMuG5fDQT37WuCFG78wdWDN1a3sBOu7xl6c
         Iluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=46uSxSzeoM55SQZ8lGaVLwPPKNXl3jLfzwh9DiIuw5k=;
        b=SiyudpJ5z3yif8HAQDF0akJFBaiLD05IOKHxn5aeiJ8MzokEojKq6AApZQjRsFsfy8
         7ySyj3aNsZzmIBdHbZb23qSsulyG8uXR1tBhlkEuRzr7/M+TAeeIUQptU+ygBey6ZSbI
         AWaFGbYeCLxGrZwnYlEqUyEy6WOMj3OIJg9up49xSnTzxe/X6xn+h7JZtnZXb+Dt+9UA
         bt5Bt4BvteXUL9wyxt8Irc5rejs+b31Y1peBDJ984r2Cn21XQ9iFAvMWr2ffp0Xq9twe
         QGdkEPACPTdo1BBKh54qaXTz70RKH0ZYlg+MQniP0e7CC9CEjTnPykssHVBMyQv+KzD9
         BSvw==
X-Gm-Message-State: APf1xPCXnZv6uDtIVz20DyuZbWoxP3yBofcspZuuCi7SFG6I26hj2XAU
        Z8cwm2LkNHRTZ7toC5kEEcIBpA==
X-Google-Smtp-Source: AH8x225GZy29RifLLJeLZndKRYJCxQmVIdvD3lc3IziF6kPnNoU99QiDVsDwTXIdXvqZGi53jaJqrw==
X-Received: by 10.107.44.68 with SMTP id s65mr10226360ios.159.1518813930149;
        Fri, 16 Feb 2018 12:45:30 -0800 (PST)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id z75sm2541844ita.3.2018.02.16.12.45.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 16 Feb 2018 12:45:29 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Mike Nordell <tamlin.thefirst@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] git-worktree.txt: fix indentation of example and text of 'add' command
Date:   Fri, 16 Feb 2018 15:44:52 -0500
Message-Id: <20180216204452.2153-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.16.1.374.g7648891022
In-Reply-To: <20180216204452.2153-1-sunshine@sunshineco.com>
References: <20180216204452.2153-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 4e85333197 (worktree: make add <path> <branch> dwim, 2017-11-26)
added an example command in a literal code block, it neglected to
insert a mandatory "+" line before the block. This omission resulted
in both the literal code block and the (existing) paragraph following
the block to be outdented, even though they should be indented under
the 'add' sub-command along with the rest of the text pertaining to
that command. Furthermore, the mandatory "+" line separating the code
block from the following text got rendered as a leading character on
the line ("+ If <commit-ish>...") rather than being treated as a
formatting directive.

Fix these problems by adding the missing "+" line before the example
code block.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index c941c48827..5ac3f68ab5 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -56,6 +56,7 @@ If <commit-ish> is a branch name (call it `<branch>`) and is not found,
 and neither `-b` nor `-B` nor `--detach` are used, but there does
 exist a tracking branch in exactly one remote (call it `<remote>`)
 with a matching name, treat as equivalent to:
++
 ------------
 $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
-- 
2.16.1.374.g7648891022

