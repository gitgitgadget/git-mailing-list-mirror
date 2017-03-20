Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FFCD20323
	for <e@80x24.org>; Mon, 20 Mar 2017 04:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbdCTEdo (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 00:33:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:47397 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbdCTEdo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 00:33:44 -0400
Received: (qmail 25383 invoked by uid 109); 20 Mar 2017 04:27:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 04:27:02 +0000
Received: (qmail 29422 invoked by uid 111); 20 Mar 2017 04:27:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 00:27:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 00:26:57 -0400
Date:   Mon, 20 Mar 2017 00:26:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 0/8] Various changes to the "tag" command
Message-ID: <20170320042657.25x5gmh7uz5zgwzf@sigill.intra.peff.net>
References: <20170318103256.27141-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170318103256.27141-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 10:32:48AM +0000, Ævar Arnfjörð Bjarmason wrote:

> This series incorporates and replaces all the "tag" patches I have
> floating around the list, and adds a lot in the mix which discovered
> while working on the initial two patches, but which made sense as
> separate patches.

I had a few small comments, and I agree with the points that Junio
raised. But aside from that, it looks good to me.

-Peff
