Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B155B1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 20:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeAYUX6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 15:23:58 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:36980 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeAYUX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 15:23:57 -0500
Received: by mail-ot0-f178.google.com with SMTP id a24so7852656otd.4
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 12:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G775RdZEP+ghYLuBwEgIogDmCv94QCLA7bm7L3NvwLY=;
        b=Ik8et/Je+hPtMfYLqBz0CPvAdlXLqbzxf+wn6jj7nRvzBxGoKFd9V8EcnQqaJkl2hi
         w9QkO3YyxxilEXl+yrTDKHGl4sKoiqdZRF6yEq8h6DTW8t7cYppeZfx405dtR2AiK+TX
         4Pgcd/HwqUSrhAYh+XU2uHNY23aaqNw5qPf+qKpDnqgp3MLkqnz6LY/+3aWXt9xDTcPS
         ksPe7HT/hpJjdMi5Lcxh8CziymXaSabqNM8nT2cyJ9nw31MXN49tsEs0Jh0nYsRcBiLa
         cg4NKKkBEtKszQa7TaE9bZFtZQaFDU7IvKH07ZcWB6yi04Hn2USzvzxUtRgTWafOJKTM
         U2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G775RdZEP+ghYLuBwEgIogDmCv94QCLA7bm7L3NvwLY=;
        b=IflGgnIShMWdBse7B04+WN3ykmu1vMd1LgEzZNBjsGSz8gvRsr5bYRG0eeo5zVnoiO
         ++c5wNpDXiRLoXPE21UlGaefLFEDqufzPZDKEKjuXWKph55JBXLlphgUoT4vpBMUs/qo
         +S3SgbVNY8nfxP21MFdgNmg9iBCI6i4Q+0qaYUvYwm2API8A78ITxG11A0Nqp2Qn0Dv6
         ZxqrO5v2ZDNGI3ZUQgOfoQvgCRQwgh27QW6BcPVKcYW32DR7EtFSuhBQwwBN87khoqlm
         IuYqV2TZrxb9M1RXsM4ppt7l7AFHPfjLbXuYSS03h20FTGX5ccBpsS9meqvAayjSx2N7
         dxQQ==
X-Gm-Message-State: AKwxytdG19iiF59xuLA0Vmg5bg2b+BKOnBzhQHw1/B/LMGOKPkD9FJmO
        Tj5GzdOx20c2Cs9Eaq9PCP39vxYt1MVOPFwY0mkNYemM
X-Google-Smtp-Source: AH8x224gToL1VODXpEoTAnUlFxHAe3gqmmFtlp84gMRmKXpLJmqrLy2CV7WXVXstJbOj2D14WFQTUg/htZoZXzb02Rc=
X-Received: by 10.36.176.8 with SMTP id d8mr10106069itf.63.1516911793770; Thu,
 25 Jan 2018 12:23:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.149.87 with HTTP; Thu, 25 Jan 2018 12:22:53 -0800 (PST)
In-Reply-To: <CAL21BmkTbr9qYK3+bsbwh9aDQ1twqrNkyUdbaFPSAn5y7ov40Q@mail.gmail.com>
References: <CAL21BmkTbr9qYK3+bsbwh9aDQ1twqrNkyUdbaFPSAn5y7ov40Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 25 Jan 2018 21:22:53 +0100
Message-ID: <CAP8UFD14V-3T0kV=VxYLdozGp5yT-Rzio7PiY8sFn_rVUDxnjA@mail.gmail.com>
Subject: Re: Please review my code
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Olga,

On Thu, Jan 25, 2018 at 6:20 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> Hi everyone,
> I haven't sent the code by mailing lists because 25 commits (every
> commit in separate message) look like a spam.

Yeah, so now that you added tests, it might be interesting to see if
the patch series can be refactored to be shorter or to be clearer.

> Please look at my code:
> https://github.com/telezhnaya/git/commits/catfile
> You could send me any ideas here or in Github.

I left some comments on GitHub. My main suggestion is to try to get
rid of the is_cat global and if possible to remove the "struct
expand_data *cat_file_info" global.

> The main idea of the patch is to get rid of using custom formatting in
> cat-file and start using general one from ref-filter.
> Additional bonus is that cat-file becomes to support many new
> formatting commands like %(if), %(color), %(committername) etc.

Yeah, that is a really nice result.

> I remember I need to rewrite docs, I will do that in the near future.

Great, thanks,
Christian.
