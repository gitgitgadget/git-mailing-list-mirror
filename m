Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D955120193
	for <e@80x24.org>; Sun,  4 Sep 2016 07:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbcIDHVn (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 03:21:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:50346 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbcIDHVm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 03:21:42 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MFu0Y-1buFVK0DCQ-00EyxE; Sun, 04 Sep 2016 09:21:24
 +0200
Date:   Sun, 4 Sep 2016 09:21:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Aaron M Watson <watsona4@gmail.com>, git@vger.kernel.org,
        Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] stash: allow ref of a stash by index
In-Reply-To: <20160904015209.ba6arov46ntr2ouq@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609040914200.129229@virtualbox>
References: <1472944878.19860.4.camel@gmail.com> <20160904015209.ba6arov46ntr2ouq@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kwXWaejiSaM0HCqujDPK/KU8uZo8vcwJcedRd4N2CPEA25epRKl
 0rSuFizofOta1StrMPPl0gRg/hStgTksx+eWn6sNnQlVOR9UZLGtJbCoQn4lBQj13H20gn6
 3fw5NZHHMmIRH31kiSAEdfUsiNtsziiR/Yy2aXq5lEowQCivHZ60FbQkq+26Z6R1uYH+rJj
 ci3/MavFAHPCYpwLNLacw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Aay47EWpHy4=:7Ex6Jo2R0gRwmlaSbZRLjp
 TrXLy4fcYpM5HDKBQ+xxNV+TthaqnuLg+KBMpvd+a1t858usBbH2ByDZrleVe75oGdn+80In2
 DjRPBJkISBS0yOc3DV2I3QP6irBbE+g8BJUBjVPJoP8nT25v8waZ0F8SgpS4vt60qjLUV4Rhy
 Ht0Zwm5hbknA5ZczkaJQcUbDeoSGL6zLwCXvMRq0ihTtFHOyZJh8cXhjzPL1yTFNQZ8z1CMZW
 DuwwXWJYXYHlazTClkng5ivHm67bfUyMoNkvDYbC+IZlHAZxIIfcLdivtRmOpzi5Ul8bzWQyT
 G4Oa87Bb+jg31Ug83VD8hDuxZlPAX2zCfQ0Y0fCkDWX3PeNO8beIIMXCgtOKikjFQIV/62zDr
 /rs3G5/XDFqcAHUYMxvottFP6g/Xx1Kbkg0JBOIHj2U7fkvL/hhtQvZKXOkKbXyHSdtyfoNrC
 1I26AOMTuhVV5UyN/7sgokHFYEtWYqPphPiUeKZdI8PHXbEMVmheM7S11rAJ0LD32k6BdCAOk
 /QneoTwF/zxoB/vXM1HiOZbbpbxl5hbl3a2unHOjp/4Yyi0eYfzrB09cdlf+t2BC0zNpLsVRI
 3FMEWnwmF/iNC7sTh3ev9UIxR0Cp2Z/xrOn/34i/hjx5YGZ2mw9GhwfTk1z9tfN11q6Htkx4m
 GLg/+E7rU3q2Wz8K9UhfwxGtRbl1jceW3BxzKnxITWI4Mi7cz8zXyMdT+sxgPeKXWWx2b9i3/
 laFezfIuaiZg81faPyCbZeyUTUaXEMyv+KbHTtZBK4/yJ4BWLJB3DvzTbiPqopI0Pf3FGLOFg
 HdEnEKW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 3 Sep 2016, Jeff King wrote:

> On Sat, Sep 03, 2016 at 07:21:18PM -0400, Aaron M Watson wrote:
> 
> > Allows stashes to be referenced by index only. Instead of referencing
> > "stash@{n}" explicitly, it can simply be referenced as "n".
> 
> This says "what" but not "why". I assume it is "because the former is
> more annoying to type".
> 
> Are there any backwards-compatibility issues you can think of?
> 
> I think that "123456" could be a sha1, but I do not see much point in
> referencing a sha1 as the argument of "stash show". And it looks like
> this code path is called only from is_stash_like(), so presumably the
> same logic would apply to other callers.

Maybe we could make it unambiguous, e.g. by using #<n> instead: #123456
cannot refer to a SHA-1.

But then, '#' are comment-starting in shells, so they would have to by
escaped. Maybe the best option would be to introduce a -n <n> option,
with the shortcut -<n> thanks to e0319ff (parseopt: add
OPT_NUMBER_CALLBACK, 2009-05-07).

Ciao,
Johannes
