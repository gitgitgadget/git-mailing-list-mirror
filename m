Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF851F406
	for <e@80x24.org>; Fri,  5 Jan 2018 10:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeAEKds (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 05:33:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:53901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeAEKdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 05:33:46 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lux3h-1exdPn3wfZ-0101GZ; Fri, 05
 Jan 2018 11:33:39 +0100
Date:   Fri, 5 Jan 2018 11:33:39 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Isaac Shabtay <isaac@shabtay.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
In-Reply-To: <CAK2k7nTRAqQKFGi0OfVgub3vWZAkdML5p786L7UyhVDFtsk7Xg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1801051130500.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com> <20180103222821.GA32287@sigill.intra.peff.net> <CAK2k7nRdk5qBp6Xzud-GS7YeSpchrQoOdqRd-3uXVeWZ1xsnVg@mail.gmail.com> <alpine.DEB.2.21.1.1801050019250.32@MININT-6BKU6QN.europe.corp.microsoft.com>
 <CAK2k7nTRAqQKFGi0OfVgub3vWZAkdML5p786L7UyhVDFtsk7Xg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:x36fVs9IYglUBUkAviO+OFsrPQNuuuegX9OjqH5TJvC+FQ83BXu
 FFX/K5Ct2wb0qr4myMp4lQbyxi4t4P6VB9xokYUCuutj259enyBw62XW+BGaYhXY1w4bObs
 WpQ5vtvdBo6tf1dIdkFptZjqmj/3Qn/nc/J4oRJsXFmRdBJIwuBxMzpzy468bNKwDbNQSpU
 fTuWiXBAn2lqW4P18l3EQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fq8yz/lUF24=:5MGF2LLtyPVig6rld+nmPr
 Msaw3rASLvr4L0rk1EgBUYMDTr7c1vPlhIjNQAMMb9DXdhwK25VScJTgHihJ9g2Vgognl+pd6
 //pegOpRGh0aLNMZNjZnu8DkD7SBkge36NV1VA+spCcm2mUdrL/gxR4JWmGBaYmbhZggc5oW6
 ckoR5Jt9Ltp98VrCvbxrA3x8SRq7nWPC+U3+V1wEgfB/UAJTqEjdZvffNpI8IsF5exBzdFGfa
 d0Y9VmcKxC0LWCPJ3l2T66Q0sLXyJGqVAJlxCtAwi3Zfqn5Mtqp+IcRRDpbitc0VVXkj3GCkG
 fOlRqhuvWyVUPZ4C5WbZMZ+0gQbqNwpWfxKirZsvFPXqmOAg0x3vvSvEv/oHQnWD8Na3u9V/l
 icYrUeeDX6BwJMjGkrkCVmNYwWT/6gYxm+/WksXcC8xGiTH8fmUIKLxBPaXJi1sy24YMAAWCd
 wmzjreDC33EIs/Gfd8l5VKN0PsRJQJQz6OERQJUXa4fdRODxBI3vpJOwtIyUs/djLWrZykj45
 FrVPUQTD1PfB4YD35VSzm2EJLcvH5WrdDTczG+16eH8nPCGd7+e4ZPIvkxl8439TBSbOKv0sc
 EFDLcQaDeORvbgy0L7/hhuwBwJy0WsLZbMufzPPTZTGklmvTfazSvmcDIL/QmAx9BuX6WsCtT
 RuUgbx9jNRmUqNXmEfpwmah4eq0kJXIOIM3e6p6fJJEzFPlVxCqBI4rRAF/UsNDbKwB0C9K1J
 Hizx4SeiwjzaahCG7ddLg4uUYMS5KGVpr96sxGwSiNOxzKzTcdvmgMQmbTZdPWwI+vr1N/SWE
 2DkVa+Kmo2eTc4k/pMFy2FKmOFDALu/WRp+nn1CCTBjmcBjSUEZofuj+seOD5wuNy3kZnha
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Isaac,

On Thu, 4 Jan 2018, Isaac Shabtay wrote:

> I cloned git's codebase, applied the four patches on master, built and
> tested on Ubuntu Trusty. (After verifying that master indeed exhibits
> this behaviour on Linux as well. Just checking).
> Seems to work fine.
> I also looked at the code. Most of the patched lines relate to tests,
> and the one for clone.c seems reasonable to me. Added tests seem to
> have very good coverage too.

Thanks.

> I qualify everything I had written above by saying that it's my first
> time ever looking at Git's source code.

We all started at some point.

Now, if you want to make this easier for me, could you please apply those
patches on top of Git for Windows' master branch and open a Pull Request
at https://github.com/git-for-windows/git?

Thank you,
Johannes
