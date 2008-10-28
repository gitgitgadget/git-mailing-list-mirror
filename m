From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add a 'source' decorator for commits
Date: Tue, 28 Oct 2008 16:27:03 -0400
Message-ID: <20081028202702.GA1876@sigill.intra.peff.net>
References: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271305500.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271306230.3386@nehalem.linux-foundation.org> <20081028054539.GA23195@sigill.intra.peff.net> <20081028131116.GA8272@artemis.googlewifi.com> <20081028194642.GB752@sigill.intra.peff.net> <20081028200901.GA2894@artemis.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 21:28:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuvAt-00064J-Dv
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 21:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbYJ1U1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 16:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753602AbYJ1U1I
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 16:27:08 -0400
Received: from peff.net ([208.65.91.99]:4973 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbYJ1U1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 16:27:07 -0400
Received: (qmail 23468 invoked by uid 111); 28 Oct 2008 20:27:05 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 16:27:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 16:27:03 -0400
Content-Disposition: inline
In-Reply-To: <20081028200901.GA2894@artemis.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99320>

On Tue, Oct 28, 2008 at 09:09:02PM +0100, Pierre Habouzit wrote:

> > Hmm. Why a date-based hack to see what's on the topic branch? Why not
> > just give an option to walk the graph twice,
> 
> it serves the purpose to not walk the graph twice actually, but indeed
> twice is not _that_ bad.

Sure, and that is reasonable. But I think the real goal is "give this
information in a not-painfully slow manner". So if we can do it by
walking a smaller graph twice, I think that is OK, too.

> Well, I was just thinking quickly during jetlag-induced insomnia. I
> don't really care about the issue that much actually.

Heh. I have to admit I don't care enough to work on this personally,
either. I just _thought_ Linus was working on it, but I think what he is
doing is subtly different, and our discussion has diverged to something
that, if it ever came to pass, would be a separate feature.

-Peff
