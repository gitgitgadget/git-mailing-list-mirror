Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB751F462
	for <e@80x24.org>; Tue, 28 May 2019 17:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfE1Rhp (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 13:37:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33077 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1Rhp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 13:37:45 -0400
Received: by mail-it1-f194.google.com with SMTP id j17so3238862itk.0
        for <git@vger.kernel.org>; Tue, 28 May 2019 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6J63JKf18EX/xm5eAz1Hp1WsfMHk2p1qHmvdOngbQJA=;
        b=yKhxMmd7g98OCl4c2YswdCzCkrirnZzMfmqKcXyp+/lnnOyMY829Mfvn74LWOUrDhz
         /q4qj9AjykUqtXh/YKJ+maTrz4p7b7bfq4DYmEyL2YqGpj3Eh0fh4INr4/X8JpzM3OXt
         volHlrRjeXvW9s7RjdS0FPySF3ORBd32w5jEDZcFzE5FNL63QeI6bkx4ul52JxR1nC9H
         CpfBEEwMupmuL+5djq2fwqnGpnE1Grf/NQpfb57hOvPHhISZ39ZApLpw1hx58BmTeN3c
         nAUnl3FNcQDCO7CcmpYtDaDzJzuWw+z/Swhq0qyaYUbwppCVjm1JbVQj0N+Rtxzu5Cl/
         ClvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6J63JKf18EX/xm5eAz1Hp1WsfMHk2p1qHmvdOngbQJA=;
        b=gPGxclfGaoccgmKPnaOlHfGMKwyeoTvmXFtBfSqq7+K+47fw/+VEnrztnIB5DkQqC7
         mi984wKmYTA9o6QiWdbXwOhxO3DnqFOEY8kQqAWNkEUqnPxGBLJ0Ht94afGc+gOMep4I
         Zbcw5/ppzr/xbWrmezm28QOr2S0M1frpUk9ubRnHFmUG/JV2tr3RkgGYyPfJaF47dDJB
         z16uhZNiPwTCwZN9iEztmzMPkreDY2NOV6AzmHclqoai6sEGD0/MsXUZhXZ/073tSWR5
         QEgLfiw4PvTjDkhBzP0SOxx4WAJIXGkWBp649GX2SfMzdUY5YHA/D292qoVH6+jcW3tc
         qskQ==
X-Gm-Message-State: APjAAAXXF1Ek0I86qDkIcysZVcCZ9Rla/nxkf6Juaol4BiheaxnbyXzv
        kuYKrX1Cy81Qr9Z5eVFbjNx+7yKXe62pE83QKADZxw==
X-Google-Smtp-Source: APXvYqxf44pW/cbhBK/7iWERl+mi5miawH68trhEOSraEWLW13RdI61yeQbMCzwKkakXInX4jipFrY10ysS35WyPkwE=
X-Received: by 2002:a24:e084:: with SMTP id c126mr3927007ith.124.1559065064150;
 Tue, 28 May 2019 10:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <87in9ucsbb.fsf@evledraar.gmail.com> <20190520182353.22221-1-matheus.bernardino@usp.br>
 <nycvar.QRO.7.76.6.1905281235280.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1905281235280.44@tvgsbejvaqbjf.bet>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 28 May 2019 14:37:33 -0300
Message-ID: <CAHd-oW7BFYd=LQBF4mF5QTpce9YtXj1WDf85AyO+CLwC9GMqDg@mail.gmail.com>
Subject: Re: [GSoC] Some #leftoverbits for anyone looking for little projects
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 7:37 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Matheus,
>
> On Mon, 20 May 2019, Matheus Tavares wrote:
>
> > > Give "rebase -i" some option so when you "reword" the patch is
> > > included in the message.
> > >
> > > I keep going to the shell because I have no idea what change I'm
> > > describing.
> >
> > I have the same problem, so I wanted to try solving this. The patch
> > bellow creates a "rebase.verboseCommit" configuration that includes a
> > diff when rewording or squashing. I'd appreciate knowing your thoughts
> > on it.
> >
> > As Christian wisely pointed out to me, though, we can also achieve this
> > behavior by setting "commit.verbose" to true. The only "downside" of it
> > is that users cannot choose to see the diff only when rebasing.
>
> You could of course add an alias like
>
>         [alias]
>                 myrebase = -c commit.verbose=true rebase

Hmm, I didn't know about `alias`. Thanks for the information.

> which *should* work.
>
> However, I am actually slightly in favor of your patch because it *does*
> make it more convenient to have this on during rebases only.

Another option we were discussing is to document that rebase obeys all
commit.* options, instead of adding the rebase.verboseCommit config.
Yes, this way we won't be able to toggle diff for rebase only, but I'm
not sure if that's something users would want to do...

> Ciao,
> Dscho
