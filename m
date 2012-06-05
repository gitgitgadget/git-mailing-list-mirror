From: Jeff King <peff@peff.net>
Subject: Re: bug in merge
Date: Tue, 5 Jun 2012 01:23:12 -0400
Message-ID: <20120605052312.GA16958@sigill.intra.peff.net>
References: <4FCCE306.9020600@corp.hrsmart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Kevin Brannen <kbrannen@corp.hrsmart.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 07:23:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbmF1-0003I4-36
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 07:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757238Ab2FEFXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 01:23:22 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43030
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756748Ab2FEFXO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 01:23:14 -0400
Received: (qmail 12951 invoked by uid 107); 5 Jun 2012 05:23:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 01:23:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 01:23:12 -0400
Content-Disposition: inline
In-Reply-To: <4FCCE306.9020600@corp.hrsmart.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199201>

On Mon, Jun 04, 2012 at 11:32:06AM -0500, Kevin Brannen wrote:

> I believe I've just found a bug in "merge", specifically in the
> "recursive" strategy. (Or really, here's another example of and
> hopefully more info on a known bug.) Oh, this is with 1.7.2.3, the
> latest I'm able to use on this machine.
> [...]
> So I think the problem is just too many renames/moves of the same
> object and when "recursive" descends the tree, it just can't handle
> that correctly -- or that's my guess. :)

There were a large number of merge-recursive corner cases fixed,
especially around renames, in the 1.7.3, 1.7.4, and 1.7.7 versions of
git. I do not recall specially a bug that matches your description, but
I would not be surprised at all if was already fixed by existing
changes.

Can you try to reproduce with a more recent version of git (preferably
the current "master" branch)?

-Peff
