From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Listing authors of each file in branch HEAD since given
 revision
Date: Thu, 29 May 2008 23:57:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805292356470.13507@racer.site.net>
References: <c6c947f60805290143r731b4a80v8d8297124899be22@mail.gmail.com> <alpine.DEB.1.00.0805291344400.13507@racer.site.net> <20080529195314.GB18781@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 30 00:59:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1r5q-0002WN-UX
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 00:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbYE2W6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 18:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbYE2W6a
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 18:58:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:51193 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751243AbYE2W63 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 18:58:29 -0400
Received: (qmail invoked by alias); 29 May 2008 22:58:27 -0000
Received: from R1bad.r.pppool.de (EHLO none.local) [89.54.27.173]
  by mail.gmx.net (mp009) with SMTP; 30 May 2008 00:58:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/18H5MTqL1kMNX7HxfxISNhoydzmOuABVbvAh/go
	Nen9jaqARTzUUw
X-X-Sender: gene099@racer.site.net
In-Reply-To: <20080529195314.GB18781@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83251>

Hi,

On Thu, 29 May 2008, Petr Baudis wrote:

> On Thu, May 29, 2008 at 01:47:29PM +0100, Johannes Schindelin wrote:
> > On Thu, 29 May 2008, Alexander Gladysh wrote:
> > 
> > > For each file in the head of my current branch I need to get a list of 
> > > all people who altered it since given revision. If file was not changed, 
> > > it should be not listed.
> > > 
> > > Something like:
> > > 
> > >   my/file1.ext user1 user2 user3
> > >   my/file2.ext user1
> > 
> > You will be able to do something like this easily from the output of
> > 
> > git log --pretty=format:%an --name-only HEAD
> > 
> > Probably just a Perl script which reads the author name, and then attaches 
> > that author name to all following file names until an empty lines occurs, 
> > recursively.
> 
> No rocket science:
>
> [snipped]

I know, but I wanted to give Alexander room to grow ;-)

Ciao,
Dscho
