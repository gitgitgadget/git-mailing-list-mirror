From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Trying to use git-filter-branch to compress history by
	removing large, obsolete binary files
Date: Sun, 7 Oct 2007 21:00:33 -0400
Message-ID: <20071008010033.GA25654@fieldses.org>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <Pine.LNX.4.64.0710080018270.4174@racer.site> <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com> <Pine.LNX.4.64.0710080028301.4174@racer.site> <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com> <Pine.LNX.4.64.0710080129480.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 03:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IegzI-0000Hq-LU
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 03:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114AbXJHBAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 21:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758111AbXJHBAk
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 21:00:40 -0400
Received: from mail.fieldses.org ([66.93.2.214]:45235 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581AbXJHBAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 21:00:39 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Iegz3-0006oO-9g; Sun, 07 Oct 2007 21:00:33 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710080129480.4174@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60271>

On Mon, Oct 08, 2007 at 01:34:07AM +0100, Johannes Schindelin wrote:
> It does what it should do.  It is _your_ task to look at refs/original/* 
> if everything went alright.  Then you just delete the checked refs.

It seems odd to me, by the way, that filter-branch has its own
home-grown backup mechanism.  Lots of other commands can "lose" commits,
but none of them keep an extra backup like this.

And I find it tedious for quicker jobs which it might otherwise be
useful for (e.g. rewrites of commits in my tree not yet in upstream),
unless I wrap it in a script that cleans up after itself.

--b.
