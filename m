Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0E761F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfH0EZH (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:25:07 -0400
Received: from forward102p.mail.yandex.net ([77.88.28.102]:43510 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbfH0EZG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Aug 2019 00:25:06 -0400
Received: from mxback17j.mail.yandex.net (mxback17j.mail.yandex.net [IPv6:2a02:6b8:0:1619::93])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id A7AEA1D40D45;
        Tue, 27 Aug 2019 07:25:04 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback17j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id GRkwBpFjzt-P4OqF8uS;
        Tue, 27 Aug 2019 07:25:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1566879904;
        bh=g3wGWwFlV+qLbZiLua2Lqb9NZw8juNy4IbvlfhaSsLI=;
        h=Subject:To:From:Cc:Date:Message-Id;
        b=nBhEath0tHltaXbqeL680cUx3hv1LetgD5GpTgNjp+98FtKgQjR0tzvBa8pI+e6Ae
         jRoflhjiCyiQxA0HXjtVdqy5yU+H5mWUTKF9I8el4oxcMddPw8xpQGef9j6WZt3e3d
         kOE8q2hPZM8WtRcvZnfK8eSwKCaitZrg3s/vdiG4=
Authentication-Results: mxback17j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id gRT48iKPW5-P20uRXud;
        Tue, 27 Aug 2019 07:25:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Andrey Mazo <ahippo@yandex.ru>
To:     git@vger.kernel.org
Cc:     Andrey Mazo <ahippo@yandex.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/1] .mailmap: update email address of Andrey Mazo
Date:   Tue, 27 Aug 2019 07:24:41 +0300
Message-Id: <b8cd556ebb4715d2111422d4bacf4075eedea8f8.1566879764.git.ahippo@yandex.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrey Mazo <ahippo@yandex.com>

I don't have access to my old work email since 20 Apr 2019.
Replace with my personal email address.

Signed-off-by: Andrey Mazo <ahippo@yandex.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 9a5ff04753..14fa041043 100644
--- a/.mailmap
+++ b/.mailmap
@@ -16,10 +16,11 @@ Alexander Gavrilov <angavrilov@gmail.com>
 Alexander Kuleshov <kuleshovmail@gmail.com>
 Alexey Shumkin <alex.crezoff@gmail.com> <zapped@mail.ru>
 Alexey Shumkin <alex.crezoff@gmail.com> <Alex.Crezoff@gmail.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
+Andrey Mazo <ahippo@yandex.com> Mazo, Andrey <amazo@checkvideo.com>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
 Amos Waterland <apw@debian.org> <apw@rossby.metr.ou.edu>
 Amos Waterland <apw@debian.org> <apw@us.ibm.com>
 Ben Peart <benpeart@microsoft.com> <Ben.Peart@microsoft.com>
 Ben Peart <benpeart@microsoft.com> <peartben@gmail.com>

base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
-- 
2.21.0

