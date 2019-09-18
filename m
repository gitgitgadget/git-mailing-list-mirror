Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD241F463
	for <e@80x24.org>; Wed, 18 Sep 2019 07:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfIRHCK (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 03:02:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43874 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfIRHCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 03:02:09 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so13624940iob.10
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 00:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugOUEYd4HfPX1bcDV8tPCwqEtK0iXnX0VISf+oUNPfY=;
        b=eyFdOfiq4HJnnPHHy49+77iRnco10BTrzz2ONa6N8gZgepOr7EYoWf6MyRBSrQKQdA
         Md/JQzlcp8EPec9t6LQtlUYmtGiv+N2UlEj4vjR/q0wiywS/Yqun+GTFz9VRo4V/fb2s
         ycN6sc+dNK6aCx7SMhIzCn4orD677ZoOcYizGWA6b1Dwx75rMSl3xDQhHa6whymi/k4/
         qMZhOfa4JDuNwsXFrXVJcWGNHXySbOFHMrmTlRrZGWs8w+Yao2pEEubhoxiwWYMmK9x4
         BmM6NTb/M84MJVcks10/0e7E3kLcTrOYGoHgaPN+P+2zfY4UpA/UjI8rjM1pb5+FnbCb
         0pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugOUEYd4HfPX1bcDV8tPCwqEtK0iXnX0VISf+oUNPfY=;
        b=Is5OvtPfPkCnUHrAJxlDn1g5Wc2TUSfAswapd18cOEOG0o8WtYsnyvHcVhbEBczHkA
         Z5Zw8TGrVQhQ4gHl9A1QP3lAcw4n33FFlKa7/K2hnhh3jWJ1HL8nd7WmcGUwVDmbEtpV
         0+70btmnMaL+Y3LvE5foDuZUbdl1xIjlMFVrO2yk4n+LFzh3Tq6wrE9dmlMKJFhOzJTk
         6bywmMFcQj3LYjColbyzO9i8lGSbV5Wv9v50fkAwoZy+r5uXEC55KQYw+zI0CyZC+c4t
         f812XV1W03qMRFGbDRXMkGI3TSelI7h2nD6tm/nnytxzfL5Eg6plGMe0uZseT8J1E1EP
         UEWg==
X-Gm-Message-State: APjAAAU6ghnF75JYZlITEAtw5R5A8pQ/YnIKwKguUQuClB9YFbnanL7o
        KRcjVqdpmeNoNcSpuBN6xKGwFT6g+oI=
X-Google-Smtp-Source: APXvYqwUiXz/X0ET1YplRDlTURiHjWWymCwybtjyJzWg54a9DCYXMQ8P6arm+dkbSVBU+B3ZrIKLvQ==
X-Received: by 2002:a02:698d:: with SMTP id e135mr3343762jac.128.1568790128323;
        Wed, 18 Sep 2019 00:02:08 -0700 (PDT)
Received: from viper.hsd1.ut.comcast.net ([2601:681:4100:375e:c6b3:1ff:fed3:9881])
        by smtp.gmail.com with ESMTPSA id i26sm4850832ion.40.2019.09.18.00.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 00:02:07 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] doc: fix reference to --ignore-submodules
Date:   Wed, 18 Sep 2019 01:02:04 -0600
Message-Id: <20190918070204.100144-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/gitmodules.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index a66e95b70c..b7f5e39d4c 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -90,7 +90,7 @@ of the superproject, the setting there will override the one found in
 .gitmodules.
 
 Both settings can be overridden on the command line by using the
-"--ignore-submodule" option. The 'git submodule' commands are not
+"--ignore-submodules" option. The 'git submodule' commands are not
 affected by this setting.
 --
 
-- 
2.23.0

