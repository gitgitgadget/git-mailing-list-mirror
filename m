From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git and symlinks as tracked content
Date: Thu, 5 May 2005 17:23:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505051715500.30848-100000@iabervon.org>
References: <200505050709.43307.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 23:18:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTniN-0003X1-7W
	for gcvg-git@gmane.org; Thu, 05 May 2005 23:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVEEVXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 17:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVEEVXi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 17:23:38 -0400
Received: from iabervon.org ([66.92.72.58]:15623 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261794AbVEEVXh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 17:23:37 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DTnoY-0003o5-00; Thu, 5 May 2005 17:23:22 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200505050709.43307.alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 5 May 2005, Alan Chandler wrote:

> On Thursday 05 May 2005 00:03, Daniel Barkalow wrote:
> 
> > (on the other hand, it might make sense for git to handle files starting
> > with '.', and only skip .git).
> 
> definitely only as an option.  I envisage checking out (maybe anonymously) 
> from svn or other repositories and then using git locally to manage my own 
> development.  It would be preferable for the .git repository not to be 
> "polluted" with the svn prisine trees etc 

It wouldn't touch them at all unless you specifically added them. The
present situation is that git ignores files starting with "." even if you
specifically add them.

	-Daniel
*This .sig left intentionally blank*

