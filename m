Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47CF200B9
	for <e@80x24.org>; Sat,  5 May 2018 21:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeEEV5j (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 17:57:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:34057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbeEEV5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 17:57:38 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhB9P-1eaEnT2mrn-00oU6z; Sat, 05
 May 2018 23:57:24 +0200
Date:   Sat, 5 May 2018 23:57:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
In-Reply-To: <20180505182631.GC17700@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de> <20180505182631.GC17700@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1CPGL4d6NI1l1mo5UJVXmycTh2jB62SwaErN0GIjP0mN5a4F1oK
 saEO3bQNjnK15fOwOEhMekuQ6ID04eCxcrpaCyJ8xGaRhcjIDZ+5JA4O7njKRpiFMW88wRA
 toSDpnDmbd/x8s/lbCC9MrZZ7GzLyJCuQVvtAjXkLCX0iasg40GaPSNBN5y13o0Uec+WD4F
 IWRIV5BzD/EM+FQ8tH4fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hckx0PLrzp8=:o8966oUmFZQH2J5pu/G8/3
 zuF7N7MDQhLPliHXYzCwBTWj09vbOtUemn5fUdtbcwsQbMx+o35cZc4GMIJrKu/dCiJIiBjXo
 0+Znj9Y0aOGCa/Rqc1THUeHi4zXOpEcrFwKgcxCkaqNR5w519Urc6NcbeHABWfTtNXOSK9Lte
 7chSLH9jT0RT4Z/tJJqMotI7zHWpqBTugDLkabrrfC0AJFDtOiLFHavYUsmEto6Gfunuhw59k
 qASeR53HepzErSDxzxNAjjJQ6p9OkkTUn6+nwMRLvxrpwlDyXcKVvd4xsIjwRtS4MCWfLFR31
 DjilLUK+zeGKfNA5bveje9NI0pHxwCLP9xGDRwes+VBgIhE7QLXnM3Ph8XurvbEwrQ3RELK72
 TIVVHB2JLnOj5BwaAC6CPAPXR1hA45h5zCXceGIPQabKNvfRvORt2IawDMXOlM044u3G9mRi+
 gFFOTU6lE6838btFTisrVIU/9wboHsS+waR3v1WZRUuF3qBQSAgNPOnPe425hoew6I2I21Q1p
 QRIcouKn15UlxiJag5qckTH9TJhWeWer9lL1ZqziV6TIbZsQYh9XedQk4N/gAArjePh9Y8lJA
 K9W8VRVcr9hllE6TlziEe6FJUzpfx1Kkvd0xJGfmTBr7dAs54DCOXrAgYt8HG6BIIjn3setPi
 y1hi2HKvSJLLODu07NDie05GXABhuYffRCk4spFLAMjNU0glfTSVk3N+meetSJ3ZvmIfELlma
 GDi3Wl5zvKyh2+Gvfq0YyyE1sheFFi90D1AWcsJEIUbpsgBjweuH76/+O4dFOGrUYUuql+OKC
 ErPED/I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 5 May 2018, Jeff King wrote:

> On Fri, May 04, 2018 at 05:34:32PM +0200, Johannes Schindelin wrote:
> 
> > This builtin does not do a whole lot so far, apart from showing a usage
> > that is oddly similar to that of `git tbdiff`. And for a good reason:
> > the next commits will turn `branch-diff` into a full-blown replacement
> > for `tbdiff`.
> 
> One minor point about the name: will it become annoying as a tab
> completion conflict with git-branch?

I did mention this in the commit message of 18/18:

    Without this patch, we would only complete the `branch-diff` part but
    not the options and other arguments.

    This of itself may already be slightly disruptive for well-trained
    fingers that assume that `git bra<TAB>ori<TAB>mas<TAB>` would expand to
    `git branch origin/master`, as we now no longer automatically append a
    space after completing `git branch`: this is now ambiguous.

> It feels really petty complaining about the name, but I just want to
> raise the point, since it will never be easier to change than right now.

I do hear you. Especially since I hate `git cherry` every single time that
I try to tab-complete `git cherry-pick`.

> (And no, I don't really have another name in mind; I'm just wondering if
> "subset" names like this might be a mild annoyance in the long run).

They totally are, and if you can come up with a better name, I am really
interested in changing it before this hits `next`, even.

Ciao,
Dscho
