From: Petr Baudis <pasky@suse.cz>
Subject: Re: Merging commits together into a super-commit
Date: Thu, 10 May 2007 21:47:42 +0200
Message-ID: <20070510194742.GC4489@pasky.or.cz>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192212.GP13719@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu May 10 21:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmEcC-0000Ez-DV
	for gcvg-git@gmane.org; Thu, 10 May 2007 21:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761342AbXEJTrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 15:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761333AbXEJTrp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 15:47:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44311 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761289AbXEJTro (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 15:47:44 -0400
Received: (qmail 21073 invoked by uid 2001); 10 May 2007 21:47:42 +0200
Content-Disposition: inline
In-Reply-To: <20070510192212.GP13719@fieldses.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46890>

On Thu, May 10, 2007 at 09:22:12PM CEST, J. Bruce Fields wrote:
> On Thu, May 10, 2007 at 11:30:37AM -0700, Carl Worth wrote:
> > stg - This probably works great if you're using it as a primary
> >       interface. But trying to use it as a quick one-off when
> >       generally using core git does not work well at all. Instead of
> >       the two "git tag" commands in my recipe above, an stg recipe
> >       would involve a lot of additional bookkeeping with stg init, stg
> >       uncommit [N times for fixing a commit N steps back in the
> >       history], stg goto, stg push, etc.
> 
> I also didn't like having to come up with another name for each
> patch--I'd rather just run git-log or gitk and cut-n-paste the sha1.

Actually, you don't have to - if you don't specify the patch names,
stgit will make them up itself using the subject of the commit message
as a base.

And by the way, I absolutely love that - when viewing the stack, it's
very useful to see what commits you still have to go etc. - stg series
is concise yet fully descriptive. I'm pondering about whether something
like this couldn't be incorporated into other git UIs somehow as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
