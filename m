Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86459C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 12:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55097206A2
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 12:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jlaPHb84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgAWML7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:11:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:33415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWML6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 07:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579781511;
        bh=7QRculjYI8/8kBqLA8hWrnSc9ksiGUMH0313+mzXsfg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jlaPHb84YCAeKa2qgUQCZPLLY03AMRLB8ZM8rMt4ysSZqHRsRSXHezvMG4QB1dnh0
         /OqN8ziuHv1AG07qFfXBzGEsd0WTlstEltDamOdFoJ8GrW25RhwuRz6OEvH2gvnWO9
         AHW6HH78xuO7iADjnl2Kj46OWikv5wHf/5MOfCLA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs0X-1jP2Lm2C2L-00mtc2; Thu, 23
 Jan 2020 13:11:51 +0100
Date:   Thu, 23 Jan 2020 13:11:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: yz/p4-py3, was Re: What's cooking in git.git (Jan 2020, #04; Wed,
 22)
In-Reply-To: <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001231306351.46@tvgsbejvaqbjf.bet>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com> <20200122235333.GA6837@szeder.dev> <xmqqftg6671g.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1316106814-1579781513=:46"
X-Provags-ID: V03:K1:DNyE2ZErqPVMql/iKfAN4OO+JpQJY3QiuLG2MkOQ6ZaKauumk2A
 WVU5nn31yy/Fvvt+cjIRo4Fa3S3uQw/MMe9E6X2gEAX9V5nMAE2btnAPgwoulMh8YuOsUUc
 uj/P8O8fN9hrqrrQMwChmSoSeYfMPrGBDvXmD6VXDyEbd3OseaVBfVRfsjdAi4GbkXjB5qQ
 zA2NAaQiptFnjozLyJhag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ie7tMsBKkgU=:xvTp2xK9ILGnYbF+n/SZdU
 cdVelCFa2ZWVaxTgglWtCohHzfig8Pmw0aF1fsuqua62u8dAic3PUquVY/FMa0rphwFOLtGUE
 NymHvPVnCNmKSQj777e6+Osfe/WVMGsd1TDnxaioSMIzGNAi00Q7mwQGvlaR+Z0JvouQsXxMd
 Z4TucQK7yM9Au0UIzMeiFhYHTHjQ9evsZePh+r9BwB9FVwona4KEx9FG2rd2RE/tqEdH5pFlk
 Aa5JbxzKKySurlC8Au2wQ3OfDV8bzhPfXwd7OMNywrnCPf5BYuWiW+KfF1qHVz08d7nzuaSKS
 gvgL3DlgOoHAV85qH09jpsNnMel7jixDvxL6qChmcN0DBEpePeUn+1/XBTsj3Xd0FCBzUxWhE
 GD+E36R0kMvHsrG840mouQACry8qIWMC61taxrHkT9dBOjqmPhnywLsSMIm50QZo0R3MS/Y94
 19QAthirSSQ6Meoxu0JnD8ebh+PAJbOHOnDk0NFMaMf0JFKvRHUnqpp7HxDuh/i0URiZQ1aiP
 8TFRKCs2t3/7XPEeogKxsWVPcUkOXbb4mKLaYUDGqQoDFkwBRK96qRVVrEBNcMzl2ovjNRy+G
 yoymXCcJLRky02htRU9GEZDFMhm8vRCJXblOAvhPjbqY7U/M75/6/4O1j4BRhM919yvCay6k0
 T5iMlSxhU1/1L7CuN1mewI5LXcF5BvqzUiJ/L/4hw038Sylzux6RXF5STAad/5YaQldNb0P35
 +zdCxgyRBaXQUHcsJuZBYjvLMtvAwX/8P7K8Ns4UdGtOVGh5rpWnSxn31inGHB9uf8HFaA0Hz
 +t4pNhUiAoQsAEtk5ul3+2yton6H0nepJE0A7a2drCcwcm9ZCWc75f1/HlRvII0nWpZxibs9H
 f9IavgHhZmZO5YCQFftNtQxAoB5kVZ791xmrCvZwTRzmBdfrJP707IBNY5O87e/EyYBGQG0Ov
 ooOLMDt1nvsq41pkJlE/YKGMH7TLQcH8GosMufEkwfDoEkDscNdlcj0JQHxnViVxuUIJ5uoam
 2l1qrzmVntory7sXiNZcz/SJg96LFZQ8XDkFMzl3SKEBDd+pnDjcDmnzdvk/w0VVMy5T8cNdw
 FPO/WIUlCoV9TNX86fUUdj5DkD1oauCeSNAGGx7kfcXDcLG2tv6yBs3UpiO/e/WPVDiDB3iSU
 oMBet5rbE0OayBSCHplJXA8t0aO6iZM6VXIRxz91eDOn316S6pn2zb3baeNc/2QwpQr7K43aw
 /5wxQviksfds4GijE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1316106814-1579781513=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 22 Jan 2020, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> > On Wed, Jan 22, 2020 at 02:18:05PM -0800, Junio C Hamano wrote:
> >> * yz/p4-py3 (2020-01-15) 14 commits
> >>  - ci: also run linux-gcc pipeline with python3.5 environment
> >
> > I still think that this last patch needs to be reworked before this
> > series is merged any further.
> >
> > The only Python script we have is 'git p4', so the Python version is
> > only relevant for 'git p4' tests ('t98*'), while the rest of Git and
> > the test suite couldn't care less [1].  This patch, however, not only
> > builds Git and runs the full test suite for each of the two Python
> > versions, but, worse, runs the full test suite _twice_ for each, first
> > as a "regular" test run and then again with all the GIT_TEST_* knobs
> > enabled.  Consequently, it adds ~50mins to every build's runtime.
> >
> > That's just too wasteful.
>
> Thanks for a reminder.  Yes, I do recall you raised the above point
> and I agree with the assessment.
>
> What's the ideal endgame wrt the tests?  Build with Py$N and run
> full test suite once, and run full test suite again with the unusual
> knobs enabled, which is what is done without this series, plus build
> with Py(5-$N) and run and run only t98?? tests?

Should we declare `t98xx` to be the namespace for the Python-based
scripts, or alternatively declare that we won't ever include another
Python script but `git-p4`?

But yes, I think that we should probably "tack on" the Python 3.x tests to
the `linux-gcc` job.

Or maybe finally split this job into three: one job that does what
`linux-gcc` suggests, a `linux-gcc-knobs` one that sets all those `GIT_*`
variables, and a python3x one that only runs t98*.sh.

The reason to split it off is this: on rare occasion, I have to restart
the `linux-gcc` job because _one_ of those `git-p4` tests failed due to
some reason or other, probably timing-related, I did not have time to
investigate this. Having to re-run the entire test suite, twice, just to
work around those flaky tests is rather wasteful.

That would actually be my prereference. If people agree, I will revive
https://github.com/gitgitgadget/git/pull/266.

Ciao,
Dscho

--8323328-1316106814-1579781513=:46--
