Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F991FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 18:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935175AbeAKSSa (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 13:18:30 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:44520 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933384AbeAKSS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 13:18:29 -0500
Received: by mail-wm0-f68.google.com with SMTP id t8so7291020wmc.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 10:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I+7bhGwcEBqgGdW9OtsHySCtRLCd3wG13liRBdQHAKs=;
        b=HjUvVIQyKjl+Jagu2F1I7ky6YwPlQ0KRohjWzVzlPN5GxU0FSzFVgSuM6bSlA4tmwS
         u6VX9gKBQ5Xg2xpeDKTcvruqw7xOpGdZyAf9r6+MsdeeQA6gUsK/vmIRnFaf0bclYJM7
         4R8mFumyzDb7YXEeDVg6zIkE09zuvknlbaG4WTVruxx7VKO1pN4UUbIP/NICAEKf788B
         7NzJkuPBojZXKjkD4pcCBpsg+i2KjFBg5Akly1kwnQ8azA25maUsOGfPLAktUC+/bej6
         f0z9pW99Db0Lbu1YcHCoE0uOEWYugIHKZUXyYcog5D+iPpsXFw4P0vo8AY2SU8ETWSKs
         aKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I+7bhGwcEBqgGdW9OtsHySCtRLCd3wG13liRBdQHAKs=;
        b=iEgr2Hi81ZtsLomnGy8YumeTQLo1ydQdBIhC0UqnQlDtSwZXHmSGx2E9Tr27tuE9fv
         VAOw09Wz1TI0VvXOiD5G0HLqQww/nkw1GKMeNT13eqcVSMJvdKXNl98vaK6hUDHDXOv5
         U2jPmOPnQLuhrKPMFU9/re2sbMSek3vEJsV4IEWMYPfOdOtYVZXl7g1xNciT7w+SaMTF
         ogEZGqnIYNvK58igfMG9bAOTWANaPkFHwzxw9RR0ISNlwykBKHxgM0yxat6I2fGGnx7a
         4+JrkpExo98ktUrASMw/c0dDRUUgkCNXGXeFJpl2z1oBxh9vqJ6g7ec7RX+9jlOJs4qA
         E/2g==
X-Gm-Message-State: AKwxytclPj7NwJHldtFiASX/2g+B2mBRneWBmRa5cH1S+RZK71hbvw3F
        i41SW1VGI9zTcMZgINdhDnHqHQaP
X-Google-Smtp-Source: ACJfBotJAjNaDA/maqTUa9rCp5drQnkz+/gujIZctNNN/Hp3HgVnRxQ8qCP5wgr2pF4ITK+4P902FA==
X-Received: by 10.80.146.221 with SMTP id l29mr4330566eda.152.1515694708327;
        Thu, 11 Jan 2018 10:18:28 -0800 (PST)
Received: from localhost (cable-82-119-28-222.cust.telecolumbus.net. [82.119.28.222])
        by smtp.gmail.com with ESMTPSA id 26sm11618239eds.67.2018.01.11.10.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jan 2018 10:18:27 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] Documentation/git-worktree.txt: add missing `
Date:   Thu, 11 Jan 2018 19:18:21 +0100
Message-Id: <20180111181821.28071-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.290.gc44db26fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 Documentation/git-worktree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index f850e8ffb..41585f535 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -118,7 +118,7 @@ OPTIONS
 --[no-]guess-remote::
 	With `worktree add <path>`, without `<commit-ish>`, instead
 	of creating a new branch from HEAD, if there exists a tracking
-	branch in exactly one remote matching the basename of `<path>,
+	branch in exactly one remote matching the basename of `<path>`,
 	base the new branch on the remote-tracking branch, and mark
 	the remote-tracking branch as "upstream" from the new branch.
 +
-- 
2.16.0.rc1.290.gc44db26fe

