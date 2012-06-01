From: Jeff King <peff@peff.net>
Subject: Re: Bug: git ls-files and ignored directories
Date: Fri, 1 Jun 2012 05:37:57 -0400
Message-ID: <20120601093757.GE32340@sigill.intra.peff.net>
References: <20120530102218.0625CFC006A@dd24126.kasserver.com>
 <20120531101451.C35C5B4C00D@dd24126.kasserver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Christoph Buchner <bilderbuchi@phononoia.at>
X-From: git-owner@vger.kernel.org Fri Jun 01 11:38:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaOJ6-0001dP-9H
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 11:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759322Ab2FAJiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 05:38:03 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39701
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759300Ab2FAJiB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 05:38:01 -0400
Received: (qmail 31552 invoked by uid 107); 1 Jun 2012 09:38:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Jun 2012 05:38:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2012 05:37:57 -0400
Content-Disposition: inline
In-Reply-To: <20120531101451.C35C5B4C00D@dd24126.kasserver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198970>

On Thu, May 31, 2012 at 12:14:51PM +0200, Christoph Buchner wrote:

> This is the right place to report bugs, right?

Yes.

> Is there any protocol to follow I'm not aware of, to enable you to
> process this bug report?

Not really. You send the report, and you may or may not get a response
(just as you may or may not have somebody respond to you in a bug
tracker).  Probably nobody has had a chance to look at it yet. If there
is a history to the bug (which there is in this case), it is sometimes
helpful to cc the previous participants to see if they are still
interested in it.

> > I think I've been bitten by a bug in git ls-files - committed
> > directories (and files therein) which are matched by a "dir/"
> > gitignore rule are not shown by "git ls-files --exclude-standard
> > -i", although they should be. Matched files are shown.
> > 
> > I've found a very brief discussion on this mailing list from March
> > 2011 about this, including a repro procedure which still is valid
> > today, at http://marc.info/?l=git&m=129926031808376&w=4
> > 
> > Is that a known/in progress bug? If yes, (when) can a fix be
> > expected? How can I work around this in the meantime?

No, I don't think anybody is working on it at the moment (at least I
do not see anything near the time of that old discussion, nor do I
recall it being discussed since).

+cc Clemens, in case he had any work-in-progress as a result that did
not end up getting published.

-Peff
