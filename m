Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177C2C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 05:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiBXFvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 00:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiBXFvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 00:51:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F22649A1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:51:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w3so1316858edu.8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZETzzFs8fNbCaxVd+mg5aIAU7Xoj/nDqzhVv8V+OHs=;
        b=Gy50WHZPigaSYmXkXFxKDKjqFVsk9sH8MRMn76rFuOQCJ8wEbOLdTNr2XRSxOxKcsW
         AFXrUPZ0ZxcbBVGpZJZxuDJqNUAm35eGeaDP8+Xxm519gchTMbGHfuxqafLXCnXXSMuQ
         rYEq/iYyHvDrHic2KaaG0bbe4cC4WWSM9Vb9N/5z2y10tPWef8X0pYoIgt9Z5R96xMMu
         VP1h8wFNSRAh3sSvZfWL4ao5vicApxzlw5JrlQGzWeNZICPYqEhQLLbSKBkwrujaWWK9
         NnY31XXRNnMowxYIoQzRA22rUHyLqyan/t3w7WpzMxUZ8mVj1rppnsajtSLYKKrAUbu+
         b1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZETzzFs8fNbCaxVd+mg5aIAU7Xoj/nDqzhVv8V+OHs=;
        b=XATWiRtBKHhCamPDI9vCI2N1GKe/mwMSzE7HwYFKdrUIVfckDuZmf6noNNcfPbuPW9
         k3bFvbQsfJZA4sEfcV5ZVTnRaod8Zl4ZSHoO8ap3QDDTZbBgBu6rEG2GKyPMmmOBaBUG
         pcYi5wJWt4+xP+fR7IWu04l+TYuiULRWYUtmmmJdRzDUHrdgD/SVWOoXSwqMAusjkcmb
         d0McDiN5vFqzPPP4D3dB7J4fvTPt1QclMVisDwN3ClPyYIuJOupL96UPkYoIOqEg6O2R
         yB038AXFFxUObuabKkOsQyaOb5VePU1Wv2yh+wavVlGgKH0FLpDniFZrYTgFJlzjE2jp
         ISjQ==
X-Gm-Message-State: AOAM532p1BWS5zJe0iyHlc7pHECbPvnmenh4xmOr3VfAAk4Lx8sd0mVC
        YeGGFvytRjqqFZugbyxN+8wZRX+sPfUNzwzzvNvTBVC9M3JV0ID9IDE=
X-Google-Smtp-Source: ABdhPJwXSUh4ukYvQ1K/Nvd/8oP3Et9/maiyQcZNDuKYN3Tv5Pzk1sRyr/iDb/shb+WeJIBwUtXju3HRooQRBOpDHao=
X-Received: by 2002:a05:6402:1495:b0:408:71a7:defe with SMTP id
 e21-20020a056402149500b0040871a7defemr797301edv.121.1645681877640; Wed, 23
 Feb 2022 21:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20220224054720.23996-1-shivam828787@gmail.com>
In-Reply-To: <20220224054720.23996-1-shivam828787@gmail.com>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Thu, 24 Feb 2022 11:21:05 +0530
Message-ID: <CAC316V4F0UTEk8+=oThMNeQpsUjs78EkY2Qrw6rz7TCKXSyqzA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Subject: [PATCH 0/2] [GSoC][PATCH 0/2] t0000-t0050:
 avoid pipes with Git on LHS
To:     git <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

for further reference, you can follow the discussion on my last
patchset - https://lore.kernel.org/git/20220222114313.14921-1-shivam828787@gmail.com/

On Thu, Feb 24, 2022 at 11:17 AM Shubham Mishra <shivam828787@gmail.com> wrote:
>
> As a microproject, I remove all pipes with GIT on LHS from
> files t0000 to t0050.
>
> Shubham Mishra (2):
>   t0001-t0028: avoid pipes with Git on LHS
>   t0030-t0050: avoid pipes with Git on LHS
>
>  t/t0000-basic.sh            | 10 +++--
>  t/t0022-crlf-rename.sh      |  4 +-
>  t/t0025-crlf-renormalize.sh |  4 +-
>  t/t0027-auto-crlf.sh        | 12 +++---
>  t/t0030-stripspace.sh       | 81 ++++++++++++++++++++++++-------------
>  t/t0050-filesystem.sh       |  3 +-
>  6 files changed, 72 insertions(+), 42 deletions(-)
>
>
> base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
> --
> 2.25.1
>
