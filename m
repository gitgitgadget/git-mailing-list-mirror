Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321951F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeHJXni (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 19:43:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:49507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbeHJXni (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 19:43:38 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQ7sF-1fstGs2G7n-005LLG; Fri, 10
 Aug 2018 23:12:01 +0200
Date:   Fri, 10 Aug 2018 23:12:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/21] range-diff: also show the diff between
 patches
In-Reply-To: <CAPig+cSeAUWFCBEbk0m7_gmATAaVDg-fi42kq49DuGm3g0L4=Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808102308140.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com> <20180729190359.GD2734@hank.intra.tgummerer.com> <CAPig+cTuD0+8etdMLu8FkFVxnXUM218taxU9in-fe3QXhDj5WQ@mail.gmail.com>
 <20180729214543.GD9955@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1807301826480.10478@tvgsbejvaqbjf.bet> <20180730212606.GL9955@hank.intra.tgummerer.com> <CAPig+cSeAUWFCBEbk0m7_gmATAaVDg-fi42kq49DuGm3g0L4=Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UB8EwvtW7DutpPjV8aDZgfCiw1DgHyp6CQVfME3RXU2CZw07/I3
 Pmw4k046wOogd+t7Ogp3yN2E0twHzxNejr7XxfpW+e6fRa8+4WFzuIW4o/Ivd20mykFrSUk
 ywEwardktRY77Ve1jZi6k5hs8KFpDcpoREuY6gB0xcwaUqs1+SEZ1u1jHP+avnuQQI3Gcbh
 yrW4bp1YKVGAQOtq3buYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B8oxtJY/M58=:7prstC5Ng0/pe/MzGkxDYv
 w8kWy+mQZa0rufdyum7MuhDqSoLbN+A0Ciw2sUMzutc2QA+BN7HMNGSrKok2BNVcyjYHbh4sM
 lXrstqr9TP4MD3GYWToAFeV1esMmSOLXH4IjZ9atpRDkW1VIC8koyZkK3ZqwdBRAzkeeq+BU9
 l+8iEZSLO++3ERwingo0KRXwCkiL/cx4Jobyujvxo8U8yNuNawfgiAnYSJQNMWJ7uOyxvPpW/
 4DRhsC5hSIzlBUzy/EU19JvfDaPSeharpFEs2zOCZE7CsdR8fEwIjfY5OHhkzlt3AuZuhBU9n
 eZ6ZLpnWePFC71YjJJrOUS+zEXtEOYHfOO2s/U0QZJhhsiK98nXvRqRKWjlfd+z+yFHEe+6pq
 pEpw4xTBa3npl+KpZW4L7O2xUTWiXdPZYT+hGEL/HlWxPwNCVstJrpPNJZrot+Uz6p1uIVVrd
 Bw1M25uQgcTJKexyCWfjL0BgNtVwILucB8MCBnRsv4myequm7yaIW+KXbth5VEGo9FpBjaYy/
 JixmqAo7eKwnHr7qIEUPPB70EPuFvzmHWyg+n10JPEz/AyUHFrgsgFYOVwHKLCkqaVff6+5Oe
 QRVDpDxVg2BQooK+b+8uO7FJs0YFx9gJjwoJWXoKAAJ6dK1WMbn+FkkSuQj1pvZLNJVNrK/f8
 JONcJg088PAcoxBYwZV/tMlh1vv2OXhE3sqxhO1UlQfof97xS0l1ZcBWG92Zz/smDolPQA59k
 ZiKT3feZBpQ5wochIhY0RR9e4kx7blM9hdKy3gdGNyXNfpSZmIbzgTwEQMySItMWz7b1/ht0A
 N3jgatq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 30 Jul 2018, Eric Sunshine wrote:

> On Mon, Jul 30, 2018 at 5:26 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > On 07/30, Johannes Schindelin wrote:
> > > On Sun, 29 Jul 2018, Thomas Gummerer wrote:
> > > > There's one more thing that I noticed here:
> > > >
> > > >     git range-diff --no-patches
> > > >     fatal: single arg format requires a symmetric range
> > > >
> > > I immediately thought of testing for a leading `-` of the remaining
> > > argument, but I could imagine that somebody enterprisey uses
> > >
> > >       git range-diff -- -my-first-attempt...-my-second-attempt
> > >
> > > and I do not really want to complexify the code... Ideas?
> >
> > Good point.  I can't really come up with a good option right now
> > either.  It's not too bad, as users just typed the command, so it
> > should be easy enough to see from the previous line what went wrong.
> 
> I think you can attain the desired behavior by making a final
> parse_options() call with empty 'options' list after the call to
> diff_setup_done(). It's pretty much a one-line fix, but can probably
> be done as an incremental change rather than rerolling.

But then we would have to keep `--` in the first, and not in the second
parse_options() call, right? We would also have to handle that `--`
properly in the loop that calls diff_opt_parse(), I think.

A bit more involved than just a one-line fix, but I guess I'll give it a
try.

Ciao,
Dscho
