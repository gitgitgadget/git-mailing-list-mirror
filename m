Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1411F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfAOTcL (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:32:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:37322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731676AbfAOTcL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:32:11 -0500
Received: (qmail 25372 invoked by uid 109); 15 Jan 2019 19:32:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Jan 2019 19:32:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12769 invoked by uid 111); 15 Jan 2019 19:32:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 15 Jan 2019 14:32:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2019 14:32:09 -0500
Date:   Tue, 15 Jan 2019 14:32:09 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 2/6] commit: copy saved getenv() result
Message-ID: <20190115193209.GF4886@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
 <20190111221539.GB10188@sigill.intra.peff.net>
 <xmqqsgxywp3w.fsf@gitster-ct.c.googlers.com>
 <20190112102635.GA16633@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1901151502130.41@tvgsbejvaqbjf.bet>
 <20190115191714.GD4886@sigill.intra.peff.net>
 <CAGZ79kYMiy=j8z2Y3XA03OD07jeUEXs3frNpjvyAFguVxeoBow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYMiy=j8z2Y3XA03OD07jeUEXs3frNpjvyAFguVxeoBow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 15, 2019 at 11:25:45AM -0800, Stefan Beller wrote:

> > Stefan was routinely running coverity, though I haven't seen results in
> > a while. I think we should make sure that continues, as it did turn up
> > some useful results (and a lot of cruft, too, but on the whole I have
> > found it useful).
> 
> coverity had some outage (end of last year?-ish) and then changed the
> way it dealt with automated uploads IIRC.
> I have not looked into redoing the automation again since then.
> 
> Since 7th of Jan, they seem to have issues with hosting (for everyone
> or just the open source projects?)
> https://community.synopsys.com/s/article/Coverity-Scan-Update

Yuck. :(

> For reference, the script that used to work is at
> https://github.com/stefanbeller/git/commit/039be8078bb0379db271135e0c0d7315c34fe243
> (which is on the `coverity` branch of that repo)

Thanks for the update. I may take a look at trying to make this work
again at some point (but I won't be sad if somebody else gets to it
first).

-Peff
