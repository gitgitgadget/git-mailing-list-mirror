From: Jeff King <peff@peff.net>
Subject: Re: non-empty index with git commit -a
Date: Tue, 15 Feb 2011 22:27:15 -0500
Message-ID: <20110216032715.GA1666@sigill.intra.peff.net>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net>
 <20110216032047.GA2858@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 04:27:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpY32-0001Dw-ES
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 04:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345Ab1BPD1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 22:27:19 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35029 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750Ab1BPD1S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 22:27:18 -0500
Received: (qmail 3003 invoked by uid 111); 16 Feb 2011 03:27:17 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 03:27:17 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Feb 2011 22:27:15 -0500
Content-Disposition: inline
In-Reply-To: <20110216032047.GA2858@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166920>

On Tue, Feb 15, 2011 at 09:20:47PM -0600, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Tue, Feb 15, 2011 at 10:43:53PM +0000, Sverre Rabbelier wrote:
> 
> >> Can we please fix this?
> >>
> >> $ hack hack hack
> >> $ git add -p # carefully add my changes
> >> $ git commit -am "Add feature foo"
> >> $ DAAAMN YOUUU FINGERS!!
> >>
> >> I remember bringing this up before, but I can't remember what the
> >> discussion ended up coming to.
> >
> > How do you differentiate this from:
> >
> >   $ hack hack hack
> >   $ git add -p ;# carefully add my changes
> >   $ hack hack hack
> >   $ git diff ;# ok, everything looks good
> >   $ git commit -am "Add feature foo"
> >
> > ?
> 
> If I remember the discussion[1] correctly, by requiring a separate
> add -u step (or commit -f -a) if the "I don't trust my fingers"
> configuration is enabled.
> 
> [1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/698001/focus=145662

Thanks for the link, I didn't recall that discussion. I have no problem
with a config option that requires an extra step, but such a safety
valve should definitely be optional, since the current behavior is part
of a perfectly reasonable workflow.

-Peff
