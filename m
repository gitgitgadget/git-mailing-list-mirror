From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: 'upstream' branches.
Date: Sat, 05 May 2007 18:50:28 +0100
Message-ID: <1178387429.17680.35.camel@shinybook.infradead.org>
References: <1178368166.11851.60.camel@pmac.infradead.org>
	 <20070505174416.GA2898@steel.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 19:50:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkOPC-0007rG-RZ
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934155AbXEERuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 13:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934152AbXEERuQ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:50:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38452 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934155AbXEERuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 13:50:11 -0400
Received: from shinybook.infradead.org ([90.155.92.197])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HkOOY-0005LB-CP; Sat, 05 May 2007 18:50:10 +0100
In-Reply-To: <20070505174416.GA2898@steel.home>
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7.dwmw2.2) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46275>

On Sat, 2007-05-05 at 19:44 +0200, Alex Riesen wrote:
> David Woodhouse, Sat, May 05, 2007 14:29:26 +0200:
> > [remote "origin"]
> >         url = ssh://git.infradead.org/~/public_git/foo-2.6.git
> >         fetch = +refs/heads/*:refs/remotes/origin/*
> > 	fetch = +refs/heads/mtd:refs/heads/mtd
> > 	fetch = +refs/heads/linus:refs/heads/linus
> 
> These pluses request overwriting of the local reference even if it has
> more commits than the remote ("is newer"). Are you sure you want that?
> 
> > What I have at the moment isn't ideal because I think pulling from the
> > 'mtd' tree will fail if the 'linus' branch there is older than the local
> > clone's 'linus' branch. But it mostly works.
> > 
> > Is there a better way?
> 
> I would just remove the pluses. git-fetch will say that the branch is
> already up-to-date, if the local branch already has everything the
> remote has.

Then after I pull from Linus' tree, I can't pull from the mtd tree -- it
complains that the 'linus' branch there can't be fast-forwarded, and
refuses to pull the 'master' branch.

I think what I actually want is an 'only fast-forward, but don't error
if you can't' option.

-- 
dwmw2
