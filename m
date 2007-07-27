From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can you do this with GIT?
Date: Fri, 27 Jul 2007 20:49:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707272048280.14781@racer.site>
References: <11834063.post@talk.nabble.com> <Pine.LNX.4.64.0707272002250.14781@racer.site>
 <200707271345.03300.rayl@mail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: CPD <cdavidson@altsoftware.com>, git@vger.kernel.org
To: Ray Lehtiniemi <rayl@mail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 21:50:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVpJ-0007GK-I5
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762514AbXG0TuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762378AbXG0TuN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:50:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:44586 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760618AbXG0TuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:50:11 -0400
Received: (qmail invoked by alias); 27 Jul 2007 19:50:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 27 Jul 2007 21:50:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8zDwjxC+8gDPoM8MYhimQbDZpgZ4kCDYzC9FQfn
	icR/WtsbH1p8ph
X-X-Sender: gene099@racer.site
In-Reply-To: <200707271345.03300.rayl@mail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53959>

Hi,

On Fri, 27 Jul 2007, Ray Lehtiniemi wrote:

> On Friday 27 July 2007 13:05, Johannes Schindelin wrote:
> > On Fri, 27 Jul 2007, CPD wrote:
> 
> > > We produce variations based on a (mostly) common codebase. In CVS I set
> > > up "environment" modules for each platform, then when you are working on
> > > that platform, you simply check out the correct environment and build.
> > > Only the needed code and tools are exposed in that environment (this is
> > > important as clients must NOT see each other's code and most customers
> > > have some customization). I do this by defining and renaming modules in
> > > the CVSROOT modules file.
> >
> > I would use branches for that.  A base branch with the common code, and
> > the customisations in all the branches, which merge from the base branch.
> 
> this would break down if there were client-specific modules in the base 
> branch, though... how could those be hidden from the other clients?

Umm.  Don't put the client-specific modules in the base branch, then?  The 
base branch is the common code, the code that every client may look at.  
Nothing else.

Maybe I did not get the whole picture...  do you want your _clients_ to 
access your main repo with Git?

Ciao,
Dscho
