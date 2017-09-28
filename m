Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C39E20A26
	for <e@80x24.org>; Thu, 28 Sep 2017 16:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdI1QPx (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 12:15:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:64767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751355AbdI1QPw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 12:15:52 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MN604-1dzpSr2ZAm-006foK; Thu, 28
 Sep 2017 18:15:37 +0200
Date:   Thu, 28 Sep 2017 18:15:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [PATCH v2] git: add --no-optional-locks option
In-Reply-To: <20170927065430.cssyxxsxjhp7k4ye@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1709281813130.40514@virtualbox>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net> <20170927065430.cssyxxsxjhp7k4ye@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vHpHz2O4DYFoKfRxLfkQ/4rZ5GcBLxngZRcgqekLkgP9+E9WYue
 9xPQPBG0MkRv0ydeIGYwDwJR0M/qv0vtat/YJoulsIo9aoYIkvBHYW3Y9PUu3EwjFNIO3in
 LqNexGrWimf5+1VfBFCb5O9xZRucJ+0orwe+O9xI54eS/ia8hiBfdmeK6op8ENAfDXWAEq4
 b6CZWDuoXgiqG9WftokPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tf3ZoBcYjAU=:16ARnp0trFa9aE8z3ldBjO
 XDT+NK2HZN1IQ2uLR5+9v10YjQTiTYJHkvTyPJYF4YETLw6lgrQIcxtuuM8wmC3bwkx+OKnrO
 aIJmtBFmwM11tx2qyc7JxWkI+6pc9uvZvZvozJsHxaHnwypq1sjrWPcg2+j2avvD8U8RvFDlx
 YbcovlJXhNlHB6DSqJvUwivz5QBVU2IZ2b5EOUoK60Jby+rPPQq/+OLNmpmqYxvANGaqqiT/m
 8PVIMX8+kujrgQlBF0dV7Azf32FQS1ae+iMNms74LJyUKXxmHTjzHjlYpAtBZY1FbchlqTw6G
 8+2aURn2MCLurcuYDY4q3SZkEcOxg3aqM0ixusJ7TGLIm6/cAbyJoaEYYDJA5hFj8xiqMVr3J
 CzuQfAlyCvFLVIF7Dsc+gDLCYNsRndiZzp/vYMBsVKZlYDT1ZEG/FyRp57tyioBdQAsYepSVE
 orr/iyYjB7fu/wBes+ft4pfhg3Zg8lN5zN8q9u98Yiek6Wr8REQEVl0HnTy9vxmFibud2lZWQ
 ZCH6HwRUvkZ3NzmpgY8ePQ9I1m6v4W/z/5gX+Blv/NMVavIEOk/A6Wcu3BKZ9S5isvEcUDITY
 0E+i1akCWEQFdTsytyoj1eDDPn3Eq8bd2G518G92g6bv+UUCZfx4DObp+IgHpf5M+dYwpkxJs
 C9oQNpngB1w9fgQhievxpx5cNXFTOqBbZSKdIbP7ZMCq3MqcLcImVLPYeOF9McnsOyXQLmAEJ
 d2VormsYUMyTFa6c2u5YQu3VYGn1yCr/vka/3GVT4ldd1KWMkA9yaztX/1Mu+l96FEXlJHet6
 30PGWrb5u6BdBBA7UvJS6Q+gM0kUTVAsf/WawbgGt44TGHWuYY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 27 Sep 2017, Jeff King wrote:

> For the other comments on v1, I decided not to make any changes:
> 
>   - JSixt suggested marking this as a local-repo variable. I think we
>     really do want it to cross repo boundaries to handle submodules (and
>     the GfW version does the same).

Indeed. We had it originally as a local-repo only variable, and you
probably guessed that submodules made us rethink that approach.

>   - there was some discussion of alternatives, including reader/writer
>     locking schemes and lock-retry timeouts for other callers. This
>     approach has the benefit of simplicity and having been tested in the
>     real world by GfW/VS.  I wouldn't mind if somebody wanted to explore
>     lock retries, but I think we'd want to have this feature regardless.

We also weighed other options, and took this route for simplicity. It's
possible to explain during an uninterrupted elevator ride what it does.
Makes for less bugs.

And yes, we wanted to test it first before showing it to the Git mailing
list ;-)

Ciao,
Dscho
