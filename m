Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F72920A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 18:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLGSwL (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 13:52:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45031 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeLGSwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 13:52:11 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so4494349edd.11
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 10:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ag8LeCijjdlSBz2sA/CnGTiA27iygPGNfLnHAHnd1LE=;
        b=UtUO6yCMr5gZppT6GBLR/Iy4Rjffe4bDW5L5YBVdM/bJyZQlXfiyB93gvJVFrIMFgV
         T+t9tgAmrG2/rD0/C3XvNHtf7/9oZgzi2TnYpTqhNe5/ncyjm4ZBze9QVrfWd806dZj1
         k3bmzgWzqYUwcV7hCXqtfdcKINtTw2qdz7hrLkobdkkNGo3lIFLct2KLXdA3tqHiijDp
         qcHoNEPV8Rp7jncFA96ELQBWKDxzpqNQ2tVer2vdjQEGBHRK6TmazDbgOSskuh+jfyfk
         OP7x2FYx8qG8p4jzUR5KzVqSxjl7ab2WtGY89WP89U9UWx9v6CDhj5BHHL3ooQDffUpP
         00gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ag8LeCijjdlSBz2sA/CnGTiA27iygPGNfLnHAHnd1LE=;
        b=k7m/7Q+O9gkKtcpW3oxISjlC9I/mHZs9hAVRPYUlFS/4El5nMMnD9u7QKVIHYmIYS6
         FMFBR2u56woHX9puhVkBgaEHFa65odfS+LLgElgTnD+Ly8QUyA/2EtxkvZFVn7WsYgpC
         5I+Ue+NCP6RWT0Rckiw8+EUWGKvMBeAnQzym3TJMozaszHp4mKlAxgL5pD0rCufW0kNo
         JvbMtXUG7F+KBGKgKe3ZHD9R8sbMaHcnZCFuaTEJZv1+7pjtxOJU5a/xqM3PnghX9t62
         bFWsPsv+QmoPzMiCT1gxjA6uSlXGHJJu7vdRm6hef5LIUZ3JmYRuEMDRDVwB++Mr8HyF
         GCfA==
X-Gm-Message-State: AA+aEWbAjvrmlKE2oCw7pLFV0eXJByU5DPHqKQoPcVxdyKRPss/Fy2Q5
        jjyBdjP5D/bbljt3B28AY2BsxTbF
X-Google-Smtp-Source: AFSGD/WTPp5Me1mGD0iS0ICeZQCVlBd94InNvj1ZwwltUAddeZOzrVpp5AHiA7xBCegBwIKFmKZ36A==
X-Received: by 2002:a05:6402:295:: with SMTP id l21mr3186681edv.149.1544208729616;
        Fri, 07 Dec 2018 10:52:09 -0800 (PST)
Received: from localhost (cable-82-119-12-149.cust.telecolumbus.net. [82.119.12.149])
        by smtp.gmail.com with ESMTPSA id w56sm1242152edb.72.2018.12.07.10.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 10:52:09 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org, Phillip Szelat <phillip.szelat@gmail.com>
Cc:     =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix two messages
Date:   Fri,  7 Dec 2018 19:52:05 +0100
Message-Id: <20181207185205.11681-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.411.g8f28e744c2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported-by: Phillip Szelat <phillip.szelat@gmail.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Hi Phillip,

Good catches. Thanks for the review!

Ralf

 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index eb213d742..d5113434a 100644
--- a/po/de.po
+++ b/po/de.po
@@ -3421,7 +3421,7 @@ msgstr "Fehler bei Vorbereitung der Packdatei aus multi-pack-index."
 #: midx.c:407
 #, c-format
 msgid "failed to add packfile '%s'"
-msgstr "Fehler beim Hinzufügen von Packdatei'%s'."
+msgstr "Fehler beim Hinzufügen von Packdatei '%s'."
 
 #: midx.c:413
 #, c-format
@@ -4559,7 +4559,7 @@ msgstr "Öffnen von /dev/null fehlgeschlagen"
 #: run-command.c:1229
 #, c-format
 msgid "cannot create async thread: %s"
-msgstr "Kann Thread für async nicht erzeugen: %s"
+msgstr "Konnte Thread für async nicht erzeugen: %s"
 
 #: run-command.c:1293
 #, c-format
-- 
2.20.0.rc2.411.g8f28e744c2

