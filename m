Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2A31FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 13:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbcGLNWk (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 09:22:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:60486 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbcGLNWj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 09:22:39 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lp3Lw-1aqwHH1miq-00evqV; Tue, 12 Jul 2016 15:22:11
 +0200
Date:	Tue, 12 Jul 2016 15:22:08 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Andreas Schwab <schwab@linux-m68k.org>
cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <mvmh9bvdnae.fsf@hawking.suse.de>
Message-ID: <alpine.DEB.2.20.1607121520310.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox> <mvmtwfve22e.fsf@hawking.suse.de>
 <alpine.DEB.2.20.1607121249390.6426@virtualbox> <mvmh9bvdnae.fsf@hawking.suse.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lmQ5+WsdqhWIZKlA2Q9j6983BcIJSUWcJujU3i3/nID+mvFap16
 S/aoAEPn5Fkri2GBeE79YB1/srSAtAt1YVURth0lLTPMNKdce2MEC4epRqfbTmumYHLTY5b
 nXjrFBwDr1lYEc7ZO2QeqWcIw1zVCZPOWGZsp4yrbc0HSnIW7sH7k5dnPqaqu/I34ylop25
 zzUbHXS1Fc2DPZL77G4Xw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:lASVQkfCJC4=:pF47R+EDM8C1dwSbl44mLZ
 QT12Gv10KCTgUeIHZ/1eTL2/ly6Y4Sjz4/f3lPo75CkCwcyF8kGI1jxSSOCbli1pTWrNG78t3
 jzQL698UiRPwragP4zuv4U/PkvbPemF3woyCzTkudlb9jvoNkMI4f3phdr0yLfj94gX8Gr2LQ
 jWHBTO7qxfx74pmaeRCv83rsaweezn2vgucF6PBhycC9HAeJ0Qil8t8ijBMYN1LdVwC4xjZmK
 rWBoXIbw5BHLtidaSSK3alMEKx4r0itP4U7K7pf6a9CSPSSe+1aaQzuj904BTdWAiKbDMkSjp
 +KuY3VHWuDjxNwCI3yZyt/OIfzeyeKzyec5QuhWV+k1tkfetYEN1CFcg+N4sqj+Wg/+K/tCdw
 q/kBCkZCf9pFmo3tknEmMTphjjjpanyXL+AP2Dkbbi6cKXYTPprQIXA5FTcojGln2fX9rAXIa
 LY5/YfTd8Ts83ZsN3q9zObEHJwAyN/EvYv6X/v+/+WyhFMarI1mEakdHDuU1QCiZuggNPXg+6
 thJ5sA2/nHAdc5QVXzrgA3RbWS/VgmB+zSVrYIvvpiM/vQrqbHgyexkliL9mFf1VLit8cn6RA
 Up5mrxGHV5Wph7ISDCFTbV5JdaKKl+jM/MgGr7DW/YN35vbMRjAQfTUp/xy2JslXWwNJDg5cs
 LBa9lZV8LQFN+KcbE5nAL68OCauUzppX/J45qmMV6SqbsnsOYEn4+bDgt2U3htIUj9AjRDbnR
 H5Ofc4THy1qo+5WA2mbVFJyr27rEDLrb6jXOBLJuxlwtvnMnJ6RDztDvqzimxp6SdCLYoMoMq
 XYVGs/V
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Andreas,

On Tue, 12 Jul 2016, Andreas Schwab wrote:

> Johannes Schindelin <schindelin@wisc.edu> writes:
> 
> >> PRIuMAX isn't compatible with time_t.
> >
> > That statement is wrong.
> 
> No, it isn't.  PRIuMAX is for uintmax_t, and time_t is not uintmax_t
> (even if they happen to have the same representation).

Sigh.

So if it is wrong, what is right? I hoped that my gentle reprimand in my
previous reply would result in a more helpful response.

Let me guess: PRId64 is what you would have suggested if you had followed
up your negative statement with a "do this instead"?

Ciao,
Johannes
