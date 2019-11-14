Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77A11F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 17:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfKNRdV (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 12:33:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54849 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfKNRdU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 12:33:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id z26so6535965wmi.4
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 09:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnpCyF/ZKovEwi8Zu2fc1TEHyc1tfWa0HbOZx4ecdeo=;
        b=byu6duxbhgVkN/shWgJy3rqF7Z7aCGPfeMJqW++6g/tNXA16+0MlTwNTMRWq/eWlGa
         uFvVcjli1qgvR9BYdKPMOUQXn27mDY9zBkOaxgXbbIQzGs+TbOF5fDEnu+lMJGtnC/1J
         e7tS/5VUfmbvz1cxVsfrA5bGTr76UmNCnGqp07pK2XvladQqyQPcfv6ROLGu/avdf9lR
         /YEl248lZJi/prb/AL8+8QSKd6xZh14WUORaGFT4abKO4rKijzdlFrK5tBvGvBUUExE9
         PmwdUNFZys3oiiOfa5tBJcMT6Pd3lyMpkENZDM3NebH9Lkj0I12IO6pRJn2lMOPLdlLh
         FwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnpCyF/ZKovEwi8Zu2fc1TEHyc1tfWa0HbOZx4ecdeo=;
        b=pA/eY1vseqozTt73bwLTA2kLfcIxcKZdYfZJT8lBWCUAlbiaCpfrdA0ouerDF3c04n
         KQ6nU9tYuqpYV41Ib0aqnWzZZ26Nqp43OircwJR2Zh78QuMvTUkt6xiHpjy6lYLq56dQ
         P2/7l1UJa3LS9YVM/v44ompLAmlXCw9PEy6+SbE1jktVlxaiyyMSce4ZvolzBEmmxfUg
         +uj+d7km4khLyF7GODGspy8YiOq+AYNiKkp1pg4e4u+516omZFgO2/t2GQEmXXCd7XN7
         FLgWAHCgy0f43uGXS9T6q/zrj0+XOQaNgBryhceXpjE6dGQXW58e3m+vFMf2eCpumGmG
         onDg==
X-Gm-Message-State: APjAAAVKc+RNp9kTwGjb/qH5+Ga/XCan4KL2jbLhwmYES97pYYta2auE
        FKgm9J26MFTBylMj3OQdkqRM0w2seSUYfg==
X-Google-Smtp-Source: APXvYqwNNJsiFolQh4vHDe99c2DE8vEfzH5GGSv7fheautfQAetq6trUYOToZnQphXOFCbwoPW2AIg==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr8717634wmj.20.1573752798433;
        Thu, 14 Nov 2019 09:33:18 -0800 (PST)
Received: from rybak.office.devexperts.com ([185.79.217.61])
        by smtp.googlemail.com with ESMTPSA id v128sm8082607wmb.14.2019.11.14.09.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 09:33:17 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] INSTALL: use existing shell scripts as example
Date:   Thu, 14 Nov 2019 18:33:16 +0100
Message-Id: <20191114173316.9190-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Script git-pull.sh has been removed in commit [1].  Use command
"request-pull" as an example of a shell script instead.  Recently, many
of shell script commands have been re-written in C, so tweak the wording
of the sentence, while we're here.

[1]: b1456605c2 (pull: remove redirection to git-pull.sh, 2015-06-18)

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 INSTALL | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index c39006e8e7..e3170b3cee 100644
--- a/INSTALL
+++ b/INSTALL
@@ -116,8 +116,8 @@ Issues of note:
 
 	- "ssh" is used to push and pull over the net.
 
-	- A POSIX-compliant shell is required to run many scripts needed
-	  for everyday use (e.g. "bisect", "pull").
+	- A POSIX-compliant shell is required to run some scripts needed
+	  for everyday use (e.g. "bisect", "request-pull").
 
 	- "Perl" version 5.8 or later is needed to use some of the
 	  features (e.g. preparing a partial commit using "git add -i/-p",
-- 
2.24.0.windows.2

