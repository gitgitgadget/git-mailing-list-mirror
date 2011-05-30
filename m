From: Jeff King <peff@peff.net>
Subject: Re: How would Git chapter look like in "The Architecture of Open
 Source Applications"?
Date: Sun, 29 May 2011 23:40:45 -0400
Message-ID: <20110530034044.GC27691@sigill.intra.peff.net>
References: <201105281417.39883.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 05:40:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQtLY-0001kK-AY
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 05:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab1E3Dkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 23:40:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49472
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275Ab1E3Dkq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 23:40:46 -0400
Received: (qmail 11806 invoked by uid 107); 30 May 2011 03:40:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 29 May 2011 23:40:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 May 2011 23:40:45 -0400
Content-Disposition: inline
In-Reply-To: <201105281417.39883.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174717>

On Sat, May 28, 2011 at 02:17:38PM +0200, Jakub Narebski wrote:

> Among covered programs is Mercurial (chapter by Dirkjan Ochtman)...
> but unfortunately no Git (they probably thought that one DVCS is enough).
> 
> How would such chapter on Git look like?  Authors of this book
> encourage (among others) to write new chapters.

I just skimmed the Mercurial chapter, but they do cover a fair bit of
general DVCS architecture. For git, I would guess a good approach would
be to describe the data structures (i.e., content-addressable object
database, DAG of commits, refs storing branches and tags), as everything
else falls out from there. Most of the basic commands can be explained
as "do some simple operation to the history graph or object db" and the
more complex commands are compositions of the simple ones. So the
architecture is really about having a data structure that represents the
problem, exposing it to the user, and then building some niceties around
the basic data structure operations.

Of course that's just my perspective. Linus might have written something
totally different. :)

-Peff
