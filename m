From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Strange behavior with git rebase (-i)
Date: Sat, 2 Feb 2008 17:08:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802021708030.7372@racer.site>
References: <47A44974.7050907@samba.org> <alpine.LSU.1.00.0802021538300.7372@racer.site> <20080202162524.GB25945@dervierte>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 18:10:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLLt6-0005ic-4U
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 18:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763883AbYBBRJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 12:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbYBBRJ2
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 12:09:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:33783 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763671AbYBBRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 12:09:10 -0500
Received: (qmail invoked by alias); 02 Feb 2008 17:09:08 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp022) with SMTP; 02 Feb 2008 18:09:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+IFSNDIxaIJZYT3HBuuxjsnB3IINZBt6VY3Fv1fp
	u1L+ZRtCTe43Y/
X-X-Sender: gene099@racer.site
In-Reply-To: <20080202162524.GB25945@dervierte>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72288>

Hi,

On Sat, 2 Feb 2008, Steven Walter wrote:

> On Sat, Feb 02, 2008 at 03:42:06PM +0000, Johannes Schindelin wrote:
> > I don't believe it.  "git branch" would have shown "* (no branch)" as 
> > current branch, unless the rebase is finalized.
> > 
> > git rebase -i works on a _detached_ HEAD, for two reasons:
> 
> > On Sat, 2 Feb 2008, Stefan (metze) Metzmacher wrote:
> > > I was using git 1.5.3.2
> 
> Did rebase -i in git 1.5.3.2 use a detached head?  I thought that was
> new in 1.5.4.

rebase -i uses a detached HEAD since it was merged.  In 1.5.4, rebase 
(note the absence of -i) uses a detached HEAD, too.

Ciao,
Dscho
