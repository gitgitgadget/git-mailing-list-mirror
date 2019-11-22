Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E301C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05ED20707
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 13:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SeOHRACm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfKVNub (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:50:31 -0500
Received: from mout.gmx.net ([212.227.15.15]:42099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbfKVNub (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 08:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574430620;
        bh=3ujIGLk3OiZWYR2QDAF2ZxOTJtWAgoXdsZCApx+eTJg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SeOHRACmKb0gpUMV83c+PxAfjjCTEsYjI2He8FLCmEF8JCkIGepgL8lfCi2O680iL
         +mgyC+dazEDFVz//rsfMy8PI6UruXxto7DQGQ2JRROrRYIhOp8wWlmWOSKSsqyeRtL
         ItXm6RCdPT8ISJMutilBR9tiLT1hh8RwYSS6DaP8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1igulg2LBo-008s5D; Fri, 22
 Nov 2019 14:50:20 +0100
Date:   Fri, 22 Nov 2019 14:50:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: GitGitGadget on git/git, was Re: Should we auto-close PRs on
 git/git?
In-Reply-To: <20191121105414.GA16238@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet>
References: <20191109020037.GB60198@google.com> <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet> <20191113011020.GB20431@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet> <20191114074117.GB17186@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet> <20191121105414.GA16238@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eJDtCgpG9sqFZyBJpHxKaO4I9ti9XU0CKaNMIxMuAXgZE0zubdk
 JOxrmZ19f+VwrdsfdBTHe83Baq96EnhJND3i0oi4LZNZKnIZbu6251O/8bEeDqYosA8QcYK
 /8FKK6sFvMG65PNkFXnJ7WU/l5edrRkzTTl/ixBndqi7UD5ljn7s8/Md2G+DlD2vXzmY+Sm
 PqgCpzDNygDbX3aWG1KQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HoQxUKw0zaE=:bLVukoAefYUnayuttLtNSu
 P9eGMFVqkG9/ykhs04VqKBRC4P9HaLiv8r0qR8CH6fdI0DwBiaTP51zdTtn/7HZyFBZcDTb1m
 9oayR0y6gs0XolLVFx8M/nId0Lp7PWoJeWllFWiTpvfDFqPbgYeDHfIhxVLcvXCQ2srrawDd9
 fSAwK5oyI6wF7wc+jJnRKb35YuPDgvhcKxEabgMqY1Shfaiopu3G99wfv0Ek9WG3/TMqCsQci
 frW/wr8bo+sbHvfnhuPFT+05FpSPxl5Br7rt0AeWPR3IWNvIWjPowbMuEMm6bjylRn7SM2fWv
 6+6aE7vFCR/vD56tImj2izvmNwFn7GDm/TgoCjkKE3mQKPLBU6W1zJKyvzUyNIzXm4f+tT3Xj
 pdsxZa5I9ulYwKiqO3EZLEAZAnTUMVlq7qZzNE2qUtm5yaRBCi0CEFhvaba6dmLXxlzproewe
 AqxsHEufni7ApHLsLaDjcJWcSUYEM8whSQ07GxMzDr2h4s4gYp40zdiOymUOT/oggO271PW8U
 /VaKjz4U7zC2JQlGl8clzy9BTzKfVm14hiG8aEko9j6quOew4rlNkEUHHDsqu8hp1+wOiD3B7
 r+FvN77scyggXDZCbCOHqvQ+/awVSxkxHqg6xe05bf1HoKMBCcxjCsFqX1mNyn50oj7v7bUzN
 d8l8VamJjI0Fgh9n8CmCgIak4v+8TYBxnNChoCACMjxbHxXSimtPXIxIISCdLdEhGUNgjlNdq
 k/b4Pn6Obe1oRvbBGwQ1uRkxTwernfCxwVl8TZ9UXGwoArTxfuIed4tJfcRI+Km2og33XpKFV
 lYSUTEK4wZ1iz268IyUsgDgS/IQsEdK9fALUFFuiUofea12iQKK8JAhJ6YRfKeD8crGrTmqxs
 7gkS+6XP+d0CxEB+5bo39Hoq28hKUhhrKRp2gSCH11YjjqBy1NsxtqWQFb6vYAHeXPpUSMz3d
 eX0VQUajq1EwbwbjUopa6BP/mJxpMaBcpGFhrxbmGomF3ps+8fZd6XFfNn7PYewG0ieHBG5gg
 lHWexEWZdfx0Cw/hrk3Wy29L+PDACB2FfaDxTmu0MnFORpsXCGKef6bCjmVl685sBX27WUNsT
 tF2X7HpPz0ZIlVvmWTsbjqoXZ+7eGbN5aqBZeqakreYH31zvdYXVNElKe5PY9TphqyiEsS7IB
 kzXP2mY+SXqdqhpvD8ESqQUHKmxc0ooTaBcsXexPGIYCc/7A8o+3273pdxl25gY18133aflSF
 51kgeYAM1K6rsKkoXXXudI9qO+5x9jovpLJ/I5Ou8Q8vqnjweYiczyIoPZ74=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 21 Nov 2019, Jeff King wrote:

> On Mon, Nov 18, 2019 at 07:37:57PM +0100, Johannes Schindelin wrote:
>
> > Yeah, it wasn't easy. But then, who does not like a little challenge,
> > especially the challenge to test things outside of production? So here
> > is a PR: https://github.com/gitgitgadget/gitgitgadget/pull/148
> >
> > I trust everybody with even rudimentary Javascript skills to be able
> > to provide useful feedback on that PR.
>
> Wow, thanks for working on this! I don't know that I'd call my
> javascript skills even rudimentary, but I did give it a look. The real
> challenge to me is not the individual lines of code, but understanding
> how the Azure Pipelines and GitHub App systems fit together. So I didn't
> see anything wrong, but I also know very little about those systems.

I actually spent some quality time with the wiki in the past days to
remedy that. You can adore the result in all its beauty here:

https://github.com/gitgitgadget/gitgitgadget/wiki/GitGitGadget's-Azure-Fun=
ction-and-Azure-Pipelines

> Likewise, the explanations in your comments and commit messages all made
> sense to me. But that may also be a false sense of security. You nicely
> led me through reading the patches, but the likely bug would probably be
> one you did not even anticipate. ;)

Right, but it does help to have somebody cross-check the ideas.

You probably also realized that Chris Webster and Danh looked over them
and provided useful suggestions, which I incorporated. One of those
suggestions was to document the involved Azure Pipelines ;-)

> > To build some confidence in my patches (as you probably know, I do not
> > trust reviews as much as I trust real-life testing, although I do
> > prefer to have both) I "kind of" activated it on my fork, limited to
> > act only on comments _I_ made on PRs (and sending only to me instead
> > of the list), and it seems to work all right, so far. I cannot say for
> > sure whether it handles the PR labels correctly, but I guess time will
> > tell, and I will fix bugs as quickly as I can.
>
> Yeah, that makes sense to me. Going from one repo to three is not much
> worse than going to two, so it's good to have a testing area, too.
>
> Do you want any third-party testing there (e.g., a user who isn't you
> making a PR against dscho/git)?

While that would be nice, my fork is a mess and not really set up to
provide any useful target branch...

The real proof of the concept will come when the first git/git PR will be
submitted.

> > Question is: should I turn this thing on? I.e. install that
> > GitGitGadget-Git App on https://github.com/git/git? This would allow
> > GitHub users to `/submit` directly from PRs opened in that repository.=
 I
> > am sure that there are a few kinks to work out, but I do think that it
> > should not take long to stabilize.
>
> I'd say "yes". The status quo is probably worse than a system with a few
> bugs. The worst case if it's disastrously wasting submitter's time is
> that we turn it back off, but I have faith that you'd just fix the bugs
> before then anyway.

Yes, I hope to be quick enough to fix things.

> Is the existing Pipelines integration enough for you to turn it on for
> git/git, or do I need to tweak any settings?

All I need is to install the app:

	Install GitGitGadget-Git

	Install on your organization Git @git
	All repositories

	This applies to all current and future repositories.
	Only select repositories
	Selected 1 repository.
	git/git

	...with these permissions:

	Read access to code
	Read access to checks and metadata
	Read and write access to issues and pull requests

... which I just did.

Thanks,
Dscho
