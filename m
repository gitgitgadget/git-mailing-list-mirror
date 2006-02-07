From: Petr Baudis <pasky@suse.cz>
Subject: Re: [Cogito] Various bugs
Date: Tue, 7 Feb 2006 17:49:46 +0100
Message-ID: <20060207164946.GN31278@pasky.or.cz>
References: <20060131041318.GC30744@diku.dk> <20060207003643.GJ31278@pasky.or.cz> <7vfymw3oym.fsf@assigned-by-dhcp.cox.net> <20060207021006.GM31278@pasky.or.cz> <7v8xsn50rf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602070751410.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 17:50:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6W27-000123-QO
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 17:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWBGQtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 11:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWBGQtg
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 11:49:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:4281 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932225AbWBGQtf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 11:49:35 -0500
Received: (qmail 22853 invoked by uid 2001); 7 Feb 2006 17:49:46 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602070751410.3854@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15697>

Dear diary, on Tue, Feb 07, 2006 at 04:53:57PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> 
> 
> On Mon, 6 Feb 2006, Junio C Hamano wrote:
> > 
> > It depends on what you expect, but it meets _my_ expectation:
> > 
> >     $ GIT_AUTHOR_NAME='' git-commit-tree $(git-write-tree) </dev/null
> >     Committing initial tree a2b59c3848164a2c9c3c75fbaadccaed9485da92
> >     ef90563fa278735af367e7606ea7eb2559121ca7
> >     $ git-cat-file commit ef90563fa278735af367e7606ea7eb2559121ca7
> >     tree a2b59c3848164a2c9c3c75fbaadccaed9485da92
> >     author  <junkio@cox.net> 1139281078 -0800
> >     committer Junio C Hamano <junkio@cox.net> 1139281078 -0800
> > 
> > That is, the user said GIT_AUTHOR_NAME is empty, so he gets a
> > commit with an empty author name.

That is what I expect and I must have done something wrong the last
night since it works for me now as well. Sorry. So I'm all alone at
this bug again. ;-)

> Yes. That said, we should probably disallow that in git-commit-tree (and 
> let the user fix it up some way).

What way? Sometimes you just receive mails from people who have only
email addy in the from line, or you can be importing from some other VCS
where the mapping does not exist and the importers may not deem it
necessary to have it in GIT. Sure, it may be kernel policy to disallow
this, but I wouldn't enforce this for all projects in GIT.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
