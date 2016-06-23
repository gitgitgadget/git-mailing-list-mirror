Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E63E2018A
	for <e@80x24.org>; Thu, 23 Jun 2016 16:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbcFWQr4 (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:47:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:59152 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751390AbcFWQr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:47:56 -0400
Received: (qmail 27962 invoked by uid 102); 23 Jun 2016 16:47:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 12:47:54 -0400
Received: (qmail 12267 invoked by uid 107); 23 Jun 2016 16:48:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 12:48:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 12:47:52 -0400
Date:	Thu, 23 Jun 2016 12:47:52 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Simon Courtois <scourtois@cubyx.fr>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] color: support "italic" attribute
Message-ID: <20160623164751.GA29882@sigill.intra.peff.net>
References: <20160623130828.GA25209@sigill.intra.peff.net>
 <20160623131028.GB12653@sigill.intra.peff.net>
 <xmqq7fdfkg3i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7fdfkg3i.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 09:46:57AM -0700, Junio C Hamano wrote:

> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 58673cf..4b97d8d 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -154,7 +154,7 @@ color::
> >         colors (at most two) and attributes (at most one), separated
> 
> This is describing the format accepted by color_parse_mem(), whose
> main loop has /* [fg [bg]] [attr]... */ comment in front?
> 
> Is "at most one" still correct, or it was already stale before this
> patch?

I think it was already stale.

I'm actually preparing a re-roll that makes some of the parsing a bit
less nasty, too. I'll fix that at the same time.

-Peff
