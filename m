Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA9B211B5
	for <e@80x24.org>; Tue, 29 Jan 2019 12:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfA2Mkd (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 07:40:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:52884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727033AbfA2Mkd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 07:40:33 -0500
Received: (qmail 25126 invoked by uid 109); 29 Jan 2019 12:40:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 12:40:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6016 invoked by uid 111); 29 Jan 2019 12:40:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 07:40:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 07:40:31 -0500
Date:   Tue, 29 Jan 2019 07:40:31 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sergey Lukashev <lukashev.s@ya.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 0/2] eol/autocrlf doc clarifications
Message-ID: <20190129124031.GA13084@sigill.intra.peff.net>
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
 <13169311548590123@iva1-16f33c6a446b.qloud-c.yandex.net>
 <20190128160944.GB23588@sigill.intra.peff.net>
 <1593541548699120@myt6-27270b78ac4f.qloud-c.yandex.net>
 <20190128183117.GA13165@sigill.intra.peff.net>
 <20190129073810.23op5qaibyj2amwq@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129073810.23op5qaibyj2amwq@tb-raspi4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 07:38:10AM +0000, Torsten Bögershausen wrote:

> > Yeah, I think the word "property" is unnecessarily confusing. Here's
> > another patch (meant to go on top of the other).
> 
> The property was originally meant to say:
> - Either the "text" attribute is set in .gitattributes
>   or
> - The "text=auto" attribute is set in .gitattributes and
>   Git auto-detects the file as text (and not as binary).

Thanks, that makes it much more clear what the original was trying to
say.

> > +	conversion. Note that this value is ignored if `core.autocrlf`
> > +	is set to `true`.
> 
> Should that be
>  > +	conversion. Note that this value is ignored if `core.autocrlf`
>  > +	is set to `true` or `input`.

Yes (and ditto in the other patch).

Here's a re-roll of both patches addressing these issues.

  [1/2]: doc/gitattributes: clarify "autocrlf overrides eol"
  [2/2]: docs/config: clarify "text property" in core.eol

 Documentation/config/core.txt   | 7 +++++--
 Documentation/gitattributes.txt | 4 +++-
 2 files changed, 8 insertions(+), 3 deletions(-)

-Peff
