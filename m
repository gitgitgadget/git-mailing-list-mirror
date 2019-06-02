Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88CA1F462
	for <e@80x24.org>; Sun,  2 Jun 2019 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFBPNk (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 11:13:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39839 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfFBPNk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 11:13:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so5950632plm.6
        for <git@vger.kernel.org>; Sun, 02 Jun 2019 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7dnR15q3Ha30UDfuZrZzYdkykzQGLAbNaO7785ayXw=;
        b=vdDp9CS6nTjD9CBr0/HS9WS1FMmh+QGZNvSgx74Q6yBjePIVHO0t3ky0r8zmZntJ1U
         9d6veZTmYWOGKHP/000vdp2Wf4Q4RmlYc8laIXwWznaaNceHEp46NiWGNJ875cNYNvIW
         6qnmkhZiVWI66OFyNWMmIUrHjArHeyBx/jDquD3jJa9B0yPqOsU7uPUiKBVcN6Abl3ek
         x1Z8AusD8ONRKXGADXZZ85ZKcMFxYwVA1ei215Lank1qI5l+r2CZb9pOiw81zZOKjSRJ
         0zbD8yqxXdVX+IdjahT0jhK/Z6UI1EA1+RFkaUwNwynHqkZrbZkit5+qNt/Kx6BPWNGe
         h1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7dnR15q3Ha30UDfuZrZzYdkykzQGLAbNaO7785ayXw=;
        b=NRaOD1owhXHoN1t3OEZgttLe0CZ2q6CByKvnrGhNx0LK9B29gPwFQLHbTaNgTe47DI
         j2paDIMUUF/JemlCjcLyS96fBQqaOuX1c4nEXaGAaqIpSm1wS9zFzAQGbH0arbXIL8dm
         TSJBbjVs2wLuvRGBX33A0YGJehYEwyAxHQ+MbzBo8cbH1F4PtMH46m3U8tThB2Ezae80
         otj2gfRNtWz+BOUG5uyvI0i3axaG9oS7ILpNFFH93Rw0319icKBjxGzC1L5iJ785VXfQ
         ofdox9hPdJnWM/azBLk7ghD6wryuj8HGEs7gXORvwLyPQpHh8foIvGsOq3vm88yKLhOE
         7H7g==
X-Gm-Message-State: APjAAAWH0kMk9RGPuj9SLSdF1K+wiX/cegIgrjHKPVxDTJWUYk+G8LMF
        DDmvd+FLl5x1P0DEkUtNt/E=
X-Google-Smtp-Source: APXvYqwEVWL9+YRXST20zBPf7Rq3l2wfclXbt0NuRpjxcFDZYOSsG9+HFVQukb9zD27F0W8tlvlgAg==
X-Received: by 2002:a17:902:2bc9:: with SMTP id l67mr24335675plb.171.1559488419564;
        Sun, 02 Jun 2019 08:13:39 -0700 (PDT)
Received: from localhost.localdomain ([2408:84e1:105:c5ce:65c5:bc73:cd52:9a5c])
        by smtp.gmail.com with ESMTPSA id x13sm10552793pfa.154.2019.06.02.08.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 08:13:38 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] i18n: fix typos found during l10n for git 2.22.0
Date:   Sun,  2 Jun 2019 23:11:22 +0800
Message-Id: <20190602151122.7512-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.14.g03eb6640cb.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Find two typos introduced by the following commits:

+ 31fba9d3b4 (diff-parseopt: convert --[src|dst]-prefix, 2019-03-24)
+ ed8b4132c8 (remote-curl: mark all error messages for translation,
  2019-03-05)

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 diff.c        | 2 +-
 remote-curl.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 2068b1c06e..a654d46f6a 100644
--- a/diff.c
+++ b/diff.c
@@ -5354,7 +5354,7 @@ static void prep_parse_options(struct diff_options *options)
 			     N_("show the given source prefix instead of \"a/\""),
 			     PARSE_OPT_NONEG),
 		OPT_STRING_F(0, "dst-prefix", &options->b_prefix, N_("<prefix>"),
-			     N_("show the given source prefix instead of \"b/\""),
+			     N_("show the given destination prefix instead of \"b/\""),
 			     PARSE_OPT_NONEG),
 		OPT_CALLBACK_F(0, "line-prefix", options, N_("<prefix>"),
 			       N_("prepend an additional prefix to every line of output"),
diff --git a/remote-curl.c b/remote-curl.c
index a1bf4f68c7..051f26629d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1117,13 +1117,13 @@ static void parse_fetch(struct strbuf *buf)
 			const char *q;
 
 			if (parse_oid_hex(p, &old_oid, &q))
-				die(_("protocol error: expected sha/ref, got %s'"), p);
+				die(_("protocol error: expected sha/ref, got '%s'"), p);
 			if (*q == ' ')
 				name = q + 1;
 			else if (!*q)
 				name = "";
 			else
-				die(_("protocol error: expected sha/ref, got %s'"), p);
+				die(_("protocol error: expected sha/ref, got '%s'"), p);
 
 			ref = alloc_ref(name);
 			oidcpy(&ref->old_oid, &old_oid);
-- 
2.22.0.rc2.14.g03eb6640cb.dirty

