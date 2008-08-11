From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH v2] Make cherry-pick use rerere for conflict resolution.
Date: Mon, 11 Aug 2008 12:40:06 +0200
Message-ID: <20080811104006.GH32184@machine.or.cz>
References: <1218368935-31124-1-git-send-email-ams@toroid.org> <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080811023053.GA9144@toroid.org> <alpine.DEB.1.00.0808111218160.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Abhijit Menon-Sen <ams@toroid.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 11 12:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSUpu-0002wN-3d
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 12:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbYHKKkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 06:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYHKKkK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 06:40:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51740 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbYHKKkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 06:40:09 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id CDA93393B31F; Mon, 11 Aug 2008 12:40:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808111218160.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91929>

  Hi,

  this makes revert use rerere too, right? Maybe use

	Make cherry-pick and revert call rerere for conflicts

instead?

  For janitors looking for a cleanup job, it would be nice to share this
code with suggest_conflicts() in the future.

On Mon, Aug 11, 2008 at 12:19:50PM +0200, Johannes Schindelin wrote:
> On Mon, 11 Aug 2008, Abhijit Menon-Sen wrote:
> 
> > It was a dark and stormy night. Sam struggled to keep his eyelids open
> > as he integrated yet another gigantic patch series. Ever the optimist,
> > he'd pulled in the changes, only to discover several merge conflicts.
> > But the night was young then, and he'd fixed them all by hand.
> > 
> > It was only later that he noticed many lousy, one-line commit messages.
> > Undaunted, he reset his branch and began to cherry-pick patches, giving
> > them a once-over, writing a comment here, squashing the odd grotesque
> > hack there, and writing sensible commit messages more often than not.
> > 
> > But even that was hours ago, and each new but oh-so-familiar conflict
> > ate into his determination like maggots through decaying meat; and Sam
> > was beginning to question the wisdom of staying in this fruit business.
> > His whiskey was running low, and time was running out.
> > 
> > "If only", thought Sam, "If only cherry-pick would..."
> 
> Nice try.
> 
> I have tried the whole dark and lonely night to find where in the git.git 
> history we have some equally enlightening commit message.
> 
> So in essence, it is nice what you wrote, but not a commit message.  
> Please imitate the style of existing commit messages, especially if you 
> want to have your patch applied.

  come on. :-)  I think it's harmless and amusing. If there was some
useful information lost because of this, that would be troublesome, but
what kind of "rationale" do you want here? The point seems obvious.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
