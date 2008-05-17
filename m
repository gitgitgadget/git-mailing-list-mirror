From: Jeff King <peff@peff.net>
Subject: Re: partial globbing in fetch refspecs broken in v1.5.5
Date: Sat, 17 May 2008 01:22:12 -0400
Message-ID: <20080517052212.GC18876@sigill.intra.peff.net>
References: <20080516212833.GA5366@penelope.zusammrottung.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 07:23:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxEss-0001Hz-An
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 07:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbYEQFWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 01:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbYEQFWQ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 01:22:16 -0400
Received: from peff.net ([208.65.91.99]:2715 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbYEQFWP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 01:22:15 -0400
Received: (qmail 24903 invoked by uid 111); 17 May 2008 05:22:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 May 2008 01:22:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 May 2008 01:22:12 -0400
Content-Disposition: inline
In-Reply-To: <20080516212833.GA5366@penelope.zusammrottung.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82335>

On Fri, May 16, 2008 at 11:28:34PM +0200, Nikolaus Schulz wrote:

> the new refspec parser in v1.5.5 has also broken fetch uses like
> 
>     git fetch <url> +refs/heads/<foo>*:refs/remotes/<bar>*. 

This was intentionally changed in ef00d150 (Tighten refspec processing).
There is some associated discussion in this thread:

  http://mid.gmane.org/7vwso2ieuu.fsf@gitster.siamese.dyndns.org

But I don't see any particular reason why this syntax should not be
allowed (besides, "it was never meant to be supported, so it was causing
other breakage").

-Peff
