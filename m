From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: More Porcelains?
Date: Tue, 27 Sep 2005 02:15:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509270132370.23242@iabervon.org>
References: <20050926175156.GB9410@reactrix.com> <20050926182341.GA26340@pasky.or.cz>
 <7v3bnrh85g.fsf@assigned-by-dhcp.cox.net> <20050927001542.GC15615@reactrix.com>
 <7v64sn8hml.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 08:12:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK8g5-0007se-3P
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 08:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVI0GKi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 02:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVI0GKi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 02:10:38 -0400
Received: from iabervon.org ([66.92.72.58]:57609 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964824AbVI0GKg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 02:10:36 -0400
Received: (qmail 4285 invoked by uid 1000); 27 Sep 2005 02:15:06 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Sep 2005 02:15:06 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64sn8hml.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9372>

On Mon, 26 Sep 2005, Junio C Hamano wrote:

> How many of you are working on your own Porcelains, announced or
> unannounced?

I don't have a porcelain, but I organize my working trees/repository in a 
non-standard way, using an additional script (which creates a new working 
tree linked to an existing repository). 

I've also got a set of scripts for splitting up a patch into a series, 
which I've still not gotten around to cleaning up and submitting.

For the way I structure my working trees, it would be really helpful if 
all of the miscellaneous things that should stay with a repository (such 
as remotes) were in a single subdirectory of .git, so that I could just 
have a third symlink and have it all work, rather than needing a bunch of 
additional links.

	-Daniel
*This .sig left intentionally blank*
