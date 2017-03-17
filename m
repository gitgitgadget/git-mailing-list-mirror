Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD61B20951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdCQW07 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:26:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:46223 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbdCQW06 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:26:58 -0400
Received: (qmail 3450 invoked by uid 109); 17 Mar 2017 22:26:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 22:26:36 +0000
Received: (qmail 7356 invoked by uid 111); 17 Mar 2017 22:26:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 18:26:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 18:26:32 -0400
Date:   Fri, 17 Mar 2017 18:26:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: remove declaration of path_name()
Message-ID: <20170317222632.wtbzxwydr5i6ylx7@sigill.intra.peff.net>
References: <476be7e2-4b7a-6707-a162-439ef1f4530e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <476be7e2-4b7a-6707-a162-439ef1f4530e@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 11:15:03PM +0100, René Scharfe wrote:

> The definition of path_name() was removed by 2824e1841 (list-objects:
> pass full pathname to callbacks); remove its declaration as well.

Yep, this should have been done back then. Thanks.

-Peff
