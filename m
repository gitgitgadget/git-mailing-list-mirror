Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E66BC4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 15:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28DC604DC
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 15:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbhHOPw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 11:52:57 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:33978 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229603AbhHOPw4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Aug 2021 11:52:56 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Aug 2021 11:52:56 EDT
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 54AF14BE6E3A
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:44:33 +0300 (MSK)
Received: from vla1-d53b4f396d89.qloud-c.yandex.net (vla1-d53b4f396d89.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:b8c:0:640:d53b:4f39])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id 4F6F33A20002
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:44:33 +0300 (MSK)
Received: from vla5-8422ddc3185d.qloud-c.yandex.net (vla5-8422ddc3185d.qloud-c.yandex.net [2a02:6b8:c18:3495:0:640:8422:ddc3])
        by vla1-d53b4f396d89.qloud-c.yandex.net (mxback/Yandex) with ESMTP id yzx1vLxQag-iXH87lMT;
        Sun, 15 Aug 2021 18:44:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brighterdan.com; s=mail;
        t=1629042273; bh=gOmz/GaZ7e6IkY33p7Iwql12MtMUUnCAi4EEXPOxGig=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=jo+GI6iRzgPpic40AeQHNA8E+B1zy7GlAHNYecEY6Ux1R+Jh7WJGyL8aSwdh1EFKb
         CjMqcb/FXXKN2UnAfrEbWlFbI7gqywpjX7HL03RROq/StHCzDUtEYKe7T/g8HLWlr1
         EhWEkCFJ+xQG/ASOOnCFxMq2i78QCD6oK+vde44s=
Authentication-Results: vla1-d53b4f396d89.qloud-c.yandex.net; dkim=pass header.i=@brighterdan.com
Received: by vla5-8422ddc3185d.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id AYZBMooUWa-iWOCseVt;
        Sun, 15 Aug 2021 18:44:32 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Daniel Santos <hello@brighterdan.com>
To:     git@vger.kernel.org
Cc:     Daniel Santos <hello@brighterdan.com>
Subject: [PATCH] l10n: pt_PT: new .mailmap file entry
Date:   Sun, 15 Aug 2021 16:44:27 +0100
Message-Id: <20210815154427.3172-1-hello@brighterdan.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 * correction of my email

Signed-off-by: Daniel Santos <hello@brighterdan.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 9c6a446bdf..66dc4422cb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -50,6 +50,7 @@ Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
 Dana L. How <danahow@gmail.com> Dana How
 Daniel Barkalow <barkalow@iabervon.org>
 Daniel Knittl-Frank <knittl89@googlemail.com> knittl
+Daniel Santos <daniel@brilhante.top> <hello@brighterdan.com>
 Daniel Trstenjak <daniel.trstenjak@gmail.com> <daniel.trstenjak@online.de>
 Daniel Trstenjak <daniel.trstenjak@gmail.com> <trsten@science-computing.de>
 David Brown <git@davidb.org> <davidb@quicinc.com>
-- 
2.32.0

