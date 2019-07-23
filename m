Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329C61F461
	for <e@80x24.org>; Tue, 23 Jul 2019 14:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390697AbfGWOp1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 10:45:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33308 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388229AbfGWOp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 10:45:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id r6so37959711qtt.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2019 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiV2JOJyIdtwTAFL1hURmqnL1IGWG/XSZSaWI895qi4=;
        b=NveMEYRuDlqdTwWISuYgp//G5x//+6GpHYNd2F4cmTx+9tvYiLqQVd7wyeWpFi6DKk
         NJ0n9LAKHh1I0m/mTq+pe8mM+f721QCcS13QxatyksDsrzhKubf1cHjLRLOLtw5l958b
         Ub13qs3em79rwJiHAQxUONVNHVaK3a7nlfIphPPSzDjgfzYX8KSnEq4ILH+uWnucKT28
         E85nbjOtv/Sn51MvLddWp8BNkBv9I3Ir8/EsTTgqW0gRmq3ACskh0Sx3iFriN4zWLVZJ
         qrt9E3DiW8AAjMZxt+aCTcoybgVqdOS58nhYTovEk3sT1dP2aGzGVDDuostpQzZ4NG2X
         DIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiV2JOJyIdtwTAFL1hURmqnL1IGWG/XSZSaWI895qi4=;
        b=t1GW+K/ZV8Ro5pFgVvb2Kq4BSLKJHrEhkyOaGLRY5C9MXFCCD3rkddLhkuXoqnq0OI
         UHoeKhuD1rl1iicIU9Dz8MqeABt69Z6/X2LLoSdu/qXUipszhifmuyIfqQcoB5YqH0Vn
         /TpK2nIwa7oTXnFFTX0Wn4wYINK+Jcdk4mjA/9GSGrnr8CZMXD4LBNicWLCNiOR7g5SN
         k8Y+BAaAEUS48x59BC8ay/j3vft9RIC4SyIdxmhQYYnoPUS9SJ/1fzcHP7YO6um5RPbs
         HdLkH33gbzf+JqFWtqXgGMIxx4fiF3i9r6zTirGip1hWNHsmMwfNwC0vFLj+0jw4Oi15
         vbXw==
X-Gm-Message-State: APjAAAW3mXmoDNXD1Pxm4dnGxotAzIL3R9FDpK6Q/DOaI4IFyblm/OB8
        Uwb558yjTOR6g0NzWtvrCOw=
X-Google-Smtp-Source: APXvYqzOKjVgW8Xh3nBSZoELQTA67yigyChdvMcPTFfwbwvjmVPv4IISOvB+mOwxKHJbxOuNZIRb6A==
X-Received: by 2002:ac8:4252:: with SMTP id r18mr53569100qtm.357.1563893125745;
        Tue, 23 Jul 2019 07:45:25 -0700 (PDT)
Received: from localhost.localdomain ([186.158.9.226])
        by smtp.gmail.com with ESMTPSA id z1sm22631875qkg.103.2019.07.23.07.45.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 07:45:25 -0700 (PDT)
From:   "Claudio J. Paz" <claudiojpaz@gmail.com>
To:     christopher.diaz.riv@gmail.com, worldhello.net@gmail.com,
        git@vger.kernel.org
Cc:     "Claudio J. Paz" <claudiojpaz@gmail.com>
Subject: [PATCH] l10n: es:  Amend accent marks
Date:   Tue, 23 Jul 2019 11:44:52 -0300
Message-Id: <20190723144452.23437-1-claudiojpaz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Claudio J. Paz <claudiojpaz@gmail.com>
---
 po/es.po | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/po/es.po b/po/es.po
index edf7b25b8..bda3bbd41 100644
--- a/po/es.po
+++ b/po/es.po
@@ -3215,7 +3215,7 @@ msgstr "se esperaba '%s', se recibió '%s'"
 #: fetch-pack.c:1234
 #, c-format
 msgid "unexpected acknowledgment line: '%s'"
-msgstr "linea de confirmación inesperada: '%s'"
+msgstr "línea de confirmación inesperada: '%s'"
 
 #: fetch-pack.c:1239
 #, c-format
@@ -7936,11 +7936,11 @@ msgstr[1] "Tu stash actualmente tiene %d entradas"
 
 #: wt-status.c:928
 msgid "Submodules changed but not updated:"
-msgstr "Submodulos cambiados pero no actualizados:"
+msgstr "Submódulos cambiados pero no actualizados:"
 
 #: wt-status.c:930
 msgid "Submodule changes to be committed:"
-msgstr "Submodulos cambiados listos para realizar commit:"
+msgstr "Submódulos cambiados listos para realizar commit:"
 
 #: wt-status.c:1012
 msgid ""
@@ -9270,11 +9270,11 @@ msgstr "Ignorar diferencias de espacios en blanco"
 
 #: builtin/blame.c:810
 msgid "color redundant metadata from previous line differently"
-msgstr "colorear metadata redundante de lineas previas de manera diferente"
+msgstr "colorear metadata redundante de líneas previas de manera diferente"
 
 #: builtin/blame.c:811
 msgid "color lines by age"
-msgstr "colorear lineas por edad"
+msgstr "colorear líneas por edad"
 
 #: builtin/blame.c:818
 msgid "Use an experimental heuristic to improve diffs"
@@ -19352,7 +19352,7 @@ msgstr "Submódulo '%s' (%s) no registrado para ruta '%s'\n"
 #: builtin/submodule--helper.c:1186
 msgid "Remove submodule working trees even if they contain local changes"
 msgstr ""
-"Remover arboles de trabajo de submódulos incluso si contienen cambios locales"
+"Remover árboles de trabajo de submódulos incluso si contienen cambios locales"
 
 #: builtin/submodule--helper.c:1187
 msgid "Unregister all submodules"
@@ -19425,13 +19425,13 @@ msgstr "no se pudo obtener el directorio de submódulo para '%s'"
 #: builtin/submodule--helper.c:1473
 #, c-format
 msgid "Invalid update mode '%s' for submodule path '%s'"
-msgstr "Modo de actualización inválido '%s' para ruta de submodulo '%s'"
+msgstr "Modo de actualización inválido '%s' para ruta de submódulo '%s'"
 
 #: builtin/submodule--helper.c:1477
 #, c-format
 msgid "Invalid update mode '%s' configured for submodule path '%s'"
 msgstr ""
-"Modo de actualización inválido '%s' configurado para ruta de submodulo '%s'"
+"Modo de actualización inválido '%s' configurado para ruta de submódulo '%s'"
 
 #: builtin/submodule--helper.c:1570
 #, c-format
@@ -19940,7 +19940,7 @@ msgstr ""
 
 #: builtin/update-index.c:1021
 msgid "with --stdin: input lines are terminated by null bytes"
-msgstr "con --stdin: las lineas de entrada son terminadas con bytes nulos"
+msgstr "con --stdin: las líneas de entrada son terminadas con bytes nulos"
 
 #: builtin/update-index.c:1023
 msgid "read list of paths to be updated from standard input"
-- 
2.20.1

