Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F247720248
	for <e@80x24.org>; Fri, 15 Mar 2019 13:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfCONnI (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 09:43:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:56715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbfCONnI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 09:43:08 -0400
Received: from [192.168.0.129] ([37.201.192.41]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHH6Z-1hH92f3ddz-00E5ZV; Fri, 15
 Mar 2019 14:42:58 +0100
Date:   Fri, 15 Mar 2019 14:42:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
In-Reply-To: <20190315031948.GD28943@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903151427460.41@tvgsbejvaqbjf.bet>
References: <20190312213246.GA6252@sigill.intra.peff.net> <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com> <20190313193909.GB3400@sigill.intra.peff.net> <20190313201854.GA5530@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903141228510.41@tvgsbejvaqbjf.bet>
 <20190315031948.GD28943@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MN0SH9B3JGmVO8WO3Z56KxDPnU/W1yXD23rcKNZbsYLObEY1Khx
 i/xcgp2tfBRWUbuhDwx45hEEuVboLVtHDZ76HwDcr7sZTCJUwiUWZ4kJ8QWBZ4fp+uO6AKE
 pii053oJZUHW40+n9HUEIlEDz6uSqUwCetUHJXgzch6WTGjzXtbcXtP942VHPp45f8t57pK
 W5B70DVe8evrynLl9eO7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ThpVpRSrT9E=:WrD6Cv2Qj1GZrkLXFn7j8a
 Z3EQDho9Z6a47E+8xIeY6KbH+2WXeytBUKGFc7BusDQH2SnM8G1bKHULkks/KfHuiHdOx6ITx
 waMbwZe6c7WInKO5S718AwzeghYQl7CNum2Xi7ZNieP0197wknJyvsy4tGpBA65XX/rw62j2a
 ru/U6LRLvpik7biVcMCLZk2g1bTdaWyYb0kmy/X8z2epEezr1M8OhO47a7VNE7FRM8H5jMVpX
 OGraSCuyRUYezb0mgC9ofxXbxfHvV0VMMlI4jm5BPYtVlCpb0ZpNT+RGlZWGvR+zfJJeDgWpV
 kWQ67O4hnmKeKmWOeHfntOp6mL0uywvq6Gdu3kzpd+ND/ShiRugpFoiXR3olw8w7GM7xS1nAX
 ugmWc5SRr8SX1p+AAg+5qf1OdWUQeDJMI1pzCK+fNHMX3WoYMVhZLZtIZOQEZbYNWakqIJGL4
 5noi+iaNAMI35pgsroWG9LuF9Shv0GojlwuQa22ja6pR9yoQmU2zs3tmGOCNFmUeTN5oEYSs9
 KJf7Jhkbg78ObeC5a99m0KdT2AIF/cknxbFRYG0I6gu4x4yjCdLPvZScv/G/bVKFL0phpKH30
 JZv3wWtlett4mzaHJz3KkFEYCHzGf0A8HetTIcsYZuIIaRZYMe9BWMzWsFYBwfeIRxNP0aogE
 d3sZ33ugFUQE8FrfFYM6DE7v+0Lbxq9NOMm0+OMO0x+/aFLzaaa2AIDDPLDH+HDZzjk1g0VKv
 eXDy1eAQhbB/wl7QtMZVZtxgfwb3zWKWhwytY+xoXAAVCxYgXHMIxXbi7mE3yTzU6SYwt9BeO
 1zNxRkFNF0ejI5KjpGnLFAHK/h9JLOO19zc4VFIoK5rPGJFRktr216eOecyzzoQVaJvm0WojS
 A3AazyzItplY5824kv5zKP/yqFAntvXXmFSase5jOiistnzc9gftKmAn6KAH8v2FWetQ/mEPC
 r1OsiZgl0ICzQ33fTDeCQOmBzGAVECO0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 14 Mar 2019, Jeff King wrote:

> On Thu, Mar 14, 2019 at 12:31:21PM +0100, Johannes Schindelin wrote:
> 
> > > Hmm. I guess it is still an issue in GGG. This thread has identical
> > > timestamps on patches 1 and 2 (and my server received them out of order
> > > by 2 seconds, so mutt orders them wrong):
> > > 
> > >   https://public-inbox.org/git/pull.163.git.gitgitgadget@gmail.com/
> > > 
> > > I do still think GGG has a more feasible path forward on this particular
> > > bug, though.
> > 
> > Indeed. And it is a bug^Wfeature of GMail, I guess, that it knows better
> > and ignores the Date: header of the mbox fed to it.
> 
> Heh. So it in fact has the identical problem that submitGit and SES
> have. :)
> 
> > The only workaround I can think of is to introduce ugly one-second-sleeps.
> > I will do that if it proves necessary, but I do have a problem right now
> > because my only GitGitGadget reviewer (Stolee) is kinda busy with other
> > things for the time being.
> 
> I suspect that may be the ultimate solution. Which isn't fantastic, but
> at the same time, I doubt anybody would really notice that much.

Fine, I'll put that on my backlog:
https://github.com/gitgitgadget/gitgitgadget/issues/81

> There are typically delays of seconds to minutes already in delivering
> email. Unless somebody has a 200 patch series, but maybe then it is
> kinder to the receivers to let it trickle in. ;)

Indeed. And you remind me: I wanted to disallow annoyingly large patch
series: https://github.com/gitgitgadget/gitgitgadget/issues/82

Another thing that I always dreamed of having: GitGitGadget could
automatically warn about commit messages that are incomplete, that
disagree with our preferred format, that contain typos or offensive
language.

Likewise, I had this idea that once we had some robust Clang format
definition, GitGitGadget could verify that the patches conform to what we
want, and automatically generate fixed branches if not.

Basically, all the automation I can get, to relieve humans from tasks that
machines can do.

Children can have dreams, can't they ;-)

Ciao,
Dscho
