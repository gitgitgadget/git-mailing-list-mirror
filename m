From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: That improved git-gui blame viewer..
Date: Mon, 11 Jun 2007 02:42:03 -0400
Message-ID: <20070611064203.GG6073@spearce.org>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 08:42:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxdbe-0005BR-Ka
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 08:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbXFKGmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 02:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbXFKGmR
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 02:42:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57624 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbXFKGmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 02:42:16 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1HxdbO-00072J-US; Mon, 11 Jun 2007 02:42:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3FD1620FBAE; Mon, 11 Jun 2007 02:42:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49824>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> That said, I do have one comment about the state of git-gui "pu".. I think 
> it's fairly pretty, and definitely useful,

Thanks!  I'm glad at least one other person on this planet finds
my work on the blame viewer at least partially useful.

> but one feature I end up really 
> wishing for is a "search" button (or Ctrl-F). I might not know what 
> line-number I'm looking for, I'm more likely to know which function I want 
> to look at, and the most natural way to find it is with a simple ctrl-F.

No, there isn't a search.  Tk internally offers one, I just haven't
bound UI to it.  Ctrl-F is actually bound to page down, much as it is
in vi.  Actually vi keys work everywhere in git-gui for scrolling.

I pushed out 0.7.3 tonight without search.  I'll work on search and
jump-to-line this week, and try to get an 0.7.4 early next week
with those and maybe some other improvements in the blame viewer
that I want to get done.

I may actually wind up just doing 0.8.0 sooner than I had expected.
There's a lot of new features queued up in the master branch that I
slated for 0.8.0 that I'm using on a daily basis and is production
stable.

I wanted to implement some slick inotify() based features for the
main window during 0.8.0, but I haven't had time to work on them.
It would really improve performance of git-gui on Windows NT, and
I do have a lot of git-gui users there.

-- 
Shawn.
