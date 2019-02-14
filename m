Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3DA51F453
	for <e@80x24.org>; Thu, 14 Feb 2019 06:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbfBNGyG (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 01:54:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:43882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390519AbfBNGyG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 01:54:06 -0500
Received: (qmail 3958 invoked by uid 109); 14 Feb 2019 06:54:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 06:54:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7559 invoked by uid 111); 14 Feb 2019 06:54:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 01:54:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 01:54:04 -0500
Date:   Thu, 14 Feb 2019 01:54:04 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2019, #03; Wed, 13)
Message-ID: <20190214065404.GB22932@sigill.intra.peff.net>
References: <xmqq4l979h8d.fsf@gitster-ct.c.googlers.com>
 <20190214035944.GB7209@sigill.intra.peff.net>
 <xmqqzhqy9axy.fsf@gitster-ct.c.googlers.com>
 <20190214055315.GK20578@sigill.intra.peff.net>
 <20190214064956.GE16125@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190214064956.GE16125@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 01:49:56AM -0500, Todd Zullinger wrote:

> Jeff King wrote:
> > Yeah, I do have the feeling that not many people really exercise our -rc
> > candidates. I'm not sure how to improve that. We could try to push
> > packagers to make them available (and I think Jonathan already does for
> > Debian's "experimental" track).
> 
> Similarly, I try to make them available in Fedora's rawhide
> channel (as well as less officially as builds for current
> stable Fedora and RHEL/CentOS releases¹).  I don't have a
> good sense of how many git users that reaches, but I haven't
> had many (or perhaps any?) bug reports from the -rc
> packages.

Thanks for doing that. Despite what I said earlier, I expect these
releases at least hit _some_ people (just not as many as I'd wish for in
an ideal world). And every additional user who may report a bug during
the -rc period is a win.

-Peff
