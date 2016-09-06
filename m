Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BA61F859
	for <e@80x24.org>; Tue,  6 Sep 2016 07:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755229AbcIFHM7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 03:12:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:38666 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754857AbcIFHM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 03:12:58 -0400
Received: (qmail 13757 invoked by uid 109); 6 Sep 2016 07:12:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 07:12:57 +0000
Received: (qmail 25118 invoked by uid 111); 6 Sep 2016 07:13:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 03:13:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Sep 2016 03:12:55 -0400
Date:   Tue, 6 Sep 2016 03:12:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
Message-ID: <20160906071255.ggsoj2lh2f3kubhj@sigill.intra.peff.net>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
 <xmqqwpiqp3ho.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpiqp3ho.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2016 at 12:10:11PM -0700, Junio C Hamano wrote:

>  * We could use <ptr,len> variant of regexp engine as you proposed,
>    which I think is a preferrable solution.  Do people know of a
>    widely accepted implementation that we can throw into compat/ as
>    fallback that is compatible with GPLv2?

Maybe the one already in compat/regex? ;P

I think re_search() the correct replacement function but it's been a
while since I've looked into it.

-Peff
