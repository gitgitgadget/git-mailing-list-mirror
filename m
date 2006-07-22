From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git BOF notes
Date: Sat, 22 Jul 2006 05:22:00 +0200
Message-ID: <20060722032200.GP13776@pasky.or.cz>
References: <20060719230155.GJ13776@pasky.or.cz> <20060721131824.GC32585@fieldses.org> <20060721144249.GO13776@pasky.or.cz> <Pine.LNX.4.63.0607220212140.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 22 05:22:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G484I-00038M-My
	for gcvg-git@gmane.org; Sat, 22 Jul 2006 05:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWGVDWD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 23:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWGVDWD
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 23:22:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32940 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751199AbWGVDWC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jul 2006 23:22:02 -0400
Received: (qmail 410 invoked by uid 2001); 22 Jul 2006 05:22:00 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607220212140.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24063>

  Hi,

Dear diary, on Sat, Jul 22, 2006 at 02:17:48AM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Fri, 21 Jul 2006, Petr Baudis wrote:
> 
> > Yes, there is some blury stuff, but I think it's rather a sign that
> > something is missing in the core Git porcelain. git-init-db is lowlevel
> > and I think in 99% of the cases you are going to do an initial commit
> > right after anyway, so you might as well just get git-init which does it
> > for you (something akin cg-init ;).
> 
> Think "changed templates".

  it may be that I'm just tired, but I don't see what you mean, sorry.

> And also think "setup a remote repository", especially "setup a remote
> HTTP repository".

  Of course. Currently you need to tinker with environment variables,
then with hooks, possibly with permissions and stuff to make the
repository shared... Think cg-admin-setuprepo. ;-)

> And also think "start a new repository with only a _part_ of the current 
> files". There are plenty reasons -- in addition to separation of concepts 
> -- not to commit straight after initializing a repository.

  So what _do_ you do if you don't commit straight?

  Of course sometimes you don't want to add everything, and that should
still be possible to do (cg-init has a switch for that).

> > I think we still tell users to use git-update-index to mark resolved 
> > conflicts, [...]
> 
> I don't know, but I had the impression we'd tell them "resolve your 
> conflicts, and then do git-commit -a". Which is good enough.

  My comment there was based on the jdl's presentation at OLS. Sorry if
in docs we are saying other things, I don't tend to lookat Git porcelain
documentation. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
