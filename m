Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DBA1F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 08:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbeFAIXU (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 04:23:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:42737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbeFAIXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 04:23:18 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIMyZ-1fSFhh0PRX-004AbP; Fri, 01
 Jun 2018 10:23:10 +0200
Date:   Fri, 1 Jun 2018 10:23:09 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
In-Reply-To: <8876f376-db86-c3e1-b97d-9e33506f2df2@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1806011017560.82@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <71b00bbf-07e7-11e1-046b-f0241b82ebd3@ramsayjones.plus.com> <nycvar.QRO.7.76.6.1805032224150.77@tvgsbejvaqbjf.bet>
 <850f1ad6-752d-85ae-ebad-feae09a76c54@ramsayjones.plus.com> <nycvar.QRO.7.76.6.1805040829390.77@tvgsbejvaqbjf.bet> <019cce70-c109-496e-e043-c471dcb21e00@ramsayjones.plus.com> <nycvar.QRO.7.76.6.1805052130360.77@tvgsbejvaqbjf.bet>
 <8876f376-db86-c3e1-b97d-9e33506f2df2@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ti8tIxlRxaavB/V5QA5FhFhXOEjLGsaVJY6GyeCp9C9o6uBij5U
 FDSZUX+jvPN9frQBFCeALm4MvEZpI2s8pM3CmqdTfDBmiXJdV9AgeVvEwgxRrk/Oi+KubGd
 YwGtsWsHDxcxpSr3T09IOjanaBfHVmzsHKFdXLDIDUVl5Kq+xdur75KCZd88i3IwkLUaTNv
 eiEI1aBuFCiRGrVLg6eNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LYLuxeaenxc=:RYHF8wVVE1UTW3eIV+/p3j
 Avskp7/l5qRh6KaN58lQfUFcQav2jIlBNAPXbU/CEJNEGCuULm/FTJAsvWUsWO8OIBqeWJy3E
 Twp4UCk3OlKgpaRmxN/DaiQKlEM5Zgcyna/f6B0JZjmbQGQm5aTDvKrgWDB8UhvMokhTTh2Lq
 gdg7eTnnX+8Ty9ClIPWb+Ks9IPsyDXF/lVYfG847ygeDeb5Eyp2sRdsmL1Ye4YFJgYEQWQib/
 2k0pZFaYeYPkWJOgJNMDF8OcynWXdBlo4LdDaqcjNvVvnFiNcYAaCSdXfgNrj7PL3KxYV71eA
 kI2/vaSiPkzn7P4da3lnJRK80H0dGskRS9LCT22D8rGdr/oCP8RkBvuYUUKrznJVU2VqzwpmR
 w5iJeD2xJNaM+gPIh3EW/L86pqzIHKWuBF4P7wYRM78epB/wBw+N5xJ8Nk1Ko9CMB8UIL9qBT
 esG7ASnEff7ap9EYnc9xyDyLNNVZlyY13KcWSt1afwBVNrLG2WAcB9a4ct1rmFyznkgw5h1r+
 Kxyrv0VE9KmA/kmgb4mnhRpmczH+DCrA4tVDcf/K+65xJvqoTQAXcjfI3jYoX/aIoDGGPxo11
 gpKUYp2/aIMhWOoq6bQv7VlrGamz4QQus5ZQSPh71ALIjZ/Al6LSIdyzUOMeJI/GENTNQMsr1
 IXR+dZTc+A/yMC/3H0f7AYaTDdpU+t+vOR8j8C2bhTOhUuhjChIa1sD1T63lHodxv8USia26c
 uze0gwv2492FvQhEy9eDx2Wx2moeXA6Kje7JYdY4c1pxoKKfUdnwLH7k0wxUik2EO7YBhgua6
 X+H8UcE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Wed, 9 May 2018, Ramsay Jones wrote:

> On 05/05/18 20:41, Johannes Schindelin wrote:
> [snip]
> 
> [Sorry for the late reply - still catching up after (long weekend)
> UK public holiday]
> 
> > Well, what I would want to do is let the cloud work for me. By adding an
> > automated build to my Visual Studio Team Services (VSTS) account, of
> > course, as I have "cloud privilege" (i.e. I work in the organization
> > providing the service, so I get to play with all of it for free).
> > 
> > So I really don't want to build sparse every time a new revision needs to
> > be tested (whether that be from one of my branches, an internal PR for
> > pre-review of patches to be sent to the mailing list, or maybe even `pu`
> > or the personalized branches on https://github.com/gitster/git).
> > 
> > I really would need a ready-to-install sparse, preferably as light-weight
> > as possible (by not requiring any dependencies outside what is available
> > in VSTS' hosted Linux build agents.
> > 
> > Maybe there is a specific apt source for sparse?
> 
> Not that I'm aware of, sorry! :(
> 
> [release _source_ tar-balls are available, but that's not
> what you are after, right?]

No, that's not what I am after, because my goal is not to build sparse
every time somebody pushes a new commit.

I want to use the Hosted Agents of Visual Studio Team Services (because I
have cloud privilege, as part of the team working on VSTS, I can use them
for free, as much as I want, within reason of course). And yes, I want to
use the Hosted Linux Agents for the sparse job.

So I cannot compile sparse and then install it into an agent. Those agents
are recycled after every build, so that every new build starts from a
clean slate.

If you have anything in the way of providing some easily-consumable
package, that would do the job. I guess I could build sparse.deb via
checkinstall in one VSTS build, offer it as artifact, and consume that
from the VSTS job that uses it on the Git branches.

Could you point me to a robus, yet current revision of sparse (and ideally
provide me with precise instructions how to build it so that I do not have
to hunt for that information)?

Ciao,
Dscho
