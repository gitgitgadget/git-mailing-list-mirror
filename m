Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEEF31F424
	for <e@80x24.org>; Mon,  9 Apr 2018 07:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDIHex (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 03:34:53 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36092 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeDIHet (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 03:34:49 -0400
Received: by mail-io0-f193.google.com with SMTP id o4so8476401iod.3
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 00:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=61+AlhoZ1WYxZKMi1EqfrSbfhUYfWIUm9JLhiPzpUws=;
        b=kC9iWG98Fw0Nh4MeoDPo5Tl2RB97uzu645e2UED86uLG9tZfiMxx/NhFm/CFu4sdG9
         R2sI9GUj0rtPlVMF69AemXHmeyEETGtYjtsERW8fXW7lcOi6UIqa1TCSbXgSaZzNfoVs
         Xrx9SH19+TnWGMwU325YOKw51Q3fo8LagFO8vK9M49WeeAigt0d0hlT89/9LdSq+u5s5
         k15ivuCrDow/q8Q0txCoLhInZ8jTvoE35y81o94N494POinZZcCi6N+dZdSpLeRvvK66
         CNxTV2SB56x5naz2+NzNVJFUAibE0OVLuOdb2DgGiHvEH1RK0fdaO0Lv/NlNcX6CNCHK
         FYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=61+AlhoZ1WYxZKMi1EqfrSbfhUYfWIUm9JLhiPzpUws=;
        b=B+hL8CbahsoYUKBygqnCxFGlHO5H6WKTiEUtAQdzL7w8jsv5qP3fhm9XxMkD0LRyWb
         sjb5V51djtjmC0LSaOXo4HHhT5L07JaDdDK9e/yN931XZnkA8F6kwWImqQgx9J1Tk18u
         4pyiWZ2qb3usXIgyje/P6vL+guYddnskCOj/X1CZKknHXE0sfb/hkSey/TRwsSPFQYyA
         3WvvcGEaoxSckHKmqFgWqtvhDXyrknESXCh/tjEMu+lizKtrSw6/Vbj+7Xst/KjRcg1/
         Y89v0mUBzyrxKUYCZREu3WUym0j2XH2aAmXM6wYVem++aXY7lpKccNaegYuROnDl/ctT
         padQ==
X-Gm-Message-State: ALQs6tBIakDtH5SGxFyrBvsG9mbvQQIHpVDOgfdfdkN+hbUUOD6zn5+C
        DXhj/iTqpOGIhiqaShqzemLgCQ==
X-Google-Smtp-Source: AIpwx4+jG1dTKmm6+7HRaeAv6T9o4oFHJOTA3slJlpZrReTXtc3kUcJ6KoG08dHCQl5lf4lgfSfwpA==
X-Received: by 10.107.41.85 with SMTP id p82mr29515879iop.81.1523259288595;
        Mon, 09 Apr 2018 00:34:48 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id a24sm9113485ioc.42.2018.04.09.00.34.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 Apr 2018 00:34:48 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] git-worktree.txt: unify command-line prompt in example blocks
Date:   Mon,  9 Apr 2018 03:34:00 -0400
Message-Id: <20180409073400.19415-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c
In-Reply-To: <20180409073400.19415-1-sunshine@sunshineco.com>
References: <20180409073400.19415-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command-line prompt in the "EXAMPLES" section is "$", however,
examples in the 'git worktree list' section (oddly) use "S" as a
prompt. Fix this inconsistency by settling on "$" as prompt in all
examples.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index bc9cd8b60f..2755ca90e3 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -233,7 +233,7 @@ The worktree list command has two output formats.  The default format shows the
 details on a single line with columns.  For example:
 
 ------------
-S git worktree list
+$ git worktree list
 /path/to/bare-source            (bare)
 /path/to/linked-worktree        abcd1234 [master]
 /path/to/other-linked-worktree  1234abc  (detached HEAD)
@@ -248,7 +248,7 @@ if the value is true.  An empty line indicates the end of a worktree.  For
 example:
 
 ------------
-S git worktree list --porcelain
+$ git worktree list --porcelain
 worktree /path/to/bare-source
 bare
 
-- 
2.17.0.484.g0c8726318c

