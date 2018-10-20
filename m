Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B4B1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeJTUux (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41654 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbeJTUuv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id u21-v6so33076579lja.8
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LkayriAszoOFP71wPTMxk2lQzr1phQ0mBh0SA54mcyc=;
        b=BHSPQ2OdJlCy0ag1igNWiKu/3Rn0uhbHGxWQJM9lpSMwsJgrWPoKvA0wjG66IyeGhT
         7rKExNn1SqxBLCFHgg+qAqGPuJ2Z3Y99kj/DNXUrDl8dObJro9qlBZHMN+2M5D7k9QPs
         Dexe2cZZnFGEgrc6WxRsPFIosNdFb+escUwjK5Ta34529BOldVXnQdUqHpecgo+hoiGW
         S9b+vknxnpE7Ga+4QxB0XCF5Ynymu5DardktiMRogg2w8bs2qVg6YnEPsdlWQVJxB7Rq
         Bjvam5uoi1Gdd3dOC9AJDMtOtf9uui62ltsMgQjH+EN3wUrF/IeVfXuaoXBN4hwtv/1v
         1TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkayriAszoOFP71wPTMxk2lQzr1phQ0mBh0SA54mcyc=;
        b=byxZn3WtTpDH5BGQSJmplm04GFtJyHWpQDtEFhxzQsNavZuToK1DQT7Up5qPL0scld
         OnPgtNvRvosJYg4T4N7SZVlNlo/KJj5bz/mC/h7wVegt/iwX9fyeE26xNT9tCK/vLMew
         Q5xWnZYJ2IWn3aaf9AvSuzQFseeLA2KkeZSqthjWJPgvjG6AKLHipcMCAxTgsbcACE5e
         N/f9j6Jn0LJQQwfBhA2s0QAiOyA1rJz9SPVkxG8YNk4WgnivpCv+a5p+yxmCNMjDDEQz
         5G60zU3ZHKewp9BPCdqMxa+mwbpxM7eS7gxDzKKQzRzKJHcyv9OFlt0pArDzsgO2/Waj
         3tjQ==
X-Gm-Message-State: ABuFfohOIFuWFDrNEzqeF6FbmBkWImGdyebVTi/S9R6QwHco1TCEJu8n
        vn57MSa+pl7qrhDDStniRXm1QVHv
X-Google-Smtp-Source: ACcGV62NKQF7swureGzq4lW1jXoyYc7F2MgQ2euFgYr0x//8Ptyvw9YxWl5dKMCm0OAugO8w8FesGg==
X-Received: by 2002:a2e:8184:: with SMTP id e4-v6mr22461734ljg.138.1540039228423;
        Sat, 20 Oct 2018 05:40:28 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 59/59] config.txt: move worktree.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:48 +0200
Message-Id: <20181020123848.2785-60-pclouds@gmail.com>
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
 Documentation/config.txt          | 10 +---------
 Documentation/worktree-config.txt |  9 +++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/worktree-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 76a0e3ed90..9e2a2e0f90 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -684,12 +684,4 @@ include::versionsort-config.txt[]
 
 include::web-config.txt[]
 
-worktree.guessRemote::
-	With `add`, if no branch argument, and neither of `-b` nor
-	`-B` nor `--detach` are given, the command defaults to
-	creating a new branch from HEAD.  If `worktree.guessRemote` is
-	set to true, `worktree add` tries to find a remote-tracking
-	branch whose name uniquely matches the new branch name.  If
-	such a branch exists, it is checked out and set as "upstream"
-	for the new branch.  If no such match can be found, it falls
-	back to creating a new branch from the current HEAD.
+include::worktree-config.txt[]
diff --git a/Documentation/worktree-config.txt b/Documentation/worktree-config.txt
new file mode 100644
index 0000000000..b853798fc2
--- /dev/null
+++ b/Documentation/worktree-config.txt
@@ -0,0 +1,9 @@
+worktree.guessRemote::
+	With `add`, if no branch argument, and neither of `-b` nor
+	`-B` nor `--detach` are given, the command defaults to
+	creating a new branch from HEAD.  If `worktree.guessRemote` is
+	set to true, `worktree add` tries to find a remote-tracking
+	branch whose name uniquely matches the new branch name.  If
+	such a branch exists, it is checked out and set as "upstream"
+	for the new branch.  If no such match can be found, it falls
+	back to creating a new branch from the current HEAD.
-- 
2.19.1.647.g708186aaf9

