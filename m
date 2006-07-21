From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git BOF notes
Date: Fri, 21 Jul 2006 16:42:51 +0200
Message-ID: <20060721144249.GO13776@pasky.or.cz>
References: <20060719230155.GJ13776@pasky.or.cz> <20060721131824.GC32585@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 21 16:43:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3wDR-0007s7-Ks
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 16:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWGUOmy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 10:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWGUOmy
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 10:42:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9127 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750747AbWGUOmy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jul 2006 10:42:54 -0400
Received: (qmail 29770 invoked by uid 2001); 21 Jul 2006 16:42:51 +0200
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <20060721131824.GC32585@fieldses.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24052>

Dear diary, on Fri, Jul 21, 2006 at 03:18:24PM CEST, I got a letter
where "J. Bruce Fields" <bfields@fieldses.org> said that...
> On Thu, Jul 20, 2006 at 01:01:55AM +0200, Petr Baudis wrote:
> >   (i) We should somehow separate the lowlevel Git commands from the
> > highlevel ones meant for user consumption. There's too many of them
> > and it is confusing for the users. Similarity with BitKeeper was pointed
> > out (and I refrained from mentioning GNU Arch).
> 
> The man page already attempts to make this distinction in its command
> list, though arguably the order is wrong (it lists the low-level
> commands first) and you could argue about some of the choices (git
> init-db may be "low level", but it's something everyone probably wants
> to see).
> 
> "git help" already has an abbreviated list.  What else could we do?

Perhaps (while coordinating with the porcelains, of course) we should
start moving the lowlevel tools to the libexec directory and keep only
the end-user tools around.

Yes, there is some blury stuff, but I think it's rather a sign that
something is missing in the core Git porcelain. git-init-db is lowlevel
and I think in 99% of the cases you are going to do an initial commit
right after anyway, so you might as well just get git-init which does it
for you (something akin cg-init ;). I think we still tell users to use
git-update-index to mark resolved conflicts, but all the Git people at
OLS were too afraid to even _mention_ the index to the users at all;
shouldn't we have git-resolved instead?

Oh well, except that people are gonna run git-resolve instead all the
time. Why do we still _have_ that one?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
