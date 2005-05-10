From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] Renaming environment variables.
Date: Tue, 10 May 2005 02:32:35 +0200
Message-ID: <20050510003235.GK15712@pasky.ji.cz>
References: <2721.10.10.10.24.1115425962.squirrel@linux1> <7vbr7nbl89.fsf@assigned-by-dhcp.cox.net> <7vacn6ak7r.fsf@assigned-by-dhcp.cox.net> <427F6693.2080707@zytor.com> <7vll6oz755.fsf@assigned-by-dhcp.cox.net> <3087.10.10.10.24.1115656919.squirrel@linux1> <427FA5FD.1050000@zytor.com> <7vfywwz11t.fsf@assigned-by-dhcp.cox.net> <7vhdhcxj0z.fsf_-_@assigned-by-dhcp.cox.net> <20050509201520.GL24216@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 10 02:25:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVIYt-00033N-E9
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVEJAci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVEJAci
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:32:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43406 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261449AbVEJAcg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 20:32:36 -0400
Received: (qmail 5392 invoked by uid 2001); 10 May 2005 00:32:35 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050509201520.GL24216@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 10:15:20PM CEST, I got a letter
where Thomas Glanzmann <sithglan@stud.uni-erlangen.de> told me that...
> > Here is a patch, requesting for comments.
> 
> sounds good. But I would forget about downward compatibility. There is
> no need to maintain it at this early stage.

Sure there is. We are actually far from an early stage now, I'd say.

And what I don't want to see are commits with messed up author
information since people upgraded and did not notice.

> And one thing which bothers me all the time but never spoke up about it:
> There is no way to provide a GIT_COMMIT_DATE. This would be useful for
> vendortracking a CVS repository for example.

You could use GIT_AUTHOR_DATE. :-)

But yes, I actually agree. When you are doing vendortracking of CVS
repository, you have one canonical source of the commit, and when you do
the CVS import twice independently, I think you _want_ the same commit,
since it _is_ the same commit after all (if the history is same too,
obviously).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
