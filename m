From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-path-utils: use xsnprintf in favor of strcpy
Date: Mon, 8 Feb 2016 18:13:32 -0500
Message-ID: <20160208231332.GA23638@sigill.intra.peff.net>
References: <20160208222155.GA17395@sigill.intra.peff.net>
 <20160208230726.GB3487@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 00:13:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSuzz-0004HS-Ho
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 00:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbcBHXNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 18:13:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:39582 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751861AbcBHXNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 18:13:35 -0500
Received: (qmail 4239 invoked by uid 102); 8 Feb 2016 23:13:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 18:13:34 -0500
Received: (qmail 11215 invoked by uid 107); 8 Feb 2016 23:13:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 18:13:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 18:13:32 -0500
Content-Disposition: inline
In-Reply-To: <20160208230726.GB3487@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285825>

On Mon, Feb 08, 2016 at 11:07:26PM +0000, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > Repost of <20160114202608.GA8806@sigill.intra.peff.net> from a few weeks
> > ago (sorry, gmane is down so I can't generate a link).
> 
> I prefer we use links derived from Message-IDs anyways.  This
> prevents reliance on gmane article numbers being a central point
> of failure:
> 
> http://marc.info/?i=$MESSAGE_ID
> http://mid.gmane.org/$MESSAGE_ID
> http://mid.mail-archive.com/$MESSAGE_ID

I actually do, too. I keep a local archive of the whole list, and I have
a script that hits gmane to convert their article ids into message-ids.
When gmane is down I can still use my archive, but I can't resolve
anybody's article mentions. :)

I mostly use gmane links because people are used to them, though (I also
don't think there's a way using message-ids to point to a whole thread
with an article highlighted, though of course readers can get their by
clicking through).

> But the MESSAGE_ID above seems missing from mail-archive.com, in this case.

It seems to have a giant hole in git@vger messages between 2016-01-07
and 2016-01-20, which covers the referenced message (which was on the
14th).

-Peff
