From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Thu, 10 May 2007 18:06:49 -0400
Message-ID: <20070510220649.GL3141@spearce.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com> <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org> <20070509134151.GT4489@pasky.or.cz> <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org> <7vzm4dplhu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 00:07:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmGmr-0005Dg-PE
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759332AbXEJWG5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 18:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759359AbXEJWG5
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:06:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43581 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759332AbXEJWG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 18:06:57 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HmGmX-0004gj-Ot; Thu, 10 May 2007 18:06:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C21D820FBAE; Thu, 10 May 2007 18:06:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vzm4dplhu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46908>

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > And unlike the "simpler" model of committing individual hunks
> > with "git add -i" or something like that, my model is actually
> > much superior!
> 
> I obviously agree with this.  As I said a few times I regret
> introducing "add -i" --- it encourages a wrong workflow, in that
> what you commit in steps never match what you had in the working
> tree and could have tested until the very end.

Which is why I'm considering shelving support (of some kind) in
git-gui...  but I'm probably not going to take away the current
index view, nor am I going to take away the current hunk selection.

But I would like to make it easier for non-patching-editing gods
(Linus) to pull hunks in from a shelf, test them, and commit them.

Said shelf probably would be another branch, much as Linus' nicely
documented workflow does...

-- 
Shawn.
