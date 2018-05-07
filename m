Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82BF200B9
	for <e@80x24.org>; Mon,  7 May 2018 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeEGRxa (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 13:53:30 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34011 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752737AbeEGRxP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 13:53:15 -0400
Received: by mail-lf0-f68.google.com with SMTP id h4-v6so41922673lfc.1
        for <git@vger.kernel.org>; Mon, 07 May 2018 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/OK4TzKIJkS91APxDOnMBp+RdQ5CxIV4oiYWAyBWLck=;
        b=FtcDfzZ7rHyCmHNEMZCZKylRr7wMbF9DJSSZOJC+epE4u0ZqyTnBORhtYkrSojvnUe
         dFfaIhdEUetBc2246GdsaNVL2AoQOoWwZ1KsViIFzObykqie7wdGGHhDzVCQW7pEz1qZ
         mkERWgSshnJdtrQPy1aafqg7SrQ0ipIU8JZC7vg4UBVc4YRg1EbW7T1GmyxHUAQpbJkb
         nasiRejfVYkeIPZkHyXJgEV7hOC17YQPTD5EUMz4hUZgD/hOrIwOecak3Qg6VMSGZ+R2
         bOkfTE4kLEOt7Yi+e8bqawM0sjAiKmp/Mhfd/Lb67T0ScmI5ok0OF3mLrbdG0jnyu7cH
         5NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/OK4TzKIJkS91APxDOnMBp+RdQ5CxIV4oiYWAyBWLck=;
        b=FIa1FChdKPbvYp0BmdsLZ9cD9XlDGmRZyBJph/mRvbhTzOJ3YBu1E1U83625WMthxb
         uKFuRIb8O9yyVYVnKWlLr4HhCsmzWMM0f2Ef7168Y6NVHcCLGMc5z2P7/nCttOVbbcYD
         0yDafB8YEmgPxC51T7BytmA/64N2c4dbqYSsHHLNZJ+xV7Oe/fV9zX4LYdMjujhF4Hq6
         T6hxiAK2cJIe6wpgZ7GtvFy/UJjnVGgZxsGPF8EySz06WDRa/s5xV92YiAv17e4N4U2K
         tnBdxWVBYwpcvISybEae7tjusxH6W6K1HBMNsXN38RTbpBurkivnsBVQN+whW1sYC3HF
         OQWg==
X-Gm-Message-State: ALQs6tA3i9JklPmG6AKk7zryOLiUuxtKhncdwn6dSUkRK1ED+CPUJICS
        YzpfOJGd+A8cJcu4jSuhEbo=
X-Google-Smtp-Source: AB8JxZoq2gjlReIY3LxW5TbB5knXmY/yDuOPeekNDI/nW3zv+3/SA3XJxb+L7wa+4nX4prz54WgS6g==
X-Received: by 2002:a2e:2283:: with SMTP id i125-v6mr26581082lji.47.1525715593880;
        Mon, 07 May 2018 10:53:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4376865ljk.83.2018.05.07.10.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 10:53:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v6 11/13] command-list.txt: documentation and guide line
Date:   Mon,  7 May 2018 19:52:20 +0200
Message-Id: <20180507175222.12114-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180507175222.12114-1-pclouds@gmail.com>
References: <20180429181844.21325-1-pclouds@gmail.com>
 <20180507175222.12114-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is intended to help anybody who needs to update command-list.txt.
It gives a brief introduction of all attributes a command can take.
---
 command-list.txt | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/command-list.txt b/command-list.txt
index 99ddc231c1..9c70c69193 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,3 +1,47 @@
+# Command classification list
+# ---------------------------
+# All supported commands, builtin or external, must be described in
+# here. This info is used to list commands in various places. Each
+# command is on one line followed by one or more attributes.
+#
+# The first attribute group is mandatory and indicates the command
+# type. This group includes:
+#
+#   mainporcelain
+#   ancillarymanipulators
+#   ancillaryinterrogators
+#   foreignscminterface
+#   plumbingmanipulators
+#   plumbinginterrogators
+#   synchingrepositories
+#   synchelpers
+#   purehelpers
+#
+# The type names are self explanatory. But if you want to see what
+# command belongs to what group to get a better picture, have a look
+# at "git" man page, "GIT COMMANDS" section.
+#
+# Commands of type mainporcelain can also optionally have one of these
+# attributes:
+#
+#   init
+#   worktree
+#   info
+#   history
+#   remote
+#
+# These commands are considered "common" and will show up in "git
+# help" output in groups. Uncommon porcelain commands must not
+# specify any of these attributes.
+#
+# "complete" attribute is used to mark that the command should be
+# completable by git-completion.bash. Note that by default,
+# mainporcelain commands are completable so you don't need this
+# attribute.
+#
+# While not true commands, guides are also specified here, which can
+# only have "guide" attribute and nothing else.
+#
 ### command list (do not change this line, also do not change alignment)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
-- 
2.17.0.705.g3525833791

