From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: All I wanted was git-fast-export
Date: Sun, 10 Feb 2008 12:51:59 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101248260.11591@racer.site>
References: <47ADE275.3060109@glidos.net> <alpine.LSU.1.00.0802091803580.11591@racer.site> <47AE2CDF.4090208@glidos.net> <alpine.LSU.1.00.0802100054490.11591@racer.site> <47AECCDC.3050500@glidos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Sun Feb 10 13:52:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOBfc-00078s-05
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 13:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbYBJMv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 07:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755705AbYBJMv6
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 07:51:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:38643 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755350AbYBJMv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 07:51:58 -0500
Received: (qmail invoked by alias); 10 Feb 2008 12:51:56 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp009) with SMTP; 10 Feb 2008 13:51:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181kA1TO5M1rJCMJVkZNmvAXneZRB54PN4FF57qwa
	FhK+RPJdb326JG
X-X-Sender: gene099@racer.site
In-Reply-To: <47AECCDC.3050500@glidos.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73349>

Hi,

[please do not look the other way when you respond to me, i.e. do not cull 
me from the Cc: list.  Thankyouverymuch]

On Sun, 10 Feb 2008, Paul Gardiner wrote:

> Johannes Schindelin wrote:
> 
> > The thing is, filter-branch was _written for this purpose_.  So if you 
> > know what commit you rewrote last, you can make the process 
> > faster/safer by issuing
> > 
> > 	$ git filter-branch --msg-filter="<blabla>" <old-commit>..master
> 
> That does look just what I need, but did you see the reason I thought I 
> couldn't use it? I need to repeatedly sync the git repository from a 
> live cvs repository, and repeatedly filter the new commit messages.

Oh, I thought you saw why I put in that "<old-commit>...".  You do not 
really need it, as filter-branch will come up with the _same_ commit 
hashes, unless _something_ was changed.

IOW if you have only commits without that "Summary: " prefix, the 
filter-branch call will be a (not so cheap) no-op.

But of course, I meant to suggest (admittedly, in a very short short-hand) 
that you use "git filter-branch ... origin@{1}..origin" after cvsimport.

Hth,
Dscho
