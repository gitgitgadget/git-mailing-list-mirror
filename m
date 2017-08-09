Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AAE7208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 21:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbdHIVmS (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 17:42:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:49465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752244AbdHIVmR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 17:42:17 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Llm9w-1d6DvJ1y6a-00ZQ7V; Wed, 09
 Aug 2017 23:42:13 +0200
Date:   Wed, 9 Aug 2017 23:42:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] dropping support for older curl
In-Reply-To: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6smS3GSf3A+2+WiWnFi5sD5sIp9ANlOftaf9RDmAvVK3qWEJFs3
 plEgiQHSohfBBjaluv4vruC/U2IpXVxeUWEZ+6f8UQSnIBpDoBnza+j2dITc2dDhvYSuLm3
 1qNRgnVD2J8Vh3kHfDT0Qt6wSr6xSBT8bkVNvW1MAZVwCpUraJXWjwZQ0CHpGWGQqNHShZ+
 1GBXqXd9Z2eWNjViiblww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CDYMgSKRAW4=:fQCeNLx3QmMLU/0hhH2YkC
 694iH0ZPk8W0X5kvbhKbrqHEoa67kwA13xjpbdEeFfm56sVjA/Rufb60nCJ23dJ2zvMpplXwO
 m5/Qsl3pvPWX58AbDT2cRF6FVQb2tOLtTD3m1P9rPFLp7nXGVO3gW0Q1uBca3U7oBtcNAAi3f
 UOxdZ1bS0D00D1QWXY9kFUHSRvDs4XGlJ6s483JxKXnnzRgrZNIvqq926OrBjN2yUJIybStvt
 fZ1tU4Ers8aRFtowIed26iPAeID/XgZX8q7VolUbBgMZj5X6bKmvQ7tm4cT4W0tL3a2bHKzII
 gtZQtQaxL+RjnSjRwLZId7t/BY+xx9Xib97QtsYIl/Hl5Y+vTlUa0Xoh2fGOx4h0kqTCoFwsC
 Z+N61oG2kvUi26e+mcR4D6egDqWEEAW0K9yfVqA2P4HIfRAlAu4/7h4gbF6D295NcBVw0d7ru
 9mXIwjvEw2VkfXyRbt7G7odOMGbsjt7AFXB2Qd0sSoSWKS/xZrSvwu8vuqptnpAn/AjmJSzyA
 EJJhMXBUViXXAdy7VZpYm521geaRnOKNuiEL2B2WJxZam7NZkJQgYsRHZ8SQIPPL7NHrJUJAG
 BsFwp/pf1PqmGRgORV82MIrSTbk8pgXl5CbfLAKiY3jpSH1q/pLcCdtsVtbc6H7qzqdFSu2jC
 sf7boYm6bsDPjufkl6MB3QA8NR3FK8QPQY/Kmp1y4TxIronSWJz4/BLszbbEa1dAbX1IWkUXI
 aJgzMjg5x1H7+2Qh6hzMW2IvsxvlU7Q0DVXwGfvW08gsA5woW0O7JvdbzFNmdfTu2yINOzWg/
 NOwO/zXdz1uJocwgfWdmt6XU4g96Gtf+sKi2spUxAoileBCIeo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 9 Aug 2017, Jeff King wrote:

> This is a resurrection of the thread from April:
> 
>   https://public-inbox.org/git/20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net/

As before, I would like to point out that people running with older cURL
are most likely not at liberty to change the system libraries.

I know that I didn't when I was working on a very expensive microscope
whose only certified control computer ran a very old version of CentOS,
and I really needed to install Git on it.

In such a case, it is often preferable to be able to build against an old
cURL -- even if some of the fancier features might be broken, and even if
some minor compile errors need to be fixed.

I know I was happy to compile Git against an ancient cURL back then.

Just so you understand where I come from when I would like to caution
against dropping support for older cURL unless it *really* adds an
*enormous* amount of maintenance burden.

I mean, if we even go out of our way to support the completely outdated
and obsolete .git/branches/ for what is likely a single user, it may not
be the worst to keep those couple of #ifdef guards to keep at least
nominal support for older cURLs?

Ciao,
Dscho
