Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2CA1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 10:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbeKFUIU (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 15:08:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:57869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbeKFUIT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 15:08:19 -0500
Received: from [10.104.164.49] ([194.69.102.49]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkBPy-1fngHl2ff8-00c89R; Tue, 06
 Nov 2018 11:43:35 +0100
Received: from [10.104.164.49] ([194.69.102.49]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkBPy-1fngHl2ff8-00c89R; Tue, 06
 Nov 2018 11:43:35 +0100
Date:   Tue, 6 Nov 2018 11:43:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, lucas.demarchi@intel.com,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
In-Reply-To: <87efbz6xys.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811061140560.45@tvgsbejvaqbjf.bet>
References: <20181105200650.31177-1-avarab@gmail.com> <CAPig+cThS8959jW9+X7bJHy5RG9Uoj4=V8ahjf2zGetTNw03SA@mail.gmail.com> <87efbz6xys.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-748378151-1541500996=:45"
Content-ID: <nycvar.QRO.7.76.6.1811061143310.45@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:VOXiGllxc6fqTVtZPu4wZRNebqusL2k46BW4wpEi5Mx92XsL9RB
 TLUlY4xZdFaXeMCldhsu4exhMq2JgC4HJ9231fRRz8mBwNnWzEH7D92mhETJMjdNvkbUm+R
 uipqGiK10SVnvnWgyExuSCNQbHgLD0ROFd+KiA/pYLDtgQMBEVss6nt0GSeb52GCg0/Kzjk
 5Ic9tV2DByqDBDNqcBhNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YhQZ4x+6G4o=:DiLZ+gREwZuTdU0aHw0B5u
 6NTo8frEZwFzihKAlDEkokIIxAlkzmoIN4tkL3d5sKqJZRQegSISH99PAO9/6o5sarJXCgh3j
 XvvW61bIloOeGrAkZjdouryV4yR92GFQo/osGa4o/0+VtPqunWG6578QY5m9Hh4Km/onf8eWT
 HVU+x2fUseJxdW6UyOFg+6Cqw3PyZN1Mc5StrKvPH76HKC/ga1+KAYhvAdxEDl38MJMd4Kp1P
 qzZz/fPJ8HrRAdFcESBQNgtBXthE4O+o7F2vzq9KjUzpRT4paBJxHCpntGlLaANoSXT9nFLlW
 GUj7wpEOZlDvDstjmaYR9DABr3bONWSL234zG92ivsZ87kAzk5LjKAWdTSeuNYvgqfKixrgiW
 ptQTO4Kp5zi+9EjIJ8ajwSuKQybJZBcuITakjnD1RVMeqtYdFRSXInEW/f8364DljIj1hN9xb
 PstylL3DoG6NekfogPUQdezvCos0y2ZnWBbAD7V2yrGN5EqX9Ljm10Lb4bzg9neJr0XZevOgE
 BqVPSapOi7xaqUu7fr+ZKGKuXAVVEPqDA8zl/Bc6QI6sOUe/6O7h4JO2ICAAqF4EMIIYbhDJQ
 eX8NaQuTdxO8s7wEUidWwEUtcD3LeADoniTSukdV+4FZyizzG+PGohyrSD/aGOhlHwJrmnaud
 9GmSiK4QION0sbk8sYbxHP9zQT30jA+49RC/0SJhvk8aV6zgyG13KLnDQ6eZm78XhAa4fKf69
 jSGCs+dCrmLlPR2wteWJ0PB9k40HCIvPdODkUZRSLl+mgV2k5QmSgzZhtXrtwpqqYm9KQRxKk
 +4DdyigDwKFpu9SjnGlWEMxEY/nbM5bXcwWZjkn9HTYPrwfIvYSFB2gpPPdNharSjiPPiwHE0
 uplhwUpddawtv1L4n9wnkT6jaZTzIjfTmW9f7wbZ3jmKrNv4Rtx+xxBSPek+KzWxl2xbxV/7M
 namfNV53tvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-748378151-1541500996=:45
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.1811061143311.45@tvgsbejvaqbjf.bet>

Hi,

On Mon, 5 Nov 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Nov 05 2018, Eric Sunshine wrote:
>
> > On Mon, Nov 5, 2018 at 3:07 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
> >> Add a --no-patch option which shows which changes got removed, added
> >> or moved etc., without showing the diff associated with them.
> >
> > This option existed in the very first version[1] of range-diff (then
> > called branch-diff) implemented by Dscho, although it was called
> > --no-patches (with an "es"), which it inherited from tbdiff. I think
> > someone (possibly me) pointed out that --no-patch (sans "es") would be
> > more consistent with existing Git options. I don't recall why Dscho
> > removed the option during the re-rolls, but the explanation may be in
> > that thread.
>
> Thanks for digging. Big thread, not going to re-read it now. I'd just
> like to have this.

In my hands, the well-documented `-s` option works (see e.g.
https://git-scm.com/docs/git-diff#git-diff--s), although I have to admit
that the `git-range-diff` manual does not talk about the diff-options.

And for the record, for me, `git range-diff A...B --no-patch` *already*
works.

Ciao,
Dscho

>
> > I was also wondering if --summarize or --summary-only might be a
> > better name, describing the behavior at a higher level, but since
> > there is precedent for --no-patch (or --no-patches in tbdiff), perhaps
> > the name is fine as is.
>
> I think we should aim to keep a 1=3D1 mapping between range-diff and
> log/show options when possible, even though the output might have a
> slightly different flavor as my 4th paragraph discussing a potential
> --stat talks about.
>
> E.g. I can imagine that range-diff --no-patch --stat --summary would not
> show the patch, but a stat as described there, plus e.g. a "create
> mode..." if applicable.
>
> This change implements only a tiny fraction of that, but it would be
> very neat if we supported more stuff, and showed it in range-diff-y way,
> e.g. some compact format showing:
>
>     1 file changed, 3->2 insertions(+), 10->9 deletions(-)
>     create mode 100(6 -> 7)44 new-executable
>
> > The patch itself looks okay.
> >
> > [1]: https://public-inbox.org/git/8bc517e35d4842f8d9d98f3b99adb9475d6d=
b2d2.1525361419.git.johannes.schindelin@gmx.de/
>

--8323328-748378151-1541500996=:45--
