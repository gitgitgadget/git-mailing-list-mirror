Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D2E2202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 20:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbdIUUaH (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 16:30:07 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:45692 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdIUUaG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 16:30:06 -0400
Received: by mail-io0-f175.google.com with SMTP id g32so13650241ioj.2
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 13:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NQpSoIR1Wgtmuz3SlLq+tOeO+RPnYMtMrGRP/PM/aGI=;
        b=pk1FV9p/z/3JYkED/Qb4k8TQSIqfYvWYIFgsS7cHNTvkN1zJ4ktq4Kf92xxvfQ7BUL
         FC6/ltHVDFPsUWevMul6TPy+IIWLdkTv/btivopkD+oquSw7aNjKiZ07s2BkikEjJpYI
         jSUQBOZ3ECbzJ4eVHMNJ+9DijbIyxn9U0I+aWsmb84XsGvHJ9DtjDAI3ELvntKfUGJGE
         agQiH+a8PRFuMd9Ay1XoMWtXY1+JVQW0Ife+zEOoTVzUzscorDNWeIQKNE0sNMsXLbNq
         7+bHAihzXYO889tbvdnRZIDdpiYPppzPruBw/lV6T29teldc9ggWl8TdL1seC1hYh1vi
         WWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NQpSoIR1Wgtmuz3SlLq+tOeO+RPnYMtMrGRP/PM/aGI=;
        b=GYaG0E2aBa4VZ4ipoqFsOOf/yEXMIpt+pCZSAv3fjOXwf6qikaAC8r4xZrvUyA5lzj
         B/HHx9yUn6ItYY5Abef/LTITgp2pBeV69OYOijtuwvbZ3GcWw52REzaCsGXiLAAcVWIV
         iMSGUetiJgQnRo/oncCxqqOKWyKDj6QfSF27ng3yoY2uexJu3GUqtZ1RPwAGeQTIHX/o
         W0T7VbNOoYvfyHkRCERvbxwXhZo2JKPCQdDBOXD70x9LnenYVW+jgvrEVeaCimjiLz68
         M0nslipVRGDeAv/DQSNUsj7QzLlwZ38ZXi/pl2zlhv0olbtk1AxdoO71S+1Gr0aFyzmp
         S7BA==
X-Gm-Message-State: AHPjjUiH8wDFCivLJspDMJsLWwgps4UErRJ8FZ/UXJlOUNRDI2o54/Wq
        1Wd4AX/0zNr8T6R6qJ/Zxl7sQg==
X-Google-Smtp-Source: AOwi7QCEF9iYFaafZzUNJO8fHUnaV3ABbT/NiqLq3lmqtuvZfqzmX1XixURUHZrzo23MqBAVsuM/hg==
X-Received: by 10.107.81.1 with SMTP id f1mr4466438iob.17.1506025805930;
        Thu, 21 Sep 2017 13:30:05 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:502f:b05c:b303:f30c])
        by smtp.gmail.com with ESMTPSA id e203sm1500802itc.16.2017.09.21.13.30.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 13:30:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     kaarticsivaraam91196@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH] Documentation/githooks: mention merge in commit-msg hook
Date:   Thu, 21 Sep 2017 13:29:54 -0700
Message-Id: <20170921202954.7854-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <1505542931.27598.4.camel@gmail.com>
References: <1505542931.27598.4.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-msg hook is invoked by both commit and merge now.

Reported-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/githooks.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 623ed1a138..f4e75b9c90 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -127,11 +127,10 @@ help message found in the commented portion of the commit template.
 commit-msg
 ~~~~~~~~~~
 
-This hook is invoked by 'git commit', and can be bypassed
-with the `--no-verify` option.  It takes a single parameter, the
-name of the file that holds the proposed commit log message.
-Exiting with a non-zero status causes the 'git commit' to
-abort.
+This hook is invoked by 'git commit' and 'git merge', and can be
+bypassed with the `--no-verify` option.  It takes a single parameter,
+the name of the file that holds the proposed commit log message.
+Exiting with a non-zero status causes the command to abort.
 
 The hook is allowed to edit the message file in place, and can be used
 to normalize the message into some project standard format. It
-- 
2.14.0.rc0.3.g6c2e499285

