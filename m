From: Petr Baudis <pasky@suse.cz>
Subject: Re: [QUESTION] What is a tag for?
Date: Wed, 18 Jan 2006 00:05:37 +0100
Message-ID: <20060117230537.GK28365@pasky.or.cz>
References: <1137538344.9104.34.camel@malory>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 00:04:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyzsQ-0001XK-PL
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 00:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWAQXE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 18:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWAQXE2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 18:04:28 -0500
Received: from w241.dkm.cz ([62.24.88.241]:41116 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932497AbWAQXE2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 18:04:28 -0500
Received: (qmail 27519 invoked by uid 2001); 18 Jan 2006 00:05:37 +0100
To: Alex Bennee <kernel-hacker@bennee.com>
Content-Disposition: inline
In-Reply-To: <1137538344.9104.34.camel@malory>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14805>

  Hi,

Dear diary, on Tue, Jan 17, 2006 at 11:52:24PM CET, I got a letter
where Alex Bennee <kernel-hacker@bennee.com> said that...
> So I want to track Linus's 2.6 git tree as well as do a little small
> time hacking. I'm not brave enough to sit on the very bleeding edge and
> build what ever happens to be at the "HEAD" of the tree. However when a
> kernel releases I'd like to build *that* kernel.
> 
> I keep thinking of tags like labels in the old convetional SCM case. Is
> this correct? I can see once I've done my update (fetch/cogito what
> ever) that these tags apear in my local tree:
> 
> 22:42 alex@malory [linux-2.6] >cat .git/refs/tags/v2.6.16-rc1
> f3bcf72eb85aba88a7bd0a6116dd0b5418590dbe
> 
> So what do I do with them now? Are they only for branch points? Is the
> only way to know I'm building 2.6.16-rc1 to branch from it as described
> in git-branch, even if I'm not planning on doing any development?

  the simplest thing to do in Cogito if you just want to follow tags
around is to cg-fetch periodically (that will get the changes to your
local database, but will not check them out), and cg-seek around to
whatever tag you want:

	$ cg-fetch
	$ cg-seek v2.6.16-rc1
	$ cg-fetch
	... no new tag ...
	$ cg-fetch
	... still no new tag ...
	$ cg-fetch
	... Linus, are you sleeping? ...
	$ cg-fetch
	$ cg-seek v2.6.16-rc2
	...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
