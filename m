From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Sat, 4 Aug 2007 02:33:53 -0400
Message-ID: <20070804063353.GR20052@spearce.org>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org> <107BD473-E055-47D0-9720-9D878BDAB954@zib.de> <20070803030101.GI20052@spearce.org> <20070803125601.GA28323@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 08:34:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHDD8-0007MV-M1
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 08:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbXHDGd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 02:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbXHDGd7
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 02:33:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43967 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbXHDGd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 02:33:58 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHDCz-000075-RL; Sat, 04 Aug 2007 02:33:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 17C1020FBAE; Sat,  4 Aug 2007 02:33:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070803125601.GA28323@fieldses.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54800>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Thu, Aug 02, 2007 at 11:01:01PM -0400, Shawn O. Pearce wrote:
> > So I'd really love to do better.  But frankly I'm at a loss here
> > and just don't know what sort of change to make.
> 
> The one thing that struck me when I fired up git-gui was that it wasn't
> obvious to me which things I should try clicking on.

Yea, that I have noticed with other newbies.  I have recently had
the chance to observe a few new users work with git-gui for the
first time and I have noticed that they just don't quite know what
to poke at and experiment with.  Unlike with many other applications
where its more obvious what's there for the poking...
 
> For example: the buttons, drop-down menus, and check-boxes all cry out
> to be played with.  But the filenames in the lists at the top are less
> obvious, and it might never have occurred to me on my own to right-click
> on the diff hunks at the bottom.  That just looks like passive colorized
> text to me.

It doesn't just look like colored text to me anymore.  Which is a
huge problem for me as an interface designer.  I know what's there.

BTW, the reason why there's a context menu in the diff viewer?
I right clicked in there one day and nothing happened.  The fact
that nothing happen surprised the hell out of me.  Even though I
had written all of that code myself.  So I went off and added
that context menu.

Later I realized I wanted to just stage that hunk.  I could click
on it all I want, but the $@!*@(!@* computer didn't do what I really
wanted it to.  So stage hunk was born and added to the context menu.

That experience is actually true of much of the git-gui UI.  Things
happen there only because I've actually tried to do something,
only to shock myself when I find out it doesn't work!  I promptly
write the patch and contribute it.  :)
 
> I don't know what sort of user-interface conventions say "play with
> me!", though.  Random ideas:
> 
> 	- maybe the cursor should change shape over the diff hunks (or
> 	  just the headers?)

That's actually a pretty cool idea.  I might play with it just to
see how I feel about the cursor changing and if it gives me any
ideas about what might happen under it.  Though as I write this
email I'm thinking that if the cursor changed shape when it was
over the diff hunk header I'd try to left-click the hunk header to
get a reaction from the computer.

> 	- maybe buttons, hunk headers, file names, etc., should all be
> 	  in the same color?
> 	- maybe the hunk headers could benefit from a little more
> 	  decoration?  I don't know how to do that without just making
> 	  the display look more cluttered, though.
> 	- maybe left-clicking on diff hunks should do something too?

I just had a thought of putting an actual button icon in the first
column of the hunk header lines.  If it looks enough like a button
icon thingy, users might just click on it.  And when they do we
can present that diff pane context menu, and look, they can stage
their hunks!  ;-)

Just a thought.  Utterly random too.  Musta been that alpha particle
slamming into a neuron.

Thanks for the ideas.  Its certainly given me some things to
experiment with in the next week or so when I can find the time.

-- 
Shawn.
