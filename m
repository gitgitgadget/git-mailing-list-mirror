Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97DB1FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 13:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbdJTNRQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 09:17:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:52250 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbdJTNRP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 09:17:15 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjZEm-1dU0Yr29EG-00bZYu; Fri, 20
 Oct 2017 15:17:13 +0200
Date:   Fri, 20 Oct 2017 15:17:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 0/4] fsmonitor fixes
In-Reply-To: <20171020011136.14170-1-alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.21.1.1710201516320.40514@virtualbox>
References: <20171020011136.14170-1-alexmv@dropbox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PAVByr1X0VJlKQGW24t0ICqcZimNpn59XQa2zRERg3S7Qq+izbX
 YjFga1uTDB7Vp+LwGUtS76cZq7cYEAyFq/L2Qa+82R2/a59WB9Xkcdg8V4dJp0GNkuJBZuZ
 zNh116Whn7HqX5kORNUfMqk3yZMMuDQhwwBqgQrR9dQEs9jybIQksqMq18/lLY6mFaXgMbi
 xuPRW14Cnv/QTtY9+cj/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ICGpkvD6oq0=:2WTcyBGQKsbaNdEMHA2qB9
 0f4bS6Qlst6i5MfeVH4tTkjnobDEfdqD9uMZJXbBnMEK+HElIEAtty/RoCZ5nU/TdurF7jhS9
 nWrlfR5mvKQmPdbNeqfKaa9hz0mFABE7MIlwmIEsx8DmcBwi17fO6QLM7ClnMdhad/sjfGB7i
 l+wmU4F/zC5kmjFKTsk73IoPx+Tlil6fSnJ/MtwoxkgyM3hHdyL1XoXIG4ds2tQ3lyEupiATm
 9k/PD6LGvgXZWXuGHeFjb1dD8WbHl2UbuBI2ivQXCpk9lEjLxp4KDF3gJpdtkM8Q65L1IAG7K
 noCM1Zh3y42QfL1dfbnhYboiEt9lzrKKq6OdmpakJEnmvR/7nL71VTXsTlySR6c7yxZlKmjSt
 /uOPeAcmoPZiqEg+I1KwDcfM0pt0JgXPkuMnr2XoleM+CG8eVKiCzbc9E1X0hlSipYArMNN7y
 VK4t6iXRza/XeJzDthVqD0+fyyRSpmY7JbjXPUAc5o7Fn3ofppilbHQPh8mhl9wZHFcq5frTy
 wBVBkrQSyk/6PPVspNxApr2aBpuJDI/4l16gh9SWvvAPxJvI3elH7RjE0k3qpYE7SvWfC9vfD
 VuU0yC2oVZQShZT/L7PMh4mTThueftU6/O0w/ah/xfw+HPKwTDvORkp8x0IKPeBXsBbQo3mPl
 ozp21UQXFvQwPd+IIypc+7ytI2gB9Lj7DwPFBwMxrDeCkFpoyHCnJOLZzU/bmL9pk7IjYMJtn
 rF3FE24cuUof4HdfHcCqReNexkBftOKVgw1TwCd71wS8i2BgaKlm5mpSmhUcgL+PlyvbgtNhI
 dUpS4aN8WYKW6O6jMdT7PUbFs6cMo7GpxL/LshFH8eCc5s+dB7amlylyA5+A9R2rPjadf20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Thu, 19 Oct 2017, Alex Vandiver wrote:

> A few fixes found from playing around with the fsmonitor branch in
> next.

Thank you for having a look, and even better: for sending a couple of
improvements on top of Ben's & my work.

I sent a couple of suggestions and hope you will find the useful?

Ciao,
Johannes
