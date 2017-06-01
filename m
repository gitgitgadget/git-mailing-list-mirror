Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183D020D12
	for <e@80x24.org>; Thu,  1 Jun 2017 06:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbdFAGKg (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 02:10:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:32946 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbdFAGKf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 02:10:35 -0400
Received: (qmail 19585 invoked by uid 109); 1 Jun 2017 06:10:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 06:10:33 +0000
Received: (qmail 14535 invoked by uid 111); 1 Jun 2017 06:11:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 02:11:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jun 2017 02:10:32 -0400
Date:   Thu, 1 Jun 2017 02:10:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
Message-ID: <20170601061032.wqcivz5e37tccvv3@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
 <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
 <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
 <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
 <xmqqshjmc1wm.fsf@gitster.mtv.corp.google.com>
 <20170530061546.tdpuhvq7yk34rvlj@sigill.intra.peff.net>
 <xmqqo9uabhqt.fsf@gitster.mtv.corp.google.com>
 <20170530152756.vs777v6unaxg6otb@sigill.intra.peff.net>
 <xmqqinkg734c.fsf@gitster.mtv.corp.google.com>
 <xmqq7f0w6z7u.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f0w6z7u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2017 at 02:42:13PM +0900, Junio C Hamano wrote:

> For now, I will mix this in when queuing the whole thing in 'pu', as
> I hate to push out something that does not even work for me to the
> general public.
> 
> -- >8 --
> Subject: [PATCH] diff- and log- family: handle "git cmd -h" early

Yeah, I think this is a good step in the interim.

-Peff
