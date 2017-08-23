Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3C31F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 22:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdHWWgE (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 18:36:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:50539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751066AbdHWWgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 18:36:03 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBaDy-1drpnQ2QaM-00AYbO; Thu, 24
 Aug 2017 00:35:54 +0200
Date:   Thu, 24 Aug 2017 00:35:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC 0/3] imap-send curl tunnelling support
In-Reply-To: <63e3ebea-ad4e-14d7-1170-594390af8e06@kdbg.org>
Message-ID: <alpine.DEB.2.21.1.1708240033440.19382@virtualbox>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com> <5c46f1e4-825e-8e10-e323-e637e170f315@morey-chaisemartin.com> <CAGZ79kbgYqo=6FvRNwB0AOKT8mioPTu2CearVttA30nZ8wBMHQ@mail.gmail.com> <alpine.DEB.2.21.1.1708161429510.19382@virtualbox>
 <4a5f9d64-0709-b6b0-c398-6887f1f7f4c0@morey-chaisemartin.com> <63e3ebea-ad4e-14d7-1170-594390af8e06@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Kdy/ka93DxWthxt0oYGgiF89wC9HkR8gXSGPIarJRtKVOZvgSky
 EQkfbTNIb0ScJdC0mySAzSmyOLIaKgyvd5kLlUn3UVP7KVYC1M7cmMCX3JDNe9jQX7rwtKG
 A5+TBekDcFYsOqKZ+Eo827DSl6vUUTJJEipxgv9atvGKAmF5mU/Wc6Bro99QNr0cBnXRMmB
 UWp0UjFejWunuCUk5m37A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eY8Lbv/uEU8=:il/k5SuFJ8WW0xOpPo9ko/
 oDYjteSG5RiclIUgIZVujMF+rjwzkWJ+wJobK4j6DFhTRLI9fORSEakFuuiAW9KUGoLLPystH
 LvyOpLgp1+pSsoCcFVcoEbZjdoNjxPglbBOKUBvOfYtm4S4zg9fEgOE822mqH7KnJfKQ345ni
 iBolddC0uiZQleaIM0VyY6o84gILObuW3RBPxrkVkNF8ysIMI2gvCY10rqRUO4Sao9uQ1UbGl
 Oxg2ngPX4G0jF+Zd3l7z5CXFuWtCOQhbICo5DDculouEY9k9H7HoTPTuabJqRZ49tZ/VWHp4H
 5uI5iXcCsUUjHw3mzN9eChYKaafbVDrwWECo7g/JVJH2bry8bZoOHrcw8zWx0TgmI1NmJYbRx
 MySu+V7YtvsJOYswnPasOaxKB8qn0kxZ4nIS2D8NhpCztvsonqpJdYP/+m0N4anwM9k3A1pNC
 IZgatFwnLSHpA6vqqkfgBQJDt1ifL9YO7+UgOrDwHMOb8DKwDjjTqHydbYvdAxsovLDfdTx/7
 riQyTvjvW+m/ICbNpBCxaGqzkl55N67izD4eJDgQL+mu0tPcA+rFDgt6+m5PH/bSR6RHId7fc
 M6Mlzgmbn0fa8W97vLxoHSq+7qDyxfugqY0uX9uiv34F90pjtSqTKnmTwuaH9rIokKd9asbTC
 LReB5ece52CXqXskLbrAB/HSNlc3Pkc56vWOBm3LyG7ju1ByXaqkhWJxWmqww0RjH21cWWhNI
 E4mjBJJObF+VqO0rN74GIqx3akYybOKIUMwAswOszLRblXcabG0qJxVzgqtsUbcZAOn0iD3QC
 ppRK7S1qOh6qLlGR4jph4JVqJa7ffEhOkB0FshIfLzuLxQGgp8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, 22 Aug 2017, Johannes Sixt wrote:

> Am 21.08.2017 um 09:27 schrieb Nicolas Morey-Chaisemartin:
> > (Sent a reply from my phone while out of town but couldn't find it so here
> > it is again)
> > 
> > It's available on my github:
> > https://github.com/nmorey/git/tree/dev/curl-tunnel
> > 
> > The series had been stlighly changed since the patch were posted, mostly to
> > add the proper ifdefs to handle older curl versions.
> 
> This does not build for me on Windows due to a missing socketpair() function.
> But I am working in an old environment, so I do not know whether this
> statement has much value.

Same problem in Git for Windows' SDK:

imap-send.c: In function 'setup_tunnel':
imap-send.c:936:6: error: implicit declaration of function 'socketpair'; did you
 mean 'socket'? [-Werror=implicit-function-declaration]
  if (socketpair(AF_UNIX, SOCK_STREAM, 0, sock_fds))
      ^~~~~~~~~~
      socket
imap-send.c: In function 'curl_tunnel_socket':
imap-send.c:1416:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  return (unsigned long)clientp;
         ^

