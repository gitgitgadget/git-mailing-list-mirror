From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] push to mirrior interferes with parallel operations
Date: Fri, 19 Nov 2010 16:54:32 -0500
Message-ID: <20101119215431.GB19644@sigill.intra.peff.net>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
 <20101118175007.GA26505@sigill.intra.peff.net>
 <20101118184241.GN3693@efreet.light.src>
 <20101118190414.GA30438@sigill.intra.peff.net>
 <m2ipzt14rh.fsf@igel.home>
 <20101119213256.GA579@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 22:55:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJYvK-0007fx-CQ
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 22:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286Ab0KSVyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 16:54:36 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54599 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757161Ab0KSVyf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 16:54:35 -0500
Received: (qmail 29161 invoked by uid 111); 19 Nov 2010 21:54:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 19 Nov 2010 21:54:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Nov 2010 16:54:32 -0500
Content-Disposition: inline
In-Reply-To: <20101119213256.GA579@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161794>

On Fri, Nov 19, 2010 at 03:32:56PM -0600, Jonathan Nieder wrote:

> Andreas Schwab wrote:
> > Jeff King <peff@peff.net> writes:
> 
> >> it really only makes sense to push from a non-bare repo,
> >
> > Why?  The repo could itself be a mirror.
> 
> Jeff seems to have meant
> 
> 	When in a non-bare repo, it only makes sense to push.
> 
> which is to say, push --mirror makes sense from a bare repo but fetch
> --mirror does not.  However, I think you read

Yes, but s/bare/non-bare/ in your statement. :)

There is also more to it, see the other mail I just sent.

-Peff
