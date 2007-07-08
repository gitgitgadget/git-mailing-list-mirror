From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Allow users to set commit.signoff from options.
Date: Sun, 8 Jul 2007 17:48:32 -0400
Message-ID: <20070708214832.GC4436@spearce.org>
References: <20070706144654.12095.qmail@c8e1b1dc78de94.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:48:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ecT-0005d5-Lr
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 23:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757775AbXGHVsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 17:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757749AbXGHVsj
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 17:48:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33158 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757634AbXGHVsi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 17:48:38 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I7ecF-0002zz-2L; Sun, 08 Jul 2007 17:48:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8582C20FBAE; Sun,  8 Jul 2007 17:48:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070706144654.12095.qmail@c8e1b1dc78de94.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51926>

Gerrit Pape <pape@smarden.org> wrote:
> Users may want to automatically sign-off any commit for a specific
> repository.  If they are mostly a git-gui user they should be able to
> view/set this option from within the git-gui environment, rather than
> needing to edit a raw text file on their local filesystem.

Sure.  But your patch to git-gui actually just lets the user set
the flag, but doesn't make git-gui honor it.  So the user can set
"Automatically Sign-Off" through git-gui but it will have no effect
within git-gui (git-gui doesn't use git-commit.sh, it has its own
pure-Tcl implementation).

I'm not applying this to git-gui, for the very same reason that
Junio already gave as to why he won't apply the git-commit.sh patch.

Within git-gui adding a signoff is either one mouse click (the
button on the toolbar), a single keystroke (Ctrl-S) or a menu action
(Commit->Signoff).  Three easy ways to insert the signoff line.
But it still needs to be a choice from the user, every time they
make a commit.
 
-- 
Shawn.
