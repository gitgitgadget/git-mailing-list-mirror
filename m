From: Petr Baudis <pasky@suse.cz>
Subject: Re: linearising TopGit forests into patch series (was: [ANNOUNCE]
	TopGit - A different patch queue manager)
Date: Sun, 10 Aug 2008 22:54:33 +0200
Message-ID: <20080810205433.GF32184@machine.or.cz>
References: <20080803031424.GV32184@machine.or.cz> <20080807175623.GA16833@lapse.rw.madduck.net> <36ca99e90808071258h62b65981s20a5b053d9bc5754@mail.gmail.com> <20080808170658.GA16055@lapse.rw.madduck.net> <20080803031424.GV32184@machine.or.cz> <20080807175623.GA16833@lapse.rw.madduck.net> <20080809010821.GT10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	vcs distro packaging discussion list 
	<vcs-pkg-discuss@lists.alioth.debian.org>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 22:55:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSHwy-0006iZ-0r
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 22:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbYHJUyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 16:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbYHJUyh
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 16:54:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38661 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509AbYHJUyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 16:54:37 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id EBC1D2C4C03D; Sun, 10 Aug 2008 22:54:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080809010821.GT10151@machine.or.cz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91886>

  Hi,

On Sat, Aug 09, 2008 at 03:08:21AM +0200, Petr Baudis wrote:
> On Thu, Aug 07, 2008 at 02:56:24PM -0300, martin f krafft wrote:
> > Assuming a number of interdependent topic branches, does TopGit
> > provide a way for me to linearise/flatten/serialise these branches
> > in a one-patch-per-branch fashion, so that I could turn any TopGit
> > repository into a quilt series? I am only interested in a one-way
> > conversion from TopGit to quilt for now.
> 
> Not _yet_. But it very well could, and it should be really simple.
> 
> There are two parts:
> 
> (i) First, getting a "tidied up" commit structure from TopGit, having
> one commit per patch (branch). This is something covered currently in
> the README by:
> 
> 	TODO: tg collapse for creating a one-commit-per-patch tidied up
> 		history (for pulling by upstream)
> 
> So it's not implemented yet, but it should be *very* easy to do.

  to prove the point, I just pushed out tg-export implementation (seems
like better name than collapse, for various reasons). It ended up not to
be as trivial as I thought, but still no more than a two-hour job. ;-)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
