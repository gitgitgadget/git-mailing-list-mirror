Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6FA200B9
	for <e@80x24.org>; Sun,  6 May 2018 12:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeEFMLI (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 08:11:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:57847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbeEFMLH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 08:11:07 -0400
Received: from MININT-6BKU6QN ([81.92.17.130]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXZ4Q-1erXEP2mRy-00WYVl; Sun, 06
 May 2018 14:10:56 +0200
Date:   Sun, 6 May 2018 14:10:55 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
In-Reply-To: <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de> <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet> <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VT4u7VDZFFfvUVja64PyvqQmw3QB6ol8ej0zQ7BxsXvpm3X5qTZ
 Z9VQiSEocWWZANDT9sFxLb5idxYbb9l/aWutPyWhJgnlWgTcEO3+x2bNW+90UuvbQ3MS7hg
 +AVOJBKLV8OtbJd3ovQqL1OoAZixSbEmXCmhTe+fRsIT9ZFO7uL1GjUs/iad693f28CiOba
 Y93fANuWXbLGYlag8OuWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AzkcG4Lz38c=:poAkchKAjiXRlzMs6zHWjf
 QiFQIhXFdTsoTBoSHGEQ2XPvtqra7hFCQt3uxaV6EnKQeACIzdzOKMbI0+afqeD/uztMqVxoc
 ltIdA/9IWlfhGlx7tRNw4GGX6hyjj8hskCLS1ZE92mysiRTpKnHfh3k8TFfk3xgIrEqAaiRQe
 Iz/S2geMfJzVcugFV1utYbKLwcb9Y0o/2SKxSj2Pw4HPdCCMycpdC5Ozp5silxhR0TD/C8HzM
 StXoiATgbuyzCZ8TaoZInl8CNoCqRjNscguD9EIYO4FFXxaaWsDaYhzudBoFKUgKEDgIWqIK+
 qNh2VgfQnFxazPAcLepd1FfxfNWdIc/RFqjC0czTo7sQEj6kX7BO2YBzA6pUbNGj/V68uya8Z
 RrxWMUtTDKVYHsMl4gUfbgUO2wIwOrwypCj3e+VuVkirng0UJBfHsAJ7JjL6UTtt0FAHl4El6
 28aHETFzor5I3WQLMDkcOGkV1h4dKTetbfedsRMFOcunbvAOXK0zA4CHJ150cDOVyRhPN7Mh8
 PBhgFuaUwc2df5vMz4/29Ra21ibbo6XXykWcHHMkE5VDh6V9otUeyqtMvsYlllMrr2l+77bad
 4qi4EllwwrdU5njCBWTot03iBFGCOnE+LgFkPxTGb9Fxl4A8gQyPYVqZsGvgfriDeNRZHr3f1
 QRxM2UdzBkErFy8NvxyqBFcAFlndHL0hQ6S2y4QYJCvQkG43L0CovNwvNEaI8wRJ3sFhzhKRx
 JU/sTnjDuVM3gAQyqGtedSNNGpD1mzPpWikSGNqTeKx4JWsdCUFCtllzCZkjDXNNgZOpc4gVD
 AuS635V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Sun, 6 May 2018, Igor Djordjevic wrote:

> On 05/05/2018 23:57, Johannes Schindelin wrote:
> > 
> > > > This builtin does not do a whole lot so far, apart from showing a
> > > > usage that is oddly similar to that of `git tbdiff`. And for a
> > > > good reason: the next commits will turn `branch-diff` into a
> > > > full-blown replacement for `tbdiff`.
> > >
> > > One minor point about the name: will it become annoying as a tab
> > > completion conflict with git-branch?
> > 
> > I did mention this in the commit message of 18/18:
> > 
> >     Without this patch, we would only complete the `branch-diff` part but
> >     not the options and other arguments.
> > 
> >     This of itself may already be slightly disruptive for well-trained
> >     fingers that assume that `git bra<TAB>ori<TAB>mas<TAB>` would expand to
> >     `git branch origin/master`, as we now no longer automatically append a
> >     space after completing `git branch`: this is now ambiguous.
> > 
> > > It feels really petty complaining about the name, but I just want
> > > to raise the point, since it will never be easier to change than
> > > right now.
> > 
> > I do hear you. Especially since I hate `git cherry` every single
> > time that I try to tab-complete `git cherry-pick`.
> > 
> > > (And no, I don't really have another name in mind; I'm just
> > > wondering if "subset" names like this might be a mild annoyance in
> > > the long run).
> > 
> > They totally are, and if you can come up with a better name, I am
> > really interested in changing it before this hits `next`, even.
> 
> I gave this just a quick glance so might be I`m missing something 
> obvious or otherwise well-known here, bur why not `diff-branch` instead?

I think that is just turning the problem from `branch` to `diff`.

Of course, we have precedent with diff-index and diff-files. Except that
they don't auto-complete (because they are low-level commands) and I
*would* like the subcommand discussed in this here patch series to
auto-complete.

I think Todd's idea to shift it from a full-blown builtin to a cmdmode
of `branch` makes tons of sense.

Ciao,
Dscho
