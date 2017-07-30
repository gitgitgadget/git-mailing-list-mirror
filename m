Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BDCC2089D
	for <e@80x24.org>; Sun, 30 Jul 2017 11:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754026AbdG3LJA (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 07:09:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37318 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbdG3LJA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 07:09:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id 72so3493064pfl.4
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gMThfARSKh2CQRi/shisI20t50h0QWq73nE8xbYzoG4=;
        b=fczXh7rD96asR9SYPGDKrqpfI0LVZINCtssEcbZDsVNsyuzKEHD6th7eBN5fkfwzPR
         scfpcdRkzECN+H2166ySf1lcKIaN8HMgTwumZisPWjPkMoErtrtpZgwHdwJGmeWo9xcT
         qk84DXe3uT6g23y/huktPYccYhFOzEUQgNyAS2LzI67mfS/Oxu2AU3qsmwTjINISk5n6
         xtDGM8YqczescVfaghjOVzO/+w6JYudWngVnOnTUdhZxTQYWyn5l73Ia9Znrx0EHKilc
         +d8e/VtVZUyj0s9qaQZcSKp28Cm8XcG4MVSYFZ5jsadS590tFuyJqbxWdO+HwMFTx3cP
         f82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gMThfARSKh2CQRi/shisI20t50h0QWq73nE8xbYzoG4=;
        b=BlWOt1IHNRjv+QDsvjLwdoBocRi9dv3d5d8WPMFuMo1EgQzxncNncp5b0i2IAp0Lp4
         iEMN9BECDRa9qEzJi/GewLwpVWPh0rhueKMC0P1ymX4Sndwg6HqJNE4AUE3kib30lcx4
         DIaJPpKdSkFxIE2mrzxDwtkXeDOjRljIUYSz2DqoQXlhyABahsw9Ywuz+MAKVHjowJ01
         +8XWitYA29R819EpRA0nTiBI1hr1NJ9UKtWv12KdqYA+EaXdRwWDIvdpVEYp+Fxio5Gb
         LhOej+/St4pohMJThtKq3RmMW/XGdbbEqzGg/78iL1dpY4+Z6TQLiKHkOvjM7rFRWO5m
         jfLw==
X-Gm-Message-State: AIVw113B7YnmoRCF8ip9n8X4+MRUR25NaJZyeYDbsjWzgI5KiJ7KS7Wt
        52JSUt6M+Oy/DrSb
X-Received: by 10.99.62.65 with SMTP id l62mr12874513pga.220.1501412939533;
        Sun, 30 Jul 2017 04:08:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:72c2:f76:6d01:c56f:1310:5568])
        by smtp.gmail.com with ESMTPSA id q199sm45824704pfq.135.2017.07.30.04.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jul 2017 04:08:59 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] doc: fix small issues in SubmittingPatches
Date:   Sun, 30 Jul 2017 16:39:20 +0530
Message-Id: <20170730110921.11805-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

