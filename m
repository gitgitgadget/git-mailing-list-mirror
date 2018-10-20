Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CFF51F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeJTUug (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32807 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeJTUug (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id z21-v6so33118003ljz.0
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVa8gG3KQx9z1I7+2T5HAnbon06rqilvzFi8WN+ki7s=;
        b=Kx/i90IYm/OTNqAt/LF87B2zvqCgoyDgkEZR1fOIUgmhyFKBAVo9sLACrsM3ZOr1ZB
         ZnkTTXg4FIyIfxOvqnSLb7ZI63i4UR+I/JKNahonXFUluSEfHBqXye6ZfhnuwiE25dyV
         4+XK1CwOD+T/UPkw8RhBdJ/nySOCPwxPvjGFu7Y4fcwRM2Oudw6v1i0HfeuVXvkBFJDo
         xUNLOkx70HG4S3i2VIzfthAhCQ/OOZV0sIyn2J/XGZ3KbPf7wmSH6oLfeNJC/ILvH1pX
         sLKGLObHVsrjMFCy3ifbgDs6htkFhTpqNoHPpShoVmXyJvFk97MBU1B0XftjAKN9ACRP
         K8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVa8gG3KQx9z1I7+2T5HAnbon06rqilvzFi8WN+ki7s=;
        b=PJBsxsdV243BtLdmM3PzGLBlsslBesHy8zyXt19tg75ZqjygBQRX3l7QfN+zj1cgsJ
         WfXfaNFTPH+gK2A0k9gIfaiTaB7rJqh7sohRflqw5DQ2djhmjCzhJbi5+8fKNWZjzo/O
         SK661MZF96/2O47jr5UJnhvhioc1MY5kjSzHX7ZLMf87jZPRfBtQlUEse4CAmEdlVTaP
         wvGOapCG998tfyiMHXjKsw8G9NbeCFWwbF/6QAy958pUffTZCmbpCUEGpCrt3M/4vpBQ
         5mBE95fwXUvYGxYbGeJy4NeNLqRJo+1HSxcX0FVPg+KWMbymPo5wk5KM4K5pwxx5jqLE
         uqNw==
X-Gm-Message-State: ABuFfoheJLJ87jtUoNPpbexKTKhM8Lgm3+AIT6r4vgdPM4TUzzREgKjK
        PVAjjyEpMMYeWNBHOJ2QPuw+sj9G
X-Google-Smtp-Source: ACcGV636kPbGsgHommKHA4N2WQSd5Zf4gr0omgXGm4TdhMHkIYdGTrVbJqbo0JVUJ/UTbBE1Ad1SAw==
X-Received: by 2002:a2e:3e0b:: with SMTP id l11-v6mr27511150lja.16.1540039213698;
        Sat, 20 Oct 2018 05:40:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 48/59] config.txt: move showBranch.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:37 +0200
Message-Id: <20181020123848.2785-49-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt            | 4 +---
 Documentation/showbranch-config.txt | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/showbranch-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e5454df2f8..6136c5638c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -656,9 +656,7 @@ include::sendemail-config.txt[]
 
 include::sequencer-config.txt[]
 
-showBranch.default::
-	The default set of branches for linkgit:git-show-branch[1].
-	See linkgit:git-show-branch[1].
+include::showbranch-config.txt[]
 
 splitIndex.maxPercentChange::
 	When the split index feature is used, this specifies the
diff --git a/Documentation/showbranch-config.txt b/Documentation/showbranch-config.txt
new file mode 100644
index 0000000000..e79ecd9ee9
--- /dev/null
+++ b/Documentation/showbranch-config.txt
@@ -0,0 +1,3 @@
+showBranch.default::
+	The default set of branches for linkgit:git-show-branch[1].
+	See linkgit:git-show-branch[1].
-- 
2.19.1.647.g708186aaf9

