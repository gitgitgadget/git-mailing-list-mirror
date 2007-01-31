From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 09:38:11 -0500
Message-ID: <20070131143811.GC10646@fieldses.org>
References: <87odognuhl.wl%cworth@cworth.org> <Pine.LNX.4.64.0701301853300.20138@iabervon.org> <Pine.LNX.4.64.0701302052230.3021@xanadu.home> <Pine.LNX.4.64.0701302331440.20138@iabervon.org> <Pine.LNX.4.64.0701310923010.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 15:38:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCGbb-0001Qe-Bp
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 15:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933307AbXAaOiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 09:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933308AbXAaOiV
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 09:38:21 -0500
Received: from mail.fieldses.org ([66.93.2.214]:40093 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933307AbXAaOiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 09:38:21 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HCGbD-00033j-NN; Wed, 31 Jan 2007 09:38:11 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701310923010.3021@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38252>

On Wed, Jan 31, 2007 at 09:31:00AM -0500, Nicolas Pitre wrote:
> It is not the commit which is dangerous when the head is detached.  It 
> is the checkout of another branch.  And this case is covered already 
> such that the checkout is refused unless you actually create a branch 
> for your detached head or you give -f to checkout to override the 
> protection.
> 
> Giving a warning at commit time is not the place where the user has to 
> be aware of the issue since it is indeed not the place where there is 
> any issue to worry about.

By the same argument, the original checkout of a non-branch is also not
the place for a warning; by the time you commit and then do a checkout
to switch away from the new commit, that original checkout may be a
distant memory.

--b.
