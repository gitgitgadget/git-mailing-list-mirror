Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DFE91F453
	for <e@80x24.org>; Thu,  7 Feb 2019 14:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBGO0t (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 09:26:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:47843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfBGO0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 09:26:49 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0gww-1h6gWd1oT8-00utRO; Thu, 07
 Feb 2019 15:26:41 +0100
Date:   Thu, 7 Feb 2019 15:26:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
In-Reply-To: <20190206184903.GC10231@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1902071518340.41@tvgsbejvaqbjf.bet>
References: <20190203230152.GA25608@sigill.intra.peff.net> <20190204205037.32143-1-martin.agren@gmail.com> <20190204233444.GC2366@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet> <20190206184903.GC10231@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:itB6y0XNzXzjMWU1q0iTxtQdV29nIY3k+AlG7Dq6SpgD/7PsQpp
 lrqVXperjxt9lUE48nudKSIJMufRYs7odViYap916cn6yc1HhpxGN/7ih9eFWOPI/cRl4aq
 gM+IKR+xTb5GNHUL88KBxI4twI/53ByhOImJEoSjAto9FqIhYir+KWR1lE4//dY1rmSmO5t
 7h9dP37kIa8i5UZed8mQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+/mPcWULgUM=:v+xfjnke1YjyPRMzyx/13r
 xg56h1IlqQ97Cnv+NRJJChLxZkVZ9uIqTi8iHgroHBvbqeBcTxs4VO86RZnogiZI/ky/aO/zx
 ro/Vel/PaajsP2d3GxpK99HbByZzk8+v4qaKDGwimxZkuUrZ9StxepsDSqdL5FINKp+2vLKJg
 52kWzth2MkAOa8yMn4hBolfX3OcrupV+UkO+eJGMpowX8LkOrtE9O/o5Q/R5WFCz03su6cBVh
 xupmALSlGAkADQ4VxE0DtP24EwKLXR/bmwddpFtZefuJeg0MaEoHTwvE56u3G6bG6vbXYA1NJ
 WcoSLeEnvRrYiIwJWUiKDbo6+zOODkm2XLrL/SG2nyJuycIh1oOseXApSUSkunn+Mz2dHf8NI
 tPLQYkZ+2D8jj2jTzcImk1yz41f5pa9upYcQ01RHJIKxPuiJ9vqLCl0XSueUT849O4Rra9E+z
 G0BfuHIzSpQ7kbQ75mgOb72+y5f8qo+rfuS8qWArm0KpilnuEOtmPg836XHgGx3DMbyP35cXo
 MJiedrLR5mL9hcMslJYv/4EjIUKRi2ytxeqsMwerynJ0CwIFrodt4KIxsE6/SUAUMIQFWNNGH
 YSKoCNfa0mbiLr96BpgvIHU7WskhEqyBCnUxc0p63wGiyNwUyOR+ELd++6Mjhjh5C4QKKEEL1
 pBluPn8yUB2xnQ1h2g4MFl7W+YRptapXy/w91KHahoTDjPRlqojc0mryqKzi3/9huoSK6LiFE
 zeVRsFBRMyP5OA4DEnP8mbARGyjz9G9y7bYQ/WCWbLRqVE3b/HDjTvcCwJpchf9lyzN4/EjSc
 0qEle2iD3TXWxYgVx/npILotGG8s5uTExfqJVbDatIeWafg3PEvkbPyAH5l0W3JHeEFRrYp+z
 Rl29EpZekPji3iu//hSRXqt8m0m0wU9m7jgChX3d1gHvSnJk8S1ywGYpA+YTUPDMEs6L09Ku2
 gEGN1VgC44A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 6 Feb 2019, Jeff King wrote:

> On Tue, Feb 05, 2019 at 11:34:54AM +0100, Johannes Schindelin wrote:
> 
> > Peff, you asked at the Contributors' Summit for a way to get notified
> > when CI fails for your patch, and I was hesitant to add it (even if it
> > would be straight-forward, really) because of the false positives.
> > 
> > This is one such example, as the test fails:
> > 
> > 	https://dev.azure.com/gitgitgadget/git/_build/results?buildId=944
> > 
> > In particular, the tests t2024 and t5552 are broken for
> > ma/doc-diff-usage-fix on Windows. The reason seems to be that those are
> > already broken for the base commit that Junio picked:
> > jk/diff-rendered-docs (actually, not the tip of it, but the commit fixed
> > by Martin's patch).
> > 
> > Of course, I understand why Junio picks base commits that are far, far in
> > the past (and have regressions that current `master` does not have), it
> > makes sense from the point of view where the fixes should be as close to
> > the commits they fix.  The downside is that we cannot automate regression
> > testing more than we do now, with e.g. myself acting as curator of test
> > failures.
> 
> Thanks for this real-world example; it's definitely something I hadn't
> thought too hard about.
> 
> I think this is a specific case of more general problems with testing.
> We strive to have every commit pass all of the tests, so that people
> building on top have a known-good base. But there are many reasons that
> may fail in practice (not exhaustive, but just things I've personally
> seen):
> 
>   - some tests are flaky, and will fail intermittently
> 
>   - some tests _used_ to pass, but no longer do if the environment has
>     changed (e.g., relying on behavior of system tools that change)
> 
>   - historical mistakes, where "all tests pass" was only true on one
>     platform but not others (which I think is what's going on here)
> 
> And these are a problem not just for automated CI, but for running "make
> test" locally. I don't think we'll ever get 100% accuracy, so at some
> point we have to accept some annoying false positives. The question is
> how often they come up, and whether they drown out real problems.
> Testing under Linux, my experience with the first two is that they're
> uncommon enough not to be a huge burden.
> 
> The third class seems like it is likely to be a lot more common for
> Windows builds, since we haven't historically run tests on them. But it
> would also in theory be a thing that would get better going forward, as
> we fix all of those test failures (and new commits are less likely to be
> built on truly ancient history).

Indeed, you are absolutely right: things *are* getting better.

To me, a big difference is the recent speed-up, making it possible for me
to pay more attention to individual branches (which are now tested, too),
and if I see any particular breakage in `pu` or `jch` that I saw already
in the individual branches, I won't bother digging further.

That is already a *huge* relief for me.

Granted, I had originally hoped to speed up the test suite, so that it
would be faster locally. But I can use the cloud as my computer, too.

> So IMHO this isn't really a show-stopper problem, so much as something
> that is a sign of the maturing test/CI setup (I say "maturing", not
> "mature", as it seems we've probably still got a ways to go). As far as
> notifications go, it probably makes sense for them to be something that
> requires the user to sign up for anyway, so at that point they're making
> their own choice about whether the signal to noise ratio is acceptable.

Maybe. I do not even know whether there is an option for that in Azure
Pipelines, maybe GitHub offers that?

In any case, I just wanted to corroborate with a real-world example what I
mentioned at the Contributors' Summit: that I would like to not script
that thing yet where contributors are automatically notified when their
branches don't pass.

> I also think there are ways to automate away some of these problems
> (e.g., flake detection by repeating test failures, re-running failures
> on parent commits to check whether a patch actually introduced the
> problem). But implementing those is non-trivial work, so I am certainly
> not asking you to do it.

Indeed. It might be a lot more common than just Git, too, in which case I
might catch the interest of some of my colleagues who could then implement
a solid solution that works not only for us, but for everybody using Azure
Pipelines.

Speaking of which... can we hook it up with https://github.com/git/git,
now that the Azure Pipelines support is in `master`? I sent you and Junio
an invitation to https://dev.azure.com/git/git, so that either you or
Junio (who are the only owners of the GitHub repository) can set it up. If
you want me to help, please do not hesitate to ping me on IRC.

Ciao,
Dscho
