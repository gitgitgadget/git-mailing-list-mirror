From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] git pull and importers
Date: Sat, 7 Apr 2007 13:41:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704071323010.27922@iabervon.org>
References: <Pine.LNX.4.64.0704062239420.27922@iabervon.org>
 <7v1wiwfeo5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 19:56:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaEv8-00087I-QY
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 19:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966188AbXDGRlr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 13:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933630AbXDGRlr
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 13:41:47 -0400
Received: from iabervon.org ([66.92.72.58]:1857 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933617AbXDGRlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 13:41:46 -0400
Received: (qmail 24681 invoked by uid 1000); 7 Apr 2007 17:41:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Apr 2007 17:41:39 -0000
In-Reply-To: <7v1wiwfeo5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43978>

On Sat, 7 Apr 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Which would mean that it would use "git svn fetch" instead of "git fetch" 
> > for that remote, and "git svn fetch" would use that config section instead 
> > of its current config section.
> >
> > Any reason this couldn't be made to work?
> 
> No reason.  Making git-$(scm)import to behave more like
> git-fetch-pack backend was one of the longstanding items on my
> wishlist.  I think "cvsimport -i" could mostly be usable in the
> current shape for that, but I do not know about others.

I picked git-svn in part because it looks especially obvious; it even 
calls fetch "fetch". Not that that *really* counts for much, but I can 
pretend.

> Especially I do not interoperate with any SVN repositories
> myself, so I cannot scratch your itch.

I'll look into it, if the config option scheme looks reasonable to you.

> However, I suspect you could help me with a code I've been
> struggling with on-and-off lately.  Do you still remember
> unpack-trees code?

I'm not sure how similar it is these days to the code I worked on (which 
was called "read-tree", I think), but I'll take a look.

	-Daniel
*This .sig left intentionally blank*
