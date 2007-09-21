From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cvsimport bug on branches [was: conversion to git]
Date: Fri, 21 Sep 2007 21:22:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709212121330.28395@racer.site>
References: <loom.20070920T010842-272@post.gmane.org>
 <8D5EA3F4-9642-4604-963E-838D03650FBC@zib.de>
 <alpine.LFD.0.999.0709210840190.16478@woody.linux-foundation.org>
 <200709211915.35642.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steffen Prohaska <prohaska@zib.de>, Eric Blake <ebb9@byu.net>,
	m4-patches@gnu.org, Jim Meyering <jim@meyering.net>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:23:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYp1q-0004aF-L9
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 22:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbXIUUXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 16:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbXIUUXD
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 16:23:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:40340 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750807AbXIUUXB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 16:23:01 -0400
Received: (qmail invoked by alias); 21 Sep 2007 20:22:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 21 Sep 2007 22:22:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181LBkEnjw1OM0wiygi0bOxzyxYHFDUOcQ9otR6Br
	TvtzboOT9kTwFW
X-X-Sender: gene099@racer.site
In-Reply-To: <200709211915.35642.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58875>

Hi,

On Fri, 21 Sep 2007, Robin Rosenberg wrote:

> fredag 21 september 2007 skrev Linus Torvalds:
> > 
> > The big advantage of git-cvsimport is that it can do incremental 
> > imports, which I don't think the other methods do. But if there is any 
> > choice at all, and especially if you're not that interested in the 
> > incremental feature (ie you can cut over to git, and perhaps use 
> > git-cvsserver to "supprt" CVS users) the other CVS importers are 
> > likely to be much better.
> 
> fromcvs does incremental import and it's very fast and uses much less 
> memory than cvsimport. It needs the rcs files however and will not 
> convert non-branch tags.

Plus you have to install Ruby.  Just wanted people to know.

Ciao,
Dscho
