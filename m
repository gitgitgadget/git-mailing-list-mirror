From: Petr Baudis <pasky@suse.cz>
Subject: Re: starting completly new repository
Date: Sat, 25 Mar 2006 22:49:31 +0100
Message-ID: <20060325214931.GA18185@pasky.or.cz>
References: <Pine.LNX.4.63.0603252148550.14361@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 22:49:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNGdZ-0004r2-70
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 22:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWCYVta (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 16:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWCYVta
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 16:49:30 -0500
Received: from w241.dkm.cz ([62.24.88.241]:35494 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751142AbWCYVt3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 16:49:29 -0500
Received: (qmail 9310 invoked by uid 2001); 25 Mar 2006 22:49:31 +0100
To: Grzegorz Kulewski <kangur@polcom.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0603252148550.14361@alpha.polcom.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18003>

Hi,

Dear diary, on Sat, Mar 25, 2006 at 10:06:42PM CET, I got a letter
where Grzegorz Kulewski <kangur@polcom.net> said that...
> First sorry if it is anwsered somewhere in the docs, but I am just 
> (slowly) learning how to use git and reading the documentation. Any 
> pointers to some article or tutorial that anwsers my questions will be 
> appreciated.

well, there's Documentation/tutorial.txt, but it doesn't cover your
questions, it looks.

> But it looks like I must first do some commit on the server? But I can not 
> make empty commit just to have things started? Or maybe there is some 
> other way...

You can of course make an empty commit, but it seems strange that you
would want that - won't the people start working on some initial version
of the project?

> Also I wonder if I can do push over git protocol or I must use real ssh 
> account on the server? This is not clear from the docs... At least not for 
> me. How should I set up my repo (on my computer) to be able to push 
> commits into main repo?

You must use real ssh account on the server. You can limit the account
to be able to do only git pushes/pulls by setting its shell to
git-shell.

> Also what should I set up additionally? How can I easily set author name 
> and email for each repo? What is the difference between author and 
> commiter and how should I set this up here?

 From Cogito's cg-commit documentation:

Each commit has two user identification fields - commit author and
committer.  By default, it is recorded that you authored the commit, but
it is considered a good practice to change this to the actual author of
the change if you are merely applying someone else's patch. It is always
recorded that you were the patch committer.

> Is there any documentation about git config file? Can I set author name, 
> email and preffered editor in it or must I use environment?

See git-commit-tree(1), the COMMIT INFORMATION section.

One big problem with Git documentation (other than e.g. falling
out-of-date occassionaly) is that information is scattered between
porcelain and plumbing or even between several commands (e.g.
git-whatchanged(1) which doesn't even directly mention where to gather
the full list of available options).

Thankfully, the plumbing documentation is mostly coherent. ;-)

> Is there some irc channel for asking dumb questions as above and having 
> them anwsered fast or should I use this mailing list?

#git on Freenode (surprisingly ;)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
