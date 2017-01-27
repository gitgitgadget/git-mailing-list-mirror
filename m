Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F041FAAD
	for <e@80x24.org>; Fri, 27 Jan 2017 03:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753936AbdA0D6O (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 22:58:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:45716 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753934AbdA0D6O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 22:58:14 -0500
Received: (qmail 23034 invoked by uid 109); 27 Jan 2017 03:58:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 03:58:08 +0000
Received: (qmail 31271 invoked by uid 111); 27 Jan 2017 03:58:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 22:58:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 22:58:06 -0500
Date:   Thu, 26 Jan 2017 22:58:06 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Intermittent failure of t1700-split-index.sh
Message-ID: <20170127035806.rtvlas7dja5ikvxg@sigill.intra.peff.net>
References: <818851a6-c3ef-618e-4146-518fbe6bd837@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <818851a6-c3ef-618e-4146-518fbe6bd837@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 02:45:15AM +0000, Ramsay Jones wrote:

> I can't devote any time to looking at this further tonight
> (it's 2-45am here, I'm off to bed!). Can you reproduce the
> problem, or is it just me? :)

I can reproduce here with 'pu'. t1700.17 seems to fail reliably with my
stress script after 5-10 seconds.

It bisects to ff97d10f57c2f99b6d86da8f07c16659979b2780, but take that
with a moderate grain of salt, as I may have marked a bad commit as
"good" if it simply got lucky and didn't fail as quickly.

-Peff
