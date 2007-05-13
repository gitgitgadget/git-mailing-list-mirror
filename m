From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Segmentation fault in git-svn
Date: Sun, 13 May 2007 01:21:19 -0700
Message-ID: <20070513082118.GC1168@muzzle>
References: <4623F613.5010108@midwinter.com> <20070503123512.GA6500@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>
To: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 10:21:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn9KZ-0006Ed-Ou
	for gcvg-git@gmane.org; Sun, 13 May 2007 10:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbXEMIVW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 04:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756414AbXEMIVW
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 04:21:22 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53297 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755216AbXEMIVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 04:21:20 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3D0737DC0A3;
	Sun, 13 May 2007 01:21:19 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 13 May 2007 01:21:19 -0700
Content-Disposition: inline
In-Reply-To: <20070503123512.GA6500@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47129>

Peter Baumann <waste.manager@gmx.de> wrote:
> On Mon, Apr 16, 2007 at 03:17:55PM -0700, Steven Grimm wrote:
> >  I expect this is really a libsvn bug, but git-svn triggers it, so I'm hoping 
> >  someone else has run into and solved it, or at least that someone can 
> >  reproduce it.
> > 
> >  If I try to clone the "memcached" public repository with the command line
> > 
> >   git-svn clone --branches=branches --trunk=trunk 
> >  http://code.sixapart.com/svn/memcached
> 
> I'm getting segfaults in git-svn, too.
> 
> This command segfaults reproducably in r55 while running
> 
> 	git svn clone svn://svn.berlios.de/vermont vermont \
> 		-T trunk -b branches -t tags
> 

Both repositories seem to be cloning fine after the
patch here:

http://permalink.gmane.org/gmane.comp.version-control.git/47128

I really don't know what's going on with libsvn, either :(

-- 
Eric Wong
