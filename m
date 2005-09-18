From: Petr Baudis <pasky@suse.cz>
Subject: Re: Improved "git add"
Date: Mon, 19 Sep 2005 00:17:02 +0200
Message-ID: <20050918221702.GE22391@pasky.or.cz>
References: <Pine.LNX.4.58.0509181119040.26803@g5.osdl.org> <20050918212904.GB1463@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 00:17:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH7T9-0006kC-Me
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 00:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVIRWRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 18:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVIRWRF
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 18:17:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15339 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932228AbVIRWRE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 18:17:04 -0400
Received: (qmail 22227 invoked by uid 2001); 19 Sep 2005 00:17:02 +0200
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Content-Disposition: inline
In-Reply-To: <20050918212904.GB1463@schottelius.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8817>

Dear diary, on Sun, Sep 18, 2005 at 11:29:04PM CEST, I got a letter
where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> told me that...
> Linus Torvalds [Sun, Sep 18, 2005 at 11:27:45AM -0700]:
> > [git-add/directory fix]
> 
> Nice, first cogito and now git itself. You are pretty fast.
> 
> > [...]
> > Also, I think we should have a default ignore list if we don't find a 
> > .git/info/exclude file. Ignoring "*.o" and ".*" by default would probably 
> > be the right thing to do.
> 
> I do use doc/.warning or similar in some projects files for outputting
> a warning when somebody simply types 'make', so he'll get instructions
> on what to do.
> 
> Other people may even want to include *.o in their tree, because it's
> used by their program for another purpose.
> 
> I do not think that a VCS should ignore anything from itself. If we
> generate a standard .git/info/excludes (or whatever the name of it is)
> and write those standard values in there, this is a different thing.

But .git/info/exclude mostly sucks, you really want these kinds of rules
in .gitignore if anywhere. E.g. CVS by default ignores some stuff and it
seems as a fine strategy for me, and is working out in the vast majority
of cases. You can unignore files by doing '!pattern', so if you want to
throw away all the defaults, just specify '!*'.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
