Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4414B207B3
	for <e@80x24.org>; Fri,  5 May 2017 16:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750801AbdEEQRK (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 12:17:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35914 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdEEQRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 12:17:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id u65so2270261wmu.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KT755pj0uksb/wpCfOmOADo1Y7ILUzIsjifCgpTLYl8=;
        b=BBL29K2euuEcu/sRHs4QPZHUNdLYa8pv/dXHmfhV9bL1RH/8xJ6oV/sS/O1i1qk7+2
         54HL36jiW0uc7Lyx6b3f9VAyVLsElIOI1Ngz85Lj5L0IPpDvEze8U7DqlLn8UOFarjjP
         DFuy+GbJt8XSu5bD5qu2tpzii62u2Z62h22hU7qJCvzkVATIhwL2bnWzfoSusWwqltEn
         ezvZiLfx8Idj3JCkwKgCiAi3jfRgHKPvqJHGrHLAKFtPSkWux5dYO/Pnf1kVoUx0pKoH
         Qcrt3Avoykj6R6WQf6KzbcHYbjqHphnYRGlcV7LvBdx0Pi7+18mi0rvGAyU7rlRkI/XR
         F5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KT755pj0uksb/wpCfOmOADo1Y7ILUzIsjifCgpTLYl8=;
        b=RW8bENielpjVaMw7khnwcQnAHoSXYxMgYFYSoyKfg69yRW6Gdc9ptSzLzFHZ+IlVNq
         NQQ42FjKkM1LbgktXAO2Uq3BcwDfWThQIKqJJQd4nG/Plvrr58Nm1xme5BIrW4H7UJLi
         s5QikBedncKfrV3fFNHO5kuMPnt/12DKyTswEabL/f6jvKZW3loc2fXnT9ELJHNCbDSx
         ki0PtLq0uEfOmxyCdhKUGvIDKsmHPZhUhxDD4aL0YnwMNsGKyvpe5e2diu1036tphIt2
         mnm42tuoKdc4bjA3XLcr1cFvsdMfjEc/kzycF9BOK9PlXaykzEq/DB/yvNPLvrkKm1Yh
         oBKw==
X-Gm-Message-State: AN3rC/4jS9QosVWGmPGcbPTHNNbszMGGCTSixpNpVbOKnz0WAyLUtKoP
        pJFIwzcnba101Oa426g=
X-Received: by 10.80.214.215 with SMTP id l23mr8513097edj.147.1494001027603;
        Fri, 05 May 2017 09:17:07 -0700 (PDT)
Received: from localhost (cable-62-117-25-91.cust.telecolumbus.net. [62.117.25.91])
        by smtp.gmail.com with ESMTPSA id i2sm250193eda.18.2017.05.05.09.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 May 2017 09:17:06 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 4 new messages
Date:   Fri,  5 May 2017 18:17:04 +0200
Message-Id: <20170505161704.4666-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.13.0.rc0.207.gb44265493
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 4 new messages came from git.pot update in 28e1aaa48 (l10n:
git.pot: v2.13.0 round 2 (4 new, 7 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/po/de.po b/po/de.po
index 12c3d36a0..679f8f472 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2493,7 +2493,7 @@ msgstr ""
 "Verwende Version %i"
 
 #: read-cache.c:2375 sequencer.c:1350 sequencer.c:2048
-#, fuzzy, c-format
+#, c-format
 msgid "could not stat '%s'"
 msgstr "Konnte '%s' nicht lesen."
 
@@ -2514,7 +2514,7 @@ msgstr "Konnte '%s' nicht zum Schreiben öffnen."
 
 #: refs.c:1667
 msgid "ref updates forbidden inside quarantine environment"
-msgstr ""
+msgstr "Aktualisierungen von Referenzen ist innerhalb der Quarantäne-Umgebung verboten."
 
 #: refs/files-backend.c:1631
 #, c-format
@@ -14135,9 +14135,8 @@ msgid "populate the new working tree"
 msgstr "das neue Arbeitsverzeichnis auschecken"
 
 #: builtin/worktree.c:335
-#, fuzzy
 msgid "keep the new working tree locked"
-msgstr "das neue Arbeitsverzeichnis auschecken"
+msgstr "das neue Arbeitsverzeichnis gesperrt lassen"
 
 #: builtin/worktree.c:343
 msgid "-b, -B, and --detach are mutually exclusive"
@@ -14243,7 +14242,7 @@ msgstr ""
 #: http.c:336
 #, c-format
 msgid "negative value for http.postbuffer; defaulting to %d"
-msgstr ""
+msgstr "negativer Wert für http.postbuffer; benutze Standardwert %d"
 
 #: http.c:357
 msgid "Delegation control is not supported with cURL < 7.22.0"
-- 
2.13.0.rc0.207.gb44265493

