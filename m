Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC3220281
	for <e@80x24.org>; Mon, 22 May 2017 12:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759288AbdEVL7p (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 07:59:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:53787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759282AbdEVL7m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 07:59:42 -0400
Received: from virtualbox ([95.208.58.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwgc-1dgtkJ3snK-00n6SU; Mon, 22
 May 2017 13:59:30 +0200
Date:   Mon, 22 May 2017 13:59:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix warnings on access of a remote with Windows
 paths
In-Reply-To: <cover.1495261020.git.j6t@kdbg.org>
Message-ID: <alpine.DEB.2.21.1.1705221357360.3610@virtualbox>
References: <cover.1495261020.git.j6t@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cExjepOinEOHl2wRSKLxzRQ/80/g0zBdTZk2epmwSNg5lacI+eX
 EuqeQDUET44stn5Q7IvLYdrmNgqNiJjub9x/dZRFuKR3nX3mnz+tjjIILWEYpDJgI3FXpjY
 P5irDZJue972Buqjx/Ye3UB8aBVay8AytRdJWPo8PApUqrN/M0o7D13LJ/vTP5UPavYrlqb
 e974zmbYkVWOp2Wy7SBZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:93uqv+531mw=:q8dfLxcmmu5c7JfC6S6+MT
 RoV6uhpJw3FRuWvhyIyhJCa8S1z9896VG+TuRSOgrkEfyCfCu51yR1g4ZCj5aTMYX9zxl6PUt
 ukpkJRLncUkmc4F0UoZ/nsw1hBq5Zj4dfnl/I5WtjS0Pf0/NTZG7IXkHpTvp8COv9i7MLtE8O
 3ZDR8xhxWggdnJ/jQ6JhcbOvf0Ue7rhA59+cWl2hTq6bHrkasjEwpKAy/KFUuYwgxFXubNpZ3
 uBldJsPeMq3bMgmxPDKqMhGJMuviX6NWXV6O8zl4eBm6ulCgKyG7CfqP1WVD/w5wYwdG9V04P
 4bo9zg+KHgS52nt5+PDz61oFef6EqRTRHzXFO+T01iQpFiJsqABKZ1l/l4FujbFFrc9Yf+w+r
 edqWrMeCqpnMPpArUXorqqFF8BkVqZbM0euAUl0zzEpsdvnQaZGeWTq9Yv9v10pOHAddxEZqX
 mfYpUQDPg+uU0A70sMb/CnmeG/nF4oobph08LCw+oHXi8hi7uBIAhpIVsB7yTU1s+zp44es4e
 4N+ysAeEF8H6aqDrW8mm44eU7hoR1EUiZAi7AO5cWer4pT2DWdZuM+Br1LSF44AlcTHLGUySp
 Vaza9CfHRKCy8jK9TnShopdTvcyK4I6HDqkFVgfF18cZzfSfj3THS3E40FUmrE6UPLMFmkyR9
 jYUJ9YUm9ANTBsY5bMx4cijfc5g3NEUxr8xuAFOxrzXWZLmRbUevlBTeNBK011YyTWq0DNAQd
 Zl4fVPf80S9Hb0IdgVXWPIvOHuAMcRJOQVLJSxYSPL56fxbtsgqWeB6H4AdPAPlwrjrjD5VWs
 Dc+3QaN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,


On Sat, 20 May 2017, Johannes Sixt wrote:

> This small series fixes these warnings on Windows:
> 
> C:\Temp\gittest>git fetch C:\Temp\gittest
> warning: unable to access '.git/remotes/C:\Temp\gittest': Invalid argument
> warning: unable to access '.git/branches/C:\Temp\gittest': Invalid argument
> From C:\Temp\gittest
>  * branch            HEAD       -> FETCH_HEAD
> 
> The fix is in the second patch; the first patch is a
> preparation that allows to write the fix in my preferred style.

Thank you!

Maybe you want to accompany these patches with a simple test case that
uses e.g. ls-remote on $(pwd | tr / \\\\)?

Ciao,
Dscho
