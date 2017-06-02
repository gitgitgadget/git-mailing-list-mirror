Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FA5F2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 19:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdFBT2Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:28:16 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35621 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdFBT2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:28:15 -0400
Received: by mail-pf0-f174.google.com with SMTP id n23so55849216pfb.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3toY/pDyN/HI3CKLUOeIA8Nbhdxqwml8G8jnII2EK9A=;
        b=Bvlw51XOKXhSqvTbklA7l81dVx7fHTA5iQnw4CO7ngL9nrDBq6ejM4G1aav4Lj7Cmd
         XYUYNaIAnnUvOdUoZ8FzufqqKKog3Gp358V7qdsnoluUvCRdYQWdGegdOa2edwg8ous7
         kxonzxCOHucAk8UphizoMeGJZcO8hRTnFf2nJR8p2Nvkwjw0xUK1iVw3bTBR4jti9Ss8
         p68MYDW8IeicvnsIEoSvvjHD1XNXPM/3O0FaZhsZMC/t6MSf3ZHM5PAvW20m2HIzonjS
         AQthHP2bX68mEw6RXxm7BpfK0S4KSTD3fOvwK9QJI8sCtJewCa9s1VH0SwbYMCeF3iI/
         6Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3toY/pDyN/HI3CKLUOeIA8Nbhdxqwml8G8jnII2EK9A=;
        b=LPXwDtaZ9WR7NQRvQnDw773S53woxluxKwehOlRRS6t+ZB+PQUiV18EzUIdIBwKX2y
         ooqowBOnUc2VbX6/fTOZc3aaUQkLoAqxY4aGpVEwgvYwgm+PVgh+uZUrtDWJmPJSMYpc
         ZbNx/kjjSuVhbBUCo1rxJzStRsFOdHQjxn2q9AASRVgBQAdOT3T+zIuv9Tszh+TfHeHo
         GvTtrBbZKaz6sfg3AhfRykxylw4hMDaPHNYuifyG3C9kneGAtJCWu0WiqTZP5N29Fvg8
         8AgqEelLxPvUO8MDtZe40/oktFgeXQLpib1/+r9xn55ltx9YYFyT9hBkN53o32A3A+Xb
         OisA==
X-Gm-Message-State: AODbwcApWl3nZmA/eqceyQO6Vrjz+XPx+6xw9YS03TFiYqN6OL4N5K6g
        c91TMtx8UiwiDS/x
X-Received: by 10.84.218.206 with SMTP id g14mr323612plm.85.1496431694613;
        Fri, 02 Jun 2017 12:28:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4d01:b9a:6ca2:1de8])
        by smtp.gmail.com with ESMTPSA id e76sm41925544pfb.92.2017.06.02.12.28.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 12:28:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation/git-rm: correct submodule description
Date:   Fri,  2 Jun 2017 12:28:10 -0700
Message-Id: <20170602192810.1230-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gab62347cd9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 3ccd681c2a (Merge branch 'sb/submodule-rm-absorb', 2017-01-18)
git-rm tries to absorb any submodules git dir before deleting the
submodule. Correct the documentation to say so.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-rm.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index f1efc116eb..8c87e8cdd7 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -140,10 +140,11 @@ Only submodules using a gitfile (which means they were cloned
 with a Git version 1.7.8 or newer) will be removed from the work
 tree, as their repository lives inside the .git directory of the
 superproject. If a submodule (or one of those nested inside it)
-still uses a .git directory, `git rm` will fail - no matter if forced
-or not - to protect the submodule's history. If it exists the
-submodule.<name> section in the linkgit:gitmodules[5] file will also
-be removed and that file will be staged (unless --cached or -n are used).
+still uses a .git directory, `git rm` will move the submodules
+git directory into the superprojects git directory to protect
+the submodule's history. If it exists the submodule.<name> section
+in the linkgit:gitmodules[5] file will also be removed and that file
+will be staged (unless --cached or -n are used).
 
 A submodule is considered up-to-date when the HEAD is the same as
 recorded in the index, no tracked files are modified and no untracked
-- 
2.13.0.17.gab62347cd9

