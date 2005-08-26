From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merges without bases
Date: Fri, 26 Aug 2005 01:00:15 -0700
Message-ID: <7vzmr5gmb4.fsf@assigned-by-dhcp.cox.net>
References: <1125004228.4110.20.camel@localhost.localdomain>
	<7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508252333550.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 10:36:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8Z8O-0000hT-TD
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 10:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbVHZIAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 04:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbVHZIAR
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 04:00:17 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54011 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751507AbVHZIAR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 04:00:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826080015.NQOX1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 04:00:15 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508252333550.23242@iabervon.org> (Daniel
	Barkalow's message of "Fri, 26 Aug 2005 00:09:04 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7784>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I'd still like to revive my idea of having projects overlaid on each
> other, where the commits in the project that absorbed the other project
> say, essentially, "also include this other commit, but any changes to
> those files belong to that branch, not this one". That way, Linus could
> have included gitk in git, but changes to it, even when done in a git
> working tree, would show up in commits that only include gitk. (git
> actually can handle this with the alternative index file mechanism that
> Linus mentioned in a different thread.)

Yes, I would love to see that cleanly done in a way that does not
confuse uninitiated (not being sarcastic at all.  Just cheering
up somebody with a better idea than I have --- I would be lost
if I were to be tasked to do it by Emperor Penguin himself or
somebody else ;-)).

Tonight I added another root in the git.git repository, but I
cheated.

> Definitely post-1.0, of course.

Agreed.
