Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5717BC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 18:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbhLJTBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 14:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbhLJTBg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 14:01:36 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA982C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 10:58:00 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m27so19656152lfj.12
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 10:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBQlb1jPnVvve04v+5OXYyCG2ihH2q5hpdP8hPlvVS8=;
        b=HWo6iZrjV3TXI/SUexSL5pMU6ZEMFIqxX44HUB3/A3vls++1sj4WG/RJ+66Fsk6tS0
         2co6wcScxMRL9gjypp72LDrWvGpQd6S7pLI4KmFP3UGKvjwEEQjt//QXbFRxGdm2/kea
         Bpuz2KQ5Z7w2KYgc2ZhQJZ3+kda0ru+1keERA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBQlb1jPnVvve04v+5OXYyCG2ihH2q5hpdP8hPlvVS8=;
        b=C2qfoOfdT75dxHurwyv+YfkfGCCdA3k1GK8mV4jjkX7IOJIln4mvhM9QZG+g6ElvMr
         3BD+nsHRFxCWYKVzktLLmHuqL7GRI5YPLHw+Wb/Pj8DxvCv/IufokkWnhALFsfBSGwhp
         CNXOI8oIhbAsx+rVj0ejWl8ky0Hj22pCYfTVzBPsBdHSHEM6nh1xmwygychf6oZo29ix
         VNY/Q0cDys64KQg7seLT3twAnfgB3+vJAtMPoq3c8InQSKX9EQTGJ7l5NorW9l6nfbpd
         Z2an8BKWqVy+X5ArciasS6yi6LtzZXLr+D589FKRyd1y065TiM7jXUMApSP9AXO04pPD
         PtNw==
X-Gm-Message-State: AOAM530eHupeqGtJrsrLBTMYitEHw0La9YsOtYJ+fuIIm33OBkCnBsj5
        l62qBNdIpZEB72amX7Cq+bzuBQ7xmCs4GqII/vejAg==
X-Google-Smtp-Source: ABdhPJy2rO3C3IoiDEHP9HMCoOIGn7esGIv1iY/sIQdpJfozIIwXJW6FfFrxEjtN/KTB5lVwYGk4uelB65Oeg2N84xM=
X-Received: by 2002:a19:e046:: with SMTP id g6mr13766291lfj.176.1639162679121;
 Fri, 10 Dec 2021 10:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20211210153101.35433-1-jholdsworth@nvidia.com> <20211210153101.35433-4-jholdsworth@nvidia.com>
In-Reply-To: <20211210153101.35433-4-jholdsworth@nvidia.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 10 Dec 2021 18:57:47 +0000
Message-ID: <CAE5ih7-nAOviVmuDbAWXONcY-FkR6xUDu_vTZhWz8_RTpDpsMg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] git-p4: add "Nvidia Corporation" to copyright header
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git Users <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Dec 2021 at 15:31, Joel Holdsworth <jholdsworth@nvidia.com> wrote:
>
> The inclusion of the coorporate copyright is a stipulation of the
> company code release process.

This doesn't seem right to me.

It seems very odd that there's a patch that just adds a copyright
notice, with no further notice.

What code does this cover and is now copyrighted? What are the license
terms of the copyright holder? I think these things need to be made
clear before this could be accepted.

> ---
>  git-p4.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index 5568d44c72..17e18265dc 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -5,6 +5,7 @@
>  # Author: Simon Hausmann <simon@lst.de>
>  # Copyright: 2007 Simon Hausmann <simon@lst.de>
>  #            2007 Trolltech ASA
> +#            2021 Nvidia Corporation
>  # License: MIT <http://www.opensource.org/licenses/mit-license.php>
>  #
>  # pylint: disable=invalid-name,missing-docstring,too-many-arguments,broad-except
> --
> 2.33.0
>
