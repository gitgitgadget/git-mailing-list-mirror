Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D176520357
	for <e@80x24.org>; Mon, 17 Jul 2017 15:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdGQPiu (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 11:38:50 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33941 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdGQPit (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 11:38:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id o88so1872942pfk.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XXwt/0SK8+hn7Wfc6C9muBtT9qBBOEDNuH7zqaPn258=;
        b=m0IpEaDq8iHAVUiPo2WOkPD3qvM8UfTCeUH8fjKfx6T/jq+J/9UjtyZWSHXYQchhDW
         2IAoI0ZUJ7PzOy7Qz9Ph+DujLAqqD6TbKsKk2dKF25oZqYtxV2BKSE2O2bg2lzf97nZR
         ursnYfmg6gkJLj6J62qhLe+u2kdy2QjZsOVDfKs6Wa5jcZmM94WuGERi8AvWb/b//JxT
         m8e4uHKOzfONkyLG3+fY8cJTutB2DXgy0Pinf8aZDFR03VW5hHMaYx5Ad1oq2ApnXAAA
         rst0/9sEotNeg8cWbLrZfdm/b8DLTPctc+899kNmRV63QfamS+cy8VUhsfIfHNLPlC5E
         DL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XXwt/0SK8+hn7Wfc6C9muBtT9qBBOEDNuH7zqaPn258=;
        b=YUzcPdv2VjBrtyHJil/Dmg1NXPmNhf2Bm9EVvuzP5DMNE8iZ1VeTLufpsaXCdJhSqU
         j0VAyKEGnMZivBLcsNHbgT7+uxPuUBB2mUhflpePqLXLGIjWmdGlq5WxFhJClFXLO0T4
         6EyKslV0zik7hFOqGLEk9S4G5kw0yqh9XH02LXZO7Qjzg2N6A8uzUQ8quHsEtcRTrrdL
         ItE+c0p//atro6mKv/Kw01+7Ijagy8Kd04eW7Ye7IEVLeegWM6JFoqCtX0rS1ZTLS8nU
         GNhBuTLe3V2F2Dqz2z/KNPOdHODM8NULgfDzk9txksapG2JLgo4l/fz4Rb/T6ck6NPab
         eQ0A==
X-Gm-Message-State: AIVw1134bDDeFeQPB62tPGGJrZsoBIVo/HyTzGADKydV68gxQ0WyBLVg
        cMkfd5wh49O6VQ==
X-Received: by 10.99.157.205 with SMTP id i196mr5845342pgd.85.1500305929496;
        Mon, 17 Jul 2017 08:38:49 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7003:dd63:70be:8c6f:6f19:1db1])
        by smtp.gmail.com with ESMTPSA id 71sm33121325pge.45.2017.07.17.08.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 08:38:49 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] doc: camelCase the i18n config variables to improve readability
Date:   Mon, 17 Jul 2017 21:09:00 +0530
Message-Id: <20170717153900.16666-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.3.973.gaaf39e6bd.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The i18n config variable used weren't readable as they were in
the crude form of how git stores/uses it's config variables.

Improve it's readability by replacing them with camelCased versions
of config variables as it doesn't have any impact on it's usage.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Documentation/i18n.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index 2dd79db5c..7e36e5b55 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -42,11 +42,11 @@ mind.
 +
 ------------
 [i18n]
-	commitencoding = ISO-8859-1
+	commitEncoding = ISO-8859-1
 ------------
 +
 Commit objects created with the above setting record the value
-of `i18n.commitencoding` in its `encoding` header.  This is to
+of `i18n.commitEncoding` in its `encoding` header.  This is to
 help other people who look at them later.  Lack of this header
 implies that the commit log message is encoded in UTF-8.
 
@@ -54,15 +54,15 @@ implies that the commit log message is encoded in UTF-8.
   `encoding` header of a commit object, and try to re-code the
   log message into UTF-8 unless otherwise specified.  You can
   specify the desired output encoding with
-  `i18n.logoutputencoding` in `.git/config` file, like this:
+  `i18n.logOutputEncoding` in `.git/config` file, like this:
 +
 ------------
 [i18n]
-	logoutputencoding = ISO-8859-1
+	logOutputEncoding = ISO-8859-1
 ------------
 +
 If you do not have this configuration variable, the value of
-`i18n.commitencoding` is used instead.
+`i18n.commitEncoding` is used instead.
 
 Note that we deliberately chose not to re-code the commit log
 message when a commit is made to force UTF-8 at the commit
-- 
2.13.3.973.gaaf39e6bd.dirty

