Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2FBC1FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 09:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971255AbdDUJuf (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 05:50:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:53003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1037418AbdDUJud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 05:50:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lk7T8-1cQWl53yuY-00c867; Fri, 21
 Apr 2017 11:50:22 +0200
Date:   Fri, 21 Apr 2017 11:50:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        peff@peff.net, bmwill@google.com
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
In-Reply-To: <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704211135430.3480@virtualbox>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com> <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g7NRxVb1GWOJauqpJtXRKAGp5TsurllT08YZaSNCO9M2KmoNUOC
 MkrWEvwbTlzFz9Fca5r+G/HwXqfG7TB8J5GTNUZ2jiAGuXvnToB+gdqP3KENniT0HoZABul
 /uJ98ltdMIKdn9vnuIk5DujhRN1nS4KWWVE5Wq/YLJacscYdjtFmtLq/d3gPq0MO5sdPIpz
 UbPg8nppYie5PDjUx/QfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LtC8qlt4IRg=:/zGXFuM86PnRHaMKFk8jz4
 y4PknabIEAFxjN2m2MjxG1T3Vtyl8G9og3UaR63tPetWtbmwEPBPFB5l+m9StEjp13RnzWQ5r
 c6hSn2XXc+S+tokbJsyRtHVB1TqVbtg6GT7PlH+ok8fnZBgkXFOdm7CstMx84wwa+BK780WG4
 KrYVNmloOsnnstTke/up+fqhBnmK3rwStH4lJmTiZMmwm7CwzwekmcVlhJuv7Or8SndmOvrqe
 ph+JCr5Bsg5piZsMLD+5efOQ/61cHGtXmyitgljhfrQxAVpu9k70dMRf1NrA76k2pESoz3nUd
 3BIwcmVADe9UQB6hrFc+S2+eCRV5TU4T9bUgD65XxBjdbENzBrhATRC8mkRE8JeJ21Fr5i0HB
 Uzp0ciyRugMuoHOsO4K7gnxftu/8l4LDqwCznnr8DQq+cGu9aKR57WhKiRO9a5tzxpPoXNy45
 6uMtJ70Teb86ty1IYdep2gW3hDNfWzuVuQcbXWbMeIDy2HOMxo/trGQY7BC+m+kuKoZGmcB8U
 WN3gYW6pF5btoyILt2JIsJ1iBp4sTkutq3gLdca/gHLmSaSI9yiLtxplOvQhy+um+I3bA3PsU
 ePwGHigOka0czIVPE0OHAz7lLpT/zQaJdGfil8Zdv+WO1zMGFOnI65ysLU8mnwl/O/MKHodFP
 hNnrccdmgL/teYWoSdTFgkKcmxe9GbYvzBU/KoLtqNYddBxIlLJSfOzWBQZsvkd6WL3diAueh
 PU+cCnADxd5Qys/VHDsLPOMaOx0pQ7i0Zds1rgwmvtxG2h69Q1tNE9suLRdE/VwnB4U77+73x
 RPCH9UK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 20 Apr 2017, Junio C Hamano wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> >> * bw/forking-and-threading (2017-04-19) 11 commits
> >> - run-command: block signals between fork and execve
> >> - run-command: add note about forking and threading
> >> - run-command: handle dup2 and close errors in child
> >> - run-command: eliminate calls to error handling functions in child
> >> - run-command: don't die in child when duping /dev/null
> >> - run-command: prepare child environment before forking
> >> - string-list: add string_list_remove function
> >> - run-command: use the async-signal-safe execv instead of execvp
> >> - run-command: prepare command before forking
> >> - t0061: run_command executes scripts without a #! line
> >> - t5550: use write_script to generate post-update hook
> >> 
> >> The "run-command" APIimplementation has been made more robust
> >> against dead-locking in a threaded environment.
> >> 
> >> Will merge to 'next'.
> >
> > There might be a problem on Windows with this (that's just a hunch, i can't test this right now):
> > https://travis-ci.org/git/git/jobs/223830474
> 
> Thanks for keeping an eye on Travis output. My eyes learned to
> ignore the Windows section as its failures often seem to be due to
> timing out.

Part of the reason is that you push out all of the branches in one go,
typically at the very end of your work day. The idea of Continuous
Integration is a little orthogonal to that style, suggesting to build &
test whenever new changes come into the integration branch.

As a consequence, my original setup was a little overloaded: the VM sat
idle most of the time, and when you pushed, it was overloaded.

To accommodate even that use case, I managed to pry away some resources
that should be mostly idle at the time you push, and that should be able
to run up to 4 builds in parallel (the number "4" is not really magic, it
is the number of integration branches of git.git).

Since that "let's aggregate everything and only push out the final result
at the end of the day" approach does not really allow the Continuous
Testing to identify problems associated with individual topic branches, I
have another job that bisects the breakages (with all associated problems
I reported earlier, as you apply some patches on top of really ancient
commits and bisect wants to test all merge bases first) because the
required time *definitely* would let Travis time out all the time. Those
bisect results are even less visible than the Travis results, see e.g.
https://github.com/git/git/commit/2e3a8b9035a#commitcomment-21836854.

Having said that, I do not think that it makes sense for you to change
your habits, as proper Continuous Integration (as opposed to a variation
of Continuous Testing that we use, really) would take a lot more of a
change than you are comfortable with: it would look a lot more Pull
Request centric than the current mailing list centered process.

Ciao,
Dscho
