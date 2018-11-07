Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806F51F453
	for <e@80x24.org>; Wed,  7 Nov 2018 10:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeKGUZy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 15:25:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:42631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeKGUZy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 15:25:54 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjZn2-1fnDbW35y4-00bZTK; Wed, 07
 Nov 2018 11:55:54 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjZn2-1fnDbW35y4-00bZTK; Wed, 07
 Nov 2018 11:55:54 +0100
Date:   Wed, 7 Nov 2018 11:55:52 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, lucas.demarchi@intel.com,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
In-Reply-To: <nycvar.QRO.7.76.6.1811071142100.39@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1811071144140.39@tvgsbejvaqbjf.bet>
References: <20181105200650.31177-1-avarab@gmail.com> <CAPig+cThS8959jW9+X7bJHy5RG9Uoj4=V8ahjf2zGetTNw03SA@mail.gmail.com> <87efbz6xys.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811061140560.45@tvgsbejvaqbjf.bet> <874lcu6vr4.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1811071130570.39@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1811071142100.39@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1737995999-1541588154=:39"
X-Provags-ID: V03:K1:7+ACE3YJcuQPxx5EHO+9TJMC+4yZy0hbHvCnySFIips6XM26NmN
 7H/9EQfJFio14+FP8ajUhgu79KkvkR7HsQxl5CfdR8oiaNDZdpJ22lw7JCGhh2Ti49XZTWL
 GWHWAVhh7L51fWdo2B6Amawj+pdMIsbPsdxodCgqjea3aCtEVYbPhqrDbXAk4HYa6K9VvIH
 LpxJzRvdhQl4Mn+rbS0DQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wRvea6PqXSI=:5ZJZoX64jd2GDM96E+I47z
 b7AQvmDnoPt464qvUnW9sXZedcAKiLQtN9j2MSo8meJi3hqBIvIHzvnAVbS/JWY4daiczbU8O
 pFVgpI7Y4UISmLzHlw5/441o//TCzOQUpQdHw4KZCZlSwe4oUX6FqcsPmN9BDV7SbVwZMht3e
 eTIEGIZWD+jTrHhKiA+80L6ZDKO81XRcK9xEy2lLeFwjbILb3qz7A2j7a3CistrisOAmiJj41
 xKMSbdjs12hbL7KjBvuc5aXtebvR16pnvcjHx3Y+lbGDcLgHHsvGW+1+45+iVT6NzWMTRplrb
 hwO3s+BTYfKEcaUA3BLNrfWYgDpgxe/9RsMnS5KywHT83lZD2jGUNBed7x2LniniaaUanNdUO
 4XuOPxTGuiDWn7cx5HgiCZ3k0slwRLqvZm3oGNz7xJoEdLZSFfhLjyrRveFatil+ioztrxQsf
 qtOmctPu327UK7fccGBWFlC3+lkyu1yvW4FCG48e8fR9hRa7DWhXPuGKJRvkPKIbrGGYJuQlx
 gaFseLRr8NIeCFRN64RuL9/OF8YaIlCi/pRkKzF/mpSC7oDK+AlDgCl04JEqN8ZidAy5ROOaU
 /sNtzCKE4lS2tKHhC7yhW8ovMZk7sI9weMuI+fPCEQYsfigw1OYuwv4167s83ztxVvlNmFVbn
 wEUVJlWzuxcujtYo4JhGqDUWi/LpcLJ9Pt3vgwBBAzQ7kRHwWikeyIEwdOZXtCuO4ROWMCKMo
 pFPP7kqukhoE/TcllNhS4h+EkZxgeyDNtjz9OXOWYaNpzSAAtyBpOjma3BlSVP8OmtCU7tvGV
 CW3sbQiLnjuo7BH1xBpk6lFna7t72Lk/+317K2jsV0sjntrePy+H1VhrP90RKL6IYnx7jXX23
 VHSfUOA1n8aVoMizmSLR40eRgB9zv2DuB8hJliZc6E/K69eA7iMiP/SRjwMARgVmcB3ohY6We
 v0e/TTqoNoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1737995999-1541588154=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Wed, 7 Nov 2018, Johannes Schindelin wrote:

> On Wed, 7 Nov 2018, Johannes Schindelin wrote:
> 
> > On Tue, 6 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> > 
> > > On Tue, Nov 06 2018, Johannes Schindelin wrote:
> > > 
> > > > On Mon, 5 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> > > >
> > > >> On Mon, Nov 05 2018, Eric Sunshine wrote:
> > > >>
> > > >> > On Mon, Nov 5, 2018 at 3:07 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > > >> >> Add a --no-patch option which shows which changes got removed, added
> > > >> >> or moved etc., without showing the diff associated with them.
> > > >> >
> > > >> > This option existed in the very first version[1] of range-diff (then
> > > >> > called branch-diff) implemented by Dscho, although it was called
> > > >> > --no-patches (with an "es"), which it inherited from tbdiff. I think
> > > >> > someone (possibly me) pointed out that --no-patch (sans "es") would be
> > > >> > more consistent with existing Git options. I don't recall why Dscho
> > > >> > removed the option during the re-rolls, but the explanation may be in
> > > >> > that thread.
> > > >>
> > > >> Thanks for digging. Big thread, not going to re-read it now. I'd just
> > > >> like to have this.
> > > >
> > > > In my hands, the well-documented `-s` option works (see e.g.
> > > > https://git-scm.com/docs/git-diff#git-diff--s), although I have to admit
> > > > that the `git-range-diff` manual does not talk about the diff-options.
> > > >
> > > > And for the record, for me, `git range-diff A...B --no-patch` *already*
> > > > works.
> > > 
> > > Neither of those works for me without my patch. E.g.
> > > 
> > >     ./git-range-diff -s 711aaa392f...a5ba8f2101
> > >     ./git-range-diff --no-patch 711aaa392f...a5ba8f2101
> > >
> > > This is on current next, 2.19.1.1182.g4ecb1133ce. What version are you
> > > on?
> > 
> > I tried it with git version 2.19.0.windows.1.
> > 
> > To verify, I repeated this with `next` (git version
> > 2.19.1.1215.g8438c0b2453a):
> > 
> > ./git range-diff -s 711aaa392f...a5ba8f2101
> > fatal: unrecognized argument: --output-indicator-new=>
> > error: could not parse log for 'a5ba8f2101..711aaa392f'
> > 
> > Which means that something broke rather dramatically between
> > v2.19.0.windows.1 and 8438c0b2453a.
> 
> Nevermind, this was solved by passing `--exec-path=$PWD`. And *now* I can
> reproduce your finding.

I've bisected this breakage down to 73a834e9e279 (range-diff: relieve
callers of low-level configuration burden, 2018-07-22). Eric, that's one
of your commits.

Ciao,
Dscho
--8323328-1737995999-1541588154=:39--
