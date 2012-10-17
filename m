From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] notes: mention --notes in more places
Date: Wed, 17 Oct 2012 15:05:07 -0400
Message-ID: <20121017190507.GA17648@sigill.intra.peff.net>
References: <1350443975-19935-1-git-send-email-eblake@redhat.com>
 <20121017055136.GA12301@sigill.intra.peff.net>
 <507EB310.8020904@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:05:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOYvq-0006DI-92
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 21:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757685Ab2JQTFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 15:05:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56271 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757676Ab2JQTFP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 15:05:15 -0400
Received: (qmail 29152 invoked by uid 107); 17 Oct 2012 19:05:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Oct 2012 15:05:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2012 15:05:07 -0400
Content-Disposition: inline
In-Reply-To: <507EB310.8020904@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207936>

On Wed, Oct 17, 2012 at 07:30:56AM -0600, Eric Blake wrote:

> > We've talked about it several times, but it's never happened (probably
> > because most people don't actually use notes).
> 
> And people (like me) don't use notes because they aren't documented.
> Catch-22, so we have to start somewhere.

Oh, I definitely agree your patch is the right direction. I was just
explaining why it hasn't happened, even though people think it's a good
idea.

> I'll submit a v2 with the non-controversial edits, and spend some time
> trying to figure out how to isolate the portion of pretty-options.txt
> that is relevant to format-patch.  If it's easy enough, I can also
> consider using --- instead of Notes: as the separator when using
> format-patch.

Hmm. After digging in the archive, it seems we (including both you and
me!) have discussed this several times, and there are even some patches
floating around. Maybe one of them would be a good starting point for
your submission (I did not read carefully over all of the arguments for
each):

  Patch from Thomas, Feb 2010:

    http://thread.gmane.org/gmane.comp.version-control.git/139919/focus=140818

  Discussion between us, Dec 2010:

    http://thread.gmane.org/gmane.comp.version-control.git/163141

  Patch from Michael, Apr 2011:

    http://thread.gmane.org/gmane.comp.version-control.git/172079

-Peff
