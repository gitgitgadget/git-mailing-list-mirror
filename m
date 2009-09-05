From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Sat, 5 Sep 2009 12:39:37 +0100
Message-ID: <20090905113937.GA13390@opensource.wolfsonmicro.com>
References: <7vy6oy9z9r.fsf@alter.siamese.dyndns.org> <200909012325.45739.j6t@kdbg.org> <7vtyzmxkpr.fsf@alter.siamese.dyndns.org> <20090902011513.GA3874@coredump.intra.peff.net> <7vmy5egefh.fsf@alter.siamese.dyndns.org> <20090902051248.GB12046@coredump.intra.peff.net> <20090902124832.GC4012@sirena.org.uk> <20090902180050.GB5998@coredump.intra.peff.net> <20090902183923.GA10581@rakim.wolfsonmicro.main> <20090905090422.GA13221@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 13:41:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjtcT-0004cZ-08
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 13:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340AbZIELji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 07:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757327AbZIELjh
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 07:39:37 -0400
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54823 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757313AbZIELjg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Sep 2009 07:39:36 -0400
Received: by opensource2.wolfsonmicro.com (Postfix, from userid 1001)
	id EF8F8768A11; Sat,  5 Sep 2009 12:39:37 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20090905090422.GA13221@coredump.intra.peff.net>
X-Cookie: Your aim is high and to the right.
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127809>

On Sat, Sep 05, 2009 at 05:04:22AM -0400, Jeff King wrote:
> On Wed, Sep 02, 2009 at 07:39:23PM +0100, Mark Brown wrote:

> > My main wishlist would be to have the same control for the changes to be
> > committed for the big merge case, the use case being while resolving

> I think we need to be more concrete than that. What is the "big merge
> case"? If there are any unmerged paths?

The context was that this was done when explictly requested by the user
so all the time when enabled.  In the context I'm thinking of this would
be used via the command line more than via the config file.

> What exactly should be cut out, and how can it be configured? Should you
> have "status.unmerged" to cut out certain things? Which things (of
> staged, unstaged, and untracked)? Or should it go the other way, with a
> status.showStaged variable which can be set to "always", "never", or
> "unmerged" (and probably adding an "unmerged" option to
> "status.showUntrackedFiles).

I'd been thinking of not showing anything in the index but keeping
everything else.  In terms of a configuration variable I'd go with
specifying the things not to show rather than the things to show - 
the noise to cut out.
