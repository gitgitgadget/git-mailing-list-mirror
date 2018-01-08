Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26A91FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 13:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932543AbeAHNnX (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 08:43:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:50907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755200AbeAHNnW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 08:43:22 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGzwE-1ecLJt25kA-00DmZN; Mon, 08
 Jan 2018 14:43:03 +0100
Date:   Mon, 8 Jan 2018 14:43:00 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, dstolee@microsoft.com,
        git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
In-Reply-To: <20180108102029.GA21232@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1801081438470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180107181459.222909-1-dstolee@microsoft.com> <87k1wtb8a4.fsf@evledraar.gmail.com> <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com> <20180108102029.GA21232@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aJpNi3faGhYwlWZNnk1fS6EzByTJCMQeD0s2XcH/fw9CBXhc9Vk
 GecdHuKcNxeh7OVvb11FBM1qychyKpmcJcaRlX7nfHRS4Ahm6G1MO7hK4hmOmVdhnBW6Jio
 wSX3je+eQY/Rc+8El0tbu0zmzmAcEueDJg8ugFWGEw7k6X7glI2JVjK74A255tuWr+n0xMU
 DQ/PanblqitNckCJChmkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UamB/mv7/9Y=:1tVca8z1Yq8RG+miBLPwoG
 VlgPtIblJfBtJr8U4E31M1nVBoEuIdK1DSCHz1cEkv3K5O9bGq7fesl4OMORsB6HMfrpGCaei
 iSGXRJW8ncAjfi4uK1hDaUm+LaGDX/Q6+JPYOgY07Ay0gKjmOLImCt3MwX90U34tiP9BBOQua
 VG0IEoteCtF8TAFI4TOqz5fpiZmG9v5DaoYWm2sUSxBEd05aJBqL+2T74MOQpbL+J6lqbWb8G
 JOzbOH5LoXCPzl4EJtkybCJNdYSBXwpgozKYce7NVG4Rd8GnS0zbGDLPch3hB7tN7DX8TcupU
 n6Odx8PuvvQu0cEu153WT4ntrEqESB/gTPpzBQozbcmAFBC2r7i1HMNlMI7zq463r+GKy/DR7
 641NMVMVtpwdcL0ZrqV0ujyNWGXKydEVKLpWHJTliWgClj9n6OGUwJ7dwdPEa2/W46CC+pDsP
 esD6Ng5VcXwGhdB5dqdUxLMXvkKnZPfyRjFF4+UK6PMrh330wyU+NFxbpsVU64iNxqMGxKNd+
 DR+uSQdi9gZ/r4FUmfDScKf7nTj4ckcHsGtfknhkLtc1uwzzj5tJ75V1hn6qbGHlWULQ33cKn
 f7ce4V7kmIZNn6pcwrLjyOC09Kg41vHG8Of090f6aQ4usMWVMennVxMe00dDGxqp1OebwkBG8
 rLLg71dvB4zxJsH3+zeyUC99x/m240454666L0EV11I2r130kIkuHpMWpWjFwUzYuw1s+dOoY
 /0ZkouUzR16GSYEMwR0TZlW1/A1qa77W51TF0aJCKwvX2OFq5FTt2OYJzLQscd5ImDQipZ66G
 3IyLaIdFPqGkYz21eRd+Cr3xdhfRwzv62Q6ONbm3O+5vp8eg1m0J89j0wZzbxqkR3xcCgkI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 8 Jan 2018, Jeff King wrote:

> On Sun, Jan 07, 2018 at 07:08:54PM -0500, Derrick Stolee wrote:
> 
> > > (Not a critique of this, just a (stupid) question)
> > > 
> > > What's the practical use-case for this feature? Since it doesn't
> > > help with --abbrev=40 the speedup is all in the part that ensures we
> > > don't show an ambiguous SHA-1.
> > 
> > The point of including the --abbrev=40 is to point out that object
> > lookups do not get slower with the MIDX feature. Using these "git log"
> > options is a good way to balance object lookups and abbreviations with
> > object parsing and diff machinery. And while the public data shape I
> > shared did not show a difference, our private testing of the Windows
> > repository did show a valuable improvement when isolating to object
> > lookups and ignoring abbreviation calculations.
> 
> Just to make sure I'm parsing this correctly: normal lookups do get
> faster when you have a single index, given the right setup?
> 
> I'm curious what that setup looked like. Is it just tons and tons of
> packs? Is it ones where the packs do not follow the mru patterns very
> well?
> 
> I think it's worth thinking a bit about, because...
> 
> > > If something cares about both throughput and e.g. is saving the
> > > abbreviated SHA-1s isn't it better off picking some arbitrary size
> > > (e.g. --abbrev=20), after all the default abbreviation is going to show
> > > something as small as possible, which may soon become ambigous after the
> > > next commit.
> > 
> > Unfortunately, with the way the abbreviation algorithms work, using
> > --abbrev=20 will have similar performance problems because you still need to
> > inspect all packfiles to ensure there isn't a collision in the first 20 hex
> > characters.
> 
> ...if what we primarily care about speeding up is abbreviations, is it
> crazy to consider disabling the disambiguation step entirely?

Not crazy. But it would break stuff. Because...

> The results of find_unique_abbrev are already a bit of a probability
> game. They're guaranteed at the moment of generation, but as more
> objects are added, ambiguities may be introduced. Likewise, what's
> unambiguous for you may not be for somebody else you're communicating
> with, if they have their own clone.

... this is only a probability game in the long term, when you consider
new objects to enter from *somewhere*.

But in purely local settings, when we expect no new objects to be
introduced, we do use known-unambiguous abbreviations.

Take the interactive rebase for example. It generates todo lists with
abbreviated commit names, for readability (and it is *really* important to
keep this readable). As we expect new objects to be introduced by the
interactive rebase, we convert that todo list to unabbreviated commit
names before executing the interactive rebase.

Your idea (to not care about unambiguous abbreviations) would break that.

Ciao,
Dscho
