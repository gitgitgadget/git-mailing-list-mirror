Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561C8C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 13:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiKJNfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 08:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiKJNfe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 08:35:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212FEB850
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 05:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668087328; bh=QywPtzySu+6NWQetdxQHVpzu06nJurEeui+WNnqEK0c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iHi/xoye82uEChWdHqvajmN1DqqaJyYRM0TT0Y7IBe8+RXuYu+5iPlS1kPcaOcznw
         eb5dDS5OvSpW+d/pm7/1IANqWu4cf49kSptWPLUJb6PFpcfWDUF+Yh9fyL9L+nsGCs
         grZ6cz4Mk1WVTj/WynZje3jsgnQVNSxdG+yYciV0/rytPnaNX3lqfipBQx0Uc/9vjN
         jzxDtFcCVDS90df8M55hVq25+RGZJGXAgmTMRT+hAGuIIaxMGE6WtEAbkDjpA4Dag3
         p6dWRtx9FvOxmK7X+svztXgWr19GtyGgaHhO/lqqxZ0stfczwdpJmjsSdtQ6YLWqGP
         qn1Oc9Mn9xLmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.27.167.171] ([213.196.213.188]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1oXYJu16QM-00VLl3; Thu, 10
 Nov 2022 14:35:28 +0100
Date:   Thu, 10 Nov 2022 14:35:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Taylor Blau <me@ttaylorr.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: js/bisect-in-c (was: What's cooking in git.git (Oct 2022, #09;
 Mon, 31))
In-Reply-To: <Y2KoKO5Sj71Nfa61@nand.local>
Message-ID: <8r1s24sp-8p26-sr61-3pp0-8o7r6pr72641@tzk.qr>
References: <Y19dnb2M+yObnftj@nand.local> <221102.86cza52rt0.gmgdl@evledraar.gmail.com> <Y2KoKO5Sj71Nfa61@nand.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-481353447-1668087328=:16139"
X-Provags-ID: V03:K1:rdwAKpv1FeLFzsGU540cVVbryDTPzLmqKez08LB5HrA7Wy1p/JW
 BZtR79L3nmRtp7SeDL786qGweQEV5Pzpdge6iqBBQg49LNylef1OYGA9xRfEf9sV/KOnmRc
 +YEsL+H1dAix1OgE1W083B9X4qHzL5kTT6BbPkO/Q5Y4QOZ/xOC4D/hqB5CgCDQlkwOg2qh
 rDeX+dZpewxDaZJ+qloLA==
UI-OutboundReport: notjunk:1;M01:P0:x3NThn+pMrs=;mOmzhrISqCt/Opkx+uDDLATc/W3
 unIHREU9upaicbCgLteEPx7wwUcNdmYsHyUptjiEzPRF1n0RHyne2bJmIbG976VxdTc2HSjcu
 QIcTZ4UnL3j0MVQyFde67Z+3vmy2ttQq7L2ohrKAyiPZ46YushmQdRaZCOnWdEo5TtJC5MSvZ
 xJg2d1yEIrxo8p5OOab2hzBxlSZNG1VEN5QVAha9pozHEK7+o469f6pB4dzd8SgdR+z50dZoh
 dVbIxQRqfaAlUYnQCKR8mIg/Src5QRsU6O1/CPZH/Ly96rM+7w0NkpvoSHBtNxG1TgLsx9kW3
 1dLSCKVzcok8LsoT1lHYQTLdnpIpQgQYeBrO3Rmgpg2uRtK8Q+471ReomGyrI0JBvgUxz+gzC
 Fsx9udwuV62PTibmoJMN9MiGU5wqWCk6IBaeCHYMFApfinxC5xQZNQ1flGnezH8yPi73En0de
 PiaZjpcxoqVC+eNCwvOIvoJIiM8jN013ZQWbIaovyUGpDyQHWBtOgTTR0Aog0kW6Qv7Rd7cgo
 5HF3/G388hhm1wgLHE0j8R4+12CXo1qXO9hBbYBTN43rjMWujTQ75WPtF2r851dWdIecN5534
 TPIeXJF/a/Awj9r/Js9oOZgCJyfhf4dwHUhJnsa+vFiskRZ3g3t6NtILQaFwwGbLhaTmuNIfV
 Nr2/h1lH73xkikTzk435BPYrhsczAIADd5GGuy/I9n4pyf5i4XVajcEK3cpx3ZvO7ewRH3TJm
 6B6ULQd6q6JhiGQzHT8B3Cw1BCr5XjJjOebWbHNFCs4jM1gRexS4ini9Xzhq81KE3s9jkppX2
 1I31w3PyHqkYHInps1Vsi5GAVSij6M6NVAvt/SeDwnyxZBLpgZ12OyNxjw7V+ngBe+tQsqrGe
 jBLjYmIAZWKun6qLeN0H+k03vZB04LiuuWHkmQo8xXgJndp3q+szGxSYN5cOc4yB8AhIiEA2a
 1ZSysSnToSxRr3bhtCQ645K7C80=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-481353447-1668087328=:16139
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Taylor,

On Wed, 2 Nov 2022, Taylor Blau wrote:

> On Wed, Nov 02, 2022 at 06:22:17PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
> >
> > On Mon, Oct 31 2022, Taylor Blau wrote:
> >
> > > What's cooking in git.git (Oct 2022, #09; Mon, 31)
> > > --------------------------------------------------
> > >
> > > * js/bisect-in-c (2022-08-30) 17 commits
> > >  . bisect: no longer try to clean up left-over `.git/head-name` file=
s
> > >  . bisect: remove Cogito-related code
> > >  . Turn `git bisect` into a full built-in
> > >  . bisect: move even the command-line parsing to `bisect--helper`
> > >  . bisect--helper: make `state` optional
> > >  . bisect--helper: calling `bisect_state()` without an argument is a=
 bug
> > >  . bisect: avoid double-quoting when printing the failed command
> > >  . bisect run: fix the error message
> > >  . bisect: verify that a bogus option won't try to start a bisection
> > >  . bisect--helper: migrate to OPT_SUBCOMMAND()
> > >  . bisect--helper: make the order consistently `argc, argv`
> > >  . bisect--helper: make `terms` an explicit singleton
> > >  . bisect--helper: simplify exit code computation
> > >  . bisect--helper: really retire `--bisect-autostart`
> > >  . bisect--helper: really retire --bisect-next-check
> > >  . bisect--helper: retire the --no-log option
> > >  . Merge branch 'sg/parse-options-subcommand' into js/bisect-in-c
> > >
> > >  Final bits of "git bisect.sh" have been rewritten in C.
> > >
> > >  Needs review.
> > >  cf. <xmqqv8pr8903.fsf@gitster.g>
> > >  source: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
> >
> > I see this has been ejected out of "seen", presumably due to the
> > outstanding conflicts.
>
> If I recall correctly, I ejected this one due to its age and lack of
> attention. If you want to reroll it or if Johannes wants to take a look,
> I'd be appreciative.

My last information was that I sent an iteration that was designed to
address all outstanding concerns, including a rather major haul to put
this on top of the new `OPT_SUBCOMMAND` feature that wasn't even dreamed
of when I sent v1 of `bisect-in-c`, and then I only saw "Needs review."
for several weeks and nobody objecting but also in particular =C3=86var (w=
ho
raised concerns against this patch series several times over the last 10
months) not chiming in with a "go ahead".

So basically, I thought this was finally done and the next thing I hear is
that it is ejected. That's quite a frustrating experience, I must admit.
At least I am not a new contributor who would be very much deterred from
contributing any further by such an experience.

Ciao,
Dscho

--8323328-481353447-1668087328=:16139--
