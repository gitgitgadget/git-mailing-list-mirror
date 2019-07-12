Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860331F461
	for <e@80x24.org>; Fri, 12 Jul 2019 06:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfGLGLa (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 02:11:30 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:40268 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfGLGLa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 02:11:30 -0400
Received: by mail-wr1-f50.google.com with SMTP id r1so8600802wrl.7
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 23:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsuSsEn3a7ba5ZazRsdO2S2LuWmHtcQrz+LiHBAf2Mk=;
        b=B+BNrrNOx/0Z4bWa2n2+qQZ+tFiaxqzT6Nm4t2IXJvAA6ceqVXtgz+uzPm+K87lKOy
         8X0QWp4Omsp9hKl2RRjL1gJYBKs/NAf7cI6JHQ2EUhKe5Bvyux+fuQKH1GMqzz9m/ae/
         9xQ8b3ju+FeIIstAqJ6ImiutcAKTI6g3iGGO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsuSsEn3a7ba5ZazRsdO2S2LuWmHtcQrz+LiHBAf2Mk=;
        b=uCU2uKb0P91xueT04T4gRiv/h5+3k4/dUasFj3zj7SiwLfk7Awl0NiWvsVytOIEcfO
         ylbKEEIH9r1mQ+OqxYyerKcocpQX77qx2Figc02rvOrVs3YXlnY6D5quv3ngQ7Z93ics
         U5IjxKQpXQlGG3gjRRVa0Hg9emZX5MJkDVA1/WSf6qip2tSsF7dg209iPmazPz5NuwGe
         YFRYt68//QAv1K940zIyYyBHwTgs4GDhIDXX1jGdn8Of/+9iQ3G4TKgbl9hSzl3Q1XBw
         cIh+M5VfOhfaYmnRUpsCNAyXMG7/d9NzlCCbmApdnSuX/kLB5KYAIRRkekbXllYU88Lm
         +7DQ==
X-Gm-Message-State: APjAAAV5bYhNjDfYcEZAOZ9xzl5ElPxxX9W4Gg5/CYKRXoaXh9X28V7a
        WjEBjtcOqR7agcHM8Qh6kHTGGnmMVYpd55hmc2c=
X-Google-Smtp-Source: APXvYqz8i8ORYzFl4D2qjhX51opQgfW75jgOOurYfRrk3KMlH6P00Aovzh3+qtUvr2H1LWTwdMTcAkh9aqOa1S10Nng=
X-Received: by 2002:adf:9bcd:: with SMTP id e13mr9251840wrc.338.1562911888163;
 Thu, 11 Jul 2019 23:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com> <1748011561196810@sas2-7b909973f402.qloud-c.yandex.net>
 <xmqqmui6j4mk.fsf@gitster-ct.c.googlers.com> <8406251561455942@sas2-a1efad875d04.qloud-c.yandex.net>
 <xmqqr27hftl2.fsf@gitster-ct.c.googlers.com> <17402391562898022@iva6-161d47f95e63.qloud-c.yandex.net>
In-Reply-To: <17402391562898022@iva6-161d47f95e63.qloud-c.yandex.net>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 12 Jul 2019 07:11:17 +0100
Message-ID: <CAE5ih79+HjZHegkwj+0e-e1uFu8ZC4rxNWGQGe5cJR1WN1FFdA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2019, #05; Wed, 19)
To:     Andrey <ahippo@yandex.ru>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 12 Jul 2019 at 03:20, Andrey <ahippo@yandex.ru> wrote:
>
> 25.06.2019, 13:44, "Junio C Hamano" <gitster@pobox.com>:
> > Andrey <ahippo@yandex.ru> writes:
> >
> >>>  Thanks. When I ask "Is this ready", I am asking for opinion(s) from
> >>>  third-party, not self nomination ;-)
> >>
> >>  Ah, ok, sorry. :)
> >>  I just haven't seen any related comments to any of your previous "What's cooking" emails,
> >>  so thought I should send a keepalive email just in case.
> >>
> >>>  Let's merge it down to 'next' and to 'master' anyway.
> >>  Thank you! That'll be great!
> >
> > Thank *you* (and also Luke) for keeping "git p4" alive ;)
> It's mostly Luke and others.
> git p4 made my life with Perforce tolerable.
> Without git-p4 it would have been much worse.

Sorry, I've been a bit maxed out with work recently.

As above, without git-p4, I think I would find it quite hard to go to
work in the morning!

So many great things about using git compared to perforce.

(My current work is mostly using git though, yeah!)


>
> --
> Andrey.
>
