From: Petr Baudis <pasky@suse.cz>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 16:19:49 +0200
Message-ID: <20070829141948.GJ10749@pasky.or.cz>
References: <1188319608.6106.63.camel@beauty> <20070828172709.GB1219@pasky.or.cz> <200708291005.08795.andyparkins@gmail.com> <20070829095202.GE1219@pasky.or.cz> <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com> <Pine.LNX.4.64.0708291446011.28586@racer.site> <20070829135441.GI10749@pasky.or.cz> <Pine.LNX.4.64.0708291502340.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benjamin Collins <aggieben@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 29 16:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQOOo-00083K-JA
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 16:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbXH2OTv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 10:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbXH2OTv
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 10:19:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49350 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbXH2OTu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 10:19:50 -0400
Received: (qmail 13718 invoked by uid 2001); 29 Aug 2007 16:19:49 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708291502340.28586@racer.site>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56955>

On Wed, Aug 29, 2007 at 04:06:17PM CEST, Johannes Schindelin wrote:
> I think that they are way more than just technical issues: the 
> chicken-and-egg problem is certainly _not_ a technical issue.

What do you mean by the chicken-and-egg problem? I think I missed that.

> Besides, another very valid issue is that of portability.  Hooks can be 
> _any_ executables.  Not just scripts.  Not just _bash_ scripts.

So? That's really up to whoever maintains the repository to sort out.

> The other issue I raised, however, seemed to die away in the other noise:
> 
> _Why_ on earth do you want to put something into the SCM specific 
> meta-data which should be part of the build process _to begin with_?
> 
> _All_ of the arguments I read are along the lines "we want to enforce some 
> coding styles" or similar.  These issues are _orthogonal_ to the question 
> which SCM is used.

Your company has certain rules on how all the source on the public
branches should look like, etc. It's not quite clear to me how can build
system enforce these rules.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
