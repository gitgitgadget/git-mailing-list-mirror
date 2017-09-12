Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2312C20281
	for <e@80x24.org>; Tue, 12 Sep 2017 22:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbdILW6x (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 18:58:53 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34457 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdILW6w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 18:58:52 -0400
Received: by mail-pf0-f196.google.com with SMTP id g65so6546599pfe.1
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=THZjx+0md/DYrDp3wHDZORszR4P3xNS+TR6mya0bVkE=;
        b=ooqSRrtqIJMtwGKqsdwncWeKowqig5m/Uqlj2Suzhl7GNqJvQJ/q9pMJLK1/btanEH
         YxTW+NoQphC7AatWSKKRpKxbKr1+WwTCTeRBwGk1zCP2eg3pBN0ZefQsgItPqSITBz/O
         /ib70ZWTqFza5Xd3wrRSJrKQgc6dtTsC0QdISlXMsQh+F5K+FSm3majHiXb9rlEp49lR
         UdZUQteeovZKxGZpAMBD5s0Ns2v2t+nLy7UCoaB1ayJKB+G1frqBSTslkuHYwfCq76al
         dPEtFLL6N9LXaHlXQSt3qvLV7QfLs8jhhCQ6EcW3tYg46gVbDuj9TDd3/UKjvji6lsqt
         V0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=THZjx+0md/DYrDp3wHDZORszR4P3xNS+TR6mya0bVkE=;
        b=tRqnKb6GyJhIJ4UysGsSel3Z9UTgvwBsvuKupXkD6DChXN/jqr+3/6dw4yjsLhKHeq
         hnSZyln4HMyZuDdEx+ocs1Hg6UClXOLJxksl6mwLn17+IvsBmoYXpYlutw5Z0GDoGjJJ
         2m1xWNwT58Fmdm6Hk5sybsIofnvk5TAVphdsl45KmqrGy0Moz2Box5dt7x+8cnKOHBHB
         iHbUcA4R9FtCpRSEIpcmXyl1Qiw4PTBOFWq4RX4SHKF6wYhcmmTaH065Pjt5jnmJXyTS
         J4vfioj9WZxUWOvWqnrju148tTpcxrayzoOceIiWbju2qDpmzoscZWuantSu4wp/SJaD
         4fag==
X-Gm-Message-State: AHPjjUiHulKJziiBeYIAjWoaCJB6uF3/ZCdUPI1XBZ6DDK2w1nhUbZHV
        0+kLOW5k1rDdaAyAVsk=
X-Google-Smtp-Source: ADKCNb6nYhVuZf6PPNKCiypo6NlOEzQbwvxrKDv0zgZr3PbWZz+VFcFNdlTwhRKd1frxUbGk1FlChw==
X-Received: by 10.101.92.6 with SMTP id u6mr16289209pgr.198.1505257131950;
        Tue, 12 Sep 2017 15:58:51 -0700 (PDT)
Received: from localhost.localdomain (67-5-157-35.ptld.qwest.net. [67.5.157.35])
        by smtp.gmail.com with ESMTPSA id g76sm23444410pfa.134.2017.09.12.15.58.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 15:58:51 -0700 (PDT)
From:   Evan Zacks <zackse@gmail.com>
To:     git@vger.kernel.org
Cc:     Evan Zacks <zackse@gmail.com>
Subject: [PATCH] doc: fix minor typos (extra/duplicated words)
Date:   Tue, 12 Sep 2017 15:58:39 -0700
Message-Id: <1505257119-12086-1-git-send-email-zackse@gmail.com>
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following are several fixes for duplicated words ("of of") and one
case where an extra article ("a") slipped in.

Signed-off-by: Evan Zacks <zackse@gmail.com>
---
 Documentation/git-cat-file.txt     | 2 +-
 Documentation/git-checkout.txt     | 2 +-
 Documentation/git-notes.txt        | 2 +-
 Documentation/git-update-index.txt | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 204541c..fb09cd6 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -192,7 +192,7 @@ newline. The available atoms are:
 	The 40-hex object name of the object.
 
 `objecttype`::
-	The type of of the object (the same as `cat-file -t` reports).
+	The type of the object (the same as `cat-file -t` reports).
 
 `objectsize`::
 	The size, in bytes, of the object (the same as `cat-file -s`
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d6399c0..bd268a8 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -38,7 +38,7 @@ $ git checkout -b <branch> --track <remote>/<branch>
 ------------
 +
 You could omit <branch>, in which case the command degenerates to
-"check out the current branch", which is a glorified no-op with a
+"check out the current branch", which is a glorified no-op with
 rather expensive side-effects to show only the tracking information,
 if exists, for the current branch.
 
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index be7db30..4367729 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -171,7 +171,7 @@ OPTIONS
 	object that does not have notes attached to it.
 
 --stdin::
-	Also read the object names to remove notes from from the standard
+	Also read the object names to remove notes from the standard
 	input (there is no reason you cannot combine this with object
 	names from the command line).
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1579abf..a14e6ae 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -153,7 +153,7 @@ you will need to handle the situation manually.
 +
 Version 4 performs a simple pathname compression that reduces index
 size by 30%-50% on large repositories, which results in faster load
-time. Version 4 is relatively young (first released in in 1.8.0 in
+time. Version 4 is relatively young (first released in 1.8.0 in
 October 2012). Other Git implementations such as JGit and libgit2
 may not support it yet.
 
-- 
2.2.1

