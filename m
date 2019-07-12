Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0BDD1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 15:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfGLP7P (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 11:59:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39575 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLP7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 11:59:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id m202so7648275oig.6
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=txvecSw9jqUzzh7fTMrwuQR6LGkiq6U0h8j626J3XHQ=;
        b=QkCmJbjMUxNVzKM1wG6yasrKB0qWZy+LLs9BD7W7pgSpSFGhgeY07IZLyGElyBIH1J
         1kw/qllR2GFRTpz+J58PxI8MumoBWU7Iri/it+lfJH0E4R1ptu2OyXo0cUhvY+4O7Jhc
         v2CrFPxxwVvbfiazQiMcnObZIOPHpIzsrSGxTciqBCXAh0Ji7lh7n059SxutuLEVxNO3
         /P+vPnOYyGHXhR7wtjC0wHAUF9K+btwel6yIdHIjGbFAQgkqi04eXAxZHDzc/Fsh5IgF
         /xkaZCuCLIghVpIc47Lxu97hvNg4tJOdoRvUdXLNHpTnG9qXVS0xB0C0RKiaAhmR2FK9
         eI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=txvecSw9jqUzzh7fTMrwuQR6LGkiq6U0h8j626J3XHQ=;
        b=qexKYx0fEGZmUEMJQ5bBVoZcohQ/+gBp2GdblpGM7rnZXPpmZxtt57vr2Hj6lwsrUz
         9qOGD1gTzwfi8GnsMr5vmm8ucWGdjtKg26cBIWbcnQas0+2bkO6lnQBR95OYcwtaJg0s
         1jLliUyaAGwo5mICXVFIWSC2QxnNQJTlKShr6mamYq5KLZWJJSG82SE3p6BHosN/aq8W
         kXVEKggf5YFP4sDATi2sfldjT91UCJ4FPBhw6XDM1S5qmcr5hJ6fBSjovD7TULJBFgu8
         6PgfNQqjrxKY3egnAMGQPh4zKrSUT6ARc5WxHHmVR/GCP+YWfLsOKiZTZlLPkGdpwktZ
         qMxA==
X-Gm-Message-State: APjAAAU2MZymLGDL3h/Zswd0k98JvfrlC/oer0SV0fXzsv7BHLn0Le/z
        us9KGyXuKeA76QxVscc02tAv4z86
X-Google-Smtp-Source: APXvYqzylfFydlH0c6Po3CsJol5nQy0KvP8dsVKgf9UTTUd3SbzGV7H30wv2BDR2GXcx7nd/evjBuA==
X-Received: by 2002:aca:72d0:: with SMTP id p199mr6648396oic.178.1562947153061;
        Fri, 12 Jul 2019 08:59:13 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:c055:b92a:b249:c6a6])
        by smtp.gmail.com with ESMTPSA id w13sm2920583oih.17.2019.07.12.08.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:59:12 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v1 2/2] documentation: mention --no-use-mailmap and log.mailmap false setting
Date:   Fri, 12 Jul 2019 10:59:01 -0500
Message-Id: <20190712155901.19210-3-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712155901.19210-1-ariadne@dereferenced.org>
References: <20190712155901.19210-1-ariadne@dereferenced.org>
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

