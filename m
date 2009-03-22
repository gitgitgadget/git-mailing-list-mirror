From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git for Windows 1.6.2.1-preview20090322
Date: Mon, 23 Mar 2009 00:25:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903230015020.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de> <20090322225315.GC22428@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlX2m-0007VL-3J
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbZCVXX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 19:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756719AbZCVXX6
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:23:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:51092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756371AbZCVXX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 19:23:57 -0400
Received: (qmail invoked by alias); 22 Mar 2009 23:23:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 23 Mar 2009 00:23:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183b5l3cUk3twm3G44qM7n3v3+3BhYoPe3WLdxlW9
	AQ4AEO1Xn2f/+x
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090322225315.GC22428@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114203>

Hi,

On Sun, 22 Mar 2009, Jeff King wrote:

> On Sun, Mar 22, 2009 at 10:17:23PM +0100, Johannes Schindelin wrote:
> 
> > - Some commands are not yet supported on Windows and excluded from the 
> >   installation; namely: git archimport, git cvsexportcommit, git 
> >   cvsimport, git cvsserver, git filter-branch, git instaweb, git 
> >   send-email, git shell.
> 
> A few people have asked about filter-branch on Windows recently;

I am not aware of any.  But then, I think nobody mentioned it on the 
msysgit list (which would be the correct place), and I am likely to have 
missed it if it was sent elsewhere.

> JSixt indicated that it works from his built version:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/112103
> 
> Is it time to include it?

Actually, not only Hannes' version runs the test t7003 okay, but also 
4msysgit's version.

But let's reduce the differences between git.git and 4msysgit.git further 
first.

I'll wait with the next Git for Windows release until the next official 
Git version is released, anyway.  Or if Steffen wants to take msysGit over 
again when he comes back, he will wait until the next official Git 
versions is released, anyway.

Ciao,
Dscho
