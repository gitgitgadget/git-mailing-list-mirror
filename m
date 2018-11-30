Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8051C211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 18:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLAFV4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 00:21:56 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33766 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeLAFVz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 00:21:55 -0500
Received: by mail-ed1-f54.google.com with SMTP id r27so5605757eda.0
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 10:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOi3k2Ll6ums49CAsSDZZwJ3xPNoTpNpj50aVtnXaq0=;
        b=PSwDsovdU5IRdX70Y3NCzUBVTUltEgkLg9rMbaFMfkDw2JlN615t7k22kMgEXdyGX9
         aO9zVLwDa8ti3p9ovYkxEa4OSvi9y7AhtxFe9dYS7b4y19G3xeennRVz+O/z1H3gUYzz
         t2SSwVJDWsWh5ghxKv2KR1VcsHdxDz9l6w7euJoH3tfaa9TBTYJY7pg7Cfw/XwaTQbqy
         q4oCPyDNW1Eqhve9Fxklc1xZzAEqjYhaAWjQ+Ka4UA2LRaBmRrhc2x56dyCMLwKvFNNk
         DaBrfuzkzwZQFo01m7dsmqGL07CWCK7Hy4NZaaGG/AX2i2VcfrNdFW0eCW3P9EIS1QpQ
         MsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qOi3k2Ll6ums49CAsSDZZwJ3xPNoTpNpj50aVtnXaq0=;
        b=hjEllFRigcU2WkO9+5UzWUtdECNQWtGkcGDeZEqSkC1aaRbTZDAxqAH6p9iCvHjRWC
         0AiqWr1/Llvqz7M7MBJvO9RsDALRWLPc4h4gD1k6iCQ3bz28VKuOnukq1kJavzYl1Jey
         POvxH0cLO2u0kbblGezrZRu8VyPHBb1tQ+rkrwk4yq3LN/yPvO8tcrVNSw/EOl0K5qsv
         AgU/JgZyAaiGPERtJBRzOnp8N9FK7HjyHUCzFDP49PiftJsnr3tE2UItnBiOmHuLhzsr
         gZKEEBEKP1bhpFudw88ZSFCYyoj0c6U++ihVFSThHE3Pqn2btazq8n1rcjiKiaigXaVE
         esiA==
X-Gm-Message-State: AA+aEWaalY/JKH+cCI5ipDzSgjGz2Q1pOYqLu1ZaGQMI0yIwQGJdT9jt
        /DwII1JtwNbqU+rkh8g12tTCg9Hv
X-Google-Smtp-Source: AFSGD/X51P2S28SM9tuKZEYE7zD5ASqZ0Au8unmZZXmumrxxK/JJVIpWSYCn6lLobKWiS25upq54Ig==
X-Received: by 2002:a50:e3cb:: with SMTP id c11mr6247297edm.80.1543601507614;
        Fri, 30 Nov 2018 10:11:47 -0800 (PST)
Received: from localhost (cable-82-119-16-173.cust.telecolumbus.net. [82.119.16.173])
        by smtp.gmail.com with ESMTPSA id o37sm1550979edc.32.2018.11.30.10.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 10:11:46 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] builtin/rebase.c: remove superfluous space in messages
Date:   Fri, 30 Nov 2018 19:11:45 +0100
Message-Id: <20181130181145.13539-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.379.g1dd7ef354c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b3e5baec8..a6acba76b4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -871,7 +871,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			       "them"), REBASE_PRESERVE_MERGES),
 		OPT_BOOL(0, "rerere-autoupdate",
 			 &options.allow_rerere_autoupdate,
-			 N_("allow rerere to update index  with resolved "
+			 N_("allow rerere to update index with resolved "
 			    "conflict")),
 		OPT_BOOL('k', "keep-empty", &options.keep_empty,
 			 N_("preserve empty commits during rebase")),
@@ -1520,7 +1520,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 */
 	strbuf_reset(&msg);
 	if (!oidcmp(&merge_base, &options.orig_head)) {
-		printf(_("Fast-forwarded %s to %s. \n"),
+		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
 			options.head_name ? options.head_name : "detached HEAD",
-- 
2.20.0.rc1.379.g1dd7ef354c

