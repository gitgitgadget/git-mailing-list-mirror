Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD61207DF
	for <e@80x24.org>; Fri,  9 Sep 2016 23:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbcIIX5F (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 19:57:05 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33406 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750976AbcIIX5E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 19:57:04 -0400
Received: by mail-oi0-f42.google.com with SMTP id y2so174830911oie.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kNkTEkO10W14jKYerT5V4hBLxa6C7tPgfYTxfNDsxRo=;
        b=HDv2sErL9ma0Q4/kxgi2Kf+6UOcibg5u7/2bEw7ZWD1GG1VptgXfJ7T2cvm5hhggB3
         4BVHndSx0WjGYHvF0stG0m+0cT0QYzrHonaXZ4ku+gT89XylvT8qobRK6UPAVY5tgcdy
         L/1B/TexfTNDNFFTxSaBf022xy5weh+qzXCMdhTnjNxztC3Axk7X7ZA8ZaM4x6Y+TlsJ
         l8aqC0BY9jJ/N50Q1uoQhIrhGzPA4/U9KyovrcUqWSWHI6e4BVZmEPtfIzWWZlT23zvw
         pZvLNFq5mBvQhhiqZO7lBBvJTED5YTpOH86qJsFzggTP2vB4RXRskbYdhbe4JUsw5qXf
         L3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kNkTEkO10W14jKYerT5V4hBLxa6C7tPgfYTxfNDsxRo=;
        b=GpqOBO1ksGg+AdSODd8vhKbAZKHgyLGiYRyWpDVrBp7woPD7MtaSUJpzIT64Fuo/zG
         MkO2dVyMf3ykdRH5tRF/ESdFrmmeFFoMETb8kvm1CCN3EQPdyBmrYwtyOLRlKt3fXb/d
         gtrXHVfuhZM0+LWg/otcX2MSebRHKGwuLYf2mPIoVNuEtzXJrM+XMoTMSjNXlhz84y+9
         yvjWQSJps3OkXRgcT4HTubSx/vOu7N1rKDk2NUmTijOck4ud8ViBDP+WQbIXOlvNXQWm
         KAOSaDnJDdCD7zngpcf/exKmUw/Cx27Uoqk2LRq3l8MRI2Z1rtp8DBHyy9QRO0NRAmAC
         oGww==
X-Gm-Message-State: AE9vXwOmJYPjleXBFBETy8lT135oIuUl6Twd/HqAvMdwPUFr0H28v5dnNcd5kXwyELZUDuvz/gR0GMTar9PYejYm
X-Received: by 10.202.75.143 with SMTP id y137mr5821210oia.167.1473465423335;
 Fri, 09 Sep 2016 16:57:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 9 Sep 2016 16:57:02 -0700 (PDT)
In-Reply-To: <CAG0BQXmyW-Hzdyj4rTviToEVbJ73d94P9GcfFVR6P2XCsA2t-g@mail.gmail.com>
References: <CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com>
 <CAGZ79kb=LyusFH6tGirGP9qK1k-cov2UubEbKPfeyPRThUsa-Q@mail.gmail.com>
 <CAG0BQX=FFWqR=45g6buujzK2jknx8aZnQoiV_m-QZhcx4Dd52g@mail.gmail.com> <CAG0BQXmyW-Hzdyj4rTviToEVbJ73d94P9GcfFVR6P2XCsA2t-g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Sep 2016 16:57:02 -0700
Message-ID: <CAGZ79kapz7PR7vO2oyWE8WygXr+hTSJeZfZgpyeERv+Z1jTjCQ@mail.gmail.com>
Subject: Re: If a branch moves a submodule, "merge --ff[-only]" succeeds while
 "merge --no-ff" fails with conflicts
To:     Dakota Hawkins <dakotahawkins@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, mwitte@ara.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 9, 2016 at 4:37 PM, Dakota Hawkins <dakotahawkins@gmail.com> wrote:
> Any ideas on this anywhere?
>
> In my opinion if a merge can fast-forward without conflict it should
> trivially be able to non-fast-forward without conflict.

Yes, I agree. Though the submodules still have a lot of sharp edges
that you can injure yourself with.

I am sorry to let you down here, but I did not have time and mental
capacity to actually dive into the issue further this week.
I hoped someone else would have picked up this thread and have
a good idea.

As you know currently the checkout doesn't touch submodules, i.e.
you have to run "git submodule update" whenever the submodule
changes. So when you checkout a different part of history, that moved
a submodule, this will fail as the submodule still resides at the old
place (and may have path name conflict with another thing)
and is not there at the new place.

I plan to fix that in the near future (read: teach git checkout to know
about submodules), mind that there is already a patch series for
exactly that out there in one of the branches of
https://github.com/jlehmann/git-submod-enhancements

This seems to be not an easy fix; Someone tried already and getting
it polished enough to include it upstream was not successful.

>
> Also, I'm not too familiar/comfortable with mailing list etiquette,
> and I don't want to be a bother by continuing to ping this thread.

Pinging is fine, as it is rather easy to ignore mails on a mailing list. ;)
I just don't know if it increases likelihood of someone responding.

Thanks,
Stefan
