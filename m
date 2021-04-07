Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C532AC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8738161262
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348430AbhDGRty (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 13:49:54 -0400
Received: from forward104p.mail.yandex.net ([77.88.28.107]:38786 "EHLO
        forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348463AbhDGRtu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Apr 2021 13:49:50 -0400
X-Greylist: delayed 36499 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Apr 2021 13:49:50 EDT
Received: from sas2-0deea21afb46.qloud-c.yandex.net (sas2-0deea21afb46.qloud-c.yandex.net [IPv6:2a02:6b8:c14:7183:0:640:dee:a21a])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id B3F534B02A6B
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 20:49:39 +0300 (MSK)
Received: from sas1-37da021029ee.qloud-c.yandex.net (sas1-37da021029ee.qloud-c.yandex.net [2a02:6b8:c08:1612:0:640:37da:210])
        by sas2-0deea21afb46.qloud-c.yandex.net (mxback/Yandex) with ESMTP id fexefZkgAG-ndIa4MPp;
        Wed, 07 Apr 2021 20:49:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1617817779;
        bh=IHK7KggAsGf2zFQ56DhIYoWeug+aEibmBArFdOfud6Q=;
        h=Subject:To:From:Date:Message-ID;
        b=cdKcmjnn4oCGfn6olCRnKHqb8XJvonlee8K4WSQZcP0EQBXq1pjTubzwlV73qjNBw
         xD0QQ5vPYXzyOUTLaQZlEoqUEZB0qJYGPq4iyMYCF2Ks31sTJc9FKWUqAHLezG+ds8
         X65lcT3k/VARLDEdN3kpuIzGuMFiKYfedU8woJnI=
Authentication-Results: sas2-0deea21afb46.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-37da021029ee.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id z3twkLahSL-ndKGpX04;
        Wed, 07 Apr 2021 20:49:39 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Wed, 7 Apr 2021 20:49:38 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <1851413381.20210407204938@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Can not list stash (git version 2.30.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,

I am in progress of rebasing

~/e/Auth/Mojolicious/Plugin $ git rebase aa3376
Created autostash: 4018bc7
hint: Waiting for your editor to close the file...


while I am in editor I switched to different console to view created autostash:

~/e/Auth $ git stash list

and see nothing

but can view stash by its id:
~/e/Auth $ git show 4018bc7
commit 4018bc7bc870eb37aa35f40a0f612ca55a586045
Merge: a790392 674e39f
.....


Expected result: I should be able to see this autostash when `git stash list`



--
Best regards,
Eugen Konkov 

