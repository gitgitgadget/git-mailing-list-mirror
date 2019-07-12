Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69BB91F461
	for <e@80x24.org>; Fri, 12 Jul 2019 23:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfGLXCO (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 19:02:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44155 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfGLXCN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 19:02:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id e189so8439676oib.11
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=txvecSw9jqUzzh7fTMrwuQR6LGkiq6U0h8j626J3XHQ=;
        b=vfAEpbJXWukmwD9BPKtPKF2UU36eyCeUKqrut8ieM8l/vCfaMwKBtJk+Qpcf8/qqSR
         UUqOa4ph6+EOdrodob3hBibAaxb1azOcz6tncypJA4TfO1rFjWgYAhJQ8uk7Aj8t6OZl
         lJrOYqcUBGKT15mwlqjdO4rCntsYbUbXq25MZQTapXPRCppnAhaRCPIy6Wcvd/zQ0cH0
         9QcuIjPLVn0IIBk7a49xDh9t2xxa8EuztMdYx2jZea8jBdxNyoEakB1oDO1Ao1ioDQmB
         tAr6Mj1mc4u/gRQiq47RG4NfgWKjRDlpviKYPaTS3hhK+9EUtMcqUExIhxG3vbZZQV+o
         Qglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=txvecSw9jqUzzh7fTMrwuQR6LGkiq6U0h8j626J3XHQ=;
        b=rMgdXYzhNKuUcPozH5FFIC3IQkvcmj2AJjEnswGW9Xl1GEpTagh84UUGzL5JakS8eL
         MJXlVvD6F5IHRiWU/cC5/2LqxG1UI8fRDIZrtdXBHEC3QnO7VLII3eDdgAiX2QvxV5ld
         wRwStZpi93GcBXGggxXuHk7aM8yMO3L8WB2y3eFE95I2iB8x2vlL5IJp52Nz/xeJ02eB
         rR36vX1XAI5VLVB2XDigoEPWKuPdkXLsgLnji2aGGCOjrZcTxMXNKlVaPFDdoKrDflna
         S/fe55i8I+m5suF75yvaXBfnw2GhUFC4FKBGCMKO7BJ8Qpymr4Kc1ljpayUhrMhJrVqD
         9iVQ==
X-Gm-Message-State: APjAAAUVoHGnezoXIA7cK21hYYgEw8KBDZEGQRtsKUVyfc2OGVFWdn5h
        KcRTtHrdVnhqffLkB3kc0RA/vfxV
X-Google-Smtp-Source: APXvYqzxTdoED9GpvOQdtr96JL19cHgoekA/7ZDLEUIeapMQlpMJP8zPgi3ALoms8dA16ZpDHG9aww==
X-Received: by 2002:aca:e046:: with SMTP id x67mr7167808oig.3.1562972532720;
        Fri, 12 Jul 2019 16:02:12 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:c055:b92a:b249:c6a6])
        by smtp.gmail.com with ESMTPSA id i21sm3260066otl.24.2019.07.12.16.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 16:02:12 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v2 2/3] documentation: mention --no-use-mailmap and log.mailmap false setting
Date:   Fri, 12 Jul 2019 18:02:03 -0500
Message-Id: <20190712230204.16749-3-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712230204.16749-1-ariadne@dereferenced.org>
References: <20190712230204.16749-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The log.mailmap setting may be explicitly set to false, which disables
the mailmap feature implicity. In practice, doing so is equivalent to
always using the previously undocumented --no-use-mailmap option on the
command line.

Accordingly, we document both the existence of --no-use-mailmap as
well as briefly discuss the equivalence of it to log.mailmap=False.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 Documentation/config/log.txt | 3 ++-
 Documentation/git-log.txt    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 78d9e4453a..7798e10cb0 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -40,4 +40,5 @@ log.showSignature::
 
 log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--use-mailmap`.
+	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
+	assume `--no-use-mailmap`. False by default.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b02e922dc3..b406bc4c48 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -49,7 +49,7 @@ OPTIONS
 	Print out the ref name given on the command line by which each
 	commit was reached.
 
---use-mailmap::
+--[no-]use-mailmap::
 	Use mailmap file to map author and committer names and email
 	addresses to canonical real names and email addresses. See
 	linkgit:git-shortlog[1].
-- 
2.17.1

