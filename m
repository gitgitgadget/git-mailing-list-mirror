Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6F76202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 20:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbdGIUMp (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 16:12:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:60253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbdGIUMo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 16:12:44 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEsXW-1dRab53jly-00Fx5e; Sun, 09
 Jul 2017 22:12:41 +0200
Date:   Sun, 9 Jul 2017 22:12:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git-for-windows@googlegroups.com
cc:     git@vger.kernel.org
Subject: Call to developers with access to Windows XP
Message-ID: <alpine.DEB.2.21.1.1707092143560.84669@virtualbox>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sWMARttdX7J2NDbuNXo+ThrlNXjttgeV/RWP1yBzU2QrfI+/MGh
 D/FaaTPRv+kYF+t8IMAGnWVuEgKyyjTl2rso84gEJ4/d0qcRyqxWkmV2OEZVvEs6qtpSJoj
 uxEkPmT3P4WZ83seEisn8rSXWWyPHCkhxGfZwRYOdbg43h+4pyZWDCIsp9czPTUswPrX5QF
 0q/2551+FSDa7P3GvA3Ew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UamAIgrrEMs=:R4eSheR/QvfQ3xzZYIEKDr
 VnFxuPRiAtZ31UbyzIM1wb9EBpyk6WpINfaBjQd7Y71krY5YDNstz08eUIaZLUo44C3w39OHC
 3oyaU3F1/S6zwVaiPXQ6+IrBMfsn08NZkZAU8npJrw+ZO9FLYzgviWlgUWYBzE0Kl5VyfPZOu
 8BTPtFd12KQjwhAy2So5V/Dq+/ZhPl586NPgRpD2dAP3ulY/+dhz7EcTkZReRh7juQX8a0C3C
 QR0fSJtQ7OJ8Cy1o59+Ge6Nkdb30hPa1/3cI0fmZ3w/9AK2KStM1FWyJTToTMeVhU2UB958Ep
 ps1L1C0JGwn9rCfx7FDJaI357pJe/jixmZ+5I4eu/d+QuYeDse6dhl/IgPLIHXLjDnHPnM0Yj
 nr8xxoVJEmiXAwTZESWFcRtEG1fGqBIO2WTT5VxdODSoBlVWpbfcCXU59cDCNjsEV4EbhU5PR
 Ymw6xazsraZeFXCoAhJ1HcFXT5YFXSJNd7PDrgSEiEK/K9I0KeJQnWq66b4oWVeGKFMWrFXSH
 Np+IVubZy5l7TgLIFLz9VNoTLaN7jY+H9RekmQ0pgXtW9tWK1PbWufygBbkdxt2B6YRvb7MEB
 nHpJSvAWTjLyrD5nu4+2j7rO0v8XLRztt+zzRfREY2pvDv3nswtm+8kUYZIGVjYRECaZVcPkL
 2mPWFNufQukAOWDV814sfcw2riK2jL0Q8cm4f+MgdXCQvpdC2bTdnPCFCUzZxhllzZ8Gc8hXJ
 NIPyfTdm390KB9pxGFavipPrsumaEBfZ2Z8+IT6N3D4AKPzSc/3JxTLAg30SAC6FVi9TxQMnn
 WKL7t9U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

it has been a while since Windows XP support has been dropped from Git for
Windows (v2.10.0 was the last version to support it), mainly due to the
code changes inherited from Cygwin's code base, which discontinued
supporting Windows XP after version 2.5.2 (because it became way too
cumbersome).

Now, as some of you recall, I was not all too happy about having to drop
the Windows XP support, but I saw no alternative seeing as it would have
taken me a good chunk of time (which I have to spend instead on keeping
Git for Windows working on Windows versions that are *not* past their
end-of-life) to reinstate XP support, and it would have taken even more
time to keep it that way, backporting changes all the time from
quickly-advancing Open Source projects moving away from XP support at a
fast pace.

All the same, I tried to make sure that developers out there who are eager
to have Windows XP support know that I am fully willing to assist them in
getting it back. Assisting, not as in "just whine enough and eventually I
will cave in and solve your problem for you", but as in "you are eager,
but do not know where to start? I can tell you all about it, and if you
get stuck, I'll help you get unstuck".

It has been over 9 months now since the first non-XP version of Git for
Windows has been released, and all I heard was that some developers found
workarounds that work for themselves only, without even trying to share
anything helpful for other developers in a similar plight.

This is not enough.

We are now finally at a road fork where I need to know, soon, whether
there is anybody out there who is willing to step up to trying to get
Windows XP support back into Git for Windows.

Side note: At this point, I am a bit sick and tired of hearing so many
opinions that *I* should work on that. So that won't fly. Just don't. If
you feel the need to whine how unfair I am even while you are unwilling to
lift so much as a finger to reinstate Windows XP support, just write it on
a piece of paper and flush it down somewhere. Don't write that email,
because all it would ensure is that I personally would rip out all
remaining XP support from Git's own source code, just to rid myself of
this kind of "helpful" advice. It's not worth your time, and certainly not
mine, either.

Back to the subject.

The reason for this call is a Pull Request I would like to merge:
https://github.com/git-for-windows/git/pull/1214. It simplifies Git for
Windows' pthreads emulation rather dramatically, but due to my
(misguided?) request, it tries to keep Windows XP support as a
compile-time option.

The thing is, this code will bit-rot if there is nobody willing to spend
even a little bit of time on Windows XP support in Git for Windows.
Meaning: it will add to my maintenance burden, which is not okay.

So my current preference would be for me to go back to the contributor of
PR #1214 with a profound apology for making that suggestion and wasting
their time unnecessarily. And then just drop the XP support of our pthread
emulation.

However, I am not quite certain that I have really exhausted all my
options for reaching active developers who are interested enough in
Git for Windows' reinstating Windows XP support that they are willing to
put in the effort to make it so.

Did I reach you, active developers? This is my final attempt to do so...

Ciao,
Johannes

