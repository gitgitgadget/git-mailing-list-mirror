Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561D51F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeJ0PFO (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40933 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeJ0PFN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id n3-v6so2486691lfe.7
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwzOdrG0GfS0h3AseVgtqC/13d4oub4gertiKperm/o=;
        b=UdA/8ehI3hFBb1nXMMvgu96qGEwtJ2H+PjWtRMElKDmw2aIHnknkdTSVTHCGM8aT9K
         71ZRUO7upUccJ9YZ8HUPIJMPvE7FNSzjrle1npX14hXAjnSnCToJbs0dJIJX6Aeb152h
         iEDMCYJw2kp8s/L4nAKxu5sc0xkiiwRNxaOJMm4JtP4i0fhacYD4v1RAnBwscuaNpu9+
         WD7dMgmqI5pM6T9vIATWLrCZko8hjmOAF4FGZcymm5Pv3D4devSUBdinSkZZnSTaJD/M
         IPuPRixbLFd0fhQseqOyABmQl5iNM9oWGNQAM8D2495ZbImMqsP52LJ1rGuXvWQNfRvS
         2MPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwzOdrG0GfS0h3AseVgtqC/13d4oub4gertiKperm/o=;
        b=trkhZQWZUIOOsf3wBl5yNcIRf83erGmWG2lQi1rPDlVEbKcHZXtPmvSP9Jjeax/qoX
         xb36lrDNTpM5RlltOOydz+V0zKHZBt69KEE3SQYsGib7ca2+86IopW+fcaKB/FO/u57x
         +Hx0VkM050EbPw3xPpr+p0TzEQSuGkU3svn4eFn1PbJs+GYt0qustj19yI+tLC84Qq9k
         OWCTmAwXA2wvWHfFlnWuyTXxDh0QLh9+UWhKtTkMJXNm8H3cZ+ZArYtieYMLGNsnwhwi
         XwqAZJDOn38DYp6wRaSglc1+gS3ckeJBxqriGM3GX9MfDo2YwXphcyFVwOCj0uVIdpYT
         9HJA==
X-Gm-Message-State: AGRZ1gI3WJPQfEikN/TrKfNe7I8HpuaKGrV6AuZG3rcL+ceMmz6g7o4z
        AIRMk3qRc4UMNRnNNqXfj4GdpqvP
X-Google-Smtp-Source: AJdET5cT2cAvmTAbWRESIW81dn8VCCie6jOQrffpuB7A0FNys7Olq8nhSs6jm/4qaaEMKMLegLvf9A==
X-Received: by 2002:a19:25c2:: with SMTP id l185-v6mr2795916lfl.122.1540621517615;
        Fri, 26 Oct 2018 23:25:17 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 71/78] config.txt: move uploadarchive.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:44 +0200
Message-Id: <20181027062351.30446-72-pclouds@gmail.com>
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
 Documentation/config.txt               | 7 +------
 Documentation/config/uploadarchive.txt | 6 ++++++
 2 files changed, 7 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/config/uploadarchive.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 07100e236e..00cc2791b5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -423,12 +423,7 @@ include::config/tag.txt[]
 
 include::config/transfer.txt[]
 
-uploadarchive.allowUnreachable::
-	If true, allow clients to use `git archive --remote` to request
-	any tree, whether reachable from the ref tips or not. See the
-	discussion in the "SECURITY" section of
-	linkgit:git-upload-archive[1] for more details. Defaults to
-	`false`.
+include::config/uploadarchive.txt[]
 
 uploadpack.hideRefs::
 	This variable is the same as `transfer.hideRefs`, but applies
diff --git a/Documentation/config/uploadarchive.txt b/Documentation/config/uploadarchive.txt
new file mode 100644
index 0000000000..e0698e8c1d
--- /dev/null
+++ b/Documentation/config/uploadarchive.txt
@@ -0,0 +1,6 @@
+uploadarchive.allowUnreachable::
+	If true, allow clients to use `git archive --remote` to request
+	any tree, whether reachable from the ref tips or not. See the
+	discussion in the "SECURITY" section of
+	linkgit:git-upload-archive[1] for more details. Defaults to
+	`false`.
-- 
2.19.1.647.g708186aaf9

