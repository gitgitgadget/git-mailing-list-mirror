From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Now What?
Date: Thu, 3 Nov 2005 12:05:42 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511031151070.25300@iabervon.org>
References: <E1EXTw5-00063o-Gt@jdl.com> <20051103083840.GA28300@ebar091.ebar.dtu.dk>
 <7v4q6uhx0a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org,
	Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 18:12:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXiYR-0001RM-GV
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 18:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVKCRF7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 12:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbVKCRF7
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 12:05:59 -0500
Received: from iabervon.org ([66.92.72.58]:27908 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030385AbVKCRF6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 12:05:58 -0500
Received: (qmail 2526 invoked by uid 1000); 3 Nov 2005 12:05:42 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Nov 2005 12:05:42 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q6uhx0a.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11075>

On Thu, 3 Nov 2005, Junio C Hamano wrote:

> "Peter Eriksen" <s022018@student.dtu.dk> writes:
> 
> > Here's one I've done too many times:
> >
> > ~/git/git-core]cat .git/remotes/origin
> > URL: git://git.kernel.org/pub/scm/git/git.git
> > Pull: master:origin
> >
> > ~/git/git-core]git-checkout maint
> > ~/git/git-core]git pull
> 
> You are merging my master into your "maint", probably a copy of
> my (previous) maint.

I think the situation is that he really wanted to update master, but 
forgot that he was on the maint branch. So now he's in a merge of things 
he didn't actually want to merge and wants to get back to not having junk 
all over the place (some files that need to be merged, some files that 
have been merged, new files, removed files, etc).

	-Daniel
*This .sig left intentionally blank*
