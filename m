Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85351F859
	for <e@80x24.org>; Mon, 22 Aug 2016 12:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbcHVMJe (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 08:09:34 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34399 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753967AbcHVMJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 08:09:32 -0400
Received: by mail-pa0-f68.google.com with SMTP id hh10so8023005pac.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aL37kLrjlA1c5vqR3OD6OwQgVRUqbgzzPXyRwRwbq6A=;
        b=yOjXCg4zSPJ3Ew43YI8KGsbhr3izFDl7qYqcIHQLm0Gnq30c/o/lm/xa1tzUC+OisR
         5DTAi7mz5495ycSatywd6K46/lX1a5fmFtoWWyR8eEepxxz3P4+R/NCuLe1tFESYCJAW
         apmwA69snOMlsQtox28UMFqsKfoQJEydgVk2s9HoCLFwxRHjwvXzJNf47L549RIGk+PM
         Ph3OHJ5tcltNQCNvHxEsa8QUvv/v7KmwBKgGt3aYK2McD5k7A6qiEClPNvweLfzwY67n
         BiEWH5YgPhPwWpxexkuJxBwLgqWbh+zwQRrongXyeeafcnnsaqs/6Cq7jSOBAU+4dfui
         spWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aL37kLrjlA1c5vqR3OD6OwQgVRUqbgzzPXyRwRwbq6A=;
        b=ZzIZS4NPhB04rJnztkRq8EQAfyMJJ76PXSxLfDEeighLiLSXf+k9Ve/f4y4/Kxt6bk
         VlelLwb5xerY4qoT/THMEarkT8PrMAEsg3MtRZ12i4WdrOEGq6o/U4mIxoVSPRHcEfil
         clvLFHBgmjgQ+z4bC/PZMyoiADZV7xvBQaTaL0+e2M0iZzQSBBw2NJWyjnFo3+kQ3cEm
         6H2pm5BUinpm2o5mNYbDkHXIYBk5B/ISCHs+qciZQjJX4yb6yxORLiYFNPM3vv5vcQyr
         27cmOKbem/K2CFLjaz2Y67O+ffexokT8jp3qRi0JAPFu+Z7lvjKwt16rA4lnhK7sUWtT
         2kEQ==
X-Gm-Message-State: AEkoousJAy6M5ORxRuPJVO0Po1ESXdE5shvWxl6XM8zJRSf5YcVsbudJ5P409Dws6ksgQQ==
X-Received: by 10.66.136.74 with SMTP id py10mr42347922pab.114.1471867746601;
        Mon, 22 Aug 2016 05:09:06 -0700 (PDT)
Received: from ash ([115.72.190.143])
        by smtp.gmail.com with ESMTPSA id y9sm31966970pay.25.2016.08.22.05.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 05:09:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 22 Aug 2016 19:09:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     worldhello.net@gmail.com, vnwildman@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] po/vi.po: add a missing space
Date:   Mon, 22 Aug 2016 19:08:54 +0700
Message-Id: <20160822120854.16178-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This space is important because the %s could be ":/abc", which makes
the final output "tham chiếu không phải là một cây::/abc".
"cây::/abc" looks like a new fancy form of extended SHA-1 syntax. But
it's not.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 po/vi.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/vi.po b/po/vi.po
index f048244..e24e214 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -4626,7 +4626,7 @@ msgstr "tham chiếu không hợp lệ: %s"
 #: builtin/checkout.c:1037
 #, c-format
 msgid "reference is not a tree: %s"
-msgstr "tham chiếu không phải là một cây:%s"
+msgstr "tham chiếu không phải là một cây: %s"
 
 #: builtin/checkout.c:1076
 msgid "paths cannot be used with switching branches"
-- 
2.8.2.524.g6ff3d78

