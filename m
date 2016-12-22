Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F9620968
	for <e@80x24.org>; Thu, 22 Dec 2016 21:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941294AbcLVVjD (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 16:39:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:64627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941244AbcLVVjC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 16:39:02 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MI5JG-1cHQiW0P2k-003scW; Thu, 22
 Dec 2016 22:38:46 +0100
Date:   Thu, 22 Dec 2016 22:38:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Klaus Ethgen <Klaus@Ethgen.ch>, git@vger.kernel.org
Subject: Re: [PATCH 4/2] t5615-alternate-env: double-quotes in file names do
 not work on Windows
In-Reply-To: <54ba9cff-b6f7-7660-261f-393cd5181da6@kdbg.org>
Message-ID: <alpine.DEB.2.20.1612222237530.155951@virtualbox>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net> <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net> <d9d2580c-a2e5-d9f3-1f56-6814b2b2285d@kdbg.org> <00b6235d-c1bc-30c2-6539-6c78c4ce9eb0@kdbg.org> <20161221224222.6fn6irefmd6li6oa@sigill.intra.peff.net>
 <4e66fba1-d881-6a96-1e4d-da9c897353ac@kdbg.org> <54ba9cff-b6f7-7660-261f-393cd5181da6@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+3HBddCKJY0/fw7MEaRvwlN+CnUNLgUo1I6yZBXiHYMrR/0IMDQ
 WvLUq/mY9pQ7xwu1UP/GhVF2M8bEy1a5Kclbido1b/tu2VM8+TaczwXOCOqbXqtqtVhXHgN
 uedVy/UrItNWRkSXff/mxhqLBcCXJ2GGZz4Xv4I9We++JeA45Rg1Fn1B0L7CMlz6Y+OrFoc
 g4KOK1Ek/yca8E6a03d4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LTULO+xDIAc=:23BxXcrs5Z8btRmPiljSl/
 O35XridrFA2MAA5RHrAXVRif7K/KdlqX86z5nObS2m1OlFe6Hws6tgJggEnM+anERtBwA3XNP
 lD/oxnaqVep1kAl8SxXnQkmphN5rK1yVZj6XOmUZ8thk1pp+415Z3Y1Us2FR6Bu2YXwBfFAHX
 94Nc1GBcXjF/VBxNyqXZVL5ijo/zM12VljkRqr9NPc8TZAWNHqfOk3ODgmJaxwVqaBW1Ion/o
 Zzz8y/X2DVFVs2/wiPqx+LNxPErsVT6O53SjAaz3UvmOOBW8A0rXByhXgebmGE5cslCF+1aU9
 TDtpgEAWsVEhvRSCVxV5G3DecePP707Z5oXYG+j9YBPfRXWvb6aAIST3SD4sYAJ8ZSgPpXxTa
 RKqVgkuIvbe9JCZWATnD1fnQldcSHWz0bfA7W2mMLQ/l4HENfwSdRfvQo6Iiso5oq1C1vWDJk
 mcELvO5drr0gQV2afZhmqj8xK8147gV6Ayemcq2bMuYFwdAiK4aHNrY7Ri5m7c8iQ/ZJWEGLk
 rrg8LJ1ds5xFF/CbRyjsi4FwuwY9HBDZRQtE6a33GJQLRBkvxtcWUpImRsqghl8N8R4Rw3Xjp
 EWjB/WLw0YPzfsBEonRI2Ja11bEVZRScEe9KJbp/97aZdEgvjl4OWrqrx63YlACTPtcneyn4v
 FyDuwxf7X4CwsbVK7FCpMjJBuwMcly+VvWBMQBDa7JvvtkTMvut1RIbmA9c3V8u4r/uVd5wxU
 iDdWwInicGPHxk1kwkHdEiRjKpRuWxzk0s48NVXkKmvBKg1lAD7/SNFjjHMFDWnj+mz5pYssJ
 05Dk3ui
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 22 Dec 2016, Johannes Sixt wrote:

> Am 22.12.2016 um 07:13 schrieb Johannes Sixt:
> > Am 21.12.2016 um 23:42 schrieb Jeff King:
> > > Hmph. I explicitly avoided a colon in the filename so that it would
> > > run on MINGW. Is a double-quote also not allowed?
> >
> > It is not allowed; that was my conclusion. But now that you ask, I'll
> > double-check.
> 
> Ok, the point is that I get this error:
> 
> mv: cannot move `one.git' to `"one.git'
> 
> I don't feel inclined to find out which of 'mv' or the Windows API or
> the NTFS driver prevents the double-quotes and come up with a
> work-around just to get the test to run in some form. Let's leave it at
> the !MINGW prerequisite.

Double-quotes are not allowed in file names in Windows. NTFS would allow
them just fine.

Ciao,
Dscho
