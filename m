Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB9C1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 16:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeJ3BJ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 21:09:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:59276 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727678AbeJ3BJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 21:09:26 -0400
Received: (qmail 24894 invoked by uid 109); 29 Oct 2018 16:20:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 16:20:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19109 invoked by uid 111); 29 Oct 2018 16:19:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 12:19:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 12:20:08 -0400
Date:   Mon, 29 Oct 2018 12:20:08 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 06/10] grep: remove #ifdef NO_PTHREADS
Message-ID: <20181029162007.GA31497@sigill.intra.peff.net>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027071003.1347-7-pclouds@gmail.com>
 <20181027074443.GE26685@sigill.intra.peff.net>
 <xmqqo9bd8pko.fsf@gitster-ct.c.googlers.com>
 <20181029142536.GE17668@sigill.intra.peff.net>
 <CACsJy8Bp_9qmGeNZuywtda1_TdQTZM1essUjBD9Q8e31175V=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Bp_9qmGeNZuywtda1_TdQTZM1essUjBD9Q8e31175V=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 05:01:41PM +0100, Duy Nguyen wrote:

> On Mon, Oct 29, 2018 at 3:25 PM Jeff King <peff@peff.net> wrote:
> > But if the problem is simply that we are not quite there yet in the grep
> > code, I am OK with taking this as the first pass, and knowing that there
> > is more cleanup to be done later (though that sort of thing is IMHO very
> > useful in a commit message).
> 
> Since the problem pops up now, I'm ok with updating/cleaning up all
> this in this series, unless there's benefits in keeping this series
> simple and merging it early (probably not?)

Mostly I did not want to tax you. I would rather have this series and
some cleanup left over, than to not have anything. But if you are
interested in moving it further, I will not say no. :)

-Peff
