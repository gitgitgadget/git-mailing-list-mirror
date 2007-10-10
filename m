From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding color to git-add--interactive
Date: Wed, 10 Oct 2007 16:06:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710101604350.4174@racer.site>
References: <91EBB71E-BB4E-4089-8C33-6B0C4A61223A@steelskies.com>
 <20071009234020.GA20952@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 17:06:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifd8y-0006tP-4G
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 17:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbXJJPGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 11:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755249AbXJJPGa
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 11:06:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:55384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755243AbXJJPG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 11:06:29 -0400
Received: (qmail invoked by alias); 10 Oct 2007 15:06:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 10 Oct 2007 17:06:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1953R9+Ll95WW/tk38QgpOrWfSGGCq8Z0qc2tp4Gw
	DoJf1c+2BqnNjI
X-X-Sender: gene099@racer.site
In-Reply-To: <20071009234020.GA20952@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60507>

Hi,

On Tue, 9 Oct 2007, Jeff King wrote:

> On Tue, Oct 09, 2007 at 02:06:31PM +0100, Jonathan del Strother wrote:
> 
> > For me at least, adding color would make the interactive mode far more
> > readable.   I hacked in basic color support (just coloring PROMPT &
> > HEADER in list_and_choose, and the "Stage this hunk?" prompt) - which
> > helped a lot - but then reached the limits of my perl knowledge.  For
> > instance, I can't see a sensible way of reusing git-svn's
> > log_use_color function without importing the entire file, and I can't
> > figure out how you'd go about diff-coloring the hunks.  Is anyone with
> > more perl knowledge than me interested in taking this on?
> 
> Why don't you post what you have, and we can make comments on it?
> 
> As far as reusing code from git-svn, there is a 'Git.pm' module in the
> perl/ subdirectory. You can move the code there and 'use Git' in
> git-add--interactive.perl (git-svn already uses it).

I think the reason git-add--interactive does not use it is that some 
people (me included) experienced heavy problems with perl modules.  
However, I do not recall to which extent they have been solved.  I guess 
when git-add--interactive goes Git.pm and stops working for me, I'll do my 
famous "aargh, I'll just make it a builtin" song.

Ciao,
Dscho
