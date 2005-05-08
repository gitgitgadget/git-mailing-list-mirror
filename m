From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Commit template
Date: Sun, 8 May 2005 22:40:43 +0200
Message-ID: <20050508204043.GJ9495@pasky.ji.cz>
References: <1965.10.10.10.24.1115579256.squirrel@linux1> <1115579764.8949.15.camel@pegasus> <2003.10.10.10.24.1115580031.squirrel@linux1> <1115580630.8949.27.camel@pegasus> <2095.10.10.10.24.1115582244.squirrel@linux1> <1115582601.8949.31.camel@pegasus> <2159.10.10.10.24.1115582791.squirrel@linux1> <20050508201723.GH9495@pasky.ji.cz> <1115584617.8949.51.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 22:36:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUsVA-0003Ml-6z
	for gcvg-git@gmane.org; Sun, 08 May 2005 22:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbVEHUl6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 16:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVEHUl5
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 16:41:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43741 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262923AbVEHUko (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 16:40:44 -0400
Received: (qmail 24435 invoked by uid 2001); 8 May 2005 20:40:43 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115584617.8949.51.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 10:36:57PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,
> 
> > > > my argument is; not to mess up with the CG: lines created by cg-commit.
> > > > If you wanna insert a warning then you can of course add additional CG:
> > > > lines to the commit template.
> > > 
> > > Well, i'd argue that anyone making their own commit should be responsible
> > > for making it look however they like.  Maybe they want to only use only 60
> > > character wide lines and are tired of seeing the notice about CG: being
> > > ignored.  Gives the power user a tad more flexibility.   But I really
> > > don't care much either way.
> > 
> > I'm with Sean on this one - implemented (with current cg-commit, and I
> > used .git/commit-template file instead), committed, pushed out.
> 
> then please do a "touch .git/commit-template" and call cg-commit. Now
> you will see what I mean. It is too easy to screw up.

So don't touch .git/commit-template. It's not like it stops working, you
just don't get the top stuff. Which you probably wanted, why would you
touch .git/commit-template otherwise?

> Why not leave the list of modified files in the hand of the cg-commit
> and people that wanna extra text inside their commit-template add
> something like:
> 
> CG: ---
> CG: This is my testing tree, don't commit
> 
> This will look much prettier and gives people the same possibilities to
> change everything.

But you have extra stuff both before and after the list of modified
files.

> If you wanna make the modified files list into a full configurable
> template, then I think you must introduce place holders.

That's what I was thinking about, actually - @@MODIFIED@@ and such, and
it replaces _all_ the CG: stuff. Just decided that I have better things
to do now personally.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
