Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A54F1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeC3NAZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:00:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:42511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751254AbeC3NAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:00:24 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6O1v-1edcgN0NMh-00yR4K; Fri, 30
 Mar 2018 15:00:08 +0200
Date:   Fri, 30 Mar 2018 15:00:06 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 7/9] git config --unset: remove empty sections (in normal
 situations)
In-Reply-To: <20180329213229.GG2939@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803301454400.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <c246c8bc2fb1cd6fe6307463d299cf56fbe4dc5b.1522336130.git.johannes.schindelin@gmx.de> <20180329213229.GG2939@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BTJ7Ranf9IpPs75js+TEQlBSlulFy32d6c1ytuhxFCUUNMApQ1S
 rw9fR+8bmG/Tskur46dIMWsnzESY/z+k3kavvNhBBT9XJj9WMXOpQJZruNAx8lw1vWAqXqg
 paPDccxGApLto1CvgSzazqvq/XU+RLgKpCMncPJwET5MmPM+XRgwyYYRfEgELijb9PXQv7J
 O58pqfN4Nkf5yEsdS201w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jikYbNtcx5k=:99rr+JUx9JP028wCInTz7R
 xlfMiBmHJVK98H1tXpRjvfEdH0ZCPatwarpiJ8a6onrM0EQTnOvU9Rm1qRtXFDNmQDfL4JA/7
 oRY8nn/fKW+9X7NEW8pG/Q+nYWY8lum89FJs4o2KOx4D7g9xkpuFM6wA+Aj+ky9nAnfRQ+yZl
 od/FgKUTVZGrU24wIVbRrtS/zd/Bv4yRnVo3wqnvXIysJC4vkVELQkssScIpwGTPtS45i7dRU
 7+fNLlrqaASEvBYopLSguy3cf2WMgajHDtBFwXILIYCEQYjACTYMORjvY59kMe4B+TGS7osLY
 srB4CDB3nwiqfQLb4ZZfgxufECd3prXthylH5UhxqgzXErLfrQKe/o8rZ7TjqpS4Hus7sBzdN
 JIfwHqPBPUDMdvif8fBo9qaumQ+enVuQrox3/nglk2hmLCUzVbgjeWDvbrNeyPnzYcX0q0H1c
 +/6Cr+8kpPTjst4+15Hw/3TktfNH7/2nWpwC9I+c5VCUO7Rr55FVFQFCfUZzz+M8SAobqdqju
 HrUfeaRUfh8MmIS/GudVdg5f3JTCXWRlZMofp/Zmn/NMuQeXMe1R8UwtMbnaGHyl8kdBl9iOs
 /WxB9vlYHj9V9q49BTwa5xAS5A0NmnykQ+xlgldDwji0Xa1GovD2mb6TLNUiEV/bgN5sPy+bX
 8hA6zmfmorEl/1VdPe0e4DGiIsSz9z2had1m0t/U/NuB4Ka0IdANYm6XnYHWMRmszBduriNIM
 R63HcPowv5pA87Zo8cwlxWguHxYCFTRXo0TogZettmRmInbPURdqkx/745XqeGl7OZArUI/T3
 7jhF4BmlreNcNqJ+gK4DqlBZiiLqII2Rhy30HUYKsvxZIQGGr9d2Kqkvm98B6oEnKuTjZdx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 29 Mar 2018, Jeff King wrote:

> On Thu, Mar 29, 2018 at 05:19:00PM +0200, Johannes Schindelin wrote:
> 
> > Let's generalize this observation to this conservative strategy: if we
> > are removing the last entry from a section, and there are no comments
> > inside that section nor surrounding it, then remove the entire section.
> > Otherwise behave as before: leave the now-empty section (including those
> > comments, even the one about the now-deleted entry).
> 
> Yep, as I said earlier, this makes a ton of sense to me.
> 
> [... thorough review ...]

Thank you for taking the time (and figuring out my off-by-ones, am I not
the king of those?).

Your in-depth analysis of the backtracking approach also makes sense, in
particular the awful bug that looks very, very similar to what 1/9 fixes
elsewhere.

I'll take some time to go over your comments in detail, but there is one
suggestion that I think I'll want to pursue first:

> I guess the holy grail would be a parser which reports _all_ syntactic
> events (section names, keys, comments, whitespace, etc) as a stream
> without storing anything. And then the normal reader could just discard
> the non-key events, and the writer here could build the tree from those
> events.

I already changed the do_config_from_file()/do_config_from() code path to
allow for handing back section headers. And I *think* that approach should
be easily extended to allow for an optional callback for these syntactic
events (and we do not need more than that, as the parsed "tree" really is
a list: there is nothing nested about ini files, so we really only have a
linear list of blocks (event type, offset range)).

I'll think about this a little bit, and hopefully come back with v2 in a
while that uses that approach.

Thank you so much for that suggestion,
Dscho
