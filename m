From: Petr Baudis <pasky@suse.cz>
Subject: Re: How to create independent branches
Date: Sat, 8 Apr 2006 22:57:47 +0200
Message-ID: <20060408205747.GT27689@pasky.or.cz>
References: <20060407184701.GA6686@xp.machine.de> <7vr749i48s.fsf@assigned-by-dhcp.cox.net> <20060408180244.GA4807@xp.machine.de> <7vsloneqtb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <peter.baumann@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 22:56:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSKUG-0003FC-SW
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 22:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWDHU4s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 16:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWDHU4s
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 16:56:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45234 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751404AbWDHU4r (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 16:56:47 -0400
Received: (qmail 15856 invoked by uid 2001); 8 Apr 2006 22:57:47 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsloneqtb.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18530>

Dear diary, on Sat, Apr 08, 2006 at 10:49:04PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Peter Baumann <peter.baumann@gmail.com> writes:
> 
> > Another question. I'd like to create a totaly independent branch (like
> > the "todo" branch in git). Is there a more user friendly way than doing
> >
> > git-checkout -b todo
> > rm .git/refs/heads/todo
> > rm .git/index
> > rm <all_files_in_your_workdir>
> >
> > ... hack hack hack ...
> > git-commit -a
> >
> > I looked all over the docs, but can't find anything obvious.
> 
> My "todo" branch is not even part of my main git repository.  I
> just have two independent repositories (git and todo) locally,
> and push into the same public repository.

Wouldn't it be better to separate it to two distinct public repositories
as well? It's confusing people and encouraging a practice that really
isn't very feasible and practical in Git.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
