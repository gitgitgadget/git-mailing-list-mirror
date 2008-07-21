From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008
	projects?
Date: Sun, 20 Jul 2008 22:22:03 -0500
Message-ID: <20080721032203.GB2275@spearce.org>
References: <200807080227.43515.jnareb@gmail.com> <200807210029.31543.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 05:23:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKlzQ-0005cY-DI
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 05:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759754AbYGUDWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 23:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759067AbYGUDWG
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 23:22:06 -0400
Received: from george.spearce.org ([209.20.77.23]:33144 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758832AbYGUDWF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 23:22:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 39BD0383A5; Mon, 21 Jul 2008 03:22:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200807210029.31543.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89296>

Jakub Narebski <jnareb@gmail.com> wrote:
> 1. GitTorrent
>  
> Student: Joshua Roys
> Mentor: Sam Vilain
...
> There is some activity there... but no summary of it anywhere I could 
> find. (I wonder if this was the project Johannes and Shawn were talking 
> about of "going dark" in GSoC 2008 podcast 018...)

Yes, this is the project I referred to in the podcast about going dark.
 
> 4. Eclipse plugin push support
>  
> Student: Marek Zawirski
> Mentor: Shawn O. Pearce
> 
> [...] Marek and I simply decided that protocol support was more
> important than really tight network transport at this point in time.

Correction, the "I" in "Marek and I" isn't Jakub, its Shawn.  This
is just an editing mistake due to copy and paste from earlier thread.
Apparently my original paragraph here was already a nice summary of
the projects decisions thus far.

I'm likely to be offline much of the rest of this week (I got lucky
and found an open access point just now) but Marek is actively
working on user interface for push support, and I think if he finds
the time is considering adding delta generation.  That will be a
lot more time consuming as I think he needs to go back to original
academic papers to learn an LCS algorithm and then implement that.

Copyright and licenses around libxdiff and delta-diff.c won't allow
us to directly port the diff code to Java and our BSD license.  No,
I don't want to start a BSD-GPL license war.  Our decision to go
BSD in jgit may be a thorn in our side in areas such as this, but it
is probably better for our long-term goals of working more directly
with the Eclipse Foundation and perhaps also the NetBeans folks.

> SUMMARY:
> ========
> From those projects, "git-merge builtin" did what it was meant to do 
> already.  "Eclipse plugin push support" and "git-statistics" did 
> minimum what it was meant to do already, and it looks like it would be 
> finished before August 11.  "Gitweb caching" is after first round of 
> patches, "git-sequencer" looks like already done; I don't know what is 
> the state of "GitTorrent" project.
> 
> Please correct any mistakes in this summary / writeup.  Thanks in 
> advance.

I think this is a pretty good summary.  I want to go through the
mid-term evaluations and summarize those for the mailing list but
I have not had a chance to do that yet.  With network being spotty
for the rest of this week it probably won't happen until the weekend.

I think the quick summary is our students and our mentors think
their projects are going well.  Jakub's summary above suggests
very much the same thing.  Its hard to claim a GSoC project isn't
meeting its goals when the code is already merged, or is at least
under active patch review.  ;-)

-- 
Shawn.
