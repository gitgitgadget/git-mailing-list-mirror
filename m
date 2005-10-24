From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFE: git rm
Date: Mon, 24 Oct 2005 18:22:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510241812530.25300@iabervon.org>
References: <435D2FE0.3060307@pobox.com> <7virvmodhz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510241725370.25300@iabervon.org> <7vr7aalg57.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 00:24:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUAil-0001BQ-9O
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 00:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVJXWXI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 18:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVJXWXI
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 18:23:08 -0400
Received: from iabervon.org ([66.92.72.58]:31760 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751147AbVJXWXG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 18:23:06 -0400
Received: (qmail 9306 invoked by uid 1000); 24 Oct 2005 18:22:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Oct 2005 18:22:33 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7aalg57.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10565>

On Mon, 24 Oct 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I often do "git add something" when I happen to think of it, not 
> > necessarily right before committing, which means that I have these files 
> > changed in my index while working. I may quit this, however, now that git 
> > status lists the ones I missed.
> 
> Oh, I do 'git add' myself; otherwise I'd surely forget by the
> time I commit.
> 
> And I did not mean to tell you to quit doing it.  If any of you
> took what I said as "Linus does not do it, I do not do it, so
> you should not be doing update-index in the middle", then that
> was not my intention and I apologize for causing confusion.

Actually, I'm thinking of quitting that because I'm actually more likely 
to realize I need to add something when I see it in the untracked list 
than any other time. Now that the untracked list is right there, I 
probably won't bother to think about it until that point. That is, the new 
feature makes my old habit unnecessary. (I obviously don't care what other 
people do; I'm still using multiple working trees with the same 
repository, which AFAIK nobody else has done for months.)

For that matter, it helps, if I find I've done two things that I want to 
commit separately in the same working tree if the first commit doesn't 
have to include the addition of all the new files.

> > Incidentally, the new git status entry for --others really ought to say 
> > something different from "Ignored files", like "Exist but not tracked", 
> > since it doesn't include the contents of .gitignore, which you'd expect to 
> > be "Ignored". (And, of course, any files it lists are hardly being 
> > ignored.)
> 
> Good point.  Something like this?

Looks like what I was thinking, yes.

	-Daniel
*This .sig left intentionally blank*
