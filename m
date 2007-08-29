From: Petr Baudis <pasky@suse.cz>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 15:54:41 +0200
Message-ID: <20070829135441.GI10749@pasky.or.cz>
References: <1188319608.6106.63.camel@beauty> <20070828172709.GB1219@pasky.or.cz> <200708291005.08795.andyparkins@gmail.com> <20070829095202.GE1219@pasky.or.cz> <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com> <Pine.LNX.4.64.0708291446011.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benjamin Collins <aggieben@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 29 15:54:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQO0O-00033d-8t
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 15:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbXH2Nyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 09:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbXH2Nyn
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 09:54:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34117 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbXH2Nyn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 09:54:43 -0400
Received: (qmail 8845 invoked by uid 2001); 29 Aug 2007 15:54:41 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708291446011.28586@racer.site>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56950>

  Hi,

On Wed, Aug 29, 2007 at 03:49:45PM CEST, Johannes Schindelin wrote:
> On Wed, 29 Aug 2007, Benjamin Collins wrote:
> 
> > Of course, I understand why it's not already like that, particularly 
> > given the context of Linux development practices.
> 
> It has nothing to do with Linux development practices.  There are 
> fundamental reasons why we don't fetch hooks:
> 
> - they are _not_ part of the repository; just look at the 
>   .gitattributes-in-the-index-but-not-worktree issue to find out why,
> 
> - it is _private_ data, just like the config.  The client has _no 
>   business_ to read them, let alone fetch them,
> 
> - if you have the hooks on different machines, chances are that you need a 
>   mechanism to update the hooks... This naturally suggests putting the 
>   hooks into their own branch.
> 
> Probably there are way more reasons not to allow such a thing as fetching 
> hooks.

  these are all really just technical details - if we decided that it
_is_ useful to have a mechanism to manage hooks, it really is no problem
to introduce some easy-to-use automated way to keep .git/hooks/ updated
based on some head, have .git-hooks/ as part of your current branch, or
whatever. And of course, "fetching hooks" may not (and very frequently
you wouldn't ever want it to) mean "grabbing the same hooks the server
uses".

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
