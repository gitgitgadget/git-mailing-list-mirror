From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 13:16:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241315290.4648@racer.site>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net> <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
 <20070524072945.GO28023@spearce.org> <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site> <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site> <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site> <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 14:16:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrCFM-00078n-E7
	for gcvg-git@gmane.org; Thu, 24 May 2007 14:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbXEXMQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 08:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756015AbXEXMQn
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 08:16:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:58229 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755689AbXEXMQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 08:16:42 -0400
Received: (qmail invoked by alias); 24 May 2007 12:16:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 24 May 2007 14:16:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ut3RM3EoUO61E+60OAEqYGSMdahw5uLmgjC3GqJ
	32zMBvXo7A8R2H
X-X-Sender: gene099@racer.site
In-Reply-To: <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48248>

Hi,

On Thu, 24 May 2007, Sven Verdoolaege wrote:

> On Thu, May 24, 2007 at 12:31:33PM +0100, Johannes Schindelin wrote:
> > On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > > OK... so what should git-update-server-info put in this file for submodules?
> > > Or, equivalently, what should be the output of ls-remote?
> > > 
> > > Right now its a list of pairs of revs(sha1) and refs.
> > > For submodules we want a connection between a submodule name
> > > and one or more URLs where the submodule can be found.
> > > How are you going to squeeze that into info/refs without confusing
> > > older versions of git?
> > 
> > I wonder if the "ref^{blub}" syntax could be used for that: change "blub" 
> > to the URL, or "sub:URL" or something.
> 
> Just to be clear, would it look like the following?
> 
> e8a6e39ecfbd391a54b9c3329fd3c6e33d745abd	refs/heads/bernstein
> c5c64e3fe48302f0c4581985f9c68d615f7bcb4e	refs/heads/master
> 3fa7ded19a8da868d3af7c942f86358e6720f0c7	refs/heads/submodule
> /home/sverdool/public_html/cloog.git	cloog^{URL}
> http://www.liacs.nl/~sverdool/cloog.git	cloog^{URL}

I was more thinking about something like this:
3fa7ded19a8da868d3af7c942f86358e6720f0c7	refs/heads/submodule^{URL:/home/sverdool/public_html/cloog.git}

But then, I haven't really thought about it deeply.

Ciao,
Dscho
