From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Refactor project list routines
Date: Mon, 16 Nov 2009 18:56:30 +0100
Message-ID: <20091116175630.GK17748@machine.or.cz>
References: <1257520246-6548-1-git-send-email-pasky@suse.cz>
 <4AF47142.4010609@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 18:56:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA5ok-00088g-63
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 18:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbZKPR4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 12:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbZKPR4Z
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 12:56:25 -0500
Received: from w241.dkm.cz ([62.24.88.241]:53109 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbZKPR4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 12:56:24 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 45D04862093; Mon, 16 Nov 2009 18:56:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4AF47142.4010609@eaglescrag.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133019>

  Hi!

On Fri, Nov 06, 2009 at 10:56:02AM -0800, J.H. wrote:
> 2) If the repository is cloned the ctag information is not retained,
> which means there is no real way for the original developer to
> manage or move this information between different hosting sites,
> I.E. repo.or.cz and kernel.org (though I'll admit I have it turned
> off)

  This is interesting argument, I have always thought about ctags being
a rather site-specific mechanism and I think it would've meet with a lot
of user opposition to e.g. keep ctags in a specific branch; I can think
of no other good way to do it either.

> So if your going to eliminate the project listing, with the general
> intention of using the tag cloud as more of a primary search
> mechanism, including the search box, I think there's some serious
> work that needs to be put into the ctags system because in it's
> current state, for the likes of kernel.org, it's unusable, unstable
> and not something I would recommend to anyone to run in production.
> I like the idea, I just have concerns over it's current
> implementation.

  This patch is orthogonal to that, I believe. I agree that the ctags
mechanism is somewhat hackish; unfortunately, I personally don't have
the time to fix it up properly. I think it is still good enough for
many users, and the frontpage mechanism would be quite useful even for
people who don't want to use content tags.

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
