Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8733A202A0
	for <e@80x24.org>; Sat,  4 Nov 2017 23:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbdKDXVG (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 19:21:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:56344 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751476AbdKDXVF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 19:21:05 -0400
Received: by mail-qt0-f195.google.com with SMTP id z28so7127562qtz.13
        for <git@vger.kernel.org>; Sat, 04 Nov 2017 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d7mFqVl6uF3CtPQckgGOh75LcelLDfNauBR/P31/S4A=;
        b=IQMyx8ZaVLj4cmYvRTdzTyrPMYFaJCmyvLghyT4DdC85+qiP/bY//2KhwLCp6NYWaG
         ktsHKbDB+MJqP3mJe0U19EO0omf8Pfl/x3+bVtjHFcdynXXQhW5p3PX0C0kXYm87bDEt
         d8NoEruSc7EXTMuMb/e04B4/VtWEI4C9bMi/alpFaB1UecqSBfmeMfySE4vEZ5CUddiA
         Ub8zYAtebsjNSL6jsXzyFAMnwGU8qkn5DBK6pOhUYCjNu365tOQ5F6bPoC2X/2VusbQZ
         m5VIkl4KUtFrzzgXgv5U7jcyvROQBUtLcsGzfjJcfmRSHlt7L6ulC4kWp/siPPP6+9tI
         n68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d7mFqVl6uF3CtPQckgGOh75LcelLDfNauBR/P31/S4A=;
        b=HLzKZiV7ujeq8+fPqs70aRzWmeJWgghzrpeO4cOXRq4ncjlwNOoXbYQAybg/9Lmvwu
         meWPTPyYXZ36a37N3LSgJJMyZVDwIPdMLdSJkOnubrz6iESw2u6+E2h/MYc2kHm2loTx
         B3AW7glDm27nRibCv47eov1aRAdFbXdVVqd7Q2LCc1GF8Kpt5y1NOovr2UOeAtq0rvsU
         ersARZJQdSYVw8HyJ0CLAOQXpOtIPpml7mptv5Uv/rjkhLzTHfWqSP4HFcDs7KW4Xu1G
         MpXEncwwYeE3eqxsNmF7gLTtdDNCTj3H7ZPnz7lnji7SFty+a1Ecgnu3nrhwXdijx9ZI
         m4sQ==
X-Gm-Message-State: AJaThX4t3S0ETPD2DvNEzhUqIUf0l+Wu/ssTuy89q6t4TdqYMPOlAkEE
        /MnVkahXw/s4mu6OwfiJvbnAMgqQ
X-Google-Smtp-Source: ABhQp+SL1Wc7Qi4CHSbP4uNqvdYSK5j3FaeBONNpDbRTIPeGX2qSi33QgoA2M2lZAOssrccYWvfI7Q==
X-Received: by 10.237.37.71 with SMTP id w7mr9814744qtc.299.1509837664246;
        Sat, 04 Nov 2017 16:21:04 -0700 (PDT)
Received: from localhost.localdomain ([181.31.238.22])
        by smtp.gmail.com with ESMTPSA id c10sm5880945qtj.29.2017.11.04.16.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Nov 2017 16:21:03 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     git@vger.kernel.org
Cc:     chrisadr@gentoo.org, Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH] l10n: es.po: fix typos
Date:   Sat,  4 Nov 2017 20:20:44 -0300
Message-Id: <20171104232044.7110-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix some typos in the spanish translation.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 po/es.po | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/po/es.po b/po/es.po
index 89a2dc014..43251cbc9 100644
--- a/po/es.po
+++ b/po/es.po
@@ -4746,7 +4746,7 @@ msgstr ""
 #: wt-status.c:1668
 #, c-format
 msgid "nothing to commit, working tree clean\n"
-msgstr "nada para hacer comit, el arbol de trabajo esta limpio\n"
+msgstr "nada para hacer commit, el arbol de trabajo esta limpio\n"
 
 #: wt-status.c:1780
 msgid "No commits yet on "
@@ -15518,17 +15518,17 @@ msgid ""
 "\n"
 "  git rebase --continue\n"
 msgstr ""
-"TIene cambios en el area de stage de su arbol de trabajo.\n"
+"Tiene cambios en el area de stage de su arbol de trabajo.\n"
 "Si estos cambios estan destinados a \n"
 "ser aplastados en el commit previo, ejecute:\n"
 "\n"
 "  git commit --amend $gpg_sign_opt_quoted\n"
 "\n"
-"Si estos estan destinados a ir en un nuevo comit, ejecute:\n"
+"Si estos estan destinados a ir en un nuevo commit, ejecute:\n"
 "\n"
 "  git commit $gpg_sign_opt_quoted\n"
 "\n"
-"En ambos casos, cuando termite, continue con:\n"
+"En ambos casos, cuando termine, continue con:\n"
 "\n"
 "  git rebase --continue\n"
 
-- 
2.15.0

