Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B6C1F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeDIIUR (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:20:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:47261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbeDIIUP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:20:15 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjN0F-1eUTiM2XCp-00dUQb; Mon, 09
 Apr 2018 10:19:57 +0200
Date:   Mon, 9 Apr 2018 10:19:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 00/15] Assorted fixes for `git config` (including the
 "empty sections" bug)
In-Reply-To: <20180406213358.GD7870@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1804091017480.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de> <20180406213358.GD7870@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jeC8HeQVeKseNs5ehO3/iD50G7Uht4zaQf5HHf32ime3EdKSEBy
 RH+lTrvA7jYNlLmDkacCfckkyqn2WqCUdJtZ9ElOsPWWs+dyHTWukhIivY8sp53IhFttMpw
 B0dYNLsXBKHO/Wf9UxCyU92NdiheTyt5F/lLRlU++0aK3tyw45nsknIDuXrYutt78IKNYoQ
 CnBXEYw6r3mTDSCiVwuvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XXLUCP7+SkI=:7QKd9e/n+c6T0DE8Q1ygEj
 U0MY5E9XGMMIr0qDnM8ObB3V87tkQxLPDTCjb93qK0IVqH+1fCbWRfilpTdun5fhUw6UPD0K8
 yMPOJXWmu368m9Jko89AYYf8+Pxb6TVwn1Cs7zjspu3L6+SZGEodB6jsIvYFKhG9AXd6RA61s
 XwDF8H1p7DYfG9g74jq0QFS/TTGoxpCeZXHSIW7KX0MbWPhfbWtutXqaTIMenu+Yk6OT0F7/2
 WVAR+YYQux+Rvhe7wESwbvQFElU4h5vxIX3g/Su3mPTDetl6PLdpMY/16u1JULfPyiQBMNuWz
 hD4tvdxogx36yEc5HptO6qhv5p768NYPeBzlNVRg/LBGzfH5tssQV1U0DJckXWaM/m5ovEHMT
 13n90YZqplOVYDn3F4fYRz0CLPypCcehXBkhzhXU604lEcCEGVhmHDrBYGE+cdoPS6ciS+Kvh
 zvY5t8iHlhirsPJ1rJcqd5RvRQpMxnD9GfxZLo4gswXoW5rOg/naB75G3pqXPXWn2MLHvQeca
 ABwZZts3i9NdFQBBDKAvZ1VYII1Z2rujPKSV5KYbpGB/zv4oW41U2Ga+pg18nMn/Lx+xfDUx2
 2r2534vuDmEEhg0di7XcG2jPmLzm4xFN1PVS/gWXEUvRItvycLuwY9G/znmgxv5Yh3uEulZWf
 w9vSPAHbFbEDB0RoF6fOW0Vyn661UCrf24z2RupwiIhcsCEZ/Tgn90WMNcwfKupwIZ3NPZl0m
 YWYoCkVEKnQwwBCXrYfXGB4RogIEsn4n6YyTk/VdzY/gnDXMCgkPT4qw3V4RwXTXtJlgwYPD4
 9ncgqOavkCElNyhmJn8OXQ+Y9SFo1TgR3YAd/mawCchUevbaWQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 6 Apr 2018, Jeff King wrote:

> On Tue, Apr 03, 2018 at 06:27:55PM +0200, Johannes Schindelin wrote:
> 
> > I am very, very grateful for the time Peff spent on reviewing the
> > previous iteration, and hope that he realizes just how much the
> > elegance of the event-stream-based version is due to his excellent
> > review.
> 
> Unfortunately I ran out of time this week to give this version an
> equally careful review, and I'm about to go on vacation for a few weeks.

No worries, and thank you for your review. I know I am adding more stuff
to review these days than I review other stuff, but I promise that I will
try to get more reviews in once I am done with this patch series (and with
the --rebase-merges one).

> I did give a cursory look over it, and the new maybe_remove_section() is
> much more pleasant. So aside from a few minor nits I pointed out, this
> generally looks good.

Thanks!

> One thing I'd like to have seen is a few more tests covering exotic
> cases that I turned up in my earlier review. Some of the weird multiline
> cases I care less about, but we should probably cover at least:
> 
>   1. Comment behavior when removing a section that isn't at the
>      beginning of the file.
> 
>   2. Removing the final key from a section with a subsection.
> 
> Those should both be natural fallouts of the new method, but it would be
> good to have test coverage.

I added this, in a new commit I call "t1300: add a few more hairy examples
of sections becoming empty".

> Thanks for reworking this, and if it's still not merged when I get back,
> I promise to review it more carefully then. :)

:-)

Have a good vacation!
Dscho
