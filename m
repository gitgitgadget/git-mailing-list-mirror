Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F2321FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbdJ3MiN (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 08:38:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:62200 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751975AbdJ3MiL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:38:11 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M6RmV-1dFVhN2qnz-00yT8v; Mon, 30
 Oct 2017 13:37:34 +0100
Date:   Mon, 30 Oct 2017 13:37:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
In-Reply-To: <CAP8UFD3qjmSrCJ1OE6x=sitbm7LqRB3aSm42aV4h=gAG853PhA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710301336270.6482@virtualbox>
References: <20171019123030.17338-1-chriscool@tuxfamily.org> <xmqqvaix8o6k.fsf@gitster.mtv.corp.google.com> <CAP8UFD3qjmSrCJ1OE6x=sitbm7LqRB3aSm42aV4h=gAG853PhA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7JC+8MNrLA43d8pp0lobGXhjHCfz22mhPmYJoc3VumombmAKmqQ
 lpnQqNU0sqM31xAQ7m3/xFIRSRvdZcdXW2iYpIc0bJy6mjWs/SS3FdPJX4ZRr+KO0UIkNyY
 AhgA13IRlLE6Sv1nt+EaXK9Y2wD9wMnq0WCAa7dtVrpfsB0y5Y3hEVeB3gg9TpeQfBlrJwt
 m6vybcc4NP+Vv1dDq+UwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bnW+NYhGmiY=:5QTViTyqzN5vYsWCeKi5PR
 Hj+KOdhr4l+GNffq+p5xyWBwA8wi4ko/udTnbe8v/FkwnlbVTP3gO+29S6+bfyjvruTUiYr8R
 ihLRPodMHN+byz1dzejoNXSIeZnY0JZgt/E8p6sMdHFZ6+aT3yKKQ/nrqLiujiZC2pBbF+7gv
 qHFqFIj5XNjtH7W6ghTqPTLF7lYR1vMFZAgtsiUL/mHKb65dLsUk92LvguCdts2Xi2F1BBq5F
 wrUqNSohbcGSsWxYUvNHHhV1drESzaziNBPO+tc/uZMAFx1XRjknQtpIaXuGXLumlhqfVwCCL
 NYwtm9gvrCasw6lmZJT2PXdD2Y5k/cH1Xo39po0J79gTepSIVIXtAQlhcBBsJJlb9RSuYY4PJ
 u5TNw4FM6eG6Li8QlO9u6VEIAUEv+vX6JIyHaE/ZCymmOL2SgDNpyeBicR/PZQRYQ7LCNcSAZ
 mjCcKzymfNPZ27eBsK2/BsERsv21wV25KabSrvAw/s2sUFiTJui9SsYdrkp3onbFikdXqkNOz
 GToMhbju2zVzQaJyFWTKRZFZWDEZMf1v22aUtHap95l0che3sOQCQZx1y4SWWac3LB1nuLOvb
 amioIYMmu0UGMq2+es8eAa2dQVOwB74qbGS6Ub3VghDqUgNTeus05hBdTebnJjTlsye1Atz/4
 Oj9XRrbcglaBQBlacoGm+pcpvUm3Tl277W5L0YYWvPkpH0hDQ9xH4pr5wEuwPHYSZ71XD8EKf
 C2bFfq75nKUNIVmLXGIzEJqv/gzAdA2Y+Gqdj4vQqe72vR4O0Uf4tBoqllt0Jd3rnmqRD+YPi
 ukahNtj9pPFG9j86WOEHyoYXd4rMIJdIrcyyoTzMBzwZKJQXPAe0xT1MSVBAUIHoorjQao5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian & Junio,

On Mon, 30 Oct 2017, Christian Couder wrote:

> On Mon, Oct 30, 2017 at 1:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > I've queued this from Dscho; please take it into consideration when
> > you reroll.
> 
> Yeah, I was planning to add something like that, though in Dscho's
> first email the patch was adding:
> 
> +modules += Git/Packet
> 
> and now it's adding:
> 
> > +modules += Git/SVN/Packet

Bah. I should have paid more attention. The original Git/Packet is
correct, of course. My fixup! commit is bogus.

Sorry for the confusion,
Dscho
