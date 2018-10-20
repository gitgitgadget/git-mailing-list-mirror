Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF151F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJTUuO (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44829 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeJTUuN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id v6-v6so33058910ljc.11
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Le9E207ycCQIOQPXFNBdzwcvde4uwacQBcDxwooFvU=;
        b=LylOkapbslik03nNKkoYNfMDwUargAJLEibiWiBF4s5n4pHTK3iWugyOx/YCgqSznx
         YAjHLCgOvnJM+zLLKWm62EGSOhLMZGv1gGVYE1itqAKEnFwr6YV5jy7K64Dc60/ljaEz
         j21jwJCoPO29zrKKxT2xzf4j4p7yD+CPqnyPvJMBWQFtC6Iv+l/VkCgcF7jT324wJPq2
         P0WjPuCwZz9t9RgUeAEBrVOEKezryt1ZWfBGUxFMna+oCYDR5RqW6mJlI5C9CSUpdWGd
         koUGXnksRkyMKqFMREwHMrE5w5p202Q0yrWdZy2jf1kAKB+yRDxujlkKIpGbLFcZS7eX
         d/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Le9E207ycCQIOQPXFNBdzwcvde4uwacQBcDxwooFvU=;
        b=JKKx0yiP1Nr2/tNyILnnZfMjl4cWCL19HBegy2iifDyEiZdGNFYG8PmV4V6UFb/0YM
         qKVJDumJyhCZjc6zD49xkvlJgggw63QA/yBe24Kn5MWYj7jmk2/l92egq/6TwHjzsN/W
         IXv7IYc377kPUxrCVPuvghCQHE+eaJtMcXP4+t2QScZRVmv0VGtCbXDg3pBezejyiZ/r
         fbAzkigGYa5lRA5Khn2eKz6r3CzjwyltFj/IaVe6Nm63jtLr4Bwc16MNUGfT/QqqWaeZ
         0GyaflFxa+tX036GrRHBEObCzxBe2DvU8d3VrL1RbdmH5Wq8lVi5GJkLZFOSkhOdzf08
         ajRg==
X-Gm-Message-State: ABuFfoheYSzod8yGrNe4kKu5otkcuufY2GrNeePgnCeYkcM7ZbBZq3x6
        RzD9UQECjwQJX0WSVM+4/P2+BpZZ
X-Google-Smtp-Source: AJdET5fWm2i2eQl7n5aeBCW5TReewLO3Oj/EJgcR3cgOALO/D3d55BuAtCtW2l146hZPWtIHFpDJxQ==
X-Received: by 2002:a2e:5d8f:: with SMTP id v15-v6mr1094119lje.86.1540039191101;
        Sat, 20 Oct 2018 05:39:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 35/59] config.txt: move mailmap.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:24 +0200
Message-Id: <20181020123848.2785-36-pclouds@gmail.com>
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
 Documentation/config.txt         | 16 +---------------
 Documentation/mailmap-config.txt | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/mailmap-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ca178e2651..c057a290a4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -618,21 +618,7 @@ include::log-config.txt[]
 
 include::mailinfo-config.txt[]
 
-mailmap.file::
-	The location of an augmenting mailmap file. The default
-	mailmap, located in the root of the repository, is loaded
-	first, then the mailmap file pointed to by this variable.
-	The location of the mailmap file may be in a repository
-	subdirectory, or somewhere outside of the repository itself.
-	See linkgit:git-shortlog[1] and linkgit:git-blame[1].
-
-mailmap.blob::
-	Like `mailmap.file`, but consider the value as a reference to a
-	blob in the repository. If both `mailmap.file` and
-	`mailmap.blob` are given, both are parsed, with entries from
-	`mailmap.file` taking precedence. In a bare repository, this
-	defaults to `HEAD:.mailmap`. In a non-bare repository, it
-	defaults to empty.
+include::mailmap-config.txt[]
 
 man.viewer::
 	Specify the programs that may be used to display help in the
diff --git a/Documentation/mailmap-config.txt b/Documentation/mailmap-config.txt
new file mode 100644
index 0000000000..48cbc30722
--- /dev/null
+++ b/Documentation/mailmap-config.txt
@@ -0,0 +1,15 @@
+mailmap.file::
+	The location of an augmenting mailmap file. The default
+	mailmap, located in the root of the repository, is loaded
+	first, then the mailmap file pointed to by this variable.
+	The location of the mailmap file may be in a repository
+	subdirectory, or somewhere outside of the repository itself.
+	See linkgit:git-shortlog[1] and linkgit:git-blame[1].
+
+mailmap.blob::
+	Like `mailmap.file`, but consider the value as a reference to a
+	blob in the repository. If both `mailmap.file` and
+	`mailmap.blob` are given, both are parsed, with entries from
+	`mailmap.file` taking precedence. In a bare repository, this
+	defaults to `HEAD:.mailmap`. In a non-bare repository, it
+	defaults to empty.
-- 
2.19.1.647.g708186aaf9

