Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC37D1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJTUta (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40829 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeJTUt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id r83-v6so33086306ljr.7
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yj9tn2TJvTbWrW1DkEERIb5NcUIEsBRyeA3IGauGRMk=;
        b=tM8R7nURT7cjAlWl34x3hAFfKc1HWKyIRtPsFFQMlpxNRkvThCVRa7R1KYYCXrqGrd
         F0Ebp7ImUgVyYViBDYm+hVEFPhGKWRo/zPOvC8whDPuWQ1FYo4ui+4462A4GXsWFlxb+
         oOi0LhAKlhlXrE2YCpCIrk/W44I+caw4s6lD84bGZEYtBe7kP/XJhBzvfYAqoLcNPyCq
         rDTEbeJ+WWhJhzspcvl/x2FVoxQQ7eDG8rusjF6bUUmHgwWiT1VN+zU3mfePC0/BR5um
         be5SShPvYx2VblDfSx8OhLlxR02V/FpVWXGAT10DnV5cCtb8sdlAnkcTer7qXILu9Pol
         plrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yj9tn2TJvTbWrW1DkEERIb5NcUIEsBRyeA3IGauGRMk=;
        b=onkeh54EfD6y/AxGV6idMED4x5icE+7Twyu6q3C+v9FXaJP03a0564U7frdL7MVtqN
         HJ42tzE/4TeuLNk9FbPGXqzNSjt06+nRqTzy8RK8byxydlZUtabp54Em8Mjk7ZrnK5+B
         csTQEJ8vaRKSCjvCJhT0xm7lO3GqNTc36lRPBvqus1HUY14c4G6Kjf9gSi/zo60RBU63
         VDRJKXPNRiaobkOjVaOHMqB9FSSmoJ6wWdmOEIsNhNqRQu2DPhy9s0puHRzTVW/PTL3N
         u6GVYyUikQIvfnp0iOOEez3nqsQ6w5Kr2aF2ovsDKzD8Y/gRU0ikNBncrokJLxE/lTVY
         pRPw==
X-Gm-Message-State: ABuFfohThqf2qdQeCVCZ9DNwcx6Tc/ZrHWhryTM59i9N1V+EvcVSDHjh
        vmR1x6i9MwUkbFIc9VhCVnLSjSV0
X-Google-Smtp-Source: ACcGV60Y9LW6xcRdx0ptDX0ZTVI1SrHhiyP4ChwBy/eHXjaosn4fpwTgs1o5CiCteB1tPiuBDNgqCg==
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr24754553ljd.148.1540039147645;
        Sat, 20 Oct 2018 05:39:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/59] config.txt: move checkout.* to a separate file
Date:   Sat, 20 Oct 2018 14:37:59 +0200
Message-Id: <20181020123848.2785-11-pclouds@gmail.com>
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
 Documentation/checkout-config.txt | 23 +++++++++++++++++++++++
 Documentation/config.txt          | 24 +-----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/checkout-config.txt

diff --git a/Documentation/checkout-config.txt b/Documentation/checkout-config.txt
new file mode 100644
index 0000000000..c4118fa196
--- /dev/null
+++ b/Documentation/checkout-config.txt
@@ -0,0 +1,23 @@
+checkout.defaultRemote::
+	When you run 'git checkout <something>' and only have one
+	remote, it may implicitly fall back on checking out and
+	tracking e.g. 'origin/<something>'. This stops working as soon
+	as you have more than one remote with a '<something>'
+	reference. This setting allows for setting the name of a
+	preferred remote that should always win when it comes to
+	disambiguation. The typical use-case is to set this to
+	`origin`.
++
+Currently this is used by linkgit:git-checkout[1] when 'git checkout
+<something>' will checkout the '<something>' branch on another remote,
+and by linkgit:git-worktree[1] when 'git worktree add' refers to a
+remote branch. This setting might be used for other checkout-like
+commands or functionality in the future.
+
+checkout.optimizeNewBranch::
+	Optimizes the performance of "git checkout -b <new_branch>" when
+	using sparse-checkout.  When set to true, git will not update the
+	repo based on the current sparse-checkout settings.  This means it
+	will not update the skip-worktree bit in the index nor add/remove
+	files in the working directory to reflect the current sparse checkout
+	settings nor will it show the local changes.
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 407fd390a2..8d890cc22a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -305,29 +305,7 @@ include::branch-config.txt[]
 
 include::browser-config.txt[]
 
-checkout.defaultRemote::
-	When you run 'git checkout <something>' and only have one
-	remote, it may implicitly fall back on checking out and
-	tracking e.g. 'origin/<something>'. This stops working as soon
-	as you have more than one remote with a '<something>'
-	reference. This setting allows for setting the name of a
-	preferred remote that should always win when it comes to
-	disambiguation. The typical use-case is to set this to
-	`origin`.
-+
-Currently this is used by linkgit:git-checkout[1] when 'git checkout
-<something>' will checkout the '<something>' branch on another remote,
-and by linkgit:git-worktree[1] when 'git worktree add' refers to a
-remote branch. This setting might be used for other checkout-like
-commands or functionality in the future.
-
-checkout.optimizeNewBranch::
-	Optimizes the performance of "git checkout -b <new_branch>" when
-	using sparse-checkout.  When set to true, git will not update the
-	repo based on the current sparse-checkout settings.  This means it
-	will not update the skip-worktree bit in the index nor add/remove
-	files in the working directory to reflect the current sparse checkout
-	settings nor will it show the local changes.
+include::checkout-config.txt[]
 
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f,
-- 
2.19.1.647.g708186aaf9

