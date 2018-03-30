Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8461F404
	for <e@80x24.org>; Fri, 30 Mar 2018 12:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeC3Mfe (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 08:35:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:57319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751118AbeC3Mfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 08:35:33 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M82zV-1egOE52kbp-00vg3Y; Fri, 30
 Mar 2018 14:35:20 +0200
Date:   Fri, 30 Mar 2018 14:35:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 0/9] Assorted fixes for `git config` (including the "empty
 sections" bug)
In-Reply-To: <20180329193932.GA2939@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803301433020.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <20180329193932.GA2939@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:q353gmLTDulQbE+Ro42ntv7hGrslSs2VxbgOn1gzcwB4Mf6DYoG
 oKGxuxTY2lJAZfSRr+m+ENJxR/Z+WR6m6R+Oezyf/Fh93QaNs3dI+OEvP/Vf/qSbN++8HYn
 odmgj/a4oYWTtaz60vokbuww4iPLY5nB4q3D5DHuaVdO5O61QFounDrn8uI20XxAkNKxMfN
 KVUX86cN3+cHEhmD5mpsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FOzAn5btz4k=:e30/5XDUp/Tdrk6G4WgYNp
 xTubIWWYEr5R5wmRg4IrHg/+2UvyhBof2ixku+X7aCQvyaje9HPU4mmgdd/TkxIkMCl3u8PP4
 5JB9qPbLlmMzbL6G+lJeicecVl9a9fBqYM8dECMwnO1C7AAyu5zTvwG3SzdQC9ORth5h4JkRF
 g1UQe66F6SOAe72VDZJjmTcIoHtchWX5rPgQmvgY/QGeAHH8ahnG+YYeJRb30UiWpHjX+kguo
 kouF6wR8nPdm4ljdxJPNUMDM4UcGk9ITJwbG0WdgaC7wiLzSCePRmiusfWKNxRWaEwLRoEpoi
 Mal39Ro6ycXxFM0NPOQhOT680Nb8u49Y9BP7O4HqelG/3yJRCYbdUz4EVLQOm99+hXzKcCS6F
 VeMlypsNQ1j7WKGHEJCXcQjH8aSyv8KMZT4+J0lU7jusN88gzd3f1akUNPbXICuxgSnvzOWac
 a7W6Tj9dTeGagLmEFXirD6jYweVJ2EI1d+u2qgT+FCcBsONoSWVQ5GFlDEzuG2Ec0O2oDDUES
 8kg4cXfwq38AyZYZNe/eJB2rinlU1Aal5CZ4BjvkWN4xh0djfyBjIEv+Z4tTzkDp+86viYJUe
 ghzKPH5OyNGFF2SRV2I0/wUiYnZanYTWa+2s1GMSvE7+X6kf+dzRrHwZ7ZktIfeFMpuVlGNoY
 FcGkPK6fm0TD72glF7qBQxnMvaAPXERhHIb4fn2CQEDdZop/hVSpRBVG03mTKqVgaBD7lP6Lm
 mVPcGmD457cBlKL7aHdz9l07tHS1RW9UuIhsNSEdqkzii5GKi4X32rvmILwzTUB5VFrVax6y4
 lMUNi4uFatV28ISDtA9O/xbPSWG60rUEbQIu67cySvia5sliCXFfNQMloQyhHFyq5+390fn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 29 Mar 2018, Jeff King wrote:

> On Thu, Mar 29, 2018 at 05:18:30PM +0200, Johannes Schindelin wrote:
> 
> > The first patch is somewhat of a "while at it" bug fix that I first
> > thought would be a lot more critical than it actually is: It really
> > only affects config files that start with a section followed
> > immediately (i.e. without a newline) by a one-letter boolean setting
> > (i.e. without a `= <value>` part). So while it is a real bug fix, I
> > doubt anybody ever got bitten by it.
> 
> That makes me wonder if somebody could craft a malicious config to do
> something bad.

I thought about that, and could not think of anything other than social
engineering vectors. Even in that case, the error message is instructive
enough that the user should be able to fix the config without consulting
StackOverflow.

> > Now, to the really important part: why does this patch series not
> > conflict with my very early statements that we cannot simply remove
> > empty sections because we may end up with stale comments?
> > 
> > Well, the patch in question takes pains to determine *iff* there are
> > any comments surrounding, or included in, the section. If any are
> > found: previous behavior. Under the assumption that the user edited
> > the file, we keep it as intact as possible (see below for some
> > argument against this). If no comments are found, and let's face it,
> > this is probably *the* common case, as few people edit their config
> > files by hand these days (neither should they because it is too easy
> > to end up with an unparseable one), the now-empty section *is*
> > removed.
> 
> I'm not against people editing their config files by hand. But I think
> what you propose here makes a lot of sense, because it works as long as
> you don't intermingle hand- and auto-editing in the same section (and it
> even works if you do intermingle, as long as you don't use comments,
> which are probably even more rare).
> 
> So it seems like quite a sensible compromise, and I think should make
> most people happy.

Thanks for confirming my line of thinking,
Dscho
