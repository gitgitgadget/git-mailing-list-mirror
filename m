From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Multi-ancestor read-tree notes
Date: Thu, 8 Sep 2005 18:10:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509081805280.23242@iabervon.org>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
 <1126199765.3984.1.camel@localhost.localdomain> <Pine.LNX.4.63.0509081727560.23242@iabervon.org>
 <7vy867te3f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 00:09:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDUY2-0004jm-RI
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 00:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVIHWG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 18:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbVIHWG4
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 18:06:56 -0400
Received: from iabervon.org ([66.92.72.58]:29713 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965007AbVIHWG4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 18:06:56 -0400
Received: (qmail 32664 invoked by uid 1000); 8 Sep 2005 18:10:53 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Sep 2005 18:10:53 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy867te3f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8223>

On Thu, 8 Sep 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I assume that what you want is something to include everything from two 
> > commits, which would give conflicts if a name is reused?
> 
> My understanding is that Darrin wants to do what Linus did when
> he merged gitk into git.git.
> 
> Personally I think that is a specialized application and
> something like the git-merge-projects script I posted as a
> follow-up would be more appropriate than adding it to the
> current merge discussion.

Well, it's an easy addition to read-tree; just need a merge function which 
takes two entries and adds the non-NULL one in stage 0, or adds both if 
they both exist. git-merge-script probably shouldn't be the entry point to 
it, of course, but that part isn't my area anyway.

	-Daniel
*This .sig left intentionally blank*
