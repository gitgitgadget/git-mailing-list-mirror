Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88EEA1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 21:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbcFWVj1 (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 17:39:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:59387 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751189AbcFWVj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 17:39:27 -0400
Received: (qmail 7944 invoked by uid 102); 23 Jun 2016 21:39:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 17:39:26 -0400
Received: (qmail 15298 invoked by uid 107); 23 Jun 2016 21:39:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 17:39:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 17:39:24 -0400
Date:	Thu, 23 Jun 2016 17:39:24 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] archive-tar: write extended headers for far-future
 mtime
Message-ID: <20160623213924.GA1123@sigill.intra.peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043758.GB18323@sigill.intra.peff.net>
 <57687417.4020009@web.de>
 <576A2631.2000608@web.de>
 <20160623192251.GB32745@sigill.intra.peff.net>
 <576C56CB.1040701@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <576C56CB.1040701@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 11:38:19PM +0200, René Scharfe wrote:

> > Yeah, I had a similar thought while writing it, but wasn't quite sure
> > how that was supposed to be formatted. I modeled my output after what
> > GNU tar writes, but of course they are expecting a different mtime for
> > each file.
> > 
> > I'll look into how global pax headers should look.
> 
> Moving the strbuf_append_ext_header() call into
> write_global_extended_header() should be enough.  The changes to the test
> script are a bit more interesting, though.  Perhaps I can come up with
> something over the weekend.

Yeah, I have the code itself working now. I'm just slogging through
writing tests that are efficient and portable. I hope to have something
out soon.

-Peff
