Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93ABD20899
	for <e@80x24.org>; Sun, 30 Jul 2017 16:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754219AbdG3QSL (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 12:18:11 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36857 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754125AbdG3QSK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 12:18:10 -0400
Received: by mail-pg0-f67.google.com with SMTP id y129so28307245pgy.3
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zMLFU6FRMxrGUlrUWWZeh2z4HfxULRrVIyQOgF7nTP8=;
        b=a9VGqGI/AQtbGMJim2mWLmBBESogtdBLXNcy5in5dFnIi1YkxyZUpPFmD/4s35jVRR
         3EYR3ZUKVqfVvj7jnCoVJmzeSGK3j/8wYA2INWRzC1cIG2QIx7ST+GHCKAm/SP0Pv7sP
         Q/b3oNnhrPQSBT/D6+KasN2obC7T1pLyq01fnoZRyV0PGpt/zwvtDKQY42xP5nIEB+P9
         erTPiayfGEkBYLtH3/l0jupa4wRzjZ/iVBPM8bRMAD0k2QaTWFVcQQoRDCCNh7SAqJEV
         W18oTvVKVTcbIsw0jvluTBjVXRIV3XtInBrUM2DiFceG+xXSHOT1PqvIjbCeEZT8Fpc5
         CYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zMLFU6FRMxrGUlrUWWZeh2z4HfxULRrVIyQOgF7nTP8=;
        b=Tkqe3bF33sW+KQoY/LkjxXamYGZadPBafoEKKUMAyV679fSrAKl3WZ6f+Mrn0SQCWP
         Sg52CwyvUhvwz8NP+T9jHkaTE5JB+0gKFTOS5fWaXWkA6yacKKvQ6ubTNAUS2sLWuXTY
         bUErpOwVQPzWv3UFClAtlYhbag0X4RpIXlMD2A4NK2d2RsCNqHpH4M4ydN32RJTLtU/W
         sMHFmiU7Xk2np1o24sMOfR6uF+CKj4d+SKdJ1RbYIgjiIrjsOscj7XtpMf1R3txVI4ZN
         4A0AVdtmWTNydQflA2U4Yo2/aOdS2L61E9ZX/w4ZcQ/JneAPaJLlXdi1LXR6AGD7uu4l
         gmTw==
X-Gm-Message-State: AIVw112/qoiRPCfCGGqD1Y0vFJ52rKp5FtorviIDruq+JXMTm1QfJiuu
        FawN/ZtXmyWIvw==
X-Received: by 10.101.83.138 with SMTP id x10mr13030147pgq.201.1501431490457;
        Sun, 30 Jul 2017 09:18:10 -0700 (PDT)
Received: from localhost.localdomain ([117.209.220.229])
        by smtp.gmail.com with ESMTPSA id j8sm32038433pgc.24.2017.07.30.09.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jul 2017 09:18:09 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com, philipoakley@iee.org
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] doc: fix small issues in SubmittingPatches
Date:   Sun, 30 Jul 2017 21:48:16 +0530
Message-Id: <20170730161816.2412-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
References: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the dashed version of a command with undashed
version and quote it.

Further, remove duplicated space character.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 558d465b6..9d0dab08d 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -293,7 +293,7 @@ then you just add a line saying
 
         Signed-off-by: Random J Developer <random@developer.example.org>
 
-This line can be automatically added by Git if you run the git-commit
+This line can be automatically added by Git if you run the 'git commit'
 command with the -s option.
 
 Notice that you can place your own Signed-off-by: line when
@@ -366,7 +366,7 @@ suggests to the contributors:
      spend their time to improve your patch.  Go back to step (2).
 
  (4) The list forms consensus that the last round of your patch is
-     good.  Send it to the maintainer and cc the list.
+     good. Send it to the maintainer and cc the list.
 
  (5) A topic branch is created with the patch and is merged to 'next',
      and cooked further and eventually graduates to 'master'.
-- 
2.14.0.rc1.434.g6eded367a

