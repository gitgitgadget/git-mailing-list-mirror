Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB1520248
	for <e@80x24.org>; Fri, 12 Apr 2019 08:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDLImH (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 04:42:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:42849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDLImH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 04:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555058525;
        bh=sqKQd9bLEi1ecY/yUzisxQ6n8YKdF58RYWa6GRSOiuE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FTBFF+PL8JrL3kYz/8sNJ72WpoO/u1CcXj1HaZHK94BhdQ/xUTDoWLS7AwsjE4ch5
         pF4P3al8nkkpaZ+4RyOIUQdJXnPgScmf/FfOC9prDUaN2SkNX84MU6b8p6KXa3F8Gp
         92brq+fsQRtWLZuQhIhKjf53SGYdVSzjwzooylms=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0y47-1h1Rdi1Kpj-00vBCE; Fri, 12
 Apr 2019 10:42:05 +0200
Date:   Fri, 12 Apr 2019 10:41:49 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: incorrect range-diff output?
In-Reply-To: <20190411220532.GG32487@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1904121038540.41@tvgsbejvaqbjf.bet>
References: <20190411111729.GB5620@ash> <20190411220532.GG32487@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ynVa743J0af+OZvDuaF6maWVA6nVPpyvUvARaE3qCwBwPBEj8gv
 A3WXmKK7/UV6j88CA7CdoqbgGEaUemVg5mT/8G8zc1JObZMrLPAM1np0JQ3NSKC6R37jSs6
 xWXawEJb689neFjaWRv6BFQFQfnHedpcZNo5RiL4UHiMNuTli/itOTK3WQqV8HmHsVRsllW
 KsPR19ro9EcwbEwruIdcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tmRzE3jOyOs=:MPI+UyCl28n7vNoWXlncdU
 uLpYc/o6qxHbSFhBWak8Dm7jmxiz46NwrAw/SINamqPbaP4pgLhFT0AXcDFjg5kErk8SWyYUa
 hcoWX8cCAEzLo/OrINYYWYa8164f79KzEh3awfqtfgkXuYdZ5dAq3Biy5TJvKy+yrOnmZusuB
 kA5K3cEqFxfYP8whBorMCI7jOGN5CavDUgQUrDRXcABAbRC3vCMrs6K9olP9+QV4Ma2WcwOLR
 lNqx9FpaAFwXYoazXZNMrSgmILzC55BeGattls9hBDmSmDxDojNeEHQ0JlUmpt4cYjU0x/oFM
 hTt4wseg+g0OHrnPQtZgxE+q2vfgoexBufXVeOfaxFfuHxYEQc/qoD3LoJe/aBtgoz7VYOh4e
 26iRdBDUXGdtX7v1NaUnwOje0Iq+DA21BOMR6mzkkpi3XsjfXQ7tsoJJ5AP/DczAWjoDItSna
 mNaUDqCxYMkPsEitPhkWY4WunOdI9EIw1btc8hMHkygnBeK3L0oyLkcE9zbEqU5IYJAHcQ6b2
 gkf4o6cQgv/mKvsWhMfMhM1i7E6AQIqKYwOl5bwSf2OVgqTclG5F0XZb+PU8M7OMkQ8nrDqSE
 4R9GSqAdcFR6mAmEMXaEohue57q3ll7DIYHyu7wEuoF3vMMlL7+aqKWi8hsbAghDskiZDk7L8
 ffNKWhRmlCcL+VNSTC6GdxWQ6MWbPLdhuywV0xOAKnZdAASw/af7foGSZLeuc2y2++nlo0Cud
 mhKPCKav2mGL2/Tv+olGXzZEi73F4+GbEAMU5Ro7DzS1VZ+q3OUwnvaqSHLFX9RB46FvS+UeH
 pWoWoBCpOLTvrh6pSZptqYzuKT6ILoI9j1dvgo0zklCP6ceYt8q5kPbYqwMajLV7VbsZioFYp
 laTT+Ka3+oEwK6ayX41PENayzZS6NWnumwvqpfRX8ut2ym0+T5OZ7/KC/yozKzpxET88J3MzS
 +mfptX+SL2g==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Thu, 11 Apr 2019, Thomas Gummerer wrote:

> On 04/11, Duy Nguyen wrote:
> > Try
> >
> >     git range-diff from...to
> >
> > with those two branches from https://gitlab.com/pclouds/git.git. The
> > interesting part is this
> >
> >       diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> >       --- a/Documentation/gitcli.txt
> >     @@ -120,10 +111,11 @@
> >         * linkgit:git-commit[1] to advance the current branch.
> >
> >      -  * linkgit:git-reset[1] and linkgit:git-checkout[1] (with
> >     -+  * linkgit:git-reset[1] and linkgit:git-restore[1] (with
> >     -     pathname parameters) to undo changes.
> >     +-    pathname parameters) to undo changes.
> >     ++  * linkgit:git-restore[1] to undo changes.
> >
> >         * linkgit:git-merge[1] to merge between local branches.
> >     +
> >
> > This particular hunk comes from giteveryday.txt, not gitcli.txt. And
> > the b/Documentation/gitcli.txt line is also missing.
>
> I think the output here is technically correct, even though it is very
> misleading.  range-diff doesn't currently show the filenames of the
> diff that changed, which makes this a bit hard to read.

True. In the spirit of the "funcname" feature of our `git diff` command,
we could add some (abbreviated) form of the corresponding `diff` lines
(maybe just the `a/` filename? Or maybe the `a/` file name, prefixed by
`-` or `+`, and if the `b/` filename is different, `old->new`? With
`/dev/null` substituted by `(new)` or `(deleted)`?).

> [...]
>
> Maybe I can find some time over the weekend to tackle this, if nobody
> else gets to it first.

Good luck ;-)

Ciao,
Dscho
