Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 310171F454
	for <e@80x24.org>; Mon,  4 Nov 2019 22:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfKDWYT (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 17:24:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:38744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729632AbfKDWYR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 17:24:17 -0500
Received: (qmail 5182 invoked by uid 109); 4 Nov 2019 22:24:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Nov 2019 22:24:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7026 invoked by uid 111); 4 Nov 2019 22:27:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2019 17:27:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Nov 2019 17:24:16 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] doc: dissuade users from trying to ignore tracked
 files
Message-ID: <20191104222416.GB22367@sigill.intra.peff.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
 <20191102192615.10013-4-sandals@crustytoothpaste.net>
 <86h83lhugj.fsf@gmail.com>
 <20191103185908.GA32531@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191103185908.GA32531@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 03, 2019 at 06:59:08PM +0000, brian m. carlson wrote:

> > I would really like to see a simple example of such template, so that
> > even people who are unfamiliar with Ruby's ERB can think of equivalent
> > solution for their language or toolchain of choice.
> 
> I hesitated to mention ERB, but I wasn't sure that folks would know what
> we meant by a "templating mechanism".  The reason I had chosen to
> mention it is that someone could search for "Ruby ERB" and find out what
> it looked like and then look for an option in their own language.

I don't mind what is here, but I might even suggest going slightly in
the opposite direction. Say something like:

  For example, you the repository can include a sample config file that
  can then be copied into the ignored name and modified.

which points people in the right direction without giving specifics. But
if you did want to go further, you can then say:

  The repository can even include a script to treat the sample file as a
  template, modifying and copying it automatically (e.g., a Ruby script
  using an ERB template).

or something.

> My concern with adding such a template is that an example will likely
> grow this section quite a bit, and it's meant as a short aside to help
> people avoid making a common mistake and guide them to a proper solution
> rather than a comprehensive howto.

Yeah. I don't think we should get into best practices for using ERB.

-Peff
