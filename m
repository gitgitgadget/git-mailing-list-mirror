Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AF681F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJTUuj (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40501 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbeJTUui (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id n3-v6so278110lfe.7
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIMUPUoh8DyRuLrx2Q/kyBgIDRfpOXBG8JNstQ/OqFQ=;
        b=Hk7UY27v5uhldZ9+ICEBgtti+K64Ic3wrFAvg9aFw+VyKxOssRT/Rumvd0Djmv/yKe
         9YKju52Mg9SkgfoUuOBkhCm/3tVdD+Pf9mWaLH3nEhdMHr2EmT8iZEWTZeqrCn1hK2Zo
         mAz6rPzo21NrKOpKStEBbh8U1LlnVy9LA20vY/25g4IY0cz8Gb+P/DxoEkJD8olDP1ZI
         HsjY58Hv0v0KtpPLY1Ym+ePSrorZyOcM8+5nLNVvv8yV81oEMvOk5sa5t+3J8mxavrb9
         JpJb//6uCJN7FmB1bArX6m2MJZ0E8B/xt/Ht8M2mwFU+Rw0llSQM3R7yAgyMhir4yyOW
         Z/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIMUPUoh8DyRuLrx2Q/kyBgIDRfpOXBG8JNstQ/OqFQ=;
        b=WpFbaqU3IJfjM3GWm4Kbb7/VcVZO7WIxoX201p/dgAUR2tgPGBvTgcFVW09kiEXVxV
         3pqus4IAk21fagNw4lQGSuYYtGeC7VqIofaaT0+H8zEUENqCLewn70f8A7z2I0v5QO67
         yiLVtvVh+yB8h1ALssPKAmJz3KiElaljgvPZRfNO6uEEnkkDu15/23OJ4dlUDWqnb9yH
         S/5pM1GLZuqLnJ2I2/1nN1VwUlDk7A97M3ef6ZbVltCaFAaEugALRo+1eOolojuO2Ld2
         bA1GDEKHPn/8J/7IxdXn8Vf7VcN71CKlj99hq0QMTwNAdjhR17nPJNGwalWmC3CQhOhq
         TlCg==
X-Gm-Message-State: ABuFfoi/pVyLWXk6mE6/W0K3jYRbDykkfN+mhQb+Pjgixtw0sDjzSaCQ
        vL7NnfladDCsZBFCTYdUuJDoGzi0
X-Google-Smtp-Source: ACcGV62taIeKthXKP5oDoiQ64fr4XcZR/VFuMtZxRDPgEnZcWTs3Ni+gvEBjTX2rvdQ5sNtQr1d5FQ==
X-Received: by 2002:a19:945b:: with SMTP id w88mr5224741lfd.15.1540039216629;
        Sat, 20 Oct 2018 05:40:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 51/59] config.txt: move tag.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:40 +0200
Message-Id: <20181020123848.2785-52-pclouds@gmail.com>
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
 Documentation/config.txt       | 27 ++-------------------------
 Documentation/stash-config.txt |  9 +++++++++
 Documentation/tag-config.txt   | 16 ++++++++++++++++
 3 files changed, 27 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/stash-config.txt
 create mode 100644 Documentation/tag-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b7df6a8311..4b1efe0a95 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -664,34 +664,11 @@ include::ssh-config.txt[]
 
 include::status-config.txt[]
 
-stash.showPatch::
-	If this is set to true, the `git stash show` command without an
-	option will show the stash entry in patch form.  Defaults to false.
-	See description of 'show' command in linkgit:git-stash[1].
-
-stash.showStat::
-	If this is set to true, the `git stash show` command without an
-	option will show diffstat of the stash entry.  Defaults to true.
-	See description of 'show' command in linkgit:git-stash[1].
+include::stash-config.txt[]
 
 include::submodule-config.txt[]
 
-tag.forceSignAnnotated::
-	A boolean to specify whether annotated tags created should be GPG signed.
-	If `--annotate` is specified on the command line, it takes
-	precedence over this option.
-
-tag.sort::
-	This variable controls the sort ordering of tags when displayed by
-	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
-	value of this variable will be used as the default.
-
-tar.umask::
-	This variable can be used to restrict the permission bits of
-	tar archive entries.  The default is 0002, which turns off the
-	world write bit.  The special value "user" indicates that the
-	archiving user's umask will be used instead.  See umask(2) and
-	linkgit:git-archive[1].
+include::tag-config.txt[]
 
 transfer.fsckObjects::
 	When `fetch.fsckObjects` or `receive.fsckObjects` are
diff --git a/Documentation/stash-config.txt b/Documentation/stash-config.txt
new file mode 100644
index 0000000000..c583d46d6b
--- /dev/null
+++ b/Documentation/stash-config.txt
@@ -0,0 +1,9 @@
+stash.showPatch::
+	If this is set to true, the `git stash show` command without an
+	option will show the stash entry in patch form.  Defaults to false.
+	See description of 'show' command in linkgit:git-stash[1].
+
+stash.showStat::
+	If this is set to true, the `git stash show` command without an
+	option will show diffstat of the stash entry.  Defaults to true.
+	See description of 'show' command in linkgit:git-stash[1].
diff --git a/Documentation/tag-config.txt b/Documentation/tag-config.txt
new file mode 100644
index 0000000000..663663bdec
--- /dev/null
+++ b/Documentation/tag-config.txt
@@ -0,0 +1,16 @@
+tag.forceSignAnnotated::
+	A boolean to specify whether annotated tags created should be GPG signed.
+	If `--annotate` is specified on the command line, it takes
+	precedence over this option.
+
+tag.sort::
+	This variable controls the sort ordering of tags when displayed by
+	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
+	value of this variable will be used as the default.
+
+tar.umask::
+	This variable can be used to restrict the permission bits of
+	tar archive entries.  The default is 0002, which turns off the
+	world write bit.  The special value "user" indicates that the
+	archiving user's umask will be used instead.  See umask(2) and
+	linkgit:git-archive[1].
-- 
2.19.1.647.g708186aaf9

