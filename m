Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4A8C433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 03:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbiDSEAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 00:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbiDSEAN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 00:00:13 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E315814
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 20:57:32 -0700 (PDT)
Date:   Tue, 19 Apr 2022 03:57:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail2; t=1650340648;
        bh=1n4Xp/INL0NKR4YwApgovTJR0qAxXATQ3TYGqcvt6wg=;
        h=Date:To:From:Reply-To:Subject:Message-ID:From:To:Cc:Date:Subject:
         Reply-To:Feedback-ID:Message-ID;
        b=DfOxMTA+1oH5+CmQuPb9Ez7TS/hhAgs9zYFKl6sbkQTsMCnlw8tvSsuKF6BFcFtVO
         sKGovNEs+eH6/7/1tAVcXPU5JKRM706YGbuCjBmax462+k9QR0eIqpIr2542cL7ReZ
         JnIY/A/LZbkXInIjyQTBT80YmNhF50hDU1Do55hcFMveLF8H07ZvoSZLRW0fE7fKAn
         1MuAcGO41L10asWgOWK3bAYzDgCtP587/jUmj/S3UElTQP76/xX0E3Cbxd6qE4oNBX
         7zUws1HJFfM38Ha3dTXqdXaD9PZHUg1zOjxkGFIfsXplYhRjwg0aBEyaLWMJutnMsr
         JhMZIgU8utA3Q==
To:     git@vger.kernel.org
From:   Solomon Tan <solomonbstoner@protonmail.ch>
Reply-To: Solomon Tan <solomonbstoner@protonmail.ch>
Subject: git send-email with Protonmail Bridge
Message-ID: <Yl4zGh5VZTPVjV4D@ArchDesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all!

Does anyone here use git send-email with Protonmail Bridge and face the
problem of missing `In-Reply-To` and `References` headers?

I am new to git send-email. I am learning how to use it to make my first
contribution to the Linux Kernel. I tried submitting a patchset, but I
realize that the patches are out of thread. Patches 1 and 2 have no
problem, but Patch 3 is missing the `In-Reply-To` and `References`
headers.
https://lore.kernel.org/lkml/20220419011340.14954-1-solomonbstoner@protonma=
il.ch/T/#t
https://lore.kernel.org/lkml/20220419011340.14954-4-solomonbstoner@protonma=
il.ch/T/#u
The git send-email log tells me that the `In-Reply-To` and `References`
headers were included when the mail was sent.

I did a couple more tests using `--in-reply-to` to explicitly set it.
The log tells me that the header was included, but it isnt there in the
test email address receiving it. Does anyone know how I can overcome
this problem?

Thank you!
Cheers,
Solomon

