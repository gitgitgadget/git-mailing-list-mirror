Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E42E1F406
	for <e@80x24.org>; Sat, 23 Dec 2017 00:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756808AbdLWAPR (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 19:15:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:59556 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756065AbdLWAPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 19:15:16 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuOYx-1f9cHA1zzr-011itN; Sat, 23
 Dec 2017 01:15:11 +0100
Date:   Sat, 23 Dec 2017 01:15:10 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] oidmap.h: strongly discourage using OIDMAP_INIT
 directly
In-Reply-To: <xmqqlghur08f.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1712230112100.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <940d8daa8eb8d42b9f0a3ebf4c25fb6417e71bc8.1513940345.git.johannes.schindelin@gmx.de> <20171222171635.GA230194@google.com> <xmqqlghur08f.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WBHCxGe9j5yBj3VJc55rmHdqRBLYZOqR2UQnOH2u+kZ56N7FAR6
 hMI458WpMSjebOlJInQCtAU5GyiLPN/BEZev4/bC5QPu+7XFcawAV/lWfccJD2xah3Ba19W
 +ZY84jMAto8wC+O/2B6MrmKDxxSNBhxCHehVEhw4/hkJcnKq0kkDycKjrtlPvMIzKXfCLBB
 Y8wnnCr3My+9qs69ePG5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:acVJHhbKN8w=:ms+w9TgFvD77edwoi2uNAq
 oK+V/G6If3rO4/d83GJXgzJVY4cR9KW0PZ5Q1y5stLhsiA5dexonNZ+sUuFJy7Na68RBounoB
 228q4T8LsXWlOEy+osAMf4UYsYV5bXbgpW71lDiy99NM7qL2VFB4sZz9Bj+U5FWzxGAiF8WDQ
 gAQetTqlXlK/JRL0p4FPt9mGJdbboYkwlw8Zp0v0lQb2OG7+TANqeakcpUyloebWjjtV+UYaD
 IT1708qB+nlVl9aG55ubhp9cwnr4a8O+qoFPjbGUt6Lf46RqmNdYPTmQCKRwMEzLVdHl8g2YI
 wGbJYrrNuYcG58BhnNZ1wRspGKc1k0SvZi/Of7EOLZl3MGAe1Sq7Os2O8r2rr/NvgPNUYrhih
 lA4zivGNNa6eXc1vFtdCCnL7YhEWvp4fz/cZIuApvPHlQ2ULc4DVIYlQiPKqhWboY1ARr6Uoz
 YKBP+d8lQ+IhLxKnYHSla1/1E/+Oefz42zZPr3onijVtYJ9jvyIn19iIvrKsuXgEEqsLbqGvG
 p3SGEEneAcxt1s0stKpKF8An7h8jlS56v2qdC22QhFgdXUkulTtLwHL9zdvwOwKi9yz0mazJ5
 FNC2xNvlMMwdpPMuYE0vZRadnheVz7dlhO44Rwr/i851AOSSw05Bd+jGoaO8FdnCKSVNCxIwj
 KD8j+ggwdkfWeUtOOOABOWh36HDKDk3bNZdnGyQNgTHjCT0BC+xbOLEiOp4yuJpH3rI9voR1p
 Zz96ehmUopPNeZRZLuxYwuGAl3S3WUHV+51CRtRqEiIIU87lzp5IpveaE8yXLeKSunJ7TAn5O
 5Tyud/dC1S6kj9iflbBvAZ2n2OPWcoszyzt2Mgck8B+5kU3YtM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 22 Dec 2017, Junio C Hamano wrote:

> Brandon Williams <bmwill@google.com> writes:
> 
> >> -#define OIDMAP_INIT { { NULL } }
> >> +/*
> >> + * This macro initializes the data structure only incompletely, just enough
> >> + * to call oidmap_get() on an empty map. Use oidmap_init() instead.
> >> + */
> >> +#define OIDMAP_INIT_INCOMPLETELY { { NULL } }
> >
> > This is one way of approaching the problem.  Couldn't we also take the
> > approach like we have with oidset and ensure that when oidmap_get() or
> > _put() are called that if the oidmap isn't initialized, we simply do
> > that then?
> 
> Hmph.  Can you show how the alternative code would look like?

No, because I refuse to perform pointless work, in particular when I am
already pretty booked with work.

But you know how it would look like, right? The cmpfn() function would be
exported via oidmap.h, and a HASHMAP_INIT(cmpfn) would be introduced in
hashmap.h that would initialize everything zeroed out except for the
cmpfn.

But then you would review it and ask if there would be any use in adding
cmp_cb_data to the signature of the HASHMAP_INIT() macro, and I would have
to implement that, too.

And then nobody would use it, and the macro would very likely get
stale/incorrect. And then I would offer another patch reverting that
change (because there is no user) and replace it with this here patch.

As I said: pointless,
Dscho
