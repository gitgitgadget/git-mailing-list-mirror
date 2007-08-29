From: Petr Baudis <pasky@suse.cz>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 15:39:00 +0200
Message-ID: <20070829133900.GH1219@pasky.or.cz>
References: <1188319608.6106.63.camel@beauty> <20070828172709.GB1219@pasky.or.cz> <200708291005.08795.andyparkins@gmail.com> <20070829095202.GE1219@pasky.or.cz> <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benjamin Collins <aggieben@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 15:39:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQNlH-0000Ol-Du
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 15:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757766AbXH2NjF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 09:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757398AbXH2NjE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 09:39:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44302 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756896AbXH2NjB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 09:39:01 -0400
Received: (qmail 6718 invoked by uid 2001); 29 Aug 2007 15:39:00 +0200
Content-Disposition: inline
In-Reply-To: <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56947>

On Wed, Aug 29, 2007 at 03:18:47PM CEST, Benjamin Collins wrote:
> On 8/29/07, Petr Baudis <pasky@suse.cz> wrote:
> > But overally, I'm still not convinced that there is a feasible use-case
> > for the cloned hooks at all. Someone has a particular example?
> >
> > --
> >                                 Petr "Pasky" Baudis
> 
> My group at work would like this capability.  We have a homogeneous
> environment with well-known NFS shares, and some scripts that do
> things in this common environment (e.g., release scripts).  It would
> be nice if when we do a clone, all the hook scripts (that would be
> valid on any machine, in any directory, for any user) would come with
> it.

Unfortunately, you didn't really describe a use-case, you just said that
you would like them - not what you would use them to. The thing is, so
far almost all the use cases would be better off with either using the
hooks only at the central repository hub and keeping the developers'
freedom locally, or would work better simply somewhere else than in hook
files. I'm not saying that this must be the case every time, that is why
I'm asking for more input data.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
