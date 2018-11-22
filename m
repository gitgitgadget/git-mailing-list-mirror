Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2781F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 12:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436645AbeKVX2z (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 18:28:55 -0500
Received: from mout.gmx.net ([212.227.17.20]:37301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403786AbeKVX2y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 18:28:54 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1nOg-1fabfm25Fa-00tm90; Thu, 22
 Nov 2018 13:49:12 +0100
Date:   Thu, 22 Nov 2018 13:48:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, mhagger@alum.mit.edu,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, dnj@google.com,
        prohaska@zib.de, john@keeping.me.uk, stanhu@gmail.com,
        richardc@unixbeard.net, Joey Hess <id@joeyh.name>
Subject: Re: [RFC/PATCH 0/5] stop installing old libexec aliases like
 "git-init"
In-Reply-To: <20181117063940.GA31057@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811221344360.41@tvgsbejvaqbjf.bet>
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-1-avarab@gmail.com> <87k1ld1f51.fsf@evledraar.gmail.com> <CAMy9T_EVh5Xa7wZFRSM+uGAKV7WSPRALRRaZhPaj_bg9v7Ohfg@mail.gmail.com> <87in0w25gc.fsf@evledraar.gmail.com>
 <20181117063940.GA31057@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-846795222-1542890952=:41"
X-Provags-ID: V03:K1:K1D+FFW5ePxStCIJUHb41ckif8AoHjXu1aqOIQkm3hNz37d4Vv1
 +xOICfwxghfEB/RyNp89A8aTBQzcLIMYqQNR8X0QzYTBJoV2kg0jxnV78Gv3MPQSQJPgpeb
 TFG5ykekFMihky82U1/jD/3bMNqscBNRk4L3EC8atuClDkGQZg3pGGSybjAXHB8iOsUBVmK
 tJOgSK2Ez45Ejvk1RtyrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:geEK5vVXdgI=:/NbaHv1rGF5RRgJLaNNNSd
 33zMRQhHW18DALQxSjkUlGRzr+nWwTYHy/1/q3FO2pD+J2VPmtVadHwCKl7CfK/kchpkWHeJx
 rDqlucxYou9T1tC7/8rV0+9LvxqblMvTjYU82Iq9MnhrjggY/6Bxd/U/ttTNvymSSZAf983vg
 caxdE98jU4Y9VMzatCJjzvTLuHSkaylEC7BsQ6Qc9KoZUbS7ljxdmgnubKL75rv5sMDY3JuzY
 jQlZVpSt2lv5Eq+C5+ODFjTxFjXDWChPJbCTUTnh8zPYTThrYdNE7m5M3nLRVIgWbcwYAw5TP
 WrHQonREHC9MUfukcfC5pDUnIYPCpE7kiOzWoYhOBFvAKm2+OR6iUnJC8Spd4bhaXXF4f/rGT
 qpgxgcauyyukTjFx+zCwt/JWHuw9mhsDLti/LbydILkxpXmvRC/ueBwY6ic2fWyya2GGBb42l
 1+HKhmKPliv/0QZ2Zkej2Y/6HBfjJlfpw472scIREAX5BJBTyMiSh1y3dmV8BLvpsxaFNInDH
 6reih+Ylbs9+S46djnyino/vnFwzlfZhVI8SXIezSV2rGjxwEJti7pRZEkfYpD/iN+nPXDmZx
 SdJQ/5d5kUuSxCWf51UBKgUlxjQfFVjBMSZvOZRV5Nnu287L7GV+34jCEfmTKGpH9ZFdoaHtZ
 3QnQOCFWaDRwwgeJuFgEjYmzJ1DFhjzk8KTUfJb94zVhZ3hzOpD6WjjxKGk/SyBgTKlZAuro3
 5O1GxSq/ErH+673b5RB3J7UT33Xej1lvy3JC8oVPVaH0YP3Q+88HCJdV7V6OI4Wx1SYJaxMc0
 yoi1wZl6E5z4xLxwUgEUQLABZz3qXYi9fTU208aOf3Pt9C2IanidBKkVgrrzDohcCRhjz/UxJ
 74rA2+6//lmF3e+H+qXfCMGHp/gCKft8OYYjJTEA0abKHknKJKts23Z5ilAJtI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-846795222-1542890952=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Peff,

On Sat, 17 Nov 2018, Jeff King wrote:

> On Fri, Nov 16, 2018 at 08:22:11PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> > So maybe we should just document this interface better. It seems one
> > implicit dependency is that we expect a manpage for the tool to exist
> > for --help.
> 
> Yeah, I think this really the only problematic assumption. The rest of
> "-c", "--git-dir", etc, are just manipulating the environment, and that
> gets passed through to sub-invocations of Git (so if I have a script
> which calls git-config, it will pick up the "-c" config).
> 
> It would be nice if there was a way to ask "is there a manpage?", and
> fallback to running "git-cmd --help". But:
> 
>   1. I don't think there is a portable way to query that via man. And
>      anyway, depending platform and config, it may be opening a browser
>      to show HTML documentation (or I think even texinfo?).
> 
>   2. We can just ask whether "man git-sizer" (or whatever help display
>      command) returned a non-zero exit code, and fall back to "git-sizer
>      --help". But there's an infinite-loop possibility here: running
>      "git-sizer --help" does what we want. But if "man git-log" failed,
>      we'd run "git-log --help", which in turn runs "git help log", which
>      runs "man git-log", and so on.
> 
>      You can break that loop with an environment variable for "I already
>      tried to show the manpage", which would I guess convert "--help" to
>      "-h".
> 
> So it's maybe do-able, but not quite as trivial as one might hope.

A trivial alternative would be to recommend adding a man page for
3rd-party git-<tool>s.

In other words, as soon as `git-sizer` is accompanied by `git-sizer.1` in
one of the appropriate locations, it is set.

(Actually, it is not: on Windows, it would have to add git-sizer.html in
the appropriate location, but we can deal with this if needed.)

> > But I don't remember the details, and can't reproduce it now with:
> > 
> >     $ cat ~/bin/git-sigint 
> >     #!/usr/bin/env perl
> >     $SIG{INT} = sub { warn localtime . " " . $$ };
> >     sleep 1 while 1;
> >     $ git sigint # or git-sigint
> >     [... behaves the same either way ...]
> > 
> > So maybe it was something else, or I'm misremembering...
> 
> I think that generally works because hitting ^C is going to send SIGINT
> to the whole process group. A more interesting case is:
> 
>   git sigint &
>   kill -INT $!
> 
> There $! is a parent "git" process that is just waiting on git-sigint to
> die. But that works, too, because the parent relays common signals due
> to 10c6cddd92 (dashed externals: kill children on exit, 2012-01-08). So
> you might have been remembering issues prior to that commit (or uncommon
> signals; these come from sigchain_push_common).

FWIW I do have a couple of scripts I use that I install into
`$HOME/bin/git-<tool>`. Although, granted, I essentially switched to
aliases for most of them, where the aliases still call a script that is
checked out in some folder in my home directory. The reason: this works in
more circumstances, as I do not have to add `$HOME/bin` to the `PATH`,
say, in PowerShell.

So YMMV with git-<tool>s. My rule of thumb is: if I want to use this
myself only, I'll make it an alias. If I want to ship it (e.g. with Git
for Windows), I'll make it a git-<tool>.

Ciao,
Dscho
--8323328-846795222-1542890952=:41--
