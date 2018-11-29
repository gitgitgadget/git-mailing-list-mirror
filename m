Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30FB5211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeK3Cpd (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 21:45:33 -0500
Received: from mout.gmx.net ([212.227.17.22]:33723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbeK3Cpd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 21:45:33 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXllr-1gzFAB0whb-00Wkhp; Thu, 29
 Nov 2018 16:39:40 +0100
Date:   Thu, 29 Nov 2018 16:39:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] rebase: mark the C reimplementation as an experimental
 opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)
In-Reply-To: <23551.63504.876084.449440@chiark.greenend.org.uk>
Message-ID: <nycvar.QRO.7.76.6.1811291638400.41@tvgsbejvaqbjf.bet>
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com> <87y39w1wc2.fsf@evledraar.gmail.com> <877eh219ih.fsf@evledraar.gmail.com> <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com> <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com> <20181128043154.GA34163@google.com>
 <nycvar.QRO.7.76.6.1811281015360.41@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1811291516540.41@tvgsbejvaqbjf.bet> <23551.63504.876084.449440@chiark.greenend.org.uk>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Bh1wUPhZ6SbM3l6qYkd2h7zjnImE440T21X2XFOmMsGXFWhX3Aw
 9SL4UoWHdbvm+YPY/A0EzYl4fBBweoydjimYEJ4ot+W13abf27V/6bkyMffTCWTRIR8YM9c
 14RG4gnF/Ng1nA5bd3gRVtOIanoozUGLi2Fdzsh7CfSyn6IuxfsowpF3HaIGkV/ONJmoUc1
 LzOEJJp15rfjKpm5AuL1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nyAyYd4LEvw=:QfYZtPmZEsvXgyuaBYY6w6
 p1DjeQswKpDr7oAfpon+2H2NC+xLPJ1uKI7tPaSrCKi6zoHSAL+UFt6P75EzEa0hjOiQ67+5R
 TtLYtcnX5cHFvGW4u23I4Qktj/BFMkyp+S1eQ4iO4mBTp5VaNntXqtTYu0fvXbYmdO0HNbUVo
 /J4X0y0zHDrqy2YSHKYquMWA6B6Sby56DS0zuq8BueBz9zQv17eOmhg0/xQteEUX0kwJaHLiq
 /jXffiMCnAu75nLyZQD9l44L/Ac8M7P3UZe1xMxJWVGF0d4IgfSTJtw0BEbZV9klBZjcU1pYz
 hLJNDGUSjmzrc/pz/JVFaR1dkfrlX0y2mIqYf6a95lfgEZ7dI8/Q4i9kPTTbAWGnJuz8closS
 O6RMP+qUOhJBYz0ByGH6zyD5wlU/hxCQs6z4EgeZ6Q0DzHZmHkjYY2jGRw0SAYEHofcO9m+52
 TJUGXtAYEM40fEjteN4YRxb/xP9PZ+CXysAck7oHlqu+ZQa3ieh0SNsEDGPTsOxDT6jkJEXAC
 tVbzVqC6l7bHfDj/QrKZfvue3OrH1M1qZ91B7OLm8C8kr4Xt8WVz+0JTY+cEdaLxz4EHfqHoe
 6F06ejAbFazk4FCUHqdmyWiPQJimDphYgFr/KbDfegttTspHtBFiLCX21kiDvWd87tXDqAGLx
 QmsRyQGW/4h+iCi9Kq7pVc87M7vL4FbyYNHMeEcl2FsjRYEA8+gULI7V6FRsIiR1Vb3PtsgoS
 A2T6boJPq4wpqB59v0JcFIiKerIc2skD+hoGLdBfdw6wbIcwENxpK7lP4UkTC7vWMtUXaU0Ln
 z9Zdm1JJ/mcmzy3YP9P/L4MHzcFVIxnO6l6/+UlKJeg1leodQKfLIe1ANf11Vd4UKzawEe9qK
 fM6scbMfiocysYeb7DlxH2ueS+jckgnH6iFP5Vb370vTSp7nbFHiAvfCDEHMwol7rHNNlUDlI
 1x79os4FROA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ian,

On Thu, 29 Nov 2018, Ian Jackson wrote:

> Johannes Schindelin writes ("Re: [PATCH] rebase: mark the C reimplementation as an experimental opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)"):
> > if you could pry more information (or better information) out of that bug
> > reporter, that would be nice. Apparently my email address is blacklisted
> > by his mail provider, so he is unlikely to have received my previous mail
> > (nor will he receive this one, I am sure).
> 
> (I did receive this mail.  Sorry for the inconvenience, which sadly is
> inevitable occasionally in the modern email world.  FTR in future feel
> free to send the bounce to postmaster@chiark and I will make a
> you-shaped hole in my spamfilter.  Also with Debian bugs you can
> launder your messages by, eg, emailing 914695-submitter@bugs.)

Right. I myself have plenty of email-related problems that seem to crop up
this year in particular.

> > > > At https://bugs.debian.org/914695 is a report of a test regression in
> > > > an outside project that is very likely to have been triggered by the
> > > > new faster rebase code.
> 
> As I wrote in the bug report last night:
> 
>  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=914695#15
> 
>  I have investigated and the bug seems to be that git-rebase --onto now
>  fails to honour GIT_REFLOG_ACTION for the initial checkout.
> 
>  In a successful run with older git I get a reflog like this:
> 
>    4833d74 HEAD@{0}: rebase finished: returning to refs/heads/with-preexisting
>    4833d74 HEAD@{1}: debrebase new-upstream 2.1-1: rebase: Add another new upstream file
>    cabd5ec HEAD@{2}: debrebase new-upstream 2.1-1: rebase: Edit the .c file
>    0b362ce HEAD@{3}: debrebase new-upstream 2.1-1: rebase: Add a new upstream file
>    29653e5 HEAD@{4}: debrebase new-upstream 2.1-1: rebase: checkout 29653e5a17bee4ac23a68bba3e12bc1f52858ac3
>    85e0c46 HEAD@{5}: debrebase: launder for new upstream
> 
>  With a newer git I get this:
> 
>    6d3fb91 HEAD@{0}: rebase finished: returning to refs/heads/master
>    6d3fb91 HEAD@{1}: debrebase new-upstream 2.1-1: rebase: Add another new upstream file
>    86c0721 HEAD@{2}: debrebase new-upstream 2.1-1: rebase: Edit the .c file
>    50ba56c HEAD@{3}: debrebase new-upstream 2.1-1: rebase: Add a new upstream file
>    8272825 HEAD@{4}: rebase: checkout 8272825bb4ff6eba89afa936e32b6460f963a36a
>    c78db55 HEAD@{5}: debrebase: launder for new upstream
> 
>  This breaks the test because my test suite is checking that I set
>  GIT_REFLOG_ACTION appropriately.
> 
>  If you want I can provide a minimal test case but this should suffice
>  to see the bug I hope...

This should be plenty for me to get going. Thank you!

Ciao,
Johannes

> 
> Regards
> Ian.
> 
> -- 
> Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.
> 
> If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
> a private address which bypasses my fierce spamfilter.
> 
