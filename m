From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svnimport
Date: Thu, 25 Oct 2007 14:04:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710251403160.25221@racer.site>
References: <31e679430710250225w39a876d0w738d819245e514e@mail.gmail.com> 
 <Pine.LNX.4.64.0710251132580.25221@racer.site>
 <31e679430710250408g679538e7ha9e1e75507c2aac5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 15:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il2Of-0008Gh-2g
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 15:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbXJYNFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 09:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbXJYNFA
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 09:05:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:55383 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752321AbXJYNFA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 09:05:00 -0400
Received: (qmail invoked by alias); 25 Oct 2007 13:04:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 25 Oct 2007 15:04:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+o+YpnIbqoXUzRASK+3VfrQVm7T27A3yhc8M7nMW
	RVa7VxGBOwAcrq
X-X-Sender: gene099@racer.site
In-Reply-To: <31e679430710250408g679538e7ha9e1e75507c2aac5@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62318>

Hi,

On Thu, 25 Oct 2007, Felipe Balbi wrote:

> On 10/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Thu, 25 Oct 2007, Felipe Balbi wrote:
> >
> > > I was importing busybox svn repository to git but I got a connection 
> > > timeout after more than 19k commits... is there a way to continue 
> > > where the error happened or should I do it all over again ??
> >
> > AFAICT git-svn is better suited, even to one-shot importing svn.
> >
> > As it happens, I got interested in this project, too, and did an 
> > import some time ago.  For your pleasure, I uploaded it to
> >
> >         http://repo.or.cz/w/busybox.git/
> 
> thanks... much better... I'm cloning your tree and I'll merge with 
> current busybox tree... ;-)

FYI you'll have to do something like this:

	git svn init svn://busybox.net/trunk/busybox
	git svn fetch

to merge with current busybox (although I updated before I pushed).

Ciao,
Dscho
