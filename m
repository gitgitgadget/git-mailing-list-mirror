From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: 'upstream' branches.
Date: Sun, 6 May 2007 00:52:49 +0200
Message-ID: <20070505225249.GE2898@steel.home>
References: <1178368166.11851.60.camel@pmac.infradead.org> <20070505174416.GA2898@steel.home> <1178387429.17680.35.camel@shinybook.infradead.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Sun May 06 00:53:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkT7Y-0002qy-9X
	for gcvg-git@gmane.org; Sun, 06 May 2007 00:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbXEEWwx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 18:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbXEEWww
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 18:52:52 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:31569 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629AbXEEWww (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 18:52:52 -0400
Received: from tigra.home (195.4.202.37)
	by post.webmailer.de (fruni mo22) (RZmta 5.9)
	with ESMTP id A04906j45Iow9s ; Sun, 6 May 2007 00:52:50 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1715B277BD;
	Sun,  6 May 2007 00:52:50 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D97F5D171; Sun,  6 May 2007 00:52:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1178387429.17680.35.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46291>

David Woodhouse, Sat, May 05, 2007 19:50:28 +0200:
> > > 
> > > Is there a better way?
> > 
> > I would just remove the pluses. git-fetch will say that the branch is
> > already up-to-date, if the local branch already has everything the
> > remote has.
> 
> Then after I pull from Linus' tree, I can't pull from the mtd tree -- it
> complains that the 'linus' branch there can't be fast-forwarded, and
> refuses to pull the 'master' branch.

Which got me by surprise (just tried). I though it'd notice that all
the commits are already present...

Experts, is it really supposed to be that way?
