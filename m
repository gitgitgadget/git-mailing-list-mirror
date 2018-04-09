Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371941F404
	for <e@80x24.org>; Mon,  9 Apr 2018 19:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeDITc0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 15:32:26 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36398 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754116AbeDITc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 15:32:26 -0400
Received: by mail-yw0-f170.google.com with SMTP id y64so3208302ywa.3
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EWEBkA6piPBWa0ayXWvKMMy1710KTyjHcDDeev7371c=;
        b=lxtl+U5SQ1YlCfktAi2MDXQRCnY2NVd8yChn4LOho7o1Z1y2PxbmJGMxTi/mTduyav
         bRAvm/EMSQSodexs6mNOsuk/FDDf61faZA+jrLnhsLwj8uXFVJMe7/uh7IY1dPRCs2is
         jC4XxrgTdUvmH4utFPU2trB6enHtJyLWKBO1GQ2FxrmMweQz8Ha50FqauYc7QIppi2gI
         f5AsC27VOBkN6jOT4BbI9mJl6jAJoW8a7sT3QmwZAu5A7+X7AA4DZUVJqsGvGcgvPUhY
         grGJl0i9kfXLmJUVo4FeVvYydWNoA8/93rQ9zvNZJ86vtR2F/DKb1p3MsGbbL7IcB+OP
         dlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EWEBkA6piPBWa0ayXWvKMMy1710KTyjHcDDeev7371c=;
        b=hzTxEIjLweM7oGurELvC0co10RdYmFMWOIT5cXN9gCGqJwLTxH2FbZcNtiXi4F5dvL
         4b4CI67st2xOB4EtK90fpR40UFv5/VOl99HitYH25vi6hALlMq8X0u4V1pYoWNLZuG7R
         w6VLYfzuCTqbrsUu38VNkG0VcAP31HCCVGND6rbEaLlXaLI9f+XGxXftYdH9IBja+9Uy
         2K6Am5JmzNWf1X+3bT45cdH6T+A/jjjERqyF1pL30TqS1m+kdEmg5JQjxYaYxUeQ0Ihf
         5b4RgDVDJ0WaEf1ONoc4/zTJ39sjD6rb3MF1k9dzAwPUD3cdXnZ+DUaE6O+nkoSuGEZV
         KoJg==
X-Gm-Message-State: ALQs6tCf2VW4tnKQFv6tPklliqhmFzeo2tPTPFI12Qeild7ql/Ke2Lrk
        NQd18Kxktlvncqt/GIzmiB+OpSvIun3VsiYphwjd6A==
X-Google-Smtp-Source: AIpwx48WeN30ReGZJNCgo8T8Tmfnd+xKLuJQv3mfaKAxg+A4cHvDeygHoYqR/hTF3AcXADy0AHLoilr+4jN5uUqdml0=
X-Received: by 10.129.159.195 with SMTP id w186mr12274001ywg.414.1523302345027;
 Mon, 09 Apr 2018 12:32:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 12:32:24 -0700 (PDT)
In-Reply-To: <CAFLu24=o0nQveRpMJV-6dhvft0H9PgdBahisBi4EEg=G0BwhpQ@mail.gmail.com>
References: <CAFLu24=o0nQveRpMJV-6dhvft0H9PgdBahisBi4EEg=G0BwhpQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 12:32:24 -0700
Message-ID: <CAGZ79kZ6xWijnZZpcogVm_JCX3nGMzN8ebKyh1vYygNc_dqGFw@mail.gmail.com>
Subject: Re: Windows > git.exe > the result of "git branch" does not always
 highlight the current branch
To:     Hari Lubovac <hlubovac@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hari,

thanks for reporting a bug!

On Mon, Apr 9, 2018 at 12:26 PM, Hari Lubovac <hlubovac@gmail.com> wrote:
> It appears to be just a reporting issue. Probably not a big deal, but
> I thought I should report this, if it hasn't been noticed: when a
> branch is switched to by being named with non-original
> character-casing, then it's not clear which branch is current.
>
> Example:
>
> C:\repo>git branch
> * bar
>   foo
>
> C:\repo>git checkout Bar
> Switched to branch 'Bar'
>
> C:\repo>git branch
>   bar
>   foo

Is this Git compiled under Windows or
Git-for-Windows as distributed by Johannes?

AFAICT Git-for-Windows prefers to have a bug on github
https://github.com/git-for-windows/git/issues/new

Thanks,
Stefan
