From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Proposal for new git Merge Strategy
Date: Wed, 23 Aug 2006 21:02:09 +0200
Organization: At home
Message-ID: <eci8nh$uk3$1@sea.gmane.org>
References: <E1GFxeZ-0000Nw-ED@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 23 21:03:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFy0g-0007OG-BN
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 21:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWHWTDY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 15:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWHWTDY
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 15:03:24 -0400
Received: from main.gmane.org ([80.91.229.2]:62607 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750973AbWHWTDY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 15:03:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFy07-0007Gm-68
	for git@vger.kernel.org; Wed, 23 Aug 2006 21:02:55 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 21:02:55 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 21:02:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25924>

Jon Loeliger wrote:

> The other day, I was talking to some other folks else-list
> about git's approach to merges and mentioned that there was
> some structure in place to handle different merge strategies.
> 
> One person observed that Perforce had a really good
> approach to merging and conflict resolution that allowed
> user interaction during the process specifically to
> help select the individual files and hunks that contributed
> to the final result.  I confess that I have never used
> Perforce, so this is all hear-say and interpretation. :-)
> 
> However, it does seem like an approach that we could
> easily add to git -- not as the default of course.
> (Just think how dead we'd all be if Linus had to manually
> interact with every merge he performed at the tip of the
> Linux Pyramid. :-)
> 
> But for complex or critical merges, a "guided merge"
> strategy seems like it might be a useful tool.  Basically,
> it would offer options to select Stage 1 or Stage 2
> revisions, or step in and offer hunks from Stage 1 and 2,
> revert to "ours" or "theirs", or "revert to 'ours' or 'theirs'
> for all remaining files".  Things like that maybe.

And select which files are which (after renaming, copying, etc.)

> Any thoughts down this line?  Good idea?  Bad idea?

Wouldn't it be better to fallback to graphical/user guided 
merger only on _failed_ merge? Merge helpers like xxdiff, 
Meld or KDiff3 
  http://git.or.cz/gitwiki/InterfacesFrontendsAndToolsWishlist
There was proposal of git script which run xxdiff with correct
extracted files, if I remeber correctly postponed waiting for
more generic version.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
