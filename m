Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A2F2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 15:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161580AbcHEPmE (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 11:42:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:58334 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161551AbcHEPmB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 11:42:01 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MVrQS-1bl7av0aOO-00X0Y4; Fri, 05 Aug 2016 17:41:49
 +0200
Date:	Fri, 5 Aug 2016 17:41:44 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v6 16/16] merge-recursive: flush output buffer even when
 erroring out
In-Reply-To: <xmqq7fbw4cqo.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608051739170.5786@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <3b4494c586574b59d80d0f1b88bd4c3d56b678cf.1470051326.git.johannes.schindelin@gmx.de> <xmqq7fbw4cqo.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:th9UCbRPmKWwrDnouFIPvb1byDNM3FQb5hAQ6K+PIKd1JyUIDJy
 iMPbUNz+IqOCH9jWX5hDQrky2OG/XksUoeHKGMgQNaUWATEQVhHzpWmtPGMYjJEcrgQ8LSM
 l4X/M1BVw4U3DJLpx9ePAYLNdBfj2f+oPw6Ylbttqkguix7gWb+S62zyorRg3neo+A4DAZ0
 hVz0a5cRb3vOsZ7Vq5VeA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:MrHENeFYvLQ=:2C7/FDHhmUkcFawu1do56b
 VtgnpycquPl6zdH3Gnu3PSQWB0fPE5QfcvOz0wgAAXZdI1PTqbucAuwCDXEmH9jrAOs/H+dn2
 iz934SQCnMBEdNgCEJHUfSZqWwf5ZjkqhHkv2pyL1peG8lA/5eYROtcH5kyi2kLZegluBxT7N
 23048SzJFvI05eSqgQFHRXzwyY9pk1cM5cyb/uvaBfVCwok/0BzO/tbSJy9ANrZYih7YCL+m2
 rMATRwGu5YLJOs2ezE8z/S/bpdkzzGANyQYhzXR8Hxl2FfEVS0ZH/0oC9mmsCG3W+rHzhndST
 z2RnbYYPrncmHWtjboXyYR+AhFiJK2us8+mqOswjQUlKwcvUTo5siFNrraeD5uL+GzsaRRUyW
 SkW/EEBHLs3bpzjn2A3ELkT7vPkT82dsocuV5yiYMfRkK0P9uWtNI240uiJlGMSbZTDg51pwq
 dzCwMh2xIjZhqAwORQP97Zvfy4lKfYD8NAGScCv9N6/bPvi9aswYKJG6ebW/QO9KE4Hdzzyou
 QiYD8O0AphRdbRkMkvDdfMfHv0fzlvWVJH2BzWTQVj81vAtCFKNcb374Omi3p52UJqvv82Epa
 u1GxYVeCwHbX6ER5WLvsWn9rk5smg35EbsMuETzx9gxzIPa24XWKz4maDHZSrucEUdSqmGixq
 qgETEt9zRMR164DE4cP/BprP/Oqqmq2gupFtNuFQmA+l9PES5oa8H2vlddVGVjdjGeFCM1s7a
 7/qgbVG81pE5lbmmsW2phA2zYZ+qS2YbgXde7eaSXmlmJZsSTwDVbhcUdGxC4rkZTMikRT2JU
 f+Ls2qS
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Thu, 4 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Ever since 66a155b (Enable output buffering in merge-recursive.,
> > 2007-01-14), we had a problem: When the merge failed in a fatal way, all
> > regular output was swallowed because we called die() and did not get a
> > chance to drain the output buffers.
> 
> OK.  Even though I really wanted to see somebody else review this
> series as well, I finished reading it through one more time before
> that happened, which is unfortunate because I think this is ready to
> start cooking in 'next' even though I no longer have much faith in
> my eyes alone after staring at this series so many times---you start
> missing details.

Yeah, well, it is a rather crucial piece of the code.

But then, I really tried my best to re-review the series a couple of times
(with my primary focus on robustness, not elegance) after working on
different tasks for a couple of days.

Combined with my long-term dogfooding and my readiness to jump on any
breakage I may have introduced, I am relatively confident nevertheless.

Thank you so much for your patient reviews!

Ciao,
Dscho
