Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E4F1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 20:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeDFUOO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 16:14:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:54149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbeDFUON (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 16:14:13 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyEJp-1ePNSz21Sv-015YXA; Fri, 06
 Apr 2018 22:14:04 +0200
Date:   Fri, 6 Apr 2018 22:13:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5404: relax overzealous test
In-Reply-To: <20180406195331.GC11450@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1804062212310.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <958ee6f006aba0c67c8e064d31206e3e68a1cc49.1523043053.git.johannes.schindelin@gmx.de> <20180406195331.GC11450@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:120lN7Q1bDdYBnSASH+tCksJiESe/53nPW/w/URhFmllXFxEaq+
 7IJ3YQ+yf2Ref0cRPgXKvHnpZu4jifHD2OSam1UWGT4mf0GvYpnuuvgUIKOY1Z+iioPFT6C
 Mf+ZE5yD5wjKyjJQ/hNVmzB/iYnlJF+iemvTOMjF+95m+fRZDlFmXNQX80FmIkjG+u4Thme
 Qb6FZBPhyAV8Geb3V9hqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/MnhLKequC0=:HUCi2ZOWB5TZsEdGNpiH27
 uYFh7ZxG7L8r4I8s5KtVNR8fTFZaz5ldMPK+Q7cbhf1bzEgnOLsTTg1MMYwYaTA0mGc7XHuSo
 Sfc8lqLmqQAb/7+iyUWJ+JyA1/qjmXxMESElxQKyauHhQWTkfKja2kXJqz7QzvhHNcGXMwu2p
 pPkv2swH5LdmI1adZeIgtwllL+YJvx4bkQpsn35EfbFm14+vcICdIRn96KAnagzkB7TOz3i9o
 LnqL9kwDK62pbJyo3VnRUK+duf0fra1eZVrrtTSRjB+nNBvw0iNuNYuS7QWNODOKGPcM/sQJg
 eL3OJ64dtSjlhfKF2izFbz4x2ZMYo3sk1ODL8nWoS0oRybA7CbdUlBR8Wl6TD3itHWar42ORm
 /W4on4Sb6pi1Z3o80MvZNRfAp6B6lwDY+iR1NwnPH/enPVxL9ObE+Z2FSrTUQTULSAXNQ1sB2
 IdMbjkJSM24v6lFh888DQUwfh7Id4TRy1hMwMdVQlQrnQdRk/5v2Gzzr7No3FUFLYmeLIlfhg
 pJd+/K37FmKPHg2fObDwDP/pKbFi8+2QFKHxQQEPt8lnHMobjS58pzsuJ0jrNYNWA80HH7rK+
 S6dfPdzgZlhdK3zukdCzkfuZcVo8SKMpgxA5r1LuO38WfZXUtihIrSibLTyLHiFgooCU6ROMB
 I8jC2B1EyyjFzyZ+8qTZZZV2+7Q5dWFT9f1VnddAgxsjh2Mi0D9xUxIUuQJQ9Ks7hE32mkZeH
 Ad1UzPpAK4lcOWy1k3P8exISyS6oZXkzcoiFE80q4Y7itZdNxUZdLcPQ59bQVw/raMsCm0HQY
 3ZEWKAdYEK180aT02qp89BvqqTagjKBDmBSV2R+WvPoRkZxyHV1F7XE4HQmkICsF+DSzMmb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 6 Apr 2018, Jeff King wrote:

> On Fri, Apr 06, 2018 at 09:31:22PM +0200, Johannes Schindelin wrote:
> 
> > Suppose, however, that you are a big fan of whales. Or even better: your
> > IT administrator has a whale of a time picking cute user names, e.g.
> > referring to you (due to your like of India Pale Ales) as "one of the
> > cuter rorquals" (see https://en.wikipedia.org/wiki/Rorqual to learn a
> > thing or two about rorquals) and hence your home directory becomes
> > /home/cuterrorqual. If you now run t5404, it fails! Why? Because the
> > test calls `git push origin :b3` which outputs:
> > 
> >     To /home/cuterrorqual/git/t/trash directory.t5404-tracking-branches/.
> >      - [deleted]         b3
> 
> This is from the same Dscho who complains about the length of some of my
> commit messages, right? ;P

Yes. I've quieted down, though, didn't I? Mainly because I see the merit
in your long commit messages now. Never too late to learn.

Ciao,
Dscho
