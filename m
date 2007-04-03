From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Distribution of longest common hash prefixes
Date: Tue, 3 Apr 2007 13:21:23 -0400
Message-ID: <20070403172123.GD27706@spearce.org>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk> <Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org> <86bqi6kae7.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org> <86y7laitlz.fsf@blue.stonehenge.com> <86r6r2isva.fsf@blue.stonehenge.com> <m3r6r1jsmq.fsf@lugabout.jhcloos.org> <867istcrhr.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Eriksen <s022018@student.dtu.dk>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 19:21:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYmhV-00067O-1X
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 19:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965816AbXDCRVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 13:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965815AbXDCRVc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 13:21:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43605 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965816AbXDCRVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 13:21:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYmh4-0004ee-HY; Tue, 03 Apr 2007 13:21:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B1F8320FBAE; Tue,  3 Apr 2007 13:21:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <867istcrhr.fsf@blue.stonehenge.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43632>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >>>>> "James" == James Cloos <cloos@jhcloos.com> writes:
> 
> James> With that version the kernel gives:
> 
> James> 0: 
> James> 1: 
> James> 2: 
> James> 3: 565
> James> 4: 288450
> James> 5: 139080
> James> 6: 10699
> James> 7: 700
> James> 8: 32
> James> 9: 2
> 
> Fascinating.  So you can spell out *any* commit in linux-2.6.git with
> 10 hex chars.  What do we need 40 for, again? :)

Well, the other thing is those 2 commits at 9 bytes probably were
not that way a year ago.  One of those might have only needed 8,
and the other is newer, so now you need 9.

What the above tells me is that 8 is almost a safe default for our
abbreviations, but isn't safe enough, as there are collisions past 8.

-- 
Shawn.
