Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFD2C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 15:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJHPY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 11:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHPY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 11:24:27 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 08 Oct 2022 08:24:25 PDT
Received: from forward400o.mail.yandex.net (forward400o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64AA47BB5
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 08:24:25 -0700 (PDT)
Received: from vla5-fbe4dab4913c.qloud-c.yandex.net (vla5-fbe4dab4913c.qloud-c.yandex.net [IPv6:2a02:6b8:c18:3607:0:640:fbe4:dab4])
        by forward400o.mail.yandex.net (Yandex) with ESMTP id A7092643840
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 18:19:11 +0300 (MSK)
Received: from 2a02:6b8:c0f:604:0:640:b07d:0 (2a02:6b8:c0f:604:0:640:b07d:0 [2a02:6b8:c0f:604:0:640:b07d:0])
        by vla5-fbe4dab4913c.qloud-c.yandex.net (mxback/Yandex) with HTTP id 9JYAdD1f9Ko1-JBf4xNbI;
        Sat, 08 Oct 2022 18:19:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1665242351;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Message-Id:Date:Subject:To:From;
        b=UsCZHraDYvghfLr62zmfgWU9Hsbn2CxMjPyoY16zq1KXBuMnDH/6ULxWj5kGJ5L1C
         SggxX/BYtyb1OdMpE8orRYeqiDxABt0XMFdfpubd8mf+G2wGKnGYMHkDoch+hrJgFH
         DscgfxreUxbKH89ww7d32bVW8OYj+j+tFBxBttu8=
Authentication-Results: vla5-fbe4dab4913c.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by ntuinyuyont3zyjz.vla.yp-c.yandex.net with HTTP;
        Sat, 08 Oct 2022 18:19:11 +0300
From:   =?utf-8?B?0JDQu9C10LrRgdC10Lkg0JrRg9GA0L3QuNC9?= 
        <kurninaleksei75gmail.ru@yandex.ru>
Envelope-From: kurninaleksei75gmail-ru@yandex.ru
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: =?utf-8?B?U2V4IHNleCBzZXgg0LrRgtC+INGF0L7Rh9C10YIg0LrRg9C90Lgg0LPRgNGD0L/QvtCy0YM=?=
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 08 Oct 2022 17:19:11 +0200
Message-Id: <10950111665242238@mail.yandex.ru>
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

