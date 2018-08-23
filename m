Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5945C1F404
	for <e@80x24.org>; Thu, 23 Aug 2018 21:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeHXBMv (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 21:12:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:54253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeHXBMu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 21:12:50 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcnRD-1gHXO91zmR-00kC5o; Thu, 23
 Aug 2018 23:41:06 +0200
Date:   Thu, 23 Aug 2018 23:41:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
In-Reply-To: <xmqq1saoixxs.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808232333160.73@tvgsbejvaqbjf.bet>
References: <20180823023955.12980-1-kyle@kyleam.com> <nycvar.QRO.7.76.6.1808232254260.73@tvgsbejvaqbjf.bet> <xmqq1saoixxs.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7BXUagFSGJgYZPxy/z2aqyUOujS37Le8iVMMxHsVD9HjAni9Gi2
 w8tuODR/CKrCL8t+MQdUAnVteHwjJgKTrCcd1HBrH9zCV236PCzuwWPvkiq+6p/WknCNJoQ
 TuELXmRb+JBHwfxEKhI7kWXnaGn24jYaIvcmnE2mH4WXIYzYp3J3Grt1IE4AG0VtRLZbqpw
 pJj6De8U6WzKhTDX5rNxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W+6+xTbxvx8=:JpCzdpzo/uGxcMOXzLfv4C
 pSSPJbF2s3czUHP20Hq5dU9UGly2USs7wfkJaeGEKzB9IrfLyEh2AbROwhM2V5pIUdxQ38b5i
 arG6bK/SjN3GN6wlFfv7gRLqg5R8IGkif1JsnMa/NIyGgMeQzaeRc5WbEO+Lvn1qinRhhIv7X
 x2sWbW3ZGL0AXFsbTvk1zMHvcc0yUrAps+x7g3j3KcfcpBvWzSVr1FgDVZChPcP0mtHq1aO6O
 Cy4BuGzTBrHeKR1c3B5rvE5X+PPhwM1Ur6HzNKMu9IPgY3x/g2eJ2Sj/12NrXWD7eOofaa0Nw
 cUlimIT3sNfrhz+mHd6UosY+gU+Al2eh3tinToCaStEc8D3MzXNBjJ5jL8ebYnj6UvMkif1M+
 jKLvchrK6bcVc9tXi4mbQGr6GiHa2Ir6xFDlLzVyzujz+fEsks1vBtFHo72dUW25kWHLfAgjB
 uso2SpYjRzSf30TnalmLj68Zv8DBH5gGPfKHc/EPfW6brmUI78usIU5UWSTzexNA5qATQ2PtN
 5DtZLqlaAlWE1vcizDKh9gxJ/gt08wO72H0BuFz5J/nCDSkzCWRZZ5xU8caOFoWBu3rtZR6/L
 Sv+XUlr7EaYhCpPgpXHRXbqvj3BOKV3bkZq8Y4H/Bi2nlvBXwUmPyP0Z+N3TTydpeUGlP0pbT
 d03FNsOoJaFXRHof5UTt+kvvWnVBquP1LLZdcnDdBocQsa69OcFD+pu4d7So5kPSjMMExEGm1
 0G4JQx24wbBHd4R1euiwRwuHICmS0NO87z2+dZQwot7jlVlS/TqC7zU2fqbvfMOFSwW6GGTtb
 NOdtk1N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 23 Aug 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 22 Aug 2018, Kyle Meyer wrote:
> >
> >> 275267937b (range-diff: make dual-color the default mode, 2018-08-13)
> >> replaced --dual-color with --no-dual-color but left the option's
> >> summary untouched.  Rewrite the summary to describe --no-dual-color
> >> rather than dual-color.
> >> 
> >> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> >> ---
> >>  builtin/range-diff.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> >> index f52d45d9d6..7dc90a5ec3 100644
> >> --- a/builtin/range-diff.c
> >> +++ b/builtin/range-diff.c
> >> @@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
> >>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
> >>  			    N_("Percentage by which creation is weighted")),
> >>  		OPT_BOOL(0, "no-dual-color", &simple_color,
> >> -			    N_("color both diff and diff-between-diffs")),
> >> +			    N_("restrict coloring to outer diff markers")),
> >
> > How about "use simple diff colors" instead?
> 
> I am wondering if it makes sense to remove the option altogether.
> I've been trying to view the comparison of the same ranges in both
> styles for the past few days, and I never found a reason to choose
> "no dual color" option myself.

We do have a track record of making decisions based on our little bubble,
don't we.

On IRC, there is at least on publicly viewable comment by a user who
preferred the simple color diff, at least in one use case:

http://colabti.org/irclogger/irclogger_log/git-devel?date=2018-07-13#l97

And I am living in my own bubble, too. I think I heard feedback regarding
range-diff from some dozen people. Multiplying 6% by the download numbers
of Git for Windows alone... that's a lot of people who can put
--no-dual-color to good use at least in *some* situations.

In short: I am hesitant to remove a feature that would help some users.

Ciao,
Dscho
