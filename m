From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Improved git-gui blame viewer
Date: Sat, 2 Jun 2007 00:17:23 -0400
Message-ID: <20070602041723.GD7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 02 06:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuL3Y-0001kD-0u
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 06:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbXFBER3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 00:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbXFBER2
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 00:17:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34549 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbXFBER2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 00:17:28 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HuL3O-000590-J9; Sat, 02 Jun 2007 00:17:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 67BC120FBAE; Sat,  2 Jun 2007 00:17:24 -0400 (EDT)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48910>

A long time ago Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> On Sun, 18 Mar 2007, Shawn O. Pearce wrote:
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > 
> > > Of course, the git gui blame colorization is clearly done by somebody who 
> > > is still actively popping LSD with both fists and didn't realize that the 
> > > 60's are long done, but that's another issue.
> > 
> > git-gui is open source.  I'd be happy to take a patch.  Or,
> > since that is horribly messy Tcl/Tk code, just a better color
> > suggestion. :-)
> 
> I would suggest:
> 
>  - some special color for "currently selected" (which defaults to being 
>    the first one coming out of the blame thing, of course). 
> 
>    I'd suggest "black text on pale green background", but that may be just 
>    me.
> 
>  - some *stable* graduated color for the rest. I don't think it 
>    necessarily needs to be "older" vs "newer", and in fact I'd suggest 
>    just two slightly different shades of gray for the background - just 
>    pick alternating shades for each blame entry that comes in (and leave 
>    un-blamed lines white).

I finally got the git-gui code to the point where cleaning up the
user interface was possible without sending myself to the nut house.

I tried out Linus' suggestions for coloring, and I like them.  Enough
that they are now sitting in my `pu` branch on repo.or.cz/git-gui.git.

There's also a whole slew of other improvements to the blame viewer,
like being able to dig through history by clicking on commit ids,
and tooltips when you mouse over a region of the file.

Behavior on Windows is actually quite good; its less so on Mac
OS X.  I'm fighting Tk there a little bit more than I should be.
Untested on Linux, so I'd love to hear some feedback on it.

  git://repo.or.cz/git-gui.git      pu
  http://repo.or.cz/r/git-gui.git   pu
 
-- 
Shawn.
