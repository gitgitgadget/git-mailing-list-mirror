Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EF261F461
	for <e@80x24.org>; Thu, 27 Jun 2019 19:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfF0TeL (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 15:34:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35388 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0TeL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 15:34:11 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so7387956ioo.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=an+WKt2ybpEXWmLQaS46P0LcNiblC4yVDvRW1/t19b0=;
        b=cb5DysKAhyH9EfWF5U0NC7FgcDc2zLBR/mHVlK1HptmAxen8TqHmPZvMGja26i6MRJ
         ypeQ0Psdw5PnRYvGXA0IdyOzELIK4Tr9GNBJs3A5V+M8wsJpGkG4B3KhqDnCOWk5ht9M
         FoSJep5QyHltbAov4WxOl8amzSXwibwFVf1IXju6gx27rGEq7/HP9ReoHnBf8gr+exFC
         AYxwauBspPJYNdSXdr5xggPblgRK4Gsws7mPRn+4q1KbilkdVi0IU7yXeRs9jyF9+9n6
         cmUCqmPhLzdS0yjGrpjRwGTz1pYW4WdO5iHkgPv6o9q6p3nmQDhGXG/U+i847L5poaa5
         B2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=an+WKt2ybpEXWmLQaS46P0LcNiblC4yVDvRW1/t19b0=;
        b=KU7k3mTutijvJ6uhWP8PpwmNMadJ1Xw5duuoch6bt2qxxLrnQqWLd0BkeBDAXDARo3
         /v+PTMkjnCkW8kY9clhSHNY16NpgOJizHRJDo24D4BckYJFRFf3oTpIMooc7Ndx1F+pq
         lHaTgDQLXzBTIPX9k04lzo8V13RkomuaVeFqszTy8xGnb6rwHaQ1t5SjT/SVmLddlkTl
         OX+aylAup36TEpqbV5f/ssh9Q1/rb7PKiPqGWW1oG+61KQaeTE2W/Kuxwgcj03YmXtgB
         RavDegqI507xaeYA1STSqxhNcANU/pOEqN0IyFJI3S/QbvYvOd2qbEeUkbryC9SOjd0G
         krkg==
X-Gm-Message-State: APjAAAVJkeZI+e1VoSw/fjhs3mgfxxd0/3S5mZ/57tIdQX7tGfJX+WdJ
        QguFRWT2Oyxx32boeXsZhEDdpKNfZVtp5PRRiw/pnA==
X-Google-Smtp-Source: APXvYqy+oF8ho6rsZwfT4tV49UmYUlkM+pnc59IJfRQ8W0qK0Ss/ilyHJyr1VodZFslN20Da0kETbDGXHW8Bzhuig/c=
X-Received: by 2002:a6b:f00c:: with SMTP id w12mr6421584ioc.280.1561664049899;
 Thu, 27 Jun 2019 12:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560898723.git.matheus.bernardino@usp.br>
 <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
 <nycvar.QRO.7.76.6.1906261528360.44@tvgsbejvaqbjf.bet> <xmqqwoh8cjeg.fsf@gitster-ct.c.googlers.com>
 <CAHd-oW5zea9wzobAQG4FzN-KSS5BsRoM5vf_x_F83=yqGRfUQw@mail.gmail.com> <nycvar.QRO.7.76.6.1906272046180.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906272046180.44@tvgsbejvaqbjf.bet>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 27 Jun 2019 16:33:58 -0300
Message-ID: <CAHd-oW6c7EoY+t-ymkcBmZM20YcGb1SWhM7XMO35Fofj-UNmYQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to dir_iterator_begin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 3:47 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Matheus,
>
> On Thu, 27 Jun 2019, Matheus Tavares Bernardino wrote:
>
> > On Wed, Jun 26, 2019 at 3:04 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > > > Hi Matheus,
> > > >
> > > > On Tue, 18 Jun 2019, Matheus Tavares wrote:
> > > >
> > > >>[...]
> > > >> +/*
> > > >> + * Look for a recursive symlink at iter->base.path pointing to any directory on
> > > >> + * the previous stack levels. If it is found, return 1. If not, return 0.
> > > >> + */
> > > >> +static int find_recursive_symlinks(struct dir_iterator_int *iter)
> > > >> +{
> > > >> +    int i;
> > > >> +
> > > >> +    if (!(iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS) ||
> > > >> +        !S_ISDIR(iter->base.st.st_mode))
> > > >> +            return 0;
> > > >>
> > > >> +    for (i = 0; i < iter->levels_nr; ++i)
> > > >> +            if (iter->base.st.st_ino == iter->levels[i].ino)
> > > >
> > > > This does not work on Windows. [[ Windows port does not have
> > > > usable st_ino field ]]]
> > >
> > > And if you cross mountpoint, st_ino alone does not guarantee
> > > uniqueness; you'd need to combine it with st_dev, I would think,
> > > even on POSIX systems.
> >
> > Ok, thanks for letting me know. I'm trying to think of another
> > approach to test for recursive symlinks that does not rely on inode:
> > Given any symlink, we could get its real_path() and compare it with
> > the path of the directory current being iterated. If the first is a
> > prefix of the second, than we mark it as a recursive symlink.
> >
> > What do you think of this idea?
>
> I think this would be pretty expensive. Too expensive.

Hmm, yes unfortunately :(

> A better method might be to rely on st_ino/st_dev when we can, and just
> not bother looking for recursive symlinks when we cannot,

What if we fallback on the path prefix strategy when st_ino is not
available? I mean, if we don't look for recursive symlinks, they would
be iterated over and over until we get an ELOOP error. So I think
using real_path() should be less expensive in this case. (But just as
a fallback to st_ino, off course)

> like I did in
> https://github.com/git-for-windows/git/commit/979b00ccf44ec31cff4686e24adf27474923c33a

Nice! At dir-iterator.h the documentation says that recursive symlinks
will be ignored. If we don't implement any fallback, should we add
that this is not available on Windows, perhaps?

> Ciao,
> Johannes
