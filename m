Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64B431FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757551AbeAHU1p (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:27:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:54272 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757547AbeAHU1n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:27:43 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7Xi3-1eltXh1Ihj-00xJyw; Mon, 08
 Jan 2018 21:27:38 +0100
Date:   Mon, 8 Jan 2018 21:27:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Dan Jacques <dnj@google.com>
cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 2/3] Makefile: add Perl runtime prefix support
In-Reply-To: <20180108191812.52565-1-dnj@google.com>
Message-ID: <nycvar.QRO.7.76.6.1801082125210.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87inccbscj.fsf@evledraar.gmail.com> <20180108191812.52565-1-dnj@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1790583715-1515443258=:31"
X-Provags-ID: V03:K0:CM6iCxYEHbEx4XnE16HZX5A4tPnCLf4VqX+wlCwdWjPAC5qbEiq
 wpDiNAFZAwhoomFO3RzR9KTMvxkjWVO7ziuntRe5VqLKuoT8zdid8u9LcqcGhRUq7OzsuHD
 x2MZ3BGaHxKbUaHt2Gl+YBEKfUx6S7g254FNcoopH86QrKpY7KIp//DhoKpgcbfG3bLYGCK
 eIJZPRVEtXzMTdqn0Zebg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mAjzjmXwjUk=:NIYu6p/4Q8XbYPRA3aMfrt
 tBx0zEimXs2o9urotvIVF9PazbZogSkP2SlSJiNus8aH+cOhEG4+m/gSZFwI0vfq3MA6UN4CL
 YrC1iGUfNgUnlNcynwVbICSJ0RVzn9kPXI3cebrmByL3VuxSZXcH7sFLDMIAyXcoP6pFgxfLD
 Pfbae4BCsUApOdFdKzEpKK4H/HD2ilcSRymEXzqiiKovY6T+IPQDYeFB3yTqgEQgmN4yxLwgc
 Duzuu5klkLhBCzF36WnzdCeVzeI8Ixa1ynawIGzhRasNWtX4S1AJDlGjIdXQCCOHAxzRJyCSi
 LtALDXU/D6scnyoLDFfwOoZ37p3rvK3h7GEDbt8iDG+do4YRJvwBXJmWRKZe4nbLRbwfW4yIk
 2D6mZLTGtQ1DnPPcjqCBMMjMVbMq6e4HQe+qgTwdFuEEjr5LFAIL/MH7dC0Vzteig/vHKegsZ
 1/IOdiJLpa9jgAuh8CC3LjBQUdFlWMsTmyrGyzUV3liLdS23blFyPp6zqU7/mRqv0xRkcIhIT
 J7+GveKHw7NaE6RsPaDNH9pnOEO1TAcLS+qSGW6BCMj8MJRxvD1Mvx39aV4UToLSEKFyo6Jy8
 DFUMMudmMiYz+gfks7tw8CSV1AOgcLDmIT25rYee9GqJ38uOtapL4bP9GlanUwanPrcf/yk7B
 zQvUAAfldDyIytLAlJ6C0tDuiGI6iMR/7nTZDfPTYmm+LW91I1gPFVYtEwqAy6bnAiT9WCgtF
 ZfSPzX32RkOXfxCLc52VkP/aRJnHhUw9MI7dWQEPsj+3BDYbRYLUAFc675aldh9BaAqEb0Y+h
 1ArfMerM93nNhatStGfZFGBHQiUX87uiBFbPQLVJBeQm8p43M5QBLHUfSR4vkZFAIFiN6jG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1790583715-1515443258=:31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Mon, 8 Jan 2018, Dan Jacques wrote:

> On Mon, 08 Jan 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason replied:
>=20
> >>+# it. This is intentionally separate from RUNTIME_PREFIX so that
> >>notably Windows +# can hard-code Perl library paths while still
> >>enabling RUNTIME_PREFIX +# resolution.
> >
> > Maybe we covered this in previous submissions, but refresh my memory,
> > why is the *_PERL define still needed? Reading this explanation
> > doesn't make sense to me, but I'm probably missing something.
> >
> > If we have a system where we have some perl library paths on the
> > system we want to use, then they'll still be in @INC after our 'use
> > lib'-ing, so we'll find libraries there.
> >
> > The only reason I can think of for doing this for C and not for Perl
> > would be if you for some reason want to have a git in /tmp/git but
> > then use a different version of the Git.pm from some system install,
> > but I can't imagine why.
>=20
> The reason is entirely due to the way Git-for-Windows is structured. In
> Git-for-Windows, Git binaries are run directly from Windows, meaning
> that they require RUNTIME_PREFIX resolution. However, Perl scripts are
> run from a MinGW universe, within which filesystem paths are fixed.
> Therefore, Windows Perl scripts don't require a runtime prefix
> resolution.

As I mentioned in the mail I just finished and sent (I started it hours
ago, but then got busy with other things while the builds were running): I
am totally cool with changing this on Windows, too. Should simplify
things, right?

Ciao,
Johannes
--8323329-1790583715-1515443258=:31--
