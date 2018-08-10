Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D03EC1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeHKAeh (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:34:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:36113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeHKAeg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:34:36 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lbujs-1gDit92JtM-00jI5E; Sat, 11
 Aug 2018 00:02:47 +0200
Date:   Sat, 11 Aug 2018 00:02:49 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/21] range-diff: also show the diff between
 patches
In-Reply-To: <CAPig+cQ9DcFPosPcjo6MbF_sF9DXuZQ_gZe5jxyx0vbH932sdA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808110001150.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com> <20180729190359.GD2734@hank.intra.tgummerer.com> <CAPig+cTuD0+8etdMLu8FkFVxnXUM218taxU9in-fe3QXhDj5WQ@mail.gmail.com>
 <20180729214543.GD9955@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1807301826480.10478@tvgsbejvaqbjf.bet> <20180730212606.GL9955@hank.intra.tgummerer.com> <CAPig+cSeAUWFCBEbk0m7_gmATAaVDg-fi42kq49DuGm3g0L4=Q@mail.gmail.com> <nycvar.QRO.7.76.6.1808102308140.71@tvgsbejvaqbjf.bet>
 <CAPig+cQ9DcFPosPcjo6MbF_sF9DXuZQ_gZe5jxyx0vbH932sdA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wvDe8x7+CbZlzJz9C7MjjHPfIu0tvo24G5HLpRbk9CW9wzwMhgr
 lRf8RBWtxE/QTPUEHP/KD3O0fblrm+UKixd3RYXeX65hTFQ/yZwFcpDCWE7YzZ6q0pH18dz
 UGCKvlashhmPB8KjZb4NehwCtNHz6mY4TNDfUg8Sl0hCBOU6sREGpeLXxi7ni0o/JoX9HjM
 f9Sf4a3IfUUo4H78rmnpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UFa1DS5dEHg=:ZEG0dD/9DmzlL2AWmiOfzQ
 0hER9orcAm3d2by8L/3onjRPnLpSBNM+VOBjcd3I9bA/+c59Pc2xYwHy4bfHcKWWM4VAF4loz
 r34hTvGu/7OOXL/B2yiW20p+t6A5Eu+gBS1GxTnyZj9O/sm5UNUZf/Ow1ebOFrso8Pw8IwTpx
 ajASOsPI0UuVplOgZH/lgfxEAE7jLj2r1RdMXBqjynmcfx5SefJqFBDzAiM4gbgcIbGQiPY87
 LY+J8YdNtLsdmbn8+dzkc88bdGvnR5v9ZODRTIJbb0qiP9xZqtoWaV0VXOH2qBdOa+ykuvXNI
 L5n77S0VxZSevvj3KsD4SYs/i7zhliEjK6b7KQ3A8BuWurgco8PAJd/guQGyG435KeuJXAQth
 hepAiZRSuyHDphiXyn61dQ5aTQ3xWZTv4EJMfbbrwy6SEa7o4qIzcW8NlaibBrzPLAqxW0dYY
 XkQUDnMjDgmJQfHbFLk/9GfEkQy5wfhTqa/EDfRKK8OFtNYpwBI7Zdo1GMJIpK6+l7s8wcu1O
 mevVN7W1d34M6g/z0xnd++cXEHWx35sr+vdQsJiHRyKMz9Fz5WZhbnsV37OJtNhFCEqC8JRvq
 umbYxVDV4Pr7ttNUo4L9SNuSsbvxsTAvkeggp6kHZTR5UifKgKHVuxiravNR4Qt7QFqN7IeiQ
 RoPqkD6LbKLBZMwe3NRyvCSq9m/Bufapth6Ir0I2KwNT1eWzgLhZdaUvdSiIaRsNJZe0pXHQS
 Rr8+YXRzbDc/ZayxKMYTH33NkWCeEOCXn26spppsPfW7w3ElE3IlH04g2nkFu0V7Eyt4E06eF
 sH9UyXS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 10 Aug 2018, Eric Sunshine wrote:

> On Fri, Aug 10, 2018 at 5:12 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 30 Jul 2018, Eric Sunshine wrote:
> > > I think you can attain the desired behavior by making a final
> > > parse_options() call with empty 'options' list after the call to
> > > diff_setup_done(). It's pretty much a one-line fix, but can probably
> > > be done as an incremental change rather than rerolling.
> >
> > But then we would have to keep `--` in the first, and not in the second
> > parse_options() call, right? We would also have to handle that `--`
> > properly in the loop that calls diff_opt_parse(), I think.
> > A bit more involved than just a one-line fix, but I guess I'll give it a
> > try.
> 
> It's something that could easily wait until after this series lands.
> After all, it's just a slightly confusing error message, not some
> fundamental problem.
> 
> As for '--', I'll have to go back and look at the code. I thought I
> had thought it all through at the time I made the suggestion, but my
> brain needs a refresh by now.

Your suggestion might have started out by trying to fix the error message,
but after staring at the code for a couple of minutes, I think the issue
would have left all kinds of opportunities for bad user experience.

So I fixed it ;-)

Ciao,
Dscho
