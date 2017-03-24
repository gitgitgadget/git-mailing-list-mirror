Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBC361FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934321AbdCXXuO (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:50:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:62889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754783AbdCXXuM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:50:12 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJSLz-1cu38a324Z-0034MZ; Sat, 25
 Mar 2017 00:50:03 +0100
Date:   Sat, 25 Mar 2017 00:50:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
In-Reply-To: <20170323202002.lfpuglqawz4ooruw@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703250044500.3767@virtualbox>
References: <20170322065612.18797-1-larsxschneider@gmail.com> <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703231716320.3767@virtualbox> <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net> <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
 <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net> <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com> <20170323193823.gxodwqv4eshgtqbc@sigill.intra.peff.net> <3CC8E237-86EA-4F35-A03E-15BED5869403@gmail.com>
 <20170323202002.lfpuglqawz4ooruw@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qh/28mRloAaQ+jVlvhlJiJeQYENRUUVmuht7bzf2RU10hFohWiN
 BPgxYC3sqJ2NM2CMNeToZi2iILV288l50h7nVeHsQszqAg65Ay4+aM72HcR/Z2iUdD0mZMI
 V/dbgKd0mmOx1mDwTWHb8sHIw/4KEa6+9OIaskEgZo6kTtMSQPC9NQ+qvNSFoIzw4E/m0ak
 cdb0ySTZA2OmsASTW7gQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XHjFM6JN0BA=:PTzCCK45X/m38U/uOhVOap
 eR6dvfwouCMx/qPCxedWDRx+9GUNAJDMvG1tpcxQ2SkZTOKvGNo+HfpgpReoC6MvEofpBzf+f
 epYGLg+lCJ7rndGHSizwJ+Fgjp4rbEksS/Y5SxSIHo4PO/2OJmBmXZKrox0PtwgEnTjDK1JuA
 LORjDHL96Z/SPgjFrupvcwhGI2N6AzTrIZPfed0BD9cR60T5VroI2GgH84BWQ8QNfZpsXl3KB
 lJNsrSm3AzbJ7aBcIdW8zx8XluEzVs96p7BTEhxN9cU+K7P6LBFXevOJLSjQkphO07kwJzN06
 yT7QTXZZVcpC4h2qcIlfsCJgk7h338FPoMpIj/gjXitoKdTGSYDA+VdmT8YA5vcUv4UiBZUse
 y130TFImydNqiXJjXKE1yYbVH6Gfu2lubU7WTetqbBVvaKALf/QdfSdrZ9bwSprTXpqwjR5iG
 osYP1wnJGI74JVrObVNIt6aePsQxOOZ+fT4YnbBExB3TbGxChCdJnFv+XSg+TD5kBGP+e1wky
 uQBF9xxk+CIRfrfZmc0CwRaJBY6G6FNtjhjPlVKSpr19PY7wyDr+dRb8Wq718b8e4ueydlbQ8
 zR3UCKQAD82SMKnGrXXOcyCq4f6AjCgvqWsiyxetHiUdMQWNPBedlNipFtP1zvu7bntUjk9ZI
 zaKaIFxx5q5GFuJgTghnXtd2xm0/vLeY4e6Yhd2MwbbMcJottUyM0weii9bLtBQyrA/EdVjwV
 0Il1+n9BcWTQFsCQfewlsVYeYNRYJ/nKek44RdoH4ypDGklpitt5yI7g7wvJ56ICiFYWFcNc0
 ttG8DOS8ZGcVRL/0WqJEH1FFiHbMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 23 Mar 2017, Jeff King wrote:

> My pattern is particularly spiky from Travis's perspective, because once
> a day I rebase everything on top of master and push them the whole thing
> in a bunch. So they 75 branches, all at once. That seems like it would
> be ripe for throttling (though I would much rather they just queue the
> builds and do them one at a time).

Travis is optimized for Continuous Integration, i.e. one or maybe two
integration branches that merge PRs every once in a while.

What we would need is Continuous Testing, really, because we do not do
Continuous Integration at all.

On the point of the sekrit variable: all I tried to do is to avoid
overwhelming the (currently) single VM with plenty of jobs. If the build &
test would not take so darned long on Windows due to going in and out of
the POSIX emulation layer a gazillion times (caused by intense shell
scripting), the tests could be faster. But that would require a massive
amount of work, and I simply have too much on my plate to take that task
on in addition.

If you have an idea how to prevent the overloading of the VM by any means
that does not involve that token, please tell me.

Ciao,
Dscho
