Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE03E1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 15:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbdCBPsV (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 10:48:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:57110 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753132AbdCBPqs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 10:46:48 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfCX2-1buxrH2ibY-00ojzP; Thu, 02
 Mar 2017 15:45:15 +0100
Date:   Thu, 2 Mar 2017 15:45:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
In-Reply-To: <CACsJy8D3h1KAaKi_Esc98za3LqXaB=YeW0Yu+VAV9UnX5vmttg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703021539330.3767@virtualbox>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com> <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com> <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703012227010.3767@virtualbox>
 <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com> <alpine.DEB.2.20.1703012334400.3767@virtualbox> <CA+55aFy9=jBJT36FC2HiAeabJBssY=jE=zLxwrXWzhpiFkMUXg@mail.gmail.com> <20170301231921.2puf7o7jkrujscwn@sigill.intra.peff.net>
 <CACsJy8D3h1KAaKi_Esc98za3LqXaB=YeW0Yu+VAV9UnX5vmttg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7ebyhwovoUW8blF+JWm0C+T7y/uMQcLOlLlchBl/3M00R3zybEc
 lG2cYTX214EO55JvYBPadkJFmrMG3U2AX0kfKDJHes2EKLlHmTsNqNGVgN1uKmC1ZJeNqIj
 rlVqW482mwicTnA5IHUyUqJZxbIjm7svPl4VnQDqGs4H/4aEUeIVjzdEmqg7sEqJZveFDzx
 TAA78kNuo8NJq5mZZY1qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9lStJf81OL8=:trPOeSSswOGa239o6A33+X
 iKLdswG+uZ1eyp4L9Oe1GG1tXsuzUruEdv63UKgV55ZXTBlFOwOdkEZJIKfI7es6WVgnjJqxT
 x0vs1iFUT/m2Mm8rgM44j4A3Co+evpCDL9WaZUsN1SrgPM+INRtEgHyR3OKt3DaKo5EOPGB0L
 VvAnal6iv3u7jlVSWE5jXZf2UWEoRp/crjTgrMjxN2yTV2PTXKvqwH3bZif5hU0h9c+ljfQcn
 k0Fh6G+g4/jIgYq7rQxTtCCuR+IZ523nbqAFgKAl/j0VkA17uG6skRLvrNIoAqDkutCMm/YQ4
 BOgem8glczg3MyH7YOJlGekwyVVaGgkyNPk/hA4k6+4FeIVWlUdW5HBnMvL2ci6M8nV0bgJ+s
 ZaUbX/NkiGI3TTIFPmFCS91Ex4GrlC4Q7+L7sOjGKeWZg7VBsezGjBYed+Xmtj0mVJ9DMf+Oa
 lDwG0aZmpnx6DD74eIwwBxNr/XIvDcNYwCAlrdmJloSi/Sk+FQNtS7t+4pkimHfn5haM7StS8
 wn5VEpUA0HG4Wxhwav0WeyKkhT6TZ7X9hlNkc1GKUrijxx/ZE6xeVUL4jeeCncbAh0IBcKjXQ
 xAn/0BNLPtMvrxknIjgPrJLeC1HdlMqlM1mlSlhUQ0m/o0AwJtjD0EEngGfuOE9yyUQxoozuH
 X2AZ9iXuySD8cj+veFhBLDv8VnXhtn2miW6zBudLKw3mbY31P153A2WQzDX178/nXknGu6Zlh
 pEzVXkaUNCy+ZKTKt0kUeMQlRmKKKXqa1v68NRU81kpoXF2D/KvWG0KW5hMfubhHy9A0uRafF
 w3k2dmOwTRZnILBcDBA+/g6r5aCaw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Thu, 2 Mar 2017, Duy Nguyen wrote:

> On Thu, Mar 2, 2017 at 6:19 AM, Jeff King <peff@peff.net> wrote:
> > You have to remember that some of the Git for Windows users are doing
> > horrific things like using repositories with 450MB .git/index files,
> > and the speed to compute the sha1 during an update is noticeable
> > there.
> 
> We probably should separate this use case from the object hashing
> anyway. Here we need a better, more reliable crc32 basically, to detect
> bit flips. Even if we move to SHA-something, we can keep staying with
> SHA-1 here (and with the fastest implementation)

I guess it was convenient to use the same hash algorithm for all hashing
purposes in the beginning. The downside, of course, was that we kept
talking about SHA-1s instead of commit hashes and the index checksum (i.e.
using labels based on implementation details rather than semantically
meaningful names).

In the meantime, we use different hash algorithms where appropriate, of
course, and we typically encapsulate the exact hash algorithm so that it
is easy to switch when/if necessary (think the hash functions for strings
in our hashtables, and the hash functions in xdiff).

It would probably make sense to switch the index integrity check away from
SHA-1 because we really only care about detecting bit flips there, and we
have no need for the computational overhead of using a full-blown
cryptographic hash for that purpose.

Ciao,
Johannes
