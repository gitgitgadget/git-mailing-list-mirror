Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EEA91F453
	for <e@80x24.org>; Mon, 28 Jan 2019 20:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfA1UqX (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 15:46:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:52008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726719AbfA1UqX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 15:46:23 -0500
Received: (qmail 14703 invoked by uid 109); 28 Jan 2019 20:46:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Jan 2019 20:46:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29186 invoked by uid 111); 28 Jan 2019 20:46:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 Jan 2019 15:46:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2019 15:46:21 -0500
Date:   Mon, 28 Jan 2019 15:46:21 -0500
From:   Jeff King <peff@peff.net>
To:     Sergey Lukashev <lukashev.s@ya.ru>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: unclear docs
Message-ID: <20190128204621.GA15915@sigill.intra.peff.net>
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
 <20190128160620.GA23588@sigill.intra.peff.net>
 <xmqqzhrkab3s.fsf@gitster-ct.c.googlers.com>
 <20190128183253.GB13165@sigill.intra.peff.net>
 <1811741548706614@myt1-06117f29c1ea.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1811741548706614@myt1-06117f29c1ea.qloud-c.yandex.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 11:16:54PM +0300, Sergey Lukashev wrote:

> >>  > Subject: [PATCH] doc/gitattributes: clarify "autocrlf overrides eol"
> >>  >
> >>  > We only override core.eol with core.autocrlf when the latter is set to
> >>  > "true" (otherwise, core.eol would never do anything!). Let's make this
> >>
> >>  I fail to understand what "otherwise..." wants to say. When
> >>  core.autocrlf is not "true", core.eol would not do anything?
> >
> > I meant that if core.autocrlf overrides core.eol also when it is not set
> > to true, then there would be no way to use core.eol, because the former
> > must be either true or false.
>
> autocrlf can be "input" as well.

Ah, true. Should the documentation actually say "if core.autocrlf is not
'false'" then? I _think_ so from my reading of the code, but it would be
nice to have confirmation from somebody better versed in the line-ending
code than I am (+cc Torsten).

-Peff
