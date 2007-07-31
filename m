From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Mon, 30 Jul 2007 20:24:48 -0400
Message-ID: <20070731002448.GV20052@spearce.org>
References: <11858118802945-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jul 31 02:24:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFfXl-0007Zy-5w
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 02:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935727AbXGaAYy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 20:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760346AbXGaAYy
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 20:24:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37063 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759758AbXGaAYx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 20:24:53 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IFfXU-0006ZF-6U; Mon, 30 Jul 2007 20:24:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5FC0420FBAE; Mon, 30 Jul 2007 20:24:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11858118802945-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54295>

Steffen Prohaska <prohaska@zib.de> wrote:
> git gui is especially useful because it allows to select diff hunks.
> Now it is at least mentioned in the user-manual.
 
> +Another approach for creating commits is git gui:
> +
> +-------------------------------------------------
> +$ git gui citool
> +-------------------------------------------------

Actually `git citool` is an alias for `git gui citool`.  Because the
former is much faster to type when you want to make a quick commit.
:-)

> +
> +starts the commit tool (Note, "`git gui`" starts the full gui, which
> +provides more options).

But this note is also really useful.  So maybe talking about the
longer form in the user manual is a good way to introduce git-gui.

> +Beyond the basic operation of staging and unstaging complete files,
> +git gui can also selectively stage diff hunks.  You can do so by
> +selecting a modified or staged file and right-click on the diff view
> +in the lower part of the gui. A pop-up will appear that lets you
> +select a specific hunk and stage or unstage it for the next commit.
> +This is particular useful for slicing large, ugly commits into smaller
> +pieces, for example when cherry-picking (see
> +<<reordering-patch-series>>).

Yes.  Now if only someone would teach it how to let you highlight a
section and stage/unstage just the selection.  Never mind splitting
a hunk.  Selection based stage/unstage would really be cool...
especially when combined with git-stash.  Where you could first
stash everything, reset back to the last committed state, then
selectively unstash changes into the working directory, test them,
stage everything for commit, then unstash more, etc...

Since git-stash is modeled as a commit, it could also work for
cherry-picking.  Which is very useful when cleaning up a series.
Hmm.  Wishlist for git-gui!

> @@ -2480,7 +2498,8 @@ $ gitk origin..mywork &
>  And browse through the list of patches in the mywork branch using gitk,
>  applying them (possibly in a different order) to mywork-new using
>  cherry-pick, and possibly modifying them as you go using commit
> ---amend.
> +--amend. git gui may be especially useful to amend commits as it
> +lets you selectively stage and unstage single diff hunks.

Yes.  Except git-gui (currently) destroys the author information
when it does an amend.  Bad git-gui!  Bad!  No prize for you!  :-)

-- 
Shawn.
