Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A961FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 15:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbdBJPvT (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 10:51:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:56793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753051AbdBJPvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 10:51:19 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlE86-1c2Kva2uBC-00b2QY; Fri, 10
 Feb 2017 16:49:09 +0100
Date:   Fri, 10 Feb 2017 16:49:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
In-Reply-To: <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1702101647340.3496@virtualbox>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de> <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:j+gvaLJ/pLO3YHw22Hh8kLsithrQdrFGWdG/SZCiLj2Q0cESgHn
 4vny7dkURItzoWXFGkvtWwHioXpyJjcgdB009RMhZYq7w3j3OuFDgGIJdPT4C4q9xHk9OcU
 6RdHJmVwtaRYpTxeYSuCHVZdbHaftDUZyILaXvQiTyIk1aGBoCR/WqSrcqugfPJaHXjPbPW
 YbzOLN4H0SyJfbo+mtH6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DKe5Rx+ibug=:ZtyiTBgkLy5y5S1Ocdtrzy
 5pO0IO2fvNUazLiuomOudDtSdYaz/EclZ605moH6ruaB9fCM640GOcXtFPcTAIv5DmQV98OrT
 qOVXiFBF+CeAVpLAsAGcPlU4zGCq9N0Hevm7UGZiob2OaxPNFud5gPoAx2fOBrbVlZeXR/p7u
 KuG7jhL+imq0dSo1bp3vvN/lzuylW6G0xTRAf3OAHFSoItv6cUGuMkRvism5Hqp+1AInE4wwr
 M5le8wgJD3vzVb+Wwy2121nZy3o1yW8LLugSG7SJINSlWWSDI76I31LAvBDcaPOTxAHAYiVV8
 6TNKMAr5baaCUHi1XpSrYjW5F9VNbOOjwdKuO3SGdGwUg3t4ofKYnLpiJ8peNrB1TXLBp6/F7
 7w98CwMoZgeWcynztHB9ggBBiM1GM3/qgBe7lfHTvG7yV6j2qw3DLMgWefvid3AAsksArxfQ7
 LDVoLTETL7jqL28TgFFWf9yOoKT6q1Cujm4pN5gZojTdZySIwRPyt9x5ykuVCMENjlMNqp6tx
 Lgq0KgxolaiLiMtItNpN1BRqqwQw9kBx/bhhal6ezlTCI3dNST9BMq3DTtv5JdhtO3b8bR63Z
 Dfhk0V93RestrxfyKDVi98QnV/W8bUzxyj/Ce/dlLBimrAif7DmMlAGT4cF/YNre6jgbZcatP
 qHnXAscMeb9eYpDCtwDhCm7Nk2UWdOZC63Cy/4KjTh7siSItmNOLZXnHrvA3+1LQ/cNe17tT/
 FKTFJUrX0NX2m3qibuu1w12L2Wm1huDrbSvl1MYFFeyggMtT7sQZFYVIHoZ176KQRB1A4k0P0
 S5EKOg6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 10 Feb 2017, Jeff King wrote:

> On Thu, Feb 09, 2017 at 11:27:49PM +0100, Johannes Schindelin wrote:
> 
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> > 
> > Use OpenSSL's SHA-1 routines rather than builtin block-sha1 routines.
> > This improves performance on SHA1 operations on Intel processors.
> > 
> > OpenSSL 1.0.2 has made considerable performance improvements and
> > support the Intel hardware acceleration features.  See:
> > https://software.intel.com/en-us/articles/improving-openssl-performance
> > https://software.intel.com/en-us/articles/intel-sha-extensions
> > 
> > To test this I added/staged a single file in a gigantic repository
> > having a 450MB index file.  The code in read-cache.c verifies the
> > header SHA as it reads the index and computes a new header SHA as it
> > writes out the new index.  Therefore, in this test the SHA code must
> > process 900MB of data.  Testing was done on an Intel I7-4770 CPU @
> > 3.40GHz (Intel64, Family 6, Model 60) CPU.
> 
> I think this is only half the story. A heavy-sha1 workload is faster,
> which is good. But one of the original reasons to prefer blk-sha1 (at
> least on Linux) is that resolving libcrypto.so symbols takes a
> non-trivial amount of time. I just timed it again, and it seems to be
> consistently 1ms slower to run "git rev-parse --git-dir" on my machine
> (from the top-level of a repo).
> 
> 1ms is mostly irrelevant, but it adds up on scripted workloads that
> start a lot of git processes.

You know my answer to that. If scripting slows things down, we should
avoid it in production code. As it is, scripting slows us down. Therefore
I work slowly but steadily to get rid of scripting where it hurts most.

Ciao,
Dscho
