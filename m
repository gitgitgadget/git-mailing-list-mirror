From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] A new merge stragety 'subtree'.
Date: Sat, 17 Feb 2007 03:53:05 -0500
Message-ID: <20070217085305.GF27864@spearce.org>
References: <7vfy95y2n9.fsf@assigned-by-dhcp.cox.net> <20070217071425.GD27864@spearce.org> <7vzm7duqzf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 09:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HILK0-0005Nd-B7
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 09:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946516AbXBQIxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 03:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946520AbXBQIxM
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 03:53:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34174 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946516AbXBQIxK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 03:53:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HILJb-0001B2-Iw; Sat, 17 Feb 2007 03:53:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4483F20FBAE; Sat, 17 Feb 2007 03:53:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vzm7duqzf.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39977>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > To avoid pulling the entire git.git history into git-gui, I'd ask
> > that anyone bypassing me (e.g. if I'm being horribly unresponsive
> > one week) checkout the git-gui branch from git.git, apply the
> > change(s) there, then merge that branch into git.git using the
> > subtree strategy.
> 
> Actually, I do not think you even need to ask them to do that.
> I am not planning to apply patches to git.git that touch
> git-gui/ subdirectory myself, but if you see such a patch on the
> list, you could first apply it to your copy of git.git
> repository, and run your private edition of cherry-pick that
> uses merge-subtree instead of merge-recursive to pick it out
> onto your 'master' branch of git-gui.git repository.  That way,
> the next time I'll pull from your git-gui.git repository, I will
> get the change through you.

Or... I/we implement -p2 in git-am.  Then I can apply it right to
my git-gui repository.  :-)

Wait, isn't there a patch floating around for that?
Wasn't it sent in by Andy Parkins just before 1.5.0?

Just for the record: I am perfectly happy taking patches for git-gui
that were made against the git.git repository.  Obviously I can
easily apply it onto git-gui.git by stripping the path.  I'm also
happy directly pulling worthwhile commits, but I won't pull something
that is based on a git.git commit, for the reason stated above.
 
> And the procedure would actually work _even_ _if_ (repeat, I do
> not plan to do this) I applied such a patch to my tree before I
> pull from you --- it will just result in an accidental clean
> merge.

Yes, of course.  One of the insanely nice things about git. :)

-- 
Shawn.
