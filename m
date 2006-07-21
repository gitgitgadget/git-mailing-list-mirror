From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git BOF notes
Date: Fri, 21 Jul 2006 16:31:16 +0200
Message-ID: <20060721143115.GN13776@pasky.or.cz>
References: <20060719230155.GJ13776@pasky.or.cz> <20060721132111.GD32585@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 21 16:31:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3w2Z-0005Lf-GQ
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 16:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWGUObX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 10:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWGUObW
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 10:31:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23431 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750744AbWGUObT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jul 2006 10:31:19 -0400
Received: (qmail 29002 invoked by uid 2001); 21 Jul 2006 16:31:17 +0200
To: "J. Bruce Fields" <bfields@fieldses.org>
Content-Disposition: inline
In-Reply-To: <20060721132111.GD32585@fieldses.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24051>

Dear diary, on Fri, Jul 21, 2006 at 03:21:11PM CEST, I got a letter
where "J. Bruce Fields" <bfields@fieldses.org> said that...
> On Thu, Jul 20, 2006 at 01:01:55AM +0200, Petr Baudis wrote:
> > 	* Support for distributing and following the mutated history.
> > 	  I'm actually not sure about the level of Git support for
> > 	  this, Cogito supports cg-updating to a mutated history
> > 	  if you have no local changes.
> 
> A fetch that doesn't fast-forward fails with a warning unless you
> explicitly ask it (--force) to blow away your old history.

I don't know if there's a point in being so paranoid - it already makes
things more painful than necessary. In the tracking branch, you just
want to have what the other side has anyway, and if the other side
decided to jump around, why would you care otherwise?

Just make sure you print the original commit ID and perhaps a warning.

> I don't see what more you could do.

I guess a huge majority of Git users is an - almost inherently - silent
mass of those who just use Git for tracking the development of others,
and we gotta make it easy for them - and it's not easy if when the
remote side rebases it doesn't just move them to the new commit but
helpfully offers a nonsensical three-way merge.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
