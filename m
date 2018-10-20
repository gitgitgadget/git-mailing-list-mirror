Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 313081F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeJTUun (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32812 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbeJTUum (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id z21-v6so33118138ljz.0
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/lwHikZ+nH5MpHfC5+Fy6uGOCl5tZ1Z/P3F6xiFTUo=;
        b=FQvBEuFNAexyphOXG+kcoVF5nxdH5bqEX6X50wAkKPigFFr7d7eB+yK1FsmwJLkFPp
         heUz1tvp6mmwjAsY48MMGVfZ3soWpPp/v2Rh3iBl7+4msFOZ2iaP1s0LfLhqSwzoMSaB
         0Mrh3tTwECWNP4Rzqd9019Y52nFfbO/h0S4hTGtYO1pBlLglz3eE9xzOMfSz+r7lduOZ
         InBa3seXtUsd664CoEs7HiMkdl2V3AyfWAzFktcwu/i0EmslLoaXwxolIk/oorMY8yMN
         hmcr8JFLX9ijhBfDGThJJX4BkslVRiOWd8oUXrFBh356Fginjt1pc8JdnB9ifJZ8l/9B
         vclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/lwHikZ+nH5MpHfC5+Fy6uGOCl5tZ1Z/P3F6xiFTUo=;
        b=FIL8jSi4quBgg6JIDt7beBe41dxCCGlYrx6aKr42SVB46IuyE9520hXEb8oAgqz28U
         3nYlRrxgD6nVb41DbW6Mzrh84J9CCNAKpvRz9jnJukELRDhTN7fHMnNS91GcIzYL1Rlr
         6SqPE45MoIJYXE9T9dYJu/iBKsqe68kAb/2grZqvOQh78ysTGO4z/6YAO7UsBYQNPD23
         go4myJ3kUdeNUGmW1Qe/UzqgJSlS1qQSyuwRl2mpwcZLnURa23JdqPNMyDhRuWkDRc9f
         V5LxYhg0A7rAJoT51RwboLhzJtPqpENBCkfG92LvcBdtiGt0fWyshYKwXbY9bqQsOevs
         g1CA==
X-Gm-Message-State: ABuFfoi9AXKlaYWxXo9A3DRWCCDM+n9dUPRd+pZs0F07aaonjGz/f8yB
        q/vgi7RoBaSnekk844Xd8Y0dNK8p
X-Google-Smtp-Source: ACcGV62TNC/2RdM1Pe+z4NPzz+e74wrxWGXAbwEatcLiYC6HZEy79pzHycNOcFHHa8on3MWYMCK97A==
X-Received: by 2002:a2e:7608:: with SMTP id r8-v6mr24559619ljc.175.1540039220019;
        Sat, 20 Oct 2018 05:40:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:19 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 53/59] config.txt: move uploadarchive.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:42 +0200
Message-Id: <20181020123848.2785-54-pclouds@gmail.com>
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
 Documentation/config.txt               | 7 +------
 Documentation/uploadarchive-config.txt | 6 ++++++
 2 files changed, 7 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/uploadarchive-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b70f98baba..fef310d47d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -672,12 +672,7 @@ include::tag-config.txt[]
 
 include::transfer-config.txt[]
 
-uploadarchive.allowUnreachable::
-	If true, allow clients to use `git archive --remote` to request
-	any tree, whether reachable from the ref tips or not. See the
-	discussion in the "SECURITY" section of
-	linkgit:git-upload-archive[1] for more details. Defaults to
-	`false`.
+include::uploadarchive-config.txt[]
 
 uploadpack.hideRefs::
 	This variable is the same as `transfer.hideRefs`, but applies
diff --git a/Documentation/uploadarchive-config.txt b/Documentation/uploadarchive-config.txt
new file mode 100644
index 0000000000..e0698e8c1d
--- /dev/null
+++ b/Documentation/uploadarchive-config.txt
@@ -0,0 +1,6 @@
+uploadarchive.allowUnreachable::
+	If true, allow clients to use `git archive --remote` to request
+	any tree, whether reachable from the ref tips or not. See the
+	discussion in the "SECURITY" section of
+	linkgit:git-upload-archive[1] for more details. Defaults to
+	`false`.
-- 
2.19.1.647.g708186aaf9

