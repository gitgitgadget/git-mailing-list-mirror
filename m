Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01181F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932529AbeA2U2e (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:28:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:58421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932485AbeA2U2c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:28:32 -0500
Received: from [192.168.0.129] ([37.201.193.1]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZkic-1eKt8O0Sn0-00LXSB; Mon, 29
 Jan 2018 21:28:26 +0100
Date:   Mon, 29 Jan 2018 21:28:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Philip Oakley <philipoakley@iee.org>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <F2A95961E128479484699EC5DDC9243D@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1801292126030.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de> <CA+P7+xozcQD2xuys6mh8MsfcYZ_nb2c9yxhDxkc7FTN2SfoofQ@mail.gmail.com>
 <F2A95961E128479484699EC5DDC9243D@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ETMvmb6R2LtRTVhET+OaXud1736T/L6ef8CQEeW0r/IsYG4Mttx
 gNoBqYFRkkNt/tx24JUDV57eQg0fMtIcs28laVCTvUDOpGDi1UGwySkgNGCS21hxcHusZMu
 gP7MciYYSVhZ/ZNSQNsufvkHrYGeYuOUhuj4lG2JfCzCDxjbQ6z6hECc8iOcUU7WbG78fCU
 DHIXTdNmtK3Ak7COxro7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t85bvagk30Y=:N4p6d4T8ep37J/lleQ2qEJ
 rz/p2iHmbA+B/MuLE1MMuapfji2itTMT/woHwXZSaLCf/nbxoIYoD72yGutZCW7TDpO+opHMd
 afmy3PmpY5+Eee2tpzE8xvCEvjf6jB7Ljq8pLAb64G6HH4p8JqzJ0yPZi6nLFXUhX6wnWO3r4
 hXpMU7tsvPxefRFvP06GoqfjuBFq46I8ZXM7prKSo1j/BxZsvsXo2G1oZ596JKgen5mJCBbix
 i/2dLdA61Y3EromH6D3hq2uWTunLMOGOBMn7H+j7fXgg5w/Xiqm5SHZV9cKPa6nVmaHL0y6GD
 kp5X7b+L3cFQEApMrmsfNONsFi7ZBqogLRMis2Nzaaz6WFISZQ+0SBGOwySSR/nHZhPT7j8e0
 BCuTnrBjJ5JuyG47qWiNZnJ1BaiqHIfdi60DrfCib5XOiM0ncmBFnOhiZc3B34xbGpVjEEJ1G
 4jZQXqESlBhyqr0DUh4qnSjquLjTIf49mkntFyhpHZ0LDPHIsBP7rszJUbheFswWZo1VCZ2Ys
 Emw5kozrT3ZDdHDjs6QunZTGxxsysQZd+4O9mx7AFwOh9EQL4BuO9lWqq/myoxEDPPCO8U6QY
 x6SjjjbNR6WVcN4ehsGUbDXq4Z8az1dpNu/c7koroOsSUc6MupiXHVhwejmBYSHSzKgZf8Ssp
 SKGLMXxYpgzGGg5hlKoFBgZ8vqdXpQmeOmt7uhuyoHVeHEqgnhXpVOc+aGVAppOqz20pTkASE
 v0n+rj5ziOD3uOgkoYmsioLskhrQdDnr6fjXdC00Rw/eeamrMosWg3GOBGozilGJAq7VnScHG
 r6MloJRuHj8t+zus1nQOV10Tb9zlREJG9Ssle7CecTpUuUM32OxQWyZVSPeQrXq6FQ9MCDz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Thu, 18 Jan 2018, Philip Oakley wrote:

> From: "Jacob Keller" <jacob.keller@gmail.com>
> > On Thu, Jan 18, 2018 at 7:35 AM, Johannes Schindelin
> > <johannes.schindelin@gmx.de> wrote:
> > > This commit implements the commands to label, and to reset to, given
> > > revisions. The syntax is:
> > >
> > >         label <name>
> > >         reset <name>
> > >
> > > As a convenience shortcut, also to improve readability of the generated
> > > todo list, a third command is introduced: bud. It simply resets to the
> > > "onto" revision, i.e. the commit onto which we currently rebase.
> > >
> >
> > The code looks good, but I'm a little wary of adding bud which
> > hard-codes a specific label. I suppose it does grant a bit of
> > readability to the resulting script... ? It doesn't seem that
> > important compared to use using "reset onto"? At least when
> > documenting this it should be made clear that the "onto" label is
> > special.
> >
> > Thanks,
> > Jake.
> 
> I'd agree.
> 
> The special 'onto' label should be fully documented, and the commit message
> should indicate which patch actually defines it (and all its corner cases and
> fall backs if --onto isn't explicitly given..)

I hoped that the example todo lists would clarify that 'onto' is just the
name of the first label:

	label onto

is *literally* how all of those todo lists start. And that is why there
are no possible concerns about any missing `--onto` argument: that
argument is irrelevant for that label.

Maybe it is just a bad name. Maybe `START` would be a better label.

What do you think?

> Likewise the choice of 'bud' should be explained with some nice
> phraseology indicating that we are growing the new flowering from the
> bud, otherwise the word is a bit too short and sudden for easy
> explanation.

I dropped the `bud` command.

Ciao,
Dscho
