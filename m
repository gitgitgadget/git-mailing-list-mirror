Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88ABC1F4F8
	for <e@80x24.org>; Sun, 16 Oct 2016 08:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbcJPIcm (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 04:32:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:63491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbcJPIci (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 04:32:38 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MhhwJ-1cGujQ04Tz-00MtBe; Sun, 16 Oct 2016 10:31:47
 +0200
Date:   Sun, 16 Oct 2016 10:31:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2016, #03; Tue, 11)
In-Reply-To: <xmqqzim6zzc7.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610151020480.197091@virtualbox>
References: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>        <CAGZ79kZu71+6QmvKgXJ5t+97jvTeAhSRtHpMQR9Rmk4Ep5RHhw@mail.gmail.com>        <xmqqk2de7e70.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1610131439400.197091@virtualbox>
 <xmqqzim6zzc7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dkSgEnsgenczIApdtvUbNjQegAA2+gkPHlnOR08YfX6TQLdZApd
 RGTWSMIXOoPgwpiOMz+59pKALqZ9Tmh2DaVNWRNmn+UHgMWh2afWD5xhvAyYsY6DPqhEL8d
 K/f/BxX8pMOqg36/vLBndr1NZ3ThH6ZdQGeajw05OfQbERI3jc3mzt74r875eXtV7SI/agB
 6vjnsJCws2qQIjHAvK9Yg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gAMTg1Khmac=:4CRr46dvLQ9Wuk8xekV5nr
 tZZMZ17T+wcGrwbHzlMLsmMNMEHDLzVdmS/R/o/R2FfUwPPIfWKhULdDYbu13SEfdx7LJbQG/
 DeWQ3FVWw6NgbN54Q03dlb9gknrURSBXSo4upHywQcYggbwxoHK1PJefyUmFg4dMdveCjXaWQ
 ECJ0uTGhnV5cNW773E+8nKvxj8bUjNG0hxYMfelLnFTz0d803Dj59CTLvHucwhlbYA7U/AL+e
 D/pmcuF3QfKDDRnouvAeVJEYern3LlBFdFPQPPZWAHnFlfVIV5FhacLwzxpzPIeDIF2GsWwDl
 LcHo4uz3whHfUFeSXc6gGbihVwuIJL/3zREL/5COGUaMLsYmEJ+rEa3INiZxYForxxQ6lJZs4
 WAvkwv6VpEPKQhbTWpOcK+qQ9rAlr722qXFeJQV2YnEm5jm/2uaDkXWs/HHPnA33mbGheuokO
 lv6zc2WS0OmX+Y3GdNT4vnMcG0dOFGCpA/z/d+gKbbInqk2r7F0ok8m2whTe+GDsR85PFJ4dF
 /j05E8nIAyOVpFc0Ga+2xLrnP2TJdDAhIBCUx9hrjVlqz39lVOkO2adZ1CIdn00gP8qONrCO4
 iVG92JKJi2tnVjBXawc2P/kfOlHQkiGIhoX8wCo6X+0rdF0xNLspKxm4LSOnz0+AwXfqWKQgB
 c/WZOMR7Y2RCsX8ogRckatPnRTa7YaMhPFBUwTJvcNsf336J2eH/BkN3cQNxOWTGIhHiI5fUS
 V3x5mlJQA8CFEkf7MXKHD9TQEBraxdBqWj+5zoQACcROA9NpkmPxaAGcrS/mLDVwJJbUwx+WA
 zYwFmG5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 14 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> >> * sb/submodule-ignore-trailing-slash (2016-10-10) 2 commits
> >> >>   (merged to 'next' on 2016-10-11 at e37425ed17)
> >> >>  + submodule: ignore trailing slash in relative url
> >> >>  + submodule: ignore trailing slash on superproject URL
> >> >>
> >> >>  A minor regression fix for "git submodule".
> >> >>
> >> >>  Will merge to 'master'.
> >> >
> >> > Going by the bug report, this *may* be more than
> >> > minor and worth merging down to maint as well, eventually.
> >> 
> >> The topic was forked at a reasonably old commit so that it can be
> >> merged as far down to maint-2.9 if we wanted to.  Which means the
> >> regression was fairly old and fix is not all that urgent as well.
> >
> > And if you merge it to `master` and `maint`,...
> 
> I'll mark it as "wait for follow-up fix" in whats-cooking.txt (on
> 'todo' branch) to remind myself not to merge it yet.

May I request your guidance as to your preference how to proceed? Here is
the problem: Stefan's fix uncovered a bug in the way Git for Windows' Bash
hands off "Unix" paths to real Windows programs, such as `git
submodule-helper`: trailing `/.` gets truncated to `/`.

That is, when passing `/c/test/.` to the helper, what arrives is
actually `C:/test/`. So the helper, being expected to cut off trailing
slashes, cuts it off because it does not see the dot.

Note: when passing URLs (`https://repos.com/mine/.`) or when passing
Windows paths (`C:/test/.`), the helper *will* see the dot, and all is
fine.

Unfortunately the behavior of the MSYS2 Bash cannot be altered in that
respect because existing build workflows *depend* on the current behavior.

Please note we did not have that problem previously, as the helper was a
shell script and therefore stayed in the POSIX-emulated realm, no
POSIX->Windows path translation necessary.

Now, we have two tests in t0060 that try to catch changes in this
particular scenario, verifying that only the dots are cut off of paths
like `/a/b/c/.`.

Given that we cannot modify MSYS2 to appease those tests (because we would
break many more important things), and given that you can easily work
around this by using paths native to Windows when using Git interactively
(which the tests cannot do because they target Linux), I am inclined to
change the tests.

Here are the options I see:

A) remove the tests in question

B) mark them as !MINGW instead

C) change just those two tests from using `$PWD` (pseudo-Unix path) to
  `$(pwd)` (native path)

I would like to hear your feedback about your preference, but not without
priming you a little bit by detailing my current opinion on the matter:

While I think B) would be the easiest to read, C) would document the
expected behavior better. A) would feel to me like shrugging, i.e. the
lazy, wrong thing to do.

What do you think?
Dscho
