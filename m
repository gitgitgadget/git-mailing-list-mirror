Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0CAC433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B20B6124D
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhKKSEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 13:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKSEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 13:04:31 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB69DC061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 10:01:41 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m14so27694651edd.0
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 10:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTi6T2y5R6yXgZruofLU1OTviWPZ3ZqBtcO14awmM/Y=;
        b=ZPcposPFVvHpc3yYPJgpuZoVM8UI6yaL6svGgKM9TpH7PNBKGvFZOa/591peVy+2ck
         nu4TowC3Tfu+52bBUZDlPHiVexz0bAMCZMYAsww5uunYlpsBnwIdfjz6lkHhGgXnCV4K
         sDMTARQFw1DklJ1dphVwgzVIDYNQuXW0WULG9Oke3fattpWfzOF2lEpVeS0tUauiasDs
         zcllNtnUBCEuOVLnYjGh3/hLCQQSfC7NGtfe7/uh0ms0pSbnlaGChuWKBEVs/crR2vYQ
         SD4xedgQPSpUyFUSK4IEQF9qEbLHQlCUbbYkVP3WRhH9wNPp65oWVyWSmpsM++ieFcJJ
         HMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTi6T2y5R6yXgZruofLU1OTviWPZ3ZqBtcO14awmM/Y=;
        b=hMaL8vxX+DxmJyC1ghZe7P6zg8TNfsmvrjdM9ec54tE5eddI4tFoc6J05qIspYMG/v
         dABIytV5DE1ZiYjvGN7lmHSon2PvOb8aK1QZNp34Xc3nOgiGHy7eEwDX/JgZ80/Ty6Ou
         /aS50l9RnPHo1xRpKPRjcnAu/MdImpEev5LErW6V9wLuWBbz1ndRMs/0TtnXEvkXrV/Q
         vXwAA9F1MaB9eo9AMWUcZ+/g84h+DX2Ji62S8jEU+1fSPWLNV993jKijerv3e0KCe8Ym
         3cZyqYMCHaHqww7Ua9VZtMk/jVXs23xNoQ6k8zLp3hhfjsG602CZhC2ZGgd2EL6pTzao
         8jRw==
X-Gm-Message-State: AOAM533VB7mhKf/9GojpbLNCaLQVOlmdzsFWLd6lj5Q+zpWKAzW0dx5W
        00hFG6AYanCcMIXKcE7I4MH8H9jLvQay5qqxt8ssf4bl
X-Google-Smtp-Source: ABdhPJyyQygg63hvIwrTnTH8mtcs8YFBWlmLjxeNoGFdcl/kJ7psd2Cx/2Z9WO8twqs+zzviDaKVE8aQRfj2qJsa4xU=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr11660035eji.434.1636653700318;
 Thu, 11 Nov 2021 10:01:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1073.git.1636526490570.gitgitgadget@gmail.com> <xmqqo86qmvnr.fsf@gitster.g>
In-Reply-To: <xmqqo86qmvnr.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Nov 2021 10:01:28 -0800
Message-ID: <CABPp-BETy2=J1jNsS_pPpby7Z1P0Yfp92eekMLRicaA=YCL8tQ@mail.gmail.com>
Subject: Re: [PATCH] RelNotes: fix a couple of typos for the upcoming release
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 11, 2021 at 9:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     RelNotes: fix a couple of typos for the upcoming release
>
> Thanks.  Relative to -rc2, here is what I have today, taking these
> typofixes, and a few topics for regression fixes.
>

> + * "git pull --ff-only" and "git pull --rebase --ff-only" should make
> +   it a no-op to attempt pulling from a remote that is behind us, but
> +   instead the command errored out by saying it was impossible to
> +   fast-forward, which may technically be true, but not a useful thing
> +   to diagnose as an error.  This has been corrected.
> +   (merge 361cb52383 jc/fix-pull-ff-only-when-already-up-to-date later to maint).

Is this worth calling out in the release notes?  I thought the
discussion elsewhere on this list pointed out that this bug did not
exist in v2.33 or before after all, but rather that it was a
regression that was new to the v2.34 development cycle.
