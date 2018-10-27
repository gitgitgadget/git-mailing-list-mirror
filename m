Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B311F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeJ0PFH (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46333 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeJ0PFG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:06 -0400
Received: by mail-lf1-f65.google.com with SMTP id o2-v6so2462248lfl.13
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2tBOORvYfqmDrlbfZNna9t/oZ2/UUWXcp1Fght9czY=;
        b=kGPRFLptRtPUw6MFDGceVNnU/yv6eDKwoIdf+A564Kh3QGANhSCCGF4xGOzy+agGC4
         TxsCB5P8qzfRX0OyG2t28Z/jJZa4NxswNPgO3BW9GhsAmoCXTtCEVHY1rnS5Pq8tG571
         87Gv1t27Q8M2PMZRJdlnM+Iedf2KW/R6ehajw9xlidBIhVLbXt9FMkAiZQx7P1W0Tdhn
         84Lk713bnbHkMyRIv+uHBWr9mZNhtGkWh3YmBhxCtUQLyHZ6P9dx+DCNlm9ob0PxdIqG
         UFqFF88ipRoJ1FXDF7eg+gRJQIS2Gt1LNfp8U0+D1fXr/7G4yfFLlWycxZ76EwDmqfWV
         yfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2tBOORvYfqmDrlbfZNna9t/oZ2/UUWXcp1Fght9czY=;
        b=LNCHySS4j8KbEkgeN2YxUAfFyzZ7LbUPiHUV3wMJa7+zuCVAjyMEdvQWZe2YJG6Xqe
         XcxnZbkm4H+dlMmAbqAdWYnVwVW5T2JovNGqCJKqdRPw6ppqLHUehaQKnSMduDfRo1Zm
         5Ieli1AxxlhSip6ljmxUYuRtC6ts9+96s6mXpsKS5PsrzCM1hWPZMt0VRYALoDzAjsjD
         F5j0K7GXncV1qlWzLchLZBh5JxhlUtrQs/JL39hNgVm0k7FqVIcny+qvPSFWL5PbE+Fl
         Y5AjCMaX+KVEFLu6BxjuRlqfWTOamilUY4OrV/AD21QcaJPkB1nV1XI3Qz8uAeS3UH9B
         rbiQ==
X-Gm-Message-State: AGRZ1gLfyw4r5s4c63fd+KjFvs+FVZHAtt6zYYcW0bjNThkwGuA4Pg/A
        mewOkHoZtIpPPYVJjGLiaakBCvjI
X-Google-Smtp-Source: AJdET5cF8kLiTPm4bOz42oVDDcVPXIBJ6cKCKbClRi1SOjegaKeAbBaA+Gpdn6plFf+yyeft8GnH3Q==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr3749819lfd.74.1540621510692;
        Fri, 26 Oct 2018 23:25:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 65/78] config.txt: move splitIndex.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:38 +0200
Message-Id: <20181027062351.30446-66-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt            | 25 +------------------------
 Documentation/config/splitindex.txt | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/config/splitindex.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 56cfe3e857..13beb1ea18 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -409,30 +409,7 @@ include::config/sequencer.txt[]
 
 include::config/showbranch.txt[]
 
-splitIndex.maxPercentChange::
-	When the split index feature is used, this specifies the
-	percent of entries the split index can contain compared to the
-	total number of entries in both the split index and the shared
-	index before a new shared index is written.
-	The value should be between 0 and 100. If the value is 0 then
-	a new shared index is always written, if it is 100 a new
-	shared index is never written.
-	By default the value is 20, so a new shared index is written
-	if the number of entries in the split index would be greater
-	than 20 percent of the total number of entries.
-	See linkgit:git-update-index[1].
-
-splitIndex.sharedIndexExpire::
-	When the split index feature is used, shared index files that
-	were not modified since the time this variable specifies will
-	be removed when a new shared index file is created. The value
-	"now" expires all entries immediately, and "never" suppresses
-	expiration altogether.
-	The default value is "2.weeks.ago".
-	Note that a shared index file is considered modified (for the
-	purpose of expiration) each time a new split-index file is
-	either created based on it or read from it.
-	See linkgit:git-update-index[1].
+include::config/splitindex.txt[]
 
 include::config/ssh.txt[]
 
diff --git a/Documentation/config/splitindex.txt b/Documentation/config/splitindex.txt
new file mode 100644
index 0000000000..afdb186df8
--- /dev/null
+++ b/Documentation/config/splitindex.txt
@@ -0,0 +1,24 @@
+splitIndex.maxPercentChange::
+	When the split index feature is used, this specifies the
+	percent of entries the split index can contain compared to the
+	total number of entries in both the split index and the shared
+	index before a new shared index is written.
+	The value should be between 0 and 100. If the value is 0 then
+	a new shared index is always written, if it is 100 a new
+	shared index is never written.
+	By default the value is 20, so a new shared index is written
+	if the number of entries in the split index would be greater
+	than 20 percent of the total number of entries.
+	See linkgit:git-update-index[1].
+
+splitIndex.sharedIndexExpire::
+	When the split index feature is used, shared index files that
+	were not modified since the time this variable specifies will
+	be removed when a new shared index file is created. The value
+	"now" expires all entries immediately, and "never" suppresses
+	expiration altogether.
+	The default value is "2.weeks.ago".
+	Note that a shared index file is considered modified (for the
+	purpose of expiration) each time a new split-index file is
+	either created based on it or read from it.
+	See linkgit:git-update-index[1].
-- 
2.19.1.647.g708186aaf9

