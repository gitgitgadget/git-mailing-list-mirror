Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F338F20357
	for <e@80x24.org>; Mon, 10 Jul 2017 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbdGJQXN (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 12:23:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34338 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754548AbdGJQXM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 12:23:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id k67so25933527wrc.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-transfer-encoding;
        bh=qoIGU6hEWjloxAkUAhYIzHNqPtGVc5AhKaylCzJHHbw=;
        b=pTX3qlnoQgincq7IzSB6ZApKgznBDKx2qfVvpHKz98oR3sakkdYQQ40D+LEptfSF/9
         zThhepj6Ohyh+c9IZePCW5DnCOkZnUy7fvYwNpG8cltiF+43eWmKUJWHIemySmEBeNab
         J0H4zAsaag3e3kYeDZv8a/xsb+bVpj/vZQoJhXkHOZQX3gCMbhPkRVW4FbPS5fTyuNoQ
         EvXQgFrG7YMhVrodmDWLywuSXr4mwA1LhsxqI7hEKdpzDpmx/YVS1DWgNllRJkIVSdPx
         oxtwrwLjFXqhjxpZcnzXrn6745fHGZQVxEqiEUfTXyvo6HJIqdxfi590UuQVS4g5rG56
         vriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:references:content-transfer-encoding;
        bh=qoIGU6hEWjloxAkUAhYIzHNqPtGVc5AhKaylCzJHHbw=;
        b=A+yWPYuvOZNKTWmN3tFTPLyTWypvf4Wxf2vjy1NhjquoJLAv9OU+akc0Lio9oDTat6
         UjNS8z4p9UhJzLCc+QzhugKBT8rDyszabLC3wwgMndOfj/rutZkRfA2lz04OXZ3PoSDg
         yB/3KbB9t/rhaLY72IynmoGs6olCmrIdzk68itlZA/gw/rT6TDwGWrT2iDQ/9wbh4T0R
         0ZKyCpMQCRTmqjDx/B8MNOtyopCD6MicJuOJRZO4tmtFo/ARZiABZba3pJ+yvS3Ho0ct
         RkvgWXVAe6SrwIXaOWsBX0cp03eEsv6cTeD8IVoly9fOBw6tJrupS9PgbzsG/SfkyvNx
         T7Uw==
X-Gm-Message-State: AIVw111hApCcTWWB2sZcykdWDotwzIX5qIJ8xtlNqj9uhXLfVLQcBKje
        GQH5EaZ6QEGN3A==
X-Received: by 10.223.133.99 with SMTP id 90mr7786555wrh.44.1499703791508;
        Mon, 10 Jul 2017 09:23:11 -0700 (PDT)
Received: from localhost (cable-62-117-17-78.cust.telecolumbus.net. [62.117.17.78])
        by smtp.gmail.com with ESMTPSA id i136sm8158488wmf.33.2017.07.10.09.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 09:23:09 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     andre.hinrichs@gmx.de
Cc:     git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix typo
Date:   Mon, 10 Jul 2017 18:23:08 +0200
Message-Id: <20170710162308.22108-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.13.2.648.g700819c
MIME-Version: 1.0
In-Reply-To: <f11120c3-30fb-bdfe-a597-8ceb41097209@gmx.de>
References: <f11120c3-30fb-bdfe-a597-8ceb41097209@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported-by: Andre Hinrichs <andre.hinrichs@gmx.de>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Hi Andre,

thanks for the bugreport!

Ralf

 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 679f8f4..42c4508 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8564,7 +8564,7 @@ msgstr "\"auto-gc\" Modus aktivieren"
 #: builtin/gc.c:362
 msgid "force running gc even if there may be another gc running"
 msgstr ""
-"Ausführung von \"git gc\" erwzingen, selbst wenn ein anderes\n"
+"Ausführung von \"git gc\" erzwingen, selbst wenn ein anderes\n"
 "\"git gc\" bereits ausgeführt wird"
 
 #: builtin/gc.c:379
-- 
2.7.4

