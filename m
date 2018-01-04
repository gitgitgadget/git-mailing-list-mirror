Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5B91F404
	for <e@80x24.org>; Thu,  4 Jan 2018 23:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbeADXUx (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 18:20:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:63531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeADXUw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 18:20:52 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1nbu-1em1XV2WxG-00tj2g; Fri, 05
 Jan 2018 00:20:43 +0100
Date:   Fri, 5 Jan 2018 00:20:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Isaac Shabtay <isaac@shabtay.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
In-Reply-To: <CAK2k7nRdk5qBp6Xzud-GS7YeSpchrQoOdqRd-3uXVeWZ1xsnVg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1801050019250.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com> <20180103222821.GA32287@sigill.intra.peff.net> <CAK2k7nRdk5qBp6Xzud-GS7YeSpchrQoOdqRd-3uXVeWZ1xsnVg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JHkut95pUi4eMWEVwkWK/PZIWmnwr38AOXDu4RPlPD8JsUQ+LRe
 xsHcytSdZSNuJKnjR1P8e9kD/168GehOOKvoyG/B8HijdZg+LhoA8lE/hCj03RZd7SU3OaA
 BfQQnvuv3DGIQWVVD4kt9pkHzdO0Gw93L6e+eiM2m3VFMxR1VxXYmxEP1gYinlxHQX/nuCf
 WplHYpte69Tg6Y5oEc9PA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yi9nWug2EUE=:2wMg3/OF+wraILnHZTCXbC
 r+RY/fo2QeI/mPxQdzJxVrszCHvAcG/ER1J9rkMCbz3cOZ+J3s7iG/pkcPvvGfAlynkIQBpMB
 slRwVd+Wz7eEyYOqXrp8mTrzG6PJgiG9XW+GPlANpaR2Votrs3SL7lEdDZM4ZaEsxF4NReE/5
 +s5Vs4v2xWkweXNACyooBVZRYke36U+4afMQ9fJxeO1SOBpQDEkdAWNZ5DyIXCYAPJ33iPBT7
 ttmXCo40eTiIpApnqGXW4f8fcvBI2lycSRN4HfLjcXGX8H+t7V2Wgd7qJfc5dOsXHVJnwYxNo
 1ysF0I0FVBd+BdxmFwSZIG+aXdo2N2aK36C+81U/FMUeLAs7WfAn6i+Nw4DiQ+uPyvuS/5z2P
 LrWcnS769ZH9zj9otqPJ4XW7QyH9m4mEOIvQO5w8jB1Vvorzfnjw9cdiURBZJGqRQJqmtWxp6
 rxBxJmRSxBg6XTDfY1iEnz26D4Ou0f9uLVeu6qlbKY+Xzc3nKMGTYZAmur38d5+KJwVfc8YbG
 lzIbpcNxWbGdG6wbuTSBbabNF0Fpx+BZiToVo6SlITnsyDaZaeg35EStZc0VtmoOOPyWTCKyb
 +LDCUAjug0cYVz6ZUI40XbHwM9OiWiQ85DHsvi/wx0Dc2QLl6pc1LbIxRVdVPsTXcEeg0/k+s
 grkPEvAVw2kxCdA1TtZFhmzOPRfCKQl7b3F2AHGXSb3dAPDyJDPFLQg0g+FaU9C4ttHIl3LD6
 JSztCwvFQiaUcUW1HCv0yGVCx5U3kcNIeWF284qHJkMUsfxeo/66QEUaViqnXVMGEXKZcW6dL
 8adknVaRzHSyDqvTD9RgCk1JEZMCE6jxX3Xhz7STpZdvoMWE/X9EuKYDFGKHlJVRJlN8NUo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Isaac,

On Wed, 3 Jan 2018, Isaac Shabtay wrote:

> Indeed interesting... this one's for the books...
> Thanks for the patches. Any idea when these are going to make it to
> the official Git client builds? (specifically the Windows one)

If you help them getting reviewed, tested, and validated, I could be
talked into taking them into Git for Windows early so that they'll be in
Git for Windows v2.16.0. It will require your effort, though.

Ciao,
Johannes
