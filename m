From: Petr Baudis <pasky@suse.cz>
Subject: Re: files are disappearing in git
Date: Fri, 25 Nov 2005 23:48:57 +0100
Message-ID: <20051125224857.GA10680@pasky.or.cz>
References: <20051123142303.GJ22568@schottelius.org> <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org> <20051124084633.GA3361@schottelius.org> <43866EDA.9050203@michonline.com> <20051125103048.GB30691@schottelius.org> <Pine.LNX.4.64.0511251022360.13959@g5.osdl.org> <20051125195121.GG16995@mythryan2.michonline.com> <Pine.LNX.4.64.0511251400570.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>,
	Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 23:50:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfmNI-0005VC-Lk
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 23:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVKYWsn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 17:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVKYWsn
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 17:48:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:64898 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932400AbVKYWsm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2005 17:48:42 -0500
Received: (qmail 25551 invoked by uid 2001); 25 Nov 2005 23:48:57 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511251400570.13959@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12755>

Dear diary, on Fri, Nov 25, 2005 at 11:11:22PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> For example, let's say that you had a dirty tree or something, and then 
> the merge failed, and you didn't see anything wrong, so you just end up 
> doing a "git commit". At _that_ point, what you had in the index matters 
> very much, of course, since the index is what will be committed.
> 
> > I think that's the situation where I've personally managed to lose
> > and/or revert some changes.
> 
> Hmm.. Can you elaborate?
> 
> (Side note: all my commentary is purely about the "raw git" interfaces. I 
> don't know what cogito may do on top of it).

Note that Cogito is now (v0.15.1 or later) supposed to handle merges on
top of trees with local changes fine - it will either error out, or in
case the merge is done on unrelated files it will temporarily ignore
your local changes and cg-commit won't mix them up (even if you do some
conflict fixups).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
