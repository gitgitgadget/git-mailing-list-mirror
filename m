Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16BBD20984
	for <e@80x24.org>; Tue, 13 Sep 2016 16:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758038AbcIMQxQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 12:53:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33060 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755062AbcIMQxP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 12:53:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id cm16so63330721pac.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=o7OZQJ7SJwS25SFw/2qMXa23m63OuCrECom2GFpX9/I=;
        b=ffp+a4opXhe30jCHmE+B0vVElmdOJOw5XyNs4eOqwGZtGeMcfoqHZBe1IJ3GEbzlNI
         jNU+V3x9B0Q2cr0e8uUSM8c445RK4FaUjFzD0IA3Xnjd7jRmMKWGJcUcK7+w8mdi6j6V
         KbrQ0dJPRrrAt8qYV81l344KVdzMRSYrugNWYLgayAUQ/l/jskVDkGHI8DQ9uQd3bgOF
         ELvQmzhg+fa2sr6+EUlKMU3DJezrFYmgsKFERQm/Ohs6gVupKtf/v9UdZ24mnJJ87w5e
         6a41LC3RBndPH775CTVQU4MWNoQHx7jAW71ucYBugLynbnQeCU5apq2BaGd2LI/SHn0e
         k/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o7OZQJ7SJwS25SFw/2qMXa23m63OuCrECom2GFpX9/I=;
        b=bge9f7MKMerZ5zMSlNd63IdGfC1C8glYIWxQphft4yiPGE8ifBJOR8uD9HWA6R5pAn
         5HkGJY7ZGFAgxI+VyBEXVgLkDLk7ze/Jcnx9jLb9XkATPteBPQvPmyeXFU6p6L710vGk
         00LSnb0h2/klC3qLDg4u3lKqSrFuXtEJdrqCXXlTb2JbikWBzS1GY2e1KCFPiVFL57oc
         AQ6JsNfD53T+Zq6dg88xpqNUWfxladcFYphzGwvuuCwrqdgC76pPGRDVvTS67E2LYSdW
         Hnj7hwnf2y9BcJ/VirlOA5C4pAtGBVd0q+UerMrNQ7gamZiNZKsUO6lb57GvtMrgn38r
         os1w==
X-Gm-Message-State: AE9vXwMGUbKH7kk1z57YoPqLkJsWjb3t92AWOF1LUmEYA6mNCRdwLX4Rl1bWMQcnDrGtLopc
X-Received: by 10.66.52.42 with SMTP id q10mr3044442pao.34.1473785594201;
        Tue, 13 Sep 2016 09:53:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:dc7c:11f3:c9ea:b5e7])
        by smtp.gmail.com with ESMTPSA id hs7sm32399776pad.24.2016.09.13.09.53.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Sep 2016 09:53:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH] pathspec: removed unnecessary function prototypes
Date:   Tue, 13 Sep 2016 09:52:51 -0700
Message-Id: <1473785571-60439-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

removed function prototypes from pathspec.h which don't have a
corresponding implementation.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/pathspec.h b/pathspec.h
index 4a80f6f..59809e4 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -96,7 +96,5 @@ static inline int ps_strcmp(const struct pathspec_item *item,
 
 extern char *find_pathspecs_matching_against_index(const struct pathspec *pathspec);
 extern void add_pathspec_matches_against_index(const struct pathspec *pathspec, char *seen);
-extern const char *check_path_for_gitlink(const char *path);
-extern void die_if_path_beyond_symlink(const char *path, const char *prefix);
 
 #endif /* PATHSPEC_H */
-- 
2.8.0.rc3.226.g39d4020

