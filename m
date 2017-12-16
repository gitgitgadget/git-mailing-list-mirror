Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474041F406
	for <e@80x24.org>; Sat, 16 Dec 2017 19:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756895AbdLPTgt (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 14:36:49 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40600 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756815AbdLPTgs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 14:36:48 -0500
Received: by mail-wm0-f65.google.com with SMTP id f206so22956094wmf.5
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vLMcY4X61wdhooYgXScii0uMxheZXA8gapTgQ3eVcTI=;
        b=PZIi3ioU9FHJNkqKS28uAqi95/D3P+1qCvgzVADc/1tYh5Crc6deCiZE4/qOTWgyGy
         1pdBlqmNNNcMw3dYoL085x7goL0ZTp1u0azkMdHfAkA91PKJIs7MtqG97WAd32PXAgWK
         sBiZ9hmXj757FReWhA0pOmbrN+o2uTsVfOcrN7GaEDK7opKrflyftPeQJN5JI7D+bnQo
         3vWwPHjw0el4ljCk+sYEYb3YQ/oskiscYzL1aWCCYeJ1sqAd+BH/JD86rWzQD4CuGLLo
         ZxowC/2cI0RXeXkakQE8kVtuXKwfQdu2BTtsS1cL9OIhcs+gQnZmPEPpavCOB7JiSOCM
         3z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vLMcY4X61wdhooYgXScii0uMxheZXA8gapTgQ3eVcTI=;
        b=dLcob1F1/YcUO/Zs/X6UMcMpL4eiB4MzY7e01qQzyB+LH5gnvNAOM+Ud9JSV/2Cv5L
         cWkvovy9xYnRcDQpenlDz9x1JY8Pk8hCZz/LKEMo69LDAoFACN448DxHJBTUg3rpkw8w
         9Do2Hg4K7YnFBCLf+ZnEJAcC3sf9iLHijZaXws9T2IJUer5aFFV5326grIi3xYudnPAy
         b//mneoVB4cXFnfCXR/qA5K5/iMUE6o+soPGRJatLqEffvZLKAdo3hSn2TkJwr/KVL00
         kuy9E51LJx9nmao03ZvBTz+SDslFRGmnMscuqIJI1blo4t+Wl5y5xE3TAQVA2AH3dfu3
         Ix4w==
X-Gm-Message-State: AKGB3mJWrfgbXx+cs2+i0fcbCRwjWQMjTeokrteg9zW0uVrvFk20jF8w
        1rxzAa9W+NXA1l534GKYJCK9wVfk
X-Google-Smtp-Source: ACJfBotPsAv8F0iSeqkgy3O60Lz8w9bo//bdOk0EgMqjD7R1P0ITdq/1D1DCiOT+gPjdlB6dtjusEQ==
X-Received: by 10.80.129.135 with SMTP id 7mr22952984ede.101.1513453006798;
        Sat, 16 Dec 2017 11:36:46 -0800 (PST)
Received: from localhost (cable-94-139-8-15.cust.telecolumbus.net. [94.139.8.15])
        by smtp.gmail.com with ESMTPSA id v20sm9032479edm.10.2017.12.16.11.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Dec 2017 11:36:45 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: improve messages when a branch starts to track another ref
Date:   Sat, 16 Dec 2017 20:36:41 +0100
Message-Id: <20171216193641.11323-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.15.1.504.g5279b8010
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/po/de.po b/po/de.po
index 400262625..00ffd8c41 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1070,42 +1070,42 @@ msgstr "Branch %s kann nicht sein eigener Upstream-Branch sein."
 #: branch.c:93
 #, c-format
 msgid "Branch '%s' set up to track remote branch '%s' from '%s' by rebasing."
-msgstr "Branch '%s' konfiguriert zum Folgen von Remote-Branch '%s' von '%s' durch Rebase."
+msgstr "Branch '%s' folgt nun Remote-Branch '%s' von '%s' durch Rebase."
 
 #: branch.c:94
 #, c-format
 msgid "Branch '%s' set up to track remote branch '%s' from '%s'."
-msgstr "Branch '%s' konfiguriert zum Folgen von Remote-Branch '%s' von '%s'."
+msgstr "Branch '%s' folgt nun Remote-Branch '%s' von '%s'."
 
 #: branch.c:98
 #, c-format
 msgid "Branch '%s' set up to track local branch '%s' by rebasing."
-msgstr "Branch '%s' konfiguriert zum Folgen von lokalem Branch '%s' durch Rebase."
+msgstr "Branch '%s' folgt nun lokalem Branch '%s' durch Rebase."
 
 #: branch.c:99
 #, c-format
 msgid "Branch '%s' set up to track local branch '%s'."
-msgstr "Branch '%s' konfiguriert zum Folgen von lokalem Branch '%s'."
+msgstr "Branch '%s' folgt nun lokalem Branch '%s'."
 
 #: branch.c:104
 #, c-format
 msgid "Branch '%s' set up to track remote ref '%s' by rebasing."
-msgstr "Branch '%s' konfiguriert zum Folgen von Remote-Referenz '%s' durch Rebase."
+msgstr "Branch '%s' folgt nun Remote-Referenz '%s' durch Rebase."
 
 #: branch.c:105
 #, c-format
 msgid "Branch '%s' set up to track remote ref '%s'."
-msgstr "Branch '%s' konfiguriert zum Folgen von Remote-Referenz '%s'."
+msgstr "Branch '%s' folgt nun Remote-Referenz '%s'."
 
 #: branch.c:109
 #, c-format
 msgid "Branch '%s' set up to track local ref '%s' by rebasing."
-msgstr "Branch '%s' konfiguriert zum Folgen von lokaler Referenz '%s' durch Rebase."
+msgstr "Branch '%s' folgt nun lokaler Referenz '%s' durch Rebase."
 
 #: branch.c:110
 #, c-format
 msgid "Branch '%s' set up to track local ref '%s'."
-msgstr "Branch '%s' konfiguriert zum Folgen von lokaler Referenz '%s'."
+msgstr "Branch '%s' folgt nun lokaler Referenz '%s'."
 
 #: branch.c:119
 msgid "Unable to write upstream branch configuration"
-- 
2.15.1.504.g5279b8010

