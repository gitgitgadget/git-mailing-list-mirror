Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1E6C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 04:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCDA64DC3
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 04:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhBPEIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 23:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhBPEIo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 23:08:44 -0500
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Feb 2021 20:07:58 PST
Received: from mail.yrabbit.cyou (mail.yrabbit.cyou [IPv6:2001:19f0:7002:92f:5400:3ff:fe1f:be14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E774C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 20:07:58 -0800 (PST)
Received: from mail.yrabbit.cyou (localhost [127.0.0.1])
        by mail.yrabbit.cyou (OpenSMTPD) with ESMTP id 8b589f29;
        Tue, 16 Feb 2021 13:01:17 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=yrabbit.cyou; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=20210101; bh=8vqMTFnRPrdD6dISXg9S/
        Bl6D+0=; b=fuQaW0xNG3U2/PnMuB32YflGyy6cK+mg5uayeJLYGNBFhzMojXOFl
        tNOu+FaIzxiuqYqWzSU4pVtLRuCQZ3FUZKNvLEokXXZCE8oqqaLG4er9cnHd+kPD
        f1V/Qr03OIm+sLqOna/u1ZCYAU9OzdTIIXxniV7+FI8xRhdOh1Ev/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=yrabbit.cyou; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=20210101; b=l5UNEi15msi3uWv
        D5EKwf/XAovu3hJuyKFDKAeXR33a31aSCLaPp/6Mr4wvSaXZhJFAts630V1fli4T
        AM50LSz/3J6pDqgucJ+rnZoyAucQ54tzYZmmDUp7iO4rCDmvKCz5oRFM/nUBeAWq
        Dsu0AjSbaa5sfQjsaEvvKBk31lFI=
Received: by mail.yrabbit.cyou (OpenSMTPD) with ESMTPSA id 83f62d53 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 16 Feb 2021 13:01:16 +0900 (JST)
Received: from localhost (fly.home.net [local])
        by fly.home.net (OpenSMTPD) with ESMTPA id 4b9193da;
        Tue, 16 Feb 2021 14:01:10 +1000 (+10)
From:   Roman Sizykh <rabbit@yrabbit.cyou>
To:     git@vger.kernel.org
Cc:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Roman Sizykh <rabbit@yrabbit.cyou>
Subject: [PATCH] Translation: correct a typo.
Date:   Tue, 16 Feb 2021 14:01:07 +1000
Message-Id: <20210216040107.24129-1-rabbit@yrabbit.cyou>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a minor typo in the Russian translation.

Signed-off-by: Roman Sizykh <rabbit@yrabbit.cyou>
---
 po/ru.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/ru.po b/po/ru.po
index a77b462e62..3e47bdc2fb 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -21527,7 +21527,7 @@ msgstr "Не удалось открыть %s.final: %s"
 
 #: git-send-email.perl:796
 msgid "Summary email is empty, skipping it\n"
-msgstr "Письмо со сводкой изменений пустое, попускаю его\n"
+msgstr "Письмо со сводкой изменений пустое, пропускаю его\n"
 
 #. TRANSLATORS: please keep [y/N] as is.
 #: git-send-email.perl:831
-- 
2.28.0

