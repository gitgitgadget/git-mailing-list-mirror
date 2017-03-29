Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D108E20958
	for <e@80x24.org>; Wed, 29 Mar 2017 12:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbdC2Mua (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 08:50:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:54895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932111AbdC2Mu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 08:50:29 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgIWi-1cPLtK3vC0-00ngFz; Wed, 29
 Mar 2017 14:50:15 +0200
Date:   Wed, 29 Mar 2017 14:49:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 2/3] sequencer: make commit options more extensible
In-Reply-To: <xmqqwpbazb34.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703291449480.48202@virtualbox>
References: <cover.1490194846.git.johannes.schindelin@gmx.de> <cover.1490285210.git.johannes.schindelin@gmx.de> <75e2c4fe839602af19811ed3e251eb583ff6c8ad.1490285210.git.johannes.schindelin@gmx.de> <xmqq7f3fa3oz.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703250100340.3767@virtualbox> <xmqqwpbb35e3.fsf@gitster.mtv.corp.google.com> <xmqqwpbazb34.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:P2PeBD+60WCajyuDcoJrbYZFjcXIZoIfK7H60AcSuOQqUBA0Ybb
 rYF59zXtv1ioZ/K4quwWGLVoe5a3l7m+pstS6ZE0hPeYpV9USpAclW0xDLBjsfKDWy0ll8Q
 tXWNmeA+7AdUe7Vo1dhlbAoqJgoIytgsXV7EUWYSXCqZ7s7IGqGOT3Nf2dnIy/7oR9rJV3k
 VIws8YPpmrXte17vG6VKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GWLlPezbQAU=:6zzBsGhaLY8xG5gqE9vRRs
 VXcXn3HbQYNkQK4LDBYicrhDJTRCw/wVgUGF9O8/3tn+5DGq5rdqB8/RDvt9nnOIR2eDrKytU
 O25qIaQu+JrqfAaYNz/9alx54hR7R+T+moI1rj3oDJs4ntGo+ZjJnkKTHHS1geSGFrXsO8o6P
 EQlKJrwF1sPfrg/x0Vj75i0xbnina/1VdGDTSDUmA8+x6Q/jrUKK3A5oygkfrBkEqeiXZ0a85
 j8/vpUqWKx9qVComWLw53gIcA4EwybxCLXNOeQGs0ZDsbMw3Uysx0WHPkPIYUnba9ra2T7fKd
 UCOnuQ4WWQ2dlvF0g+IoCfRd8cHow1lxHldtLJVN3V3JRBMc2mXbSGa2y5d95z/o1zyNlZhPB
 bmy5kXACXhjedPFOa3sHqpF8YRGd4q2CdjCG/cYtmte5tvffEkt2aFGBIaBtjoUOY2+wacQar
 aw8vZuv8xpR3i+RdfIG0LS+Iey/w5YLYlffG9XI9S/GuIjsfCLWOQIdofrtQO4+GoCIRfvo9m
 oVjjQX366RIJD48UQV7R+hbXohBD3cFsksKsFih26+lV8Af+aNYFgRQxyIV7hbLi2oobEU4Qv
 56ec7A9zDpkoUmI6IkYpA0mdCgtId5c366thBOXW4SOD1wpEq86K4pozwM4A89g9cqHIh3Ke8
 z3MoWKUFsUk8qFmni1IS2fIPLAdwhrsbZbZ+YxmQhRoDlXnXORUONx+xNoJONFMeDJZHwxRF4
 PKtXxXVfBizTiPYvALx/hKx3XT2BGkUIa+aQmHAsoeQMFHtqaKMAG3/yLEvtXcQMOM9mkK02Q
 wnRnVON
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 27 Mar 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > As this thing is about fixing a regression visible to end users, I
> > may get around to fixing things up myself, but I have other topics
> > to attend to, so...
> 
> So I ended up with this version before merging it to 'next'.  

Thanks,
Dscho
