Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17AF1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 11:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeGJLkO (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 07:40:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:51795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbeGJLkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 07:40:14 -0400
Received: from [192.168.0.129] ([37.201.195.87]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MdaiW-1fQnnB1daG-00PIcv; Tue, 10
 Jul 2018 13:40:01 +0200
Date:   Tue, 10 Jul 2018 13:40:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Paul Smith <paul@mad-scientist.net>,
        Daniel Jacques <dnj@google.com>, git@vger.kernel.org
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
In-Reply-To: <20180710022141.GC10248@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1807101339370.75@tvgsbejvaqbjf.bet>
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net> <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet> <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net> <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
 <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com> <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net> <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet> <20180709195822.GA9000@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1807092225120.75@tvgsbejvaqbjf.bet> <20180710022141.GC10248@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:87xd8vce1Lqa58zhyHVXEhcZW8fBZRVHPcnzoBA431pQBNBlVaK
 c//kiHKJWsKU8zBOb7MRd1N8pLq05UPMyaAQ41BhR/KHizyesrd4amkpUZN2CjzD3FiAfFV
 us2cQZtarT4Ojf4Iv1DO79mJbDJ2/pziEPNPMi2hOeZYojHZzcs4UDOiA9zRbbgOthS6ko7
 ucYlKRXxwJEITJ6udMUlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sfIpaVwG8aI=:W/8UisZTZovx8NAEc8Hy5A
 LNOxi5fLzpZntohW7XwkAmm+7/mY4kYZxNq4HWqc1S3qC1ktLnjk/t7I6azq8Q6w9VNw/kWf9
 5jVP6jqw1XXnFO6wt0C4w8Ns2FwvMvwS3LQDsLha3eHTPBufaMFEANF5KZzLiPVANu5uXPpN5
 Nto/kKFPllRFt8ZwWUjd4qvyTD1t3WqpQtsV0M8BteRsQ20hGph8fLptB2rnmp+JkGVgNYlzb
 rJ6QJCEz/Lagj0HFwW/tMYGsQM8yvlfwITFlC01qP/VcYoCk6IzDlHOswfd5s/dPXjPQeDjQo
 37JnuFDebhloqP+RftLoiiCsFitwgcKe4Ofn2ejk7K15q8D0qA/eyq7KhrWLpg6T1pI3u3Ptn
 c8Nvo6h2C6dL4kDcTmh2oswB1RWcS3QiHiwhbpxGoop1qIxwygQoPUBwr950rFZt5Db3Rqp7e
 PZAK4Y3V89DmwO97/Pq1ziCnACG4e80Nq/MWCAxyGnN2ZvMHzdraek2Pf8uWtoeBVV9oydMGM
 Kf4B/80xSscXdZI5NX08MXtWD1/yZFbkQWsmF4HixG3U9cZOxuzkNBo2iPY6sC8dujiAgpC3g
 YE210xVpxVf9LpYWt0+5+3KgRL6dhP0ear+ZLOk/aocIbbyhIKxFiA9mzRVxmnXEm3BNBTMCo
 +PF0K/1uHMvKL21sE6hbCq24msXkwppac2WFvVdVDaob0aQ0dMWHh1HdkZ0qHcveDRSoHreJ6
 IwVnPvUqBk9prM8MZEZFstH6uSCMdh6oFx0neASSu8MbHZhvLvYiEobq0m3nazjBUNeCqxlZd
 T/TU8Yf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 9 Jul 2018, Jeff King wrote:

> On Mon, Jul 09, 2018 at 10:26:54PM +0200, Johannes Schindelin wrote:
> 
> > > Would it be reasonable to make RUNTIME_PREFIX the default on systems
> > > where we _do_ have that support? AFAIK there is no downside to having it
> > > enabled (minus a few syscalls to find the prefix, I suppose, but I
> > > assume that's negligible).
> > > 
> > > I.e., a patch to config.mak.uname (and possibly better support for
> > > _disabling_ it, though I think "make RUNTIME_PREFIX=" would probably
> > > work).
> > 
> > The obvious downside is that we would be a lot more likely to break one
> > side of the equation. At least right now, we have Git for Windows being a
> > prime user of RUNTIME_PREFIX (so breakages should be caught relatively
> > quickly), and macOS/Linux *not* being users of that feature (so breakages
> > in the non-RUNTIME_PREFIX code paths should be caught even quicker). By
> > turning on RUNTIME_PREFIX for the major platforms, the fringe platforms
> > are even further out on their own.
> 
> That's true. On the other hand, we have a zillion compat features for
> fringe platforms already, so there already is an expectation that people
> on those platforms would need to occasionally report and fix
> system-specific bugs. Perhaps thinking of it not as an feature to opt
> into, but rather as a compat for "your system has not caught up to the
> modern world by implementing RUNTIME_PREFIX" would encourage people on
> those platforms to implement the necessary scaffolding.
> 
> I also have a gut feeling that it is much easier for static-path devs to
> break RUNTIME_PREFIX folks, rather than the other way around, simply
> because RUNTIME_PREFIX has a lot more moving parts. But I admit that's
> just a feeling.

Your gut feeling comes from a lot of experience that I trust. So I'll go
with it, too.

Ciao,
Dscho
