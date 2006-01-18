From: Petr Baudis <pasky@suse.cz>
Subject: Re: [QUESTION] What is a tag for?
Date: Wed, 18 Jan 2006 11:07:01 +0100
Message-ID: <20060118100701.GM28365@pasky.or.cz>
References: <1137538344.9104.34.camel@malory> <7v1wz648jc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 11:05:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzACN-0008A3-AM
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 11:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWARKFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 05:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWARKFs
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 05:05:48 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9627 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751374AbWARKFr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 05:05:47 -0500
Received: (qmail 5766 invoked by uid 2001); 18 Jan 2006 11:07:01 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wz648jc.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14815>

Dear diary, on Wed, Jan 18, 2006 at 02:41:27AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Alex Bennee <kernel-hacker@bennee.com> writes:
> > Is the
> > only way to know I'm building 2.6.16-rc1 to branch from it as described
> > in git-branch, even if I'm not planning on doing any development?
> 
> I do not quite understand.  Immediately after the above example
> checkout, before or after doing the hackhack and commit, git
> branch would probably say:
> 
> 	$ git branch
>           origin
> 	  master
>         * myhack

Well if I understand it, at this point he would just periodically fetch
and get the tags, and when a new release appears, he would merge it to
myhack, and so on. Which is probably the only way if you don't have
cg-seek (I thought git checkout could do it, but it doesn't seem to be
the case), but I can see no advantage of doing it if you can just
cg-seek (unless, after all, you do want to do some development). But
just in case, with Cogito that would be:

	$ cg-switch -r v2.6.16-rc1 myhack
	# You need Cogito-0.17.GIT for this. It is equivalent to git
	# branch, I think.
	$ cg-fetch
	$ cg-fetch
	$ cg-fetch
	$ cg-merge v2.6.16-rc2
	$ cg-fetch
	$ cg-merge v2.6.16
	...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
