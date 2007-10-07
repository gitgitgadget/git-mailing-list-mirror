From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Many gits are offline this week
Date: Sun, 7 Oct 2007 13:01:53 -0400
Message-ID: <20071007170153.GX2137@spearce.org>
References: <20071005010448.GQ2137@spearce.org> <863awq5p1y.fsf@blue.stonehenge.com> <4d8e3fd30710050214j135260cn842ee7396a3d63c7@mail.gmail.com> <86tzp54sez.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 19:02:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeZW4-0000mY-J2
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 19:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbXJGRB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 13:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbXJGRB7
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 13:01:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44816 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbXJGRB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 13:01:57 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IeZVk-00054s-EI; Sun, 07 Oct 2007 13:01:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3B5E720FBAE; Sun,  7 Oct 2007 13:01:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <86tzp54sez.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60203>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >>>>> "Paolo" == Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> writes:
> 
> Paolo> is there any material (slides, docs) you can share before the talks?
> 
> I've had the slides reviewed by Smarter People Than Me on #git already, so
> hopefully most of it is accurate. :)  They're temporarily at
> 
>   http://www.stonehenge.com/pic/Git-2.0.3-to-be.pdf
> 
> I still hope to have a few hours to go in and add a few sadly missing
> graphics, particularly on the rebase vs merge section.

What, no mention of git-gui as a porcelain?  It has more users
than qgit according to the survey.  Maybe rephrase the porcelains
on slide 15 as:

  Other porcelain exists:
    - StGit ("stacked git"), guilt
    - tig (curses-based viewer)
    - qgit, git-gui

On slide 26 you say "gitk mytopic origin" shows the changes back to
the common ancestor.  That's what "gitk mytopic...origin" would do.
Note the three dots instead of the space.  The space will cause
gitk to show all history back to the beginning of time.

On slide 27 you say that you can rebase your changes on upstream
using "git-rebase origin/master master".  That's a lot more
typing than is required, most people will want to rebase their
current branch onto the upstream and thus will use "git-rebase
origin/master".  Personally I think combining git-checkout's branch
switch feature into git-rebase is stupid.  It really makes things
confusing.  But its supported.  :-(

-- 
Shawn.
