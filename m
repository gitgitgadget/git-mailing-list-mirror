From: Petr Baudis <pasky@suse.cz>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 16:41:35 +0200
Message-ID: <20070829144135.GI1219@pasky.or.cz>
References: <1188319608.6106.63.camel@beauty> <20070828172709.GB1219@pasky.or.cz> <200708291005.08795.andyparkins@gmail.com> <20070829095202.GE1219@pasky.or.cz> <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com> <Pine.LNX.4.64.0708291446011.28586@racer.site> <20070829135441.GI10749@pasky.or.cz> <Pine.LNX.4.64.0708291502340.28586@racer.site> <20070829141948.GJ10749@pasky.or.cz> <Pine.LNX.4.64.0708291529010.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benjamin Collins <aggieben@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 29 16:41:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQOjm-0004ev-LT
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 16:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbXH2Oli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 10:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbXH2Oli
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 10:41:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44239 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147AbXH2Olh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 10:41:37 -0400
Received: (qmail 17023 invoked by uid 2001); 29 Aug 2007 16:41:35 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708291529010.28586@racer.site>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56958>

Hi!

On Wed, Aug 29, 2007 at 04:31:29PM CEST, Johannes Schindelin wrote:
> On Wed, 29 Aug 2007, Petr Baudis wrote:
> 
> > On Wed, Aug 29, 2007 at 04:06:17PM CEST, Johannes Schindelin wrote:
> > > I think that they are way more than just technical issues: the 
> > > chicken-and-egg problem is certainly _not_ a technical issue.
> > 
> > What do you mean by the chicken-and-egg problem? I think I missed that.
> 
> What if hooks/update is in your set?  It _does not_ run before it is 
> checked out, but of course, some ref is updated before it is checked out.

The hook may depend on some other data checked out as well etc., so I
think the simple sane solution is to use the new update hook only for
the next update; this should match users' expectations as well.

But we got into discussing the details before the fundamentals. :-)

> > > _All_ of the arguments I read are along the lines "we want to enforce 
> > > some coding styles" or similar.  These issues are _orthogonal_ to the 
> > > question which SCM is used.
> > 
> > Your company has certain rules on how all the source on the public 
> > branches should look like, etc. It's not quite clear to me how can build 
> > system enforce these rules.
> 
> The same as a hook.  You just put the check into the Makefile.

How exactly does the Makefile affect what does and what does not get
checked in?

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
