From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] git rm: Support for removing submodules
Date: Thu, 17 Jul 2008 13:59:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807171358550.8986@racer>
References: <20080716190753.19772.93357.stgit@localhost> <20080716191134.19772.85003.stgit@localhost> <alpine.DEB.1.00.0807170038430.4318@eeepc-johanness> <20080717123501.GD10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 15:00:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJT60-0003an-Hx
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 15:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbYGQM7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 08:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755597AbYGQM7e
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 08:59:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:39754 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754249AbYGQM7d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 08:59:33 -0400
Received: (qmail invoked by alias); 17 Jul 2008 12:59:32 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp029) with SMTP; 17 Jul 2008 14:59:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AJTtJoyYAsW09YCylqPg/EOlJYVMirerOK7M/gx
	HXWg0QIuPgx9EX
X-X-Sender: gene099@racer
In-Reply-To: <20080717123501.GD10151@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88846>

Hi,

On Thu, 17 Jul 2008, Petr Baudis wrote:

> On Thu, Jul 17, 2008 at 12:41:57AM +0200, Johannes Schindelin wrote:
> > On Wed, 16 Jul 2008, Petr Baudis wrote:
> > 
> > > This patch adds support for removing submodules to 'git rm', 
> > > including removing the appropriate sections from the .gitmodules 
> > > file to reflect this
> > 
> > I have no time to look at the whole series, or even at the patch, but 
> > I have concerns.  Do you really remove the whole directory?  Because 
> > if you do, you remove more than what can be possibly reconstructed 
> > from the object store.
> 
> no; I remove only the index entry and the empty directory made for 
> non-checked-out submodules (I just try rmdir() and ignore ENOTEMPTY 
> error).  I make that clear in git rm documentation, but not in the patch 
> description; I will fix that.

Thanks for explanation!

> > I wonder if it really makes sense to integrate that into git-rm, and 
> > not git-submodule, if only to introduce another level of consideration 
> > for the user before committing what is potentially a big mistake.
> 
> That is good question and I forgot to elaborate on this in the cover 
> letter. However, I believe that integrating this functionality into the 
> basic commands makes for a smoother user experience, following the 
> principle of the least surprise.

Makes sense,
Dscho
