Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9C5F1F609
	for <e@80x24.org>; Fri, 24 May 2019 06:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbfEXGFz (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 02:05:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:37502 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387622AbfEXGFz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 02:05:55 -0400
Received: (qmail 24804 invoked by uid 109); 24 May 2019 06:05:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 May 2019 06:05:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6293 invoked by uid 111); 24 May 2019 06:06:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 May 2019 02:06:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 May 2019 02:05:53 -0400
Date:   Fri, 24 May 2019 02:05:53 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] server-info: do not list unlinked packs
Message-ID: <20190524060552.GA25694@sigill.intra.peff.net>
References: <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
 <20190514115047.oncvfq24fhnp64re@dcvr>
 <87ftphw7mv.fsf@evledraar.gmail.com>
 <20190515004551.emrxvboqemwnqh4g@dcvr>
 <20190515203839.zixx23bwzeyto6a3@dcvr>
 <20190515214806.GA31693@sigill.intra.peff.net>
 <20190523085959.4q76pokx2gy6wqq7@dcvr>
 <20190523102456.GA6583@sigill.intra.peff.net>
 <20190523172723.eny6smdt57zxau6z@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523172723.eny6smdt57zxau6z@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 05:27:23PM +0000, Eric Wong wrote:

> ALLOC_GROW makes the whole thing much nicer.
> Thanks for the hint :>
> 
> ---------------------8<---------------------
> Subject: [PATCH] server-info: do not list unlinked packs

This looks fine to me (though the "v2" note is in your commit message).
I'd probably break it into two separate patches, but I can live with it
either way.

-Peff
