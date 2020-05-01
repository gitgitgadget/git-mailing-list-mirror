Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCB7C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 07:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E69214D8
	for <git@archiver.kernel.org>; Fri,  1 May 2020 07:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgEAHbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 03:31:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:33378 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726452AbgEAHbO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 03:31:14 -0400
Received: (qmail 2418 invoked by uid 109); 1 May 2020 07:31:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 May 2020 07:31:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15914 invoked by uid 111); 1 May 2020 07:31:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2020 03:31:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 May 2020 03:31:13 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Junio C Hamano <gitster@pobox.com>, douglas.fuller@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] gitcredentials(7): clarify quoting of helper examples
Message-ID: <20200501073113.GA27392@coredump.intra.peff.net>
References: <20200501061917.GC23665@coredump.intra.peff.net>
 <20200501062039.GA25603@coredump.intra.peff.net>
 <87tv10i0ll.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tv10i0ll.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 09:19:18AM +0200, Andreas Schwab wrote:

> On Mai 01 2020, Jeff King wrote:
> 
> >  # or you can specify your own shell snippet
> > -!f() { echo "password=`cat $HOME/.secret`"; }; f
> > +[credential]
> > +helper = "!f() { echo password=$(cat $HOME/.secret); }; f"
> 
> That now lacks a pair of quotes around the argument of echo.

Right, as discussed in the commit message.

-Peff
