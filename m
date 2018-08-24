Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE7E21F404
	for <e@80x24.org>; Fri, 24 Aug 2018 16:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeHXURZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 16:17:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:58525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbeHXURZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 16:17:25 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaIPo-1gD7SX0EbQ-00Jrnt; Fri, 24
 Aug 2018 18:41:57 +0200
Date:   Fri, 24 Aug 2018 18:41:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [git-for-windows] Request for testing v2.19.0-rc0 *with builtin
 stash/rebase*
In-Reply-To: <nycvar.QRO.7.76.6.1808241320540.73@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1808241839350.73@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1808241320540.73@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:++j9lBAwh+ets7YivD1OOndPyBlAD1zGxtsmb28cHUDVtq13SPo
 SSShjFc6n1HSjaQty/SzGodgkr69v2qur5fTMrdy2/Mm5B/RpC91qLZNWJjEU9EEQ26KHPB
 GctrNJO/yXBKuwfGVD4LUcEpIccsmqZeiKry7urhyfsb/yhC4RLhml+T/YFCH8ywCs+U8CY
 oZYtbxqMEWVkAL+xKC+oA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5Mg3mC2VSZY=:eNLuFN/g2A0PEiTmxOPL0d
 6W/4QMRXm9+kntn9WLpuIXahjs1Z5Yq3fOXprC4QVqc833a7wuhkr0hFrtk8POKM3u4F473TC
 GPDh4aQpOvUX46tan49dRTYk/BLKkOBL2xqdr3imX0fpzBg284r3QRmRchylUCjD9ESrFsqpE
 FzbipEbA20FlcN6pG8kAEyRNAKMgfLwoRHR4Lkz8yqwD3hh2zjLqcLeYsYs8ycFuJGu94MPn9
 0TVC7RiTyRycFDdlIog7Nk+oKcSN52TRlDcKekzG3OCGV6J3uXxCbLMiYIdLWgD9OoYThfPr3
 NqAJAl3QtbmSa+9gVx/4SXeyxwg0C7+dpxKzVmhpU0TrqsrSM+aN7hHUTCe+kVe83oBdLpz06
 j3pqDrleBQ98VV3OAAs6G2zRu3Ash+mzYzQUUBQqENDBWAA/de558dA5HK2+ewuSBP/Mn2Qxb
 npuDFa1VrfVko2R0pCQolqQd61yvHAPLZ6OGTW7sW9xBV5kao13piLZbhaWTe65wtqNva/vAL
 HLvIRUsGb0Ting0dajd9Ymlx5AvFXOfW/d2b5Lm1IjKgqnkzueWHgofPbEuS//zH0UK4k8ii6
 fP1wyXW7nu9XgygagGxitC11koMjZV4EIs31TWiXH36rBAUad8uzf4cwYPTzW2jSN6NBfVAtz
 CPoza8vejFRD46WOBvWOr/oJ2fQDxfaSSj4e3JlqRqEmwPVj6TZOLfT0bAAjmtVwyWjA6ZvY8
 ZU264D+wkLWEZIPj74J9QfTfxHGMJhvdGzsQryUlfxZFsZRsAM9NcQy6keBUGcOIQ0K5g99Y+
 sH6TlrF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Fri, 24 Aug 2018, Johannes Schindelin wrote:

> while this mail talks about Git for Windows, please keep in mind that we
> try *very* hard to keep Git for Windows' master working correctly not only
> on Windows but also on macOS and Linux.
> 
> I, for one, run Git built from Git for Windows' `master` branch in my
> Linux VMs all the time.
> 
> As all of you know by now, the fact that Git was pretty much designed to
> work well on Linux is not exactly helping Git for Windows. (Or for that
> matter, macOS: Git is substantially slower on macOS than on Linux when
> running on the same hardware.) The quickest pay-off comes from converting
> Unix shell scripts (which are designed to spawn processes, whereas Windows
> is more optimized for multi-threaded applications).
> 
> For that reason, I was delighted to see that our Google Summer of Code
> pushed pretty hard in that direction. And I could not help myself so I had
> to test how much faster things got. Here is the result of my first, really
> quick and dirty test:
> 
> 		without builtin stash/rebase	with builtin stash/rebase
> t3400 (rebase)		1m27s				32s
> t3404 (rebase -i)	13m15s				3m59s
> t3903 (stash)		8m37s				1m18s
> 
> What can I say? Even if the numbers are off by as much as 10%, these are
> impressive improvements: keep in mind that there is a lot of churn going
> on in the test suite because it is itself implemented in Unix shell
> scripts (and hence I won't even bother to try more correct performance
> benchmarking because that is simply not possible when Unix shell scripts
> are in the equation). So the speed improvements of the stash/rebase
> commands are *even higher* than this.
> 
> So I really, really, really want those builtins in Git for Windows
> v2.19.0. At *least* as an option.
> 
> Therefore, after creating a pre-release of Git for Windows corresponding
> to Git v2.19.0-rc0, I created another one (note the .2 at the end), *with*
> those new builtins:
> https://github.com/git-for-windows/git/releases/tag/v2.19.0-rc0.windows.2
> 
> I would like to ask you for help in dog-fooding this. In particular if you
> are a heavy stash/rebase user (like I am), it would be helpful to really
> kick those tires.
> 
> Of course, those are only Windows binaries on that web page, but it should
> be easy to compile from that tag on Linux and macOS. I could also build a
> macOS installer and add it to that pre-release, is there interest in that?
> 
> Currently I am uncertain whether I should spend the time to reinstate the
> old scripted `git stash` guarded by `stash.useBuiltin` and the old
> scripted `git rebase -i` (guarded by the same `rebase.useBuiltin` that
> guards the scripted `git rebase`), as a fall-back (or make the new
> builtins opt-ins instead of opt-outs).
> 
> So far, I have not encountered any serious bug, but then, I did not really
> have a chance to use it yet (I installed it, of course, but I have not
> done any serious rebasing yet). So your help will be crucial in
> determining where I need to spend time.

Thomas Gummerer pointed out just how dangerously I want to live, so I did
implement the `stash.useBuiltin` option (and extended the
`rebase.useBuiltin` option to also cover `rebase -i`), and made the use of
those builtins an opt-in, i.e. still default to the scripted versions.

You can see my progress in this PR (which I mainly opened to have this
tested on Windows, macOS and Linux):
https://github.com/git-for-windows/git/pull/1800

Ciao,
Johannes
