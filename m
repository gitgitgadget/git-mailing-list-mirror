Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9EA11FD09
	for <e@80x24.org>; Sun, 28 May 2017 12:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbdE1MOJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 08:14:09 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34647 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdE1MOI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 08:14:08 -0400
Received: by mail-lf0-f68.google.com with SMTP id q24so4104417lfb.1
        for <git@vger.kernel.org>; Sun, 28 May 2017 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E3/hrSZic4dsL9wl19lfxfqDPbDZBuFDMAoQtYG9+yw=;
        b=QJW/VN5j6e94HIK6frF1qCLzcHDw2NXKdXnZVWIAmxqQFQnPRBqT+Tn+0HusH+WoYy
         CguHqmzZS2CO4mfPcCPktNggIJuU2cvc1fNR4KVs5EBVFGP8WCt+jB7BF5c/k4hMZ4ud
         Y/ThHCTyX9lsXgV8OwHeNzzrmtoTmqU1KhUwsonaJ6WdRDCGwWHaQ7pI5epf7/HHhch9
         PALWk/FmbPdXHY5pJC6BLnJLxDVtLn1zDCt/OJHHUjqnLrqqjyJi/RB7w7N6Pjh6rb1A
         p+bAZjNH4wRIeRl/XAppXqbhdm1LgE0b8bJwqM2Xh6rhu4O1NWSFKwdrRWXhBkzOGsPt
         ajDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E3/hrSZic4dsL9wl19lfxfqDPbDZBuFDMAoQtYG9+yw=;
        b=O5zRGt23mxGK8V/Ktlb0KewKV7VoJhyV7+JQolr4Se16a8e3X+MsWScby9ghGzGy8x
         6E4pwsELtwnPDrTMmzbAqNP2ag07ED/cdTcDYkCiXkR256eiZkPDe1VpbgPEO3Csa1+R
         0TjV3Ymbw3n56Mdh/IE5ck+F1hl6nURtD2s06a4plm1O9BxfJz0bdp14os+b1XJ31zXf
         JnFGIiqnZvpBrFwPczo3JAyBfP55gm+XBecsA+yD4l0K27NICeudKaETL8SoqW4TZgii
         2HUhk/sJiRgNvkKuENdTWWJJ0rV+elg72JIHKCp7yjWyB/OuCtXwOZ1X+1ZlOSuJtenK
         H9OQ==
X-Gm-Message-State: AODbwcCW00tGvMqxsOX8OFtfHIPlubIa+J6w0xi8u/vpL6mVrsHrk3z4
        0FJdh3d4LIhl8MJlq48=
X-Received: by 10.46.13.1 with SMTP id 1mr3212360ljn.134.1495973646486;
        Sun, 28 May 2017 05:14:06 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-95.na.cust.bahnhof.se. [155.4.133.95])
        by smtp.gmail.com with ESMTPSA id d188sm1358100lfg.69.2017.05.28.05.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 May 2017 05:14:05 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     git@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] completion: Add completions for git config commit
Date:   Sun, 28 May 2017 14:13:25 +0200
Message-Id: <20170528121325.4033-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing completions for git config:

* commit.cleanup
* commit.gpgSign
* commit.verbose

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1ed0a09fe..90dfd7681 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2395,8 +2395,11 @@ _git_config ()
 		color.status.untracked
 		color.status.updated
 		color.ui
+		commit.cleanup
+		commit.gpgSign
 		commit.status
 		commit.template
+		commit.verbose
 		core.abbrev
 		core.askpass
 		core.attributesfile
-- 
2.13.0

