Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451F320899
	for <e@80x24.org>; Thu, 27 Jul 2017 22:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbdG0Wya (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 18:54:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37911 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdG0Wy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 18:54:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id y206so2371858wmd.5
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7TUnKao75PeswFuFOULZxbgduep42jevk1jGztCzARA=;
        b=tjWdBRBc+FCryMWMWF7k0jlUOH0wgr+wUcl9T+LGEL9j0mjEDMht1oiSngDFzkvMw3
         xusXlo8pgmWGf8n2a6DeWzIqgHOzMmKdmPu0ABIQ+0Y7T73VJQqsXUZ2b5ewAdvB6Kgx
         vsa6QPCOlHfr5BimzFcAXJIiPTy7vbuGm4TB5S7SmWsZyxQ7Eb/nAlePCLe7QHl27sWH
         jJAhtFoIsMKKw90386WKvqO/T4xre0kyQLhODNEcAvYlnFeC7yCXl+8v/eQQLot2M3T6
         bby8LTzIg9OdSBRvW2fo9m10bMCMMOG6Fx7jKKbPP1dokWv+KdQAhHcSbTQfGb8DqU7B
         V4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7TUnKao75PeswFuFOULZxbgduep42jevk1jGztCzARA=;
        b=sZjkL9x1LIWtAb+cm8vo0KKJohQAn+c6mEbq5wUUbvLqt8TAIljYl4ODgdlbsz030h
         uAsU7ApJfGkkRWNa8pY8sC8vKEExA2PWVz0tXNpDUAJM/e51URlWy0v1m8VtWbV+qgvB
         80SYHHzwc7NjIw4XtOGGCgKp6rrDdOlmTyZ1P/2VdfPcCJPWPRUJVmY1F+cz4Y6B9Pm9
         lJeL1rW4TaOGp1VZcpsbUjHb7Ztp1xY1O77vvSCfLz7zXNcDV/2cMoQ6uvyYoaGtmv9k
         snEwkrd8CH2Kbn5zyz6DAE3Mu/5bqG1iBvmHKeeIvWdyBQxWC+6xA5e1xwKz5uepdDuy
         Ai1w==
X-Gm-Message-State: AIVw113UVpxtvQPOhje2EOnnGbs+CtYX0Hk+aVx4p6ePrdO7O2fveLoj
        eZX24imGGyUfT8dv
X-Received: by 10.28.59.133 with SMTP id i127mr134527wma.17.1501195588652;
        Thu, 27 Jul 2017 15:46:28 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3412:3c00:8c82:c2c4:5450:82af])
        by smtp.gmail.com with ESMTPSA id p136sm14870744wmd.39.2017.07.27.15.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Jul 2017 15:46:27 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] doc: remove unsupported parameter from patch-id
Date:   Fri, 28 Jul 2017 00:46:16 +0200
Message-Id: <20170727224616.7216-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patch is read from standard input and not from a parameter.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-patch-id.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index cf71fba1c..442caff8a 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -56,9 +56,6 @@ OPTIONS
 
 	This is the default.
 
-<patch>::
-	The diff to create the ID of.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.13.3

