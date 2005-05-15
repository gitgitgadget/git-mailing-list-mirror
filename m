From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Sun, 15 May 2005 11:40:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505151129200.30848-100000@iabervon.org>
References: <7v4qd5xdby.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun May 15 17:42:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXLF4-0000SN-0M
	for gcvg-git@gmane.org; Sun, 15 May 2005 17:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVEOPlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 11:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVEOPlc
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 11:41:32 -0400
Received: from iabervon.org ([66.92.72.58]:6 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261666AbVEOPlb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 11:41:31 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DXLEa-0002s9-00; Sun, 15 May 2005 11:40:52 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4qd5xdby.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 14 May 2005, Junio C Hamano wrote:

> I am having a bit hard time understanding how the end user uses
> what you are trying to give them.  Is the basic idea to let them
> say "I want to get Pasky's $GIT_DIR/refs/heads/master and store
> it in my $GIT_DIR/refs/heads/git-pb, and then I want to start
> the pull starting from the commit recorded in that ref"?

Yes. This would be: git-http-pull -w heads/git-pb heads/master
http://www.kernel.org/pub/scm/cogito/git-pb.git/

> Assuming that is what you are doing, I do not have much
> objection to it.  I however think introducing REFS_ENVIRONMENT
> is going overboard.

Now that we have GIT_DIR, you're probably right. I mainly kept it there
for symmetry. On the other hand, I think that, if you're using a shared
objects directory, you want to also use a shared refs directory, or you'll
never be able to identify unreachable objects accurately.

	-Daniel
*This .sig left intentionally blank*

