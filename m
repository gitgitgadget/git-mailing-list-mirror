From: Petr Baudis <pasky@suse.cz>
Subject: Re: cogito push problem
Date: Sun, 25 Sep 2005 23:09:08 +0200
Message-ID: <20050925210908.GA21019@pasky.or.cz>
References: <20050925192214.GC19023@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 23:10:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJdkI-00055V-Hh
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 23:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVIYVJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 17:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVIYVJL
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 17:09:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10151 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932297AbVIYVJK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 17:09:10 -0400
Received: (qmail 32619 invoked by uid 2001); 25 Sep 2005 23:09:08 +0200
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Content-Disposition: inline
In-Reply-To: <20050925192214.GC19023@schottelius.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9287>

Dear diary, on Sun, Sep 25, 2005 at 09:22:14PM CEST, I got a letter
where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> told me that...
> Hello!
> 
> I was trying to push my current work out and recieved this error:
> 
> [21:20] hydrogenium:cinit% cg-push main
> error: remote ref 'refs/heads/master' is not a strict subset of local ref 'refs/heads/master'.
> 
> My questions:
> - What does that mean to me as an end-user?
> - What's the reason that this happened?
> - How do I fix that?

This means someone probably pushed out some new stuff you don't have
yet (or you did something evil, like uncommitted something you already
pushed out before). So what to do is cg-update, that will merge the new
stuff, then try to cg-push again.

cg-push already spits out a somewhat more helpful message about this in
some cases, I'll make it do so in all cases. Thanks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
