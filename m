From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 10:56:30 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801091054400.31053@racer.site>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.00.0801071332530.3148@woody.linux-foundation.org>
 <alpine.DEB.1.00.0801082226110.21686@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Jan 09 11:57:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCYcT-0007iy-2x
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 11:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbYAIK4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 05:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYAIK4p
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 05:56:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:57711 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751149AbYAIK4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 05:56:45 -0500
Received: (qmail invoked by alias); 09 Jan 2008 10:56:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 09 Jan 2008 11:56:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/o4Ys0RI/34bD9GU9swweUHS4khbhigqAGV6oSO
	gQ9fm2OiabIJA1
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.DEB.1.00.0801082226110.21686@perkele.intern.softwolves.pp.se>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69981>

Hi,

On Tue, 8 Jan 2008, Peter Karlsson wrote:

> Linus Torvalds:
> 
> > So defaulting to (or asking) "autocrlf" at install time is probably 
> > the safest thing, and then people can edit their global .gitconfig to 
> > turn it off.
> 
> Indeed. A checkbox in the Windows installer (like Cygwin has) would be 
> nice.

No.  There are different needs for different projects, and having 
different defaults just adds to the confusion.

I am no longer opposed to setting crlf=true by default for Git (although 
this does not necessarily hold true for msysGit, but that could be 
helped by explicitely unsetting crlf for the repositories we check out 
with the netinstaller).

Ciao,
Dscho
