Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B8120A40
	for <e@80x24.org>; Sun, 26 Nov 2017 20:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbdKZUTh (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 15:19:37 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:44811 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdKZUTg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 15:19:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so30577644wmr.3
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 12:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KSH2YK8I/quBeIIjXBWd+GLkWo9dCo31j6g92PaWZqY=;
        b=Q8Ol+l+LKaVlMldvmnpI6HR2t4l/bOeMJyTn7v9rTpkKf3ZOJWUDKx/uL3vCNybQYU
         ISnL7lPbQKQQqGq+hGjOSHH9sTsKWy4fPqZ1BXE35mj7Rhor3qDg5EXurIu3sOpX4NTa
         obqxoYfmWy5I9GLiQhjWwyQJHTQgy7gpX8K2/KMwU6THRexMSq8D71ZiqM+rD+e/WLOC
         C8OYJYBpOG5K/PJzlFWAGkErXz86OulMWCdyhKqgbiRvj2sRJon/stgNR7GMzFckdqiX
         /+1nCs3i46P+V10tTU4MaLr1gpWkIyTwlRk250UnaQS7OYsf/nFh5L5h5SsgORmOMg6M
         HPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KSH2YK8I/quBeIIjXBWd+GLkWo9dCo31j6g92PaWZqY=;
        b=R2D92UYiYiPdRhI5oNEIxgak7/WKQBPbsC/UOWy4UNF0yyZvTnna/DVbM1y94qc7U/
         nAqZynKawmmZZmaeK/JQ4PgJhukIw94DGzcHBTYHGrXmengsU2vlo2WSW5u6lTDYtRL5
         HUitxJdAOA6BO4B6qutoW2VnH8Ub67ysn16lsiT5EIRPr06g/9+/5oPEBAiOit3gDbUt
         VhB4LaHfZhNDOPJ9Fb1pIwYLi+ESWF6TNZSBHfGInuYzRuyd5Y4IN9yqVxVzy4cp0X0u
         rsKKfZXBa0zzCCXs9mOZ/YPRk7rhH9nA0o5iMoclBxZCS1NEAlNv0IqW7oowQcdDASQY
         wCyg==
X-Gm-Message-State: AJaThX5QgJoJQZzriHM3TxUqrYa7oavT3+URqI7Fc+SlTdaTUv3idHAn
        Ve2VSE4VUSgVE0BEPA+163b+NhCa
X-Google-Smtp-Source: AGs4zMamPI1EkNM/BjVb7kACyNq0qYbY7L+fThbH+3K/tu4uHCOW16wuTpN/a3gBKqzu4qzbqBwozw==
X-Received: by 10.28.214.205 with SMTP id n196mr13305250wmg.10.1511727575230;
        Sun, 26 Nov 2017 12:19:35 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 64sm14090210wrk.46.2017.11.26.12.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Nov 2017 12:19:34 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v1 1/2] t/README: remove mention of adding copyright notices
Date:   Sun, 26 Nov 2017 20:20:59 +0000
Message-Id: <20171126202100.1658-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We generally no longer include copyright notices in new test scripts.
However t/README still mentions it as something to include at the top of
every new script.

Remove that mention as it's outdated.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

I read through some parts of t/README, while working on the tests for
the worktree dwim patches, and noticed some things that are outdated/a
useful function that's not documented anywhere.  Here's a couple of
patches to fix that.

 t/README | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 4b079e4494..448569b60e 100644
--- a/t/README
+++ b/t/README
@@ -332,13 +332,10 @@ Writing Tests
 -------------
 
 The test script is written as a shell script.  It should start
-with the standard "#!/bin/sh" with copyright notices, and an
+with the standard "#!/bin/sh", and an
 assignment to variable 'test_description', like this:
 
 	#!/bin/sh
-	#
-	# Copyright (c) 2005 Junio C Hamano
-	#
 
 	test_description='xxx test (option --frotz)
 
-- 
2.15.0.426.gb06021eeb

