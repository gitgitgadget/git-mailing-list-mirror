Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396E02027B
	for <e@80x24.org>; Thu,  2 Mar 2017 14:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbdCBOkI (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 09:40:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:55326 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752940AbdCBOjq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 09:39:46 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MhMg2-1cxHY81F8k-00Mdh1; Thu, 02
 Mar 2017 15:39:30 +0100
Date:   Thu, 2 Mar 2017 15:39:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
In-Reply-To: <20170301231921.2puf7o7jkrujscwn@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703021538060.3767@virtualbox>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan> <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com> <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com> <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703012227010.3767@virtualbox>
 <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com> <alpine.DEB.2.20.1703012334400.3767@virtualbox> <CA+55aFy9=jBJT36FC2HiAeabJBssY=jE=zLxwrXWzhpiFkMUXg@mail.gmail.com> <20170301231921.2puf7o7jkrujscwn@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VcbkxHhfixPKt2FdyVhm9OclLKzDD5+0TNCxvV3JvbUuMWklGAt
 surIYTXPlxI7S6kf4ttL1tCcksfmxegSJGqZayUgm1LmKU9O/wYWZnGlGXDerdw/t7cOf7u
 a8Q41m7VSJ20C+xqJQ2Hqwr5+oR4vLKbC7gX9bApe6PwAmSVrep6i45JKHzzH88iWhekmOE
 zbIBBKeQjEA9HwklcNCgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HuOffjyF3gM=:w4tubxcbcnWQd8BZNtAPJ9
 4BOLY1Zqezs/6dGi6ZQygdxFlQNqeVJSdzuC0uKmP7jogl4qrkPoV88k6744c9P6zUKvdhVyl
 S9WiiM6xcNjaF0LMsK+QwlFfowqABcCm0ablJFw3FuXvZUdU2DkE+8GGG/LbiMPnlmM9DKlGv
 NNcN9RcWgbxXNMKw0f7aZfAjyK1jt1S28sQ+9C7gHTXNqoMyNobVl/PygYO6M0NNOtVQ3FBqd
 SoIRDiKUqd0Bzi0tA0Bni9dOp6XxnLCMK3j/i+APWmq6jgFks02dJYh2sTT6zWHpkXiUwU/gI
 atz5MdX/uiUI+xWRYEfwWiumQEfooAfbUUuBzx8Pzei/FJsUR0pqR5W9aAvJOOmf57sX0yn6X
 WOewG6VnM7ZXFj3ztIQ9XxtCHMzOZ0ZnBrb9j5u8t19omHDBuMWD1va3+7pFYEnUi8LZq/VLy
 LE3Eu/nO44SujrLdAnAVMGHFVxZ1jYGDHVvPLVviib0eIjvUqGpgxwZuWVvwOqnp5fXjEXoMP
 FEHM6OpNOXOkSpb9NBuC+Zq8k6K8lKzXmy3DvfnSfeV0t2n/WWG1CjoYQB5WIYDSiBwoZV2Ie
 DQiTlnih0YjiMEL4qe4fKV2id+fvi/H3o628UFhHQ27rI4SxT1Sx8XEPW1w5MHycgG43NLhFv
 6uUzNcjqoVlhsx//3duOLWaevHxr6l3QNe1DfShC4tNAWyNAhL5sY/bPRk6T3uyc6W7Lli7Ly
 UUq8Ojua5Xj7pjRWV71DKl4V60RaGlSrFc1OVKshFKO+/0+qa2XSt4KIISc+4w60tz6coLvDu
 IxQRcmzqTXh80QjPu3pAtFjSCjIrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 1 Mar 2017, Jeff King wrote:

> I do think that could argue for turning on the collision detection only
> during object-write operations, which is where it matters. It would be
> really trivial to flip the "check collisions" bit on sha1dc. But I
> suspect you could go faster still by compiling against two separate
> implementations: the fast-as-possible one (which could be openssl or
> blk-sha1), and the slower-but-careful sha1dc.

Given the speed difference between OpenSSL and sha1dc, it would be a wise
thing indeed to do sha1dc only where objects enter from possibly untrusted
sources, and use OpenSSL for all other hashing.

Ciao,
Johannes
