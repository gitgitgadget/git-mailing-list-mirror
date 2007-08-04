From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Sat, 4 Aug 2007 02:20:10 -0400
Message-ID: <20070804062010.GQ20052@spearce.org>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org> <20070803030459.GJ20052@spearce.org> <20070803125846.GC28323@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 08:20:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHCzu-0005IW-PA
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 08:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbXHDGUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 02:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbXHDGUT
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 02:20:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43636 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbXHDGUR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 02:20:17 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHCzj-0008Ib-46; Sat, 04 Aug 2007 02:20:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E67E520FBAE; Sat,  4 Aug 2007 02:20:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070803125846.GC28323@fieldses.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54799>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Thu, Aug 02, 2007 at 11:04:59PM -0400, Shawn O. Pearce wrote:
> > Online help?  In git-gui?  :-)
> > 
> > We don't have an online help system yet.
> 
> Fair enough.
> 
> Though I'd like to keep the main body of the manual focused on the major
> command line tools, I'd have no objection to a separate chapter (or
> appendix?) devoted to git-gui; then you could point directly at that.
> Would that make sense?

Yea, that makes a lot of sense.  git-gui isn't a full replacement
for the command line anyway, so I would never suggest a wholesale
rewrite of the user manual to slant the entire thing towards git-gui.
Doing so would only point out the many shortcomings in git-gui.  :)

I haven't explored any in-Tk rendering options yet, been too busy
with other projects.  Ideally I'd like to just render the asciidoc
markup directly, but I don't think anyone has done an asciidoc
viewer for Tk.  I can't imagine it would be that difficult to get
some sort of parser working though...


But at this point in git (and git-gui's) life I think it would
be very worthwhile to devote an entire (new) chapter to git-gui,
maybe as part of git 1.5.4/git-gui 0.9.0.  I think we're far too
late in the 1.5.3 cycle to do it now.  I personally won't have the
time to even try to rough draft something anytime soon, let alone
let others copy-edit me before Juino releases 1.5.3.  :)

Being bundled with core git has brought git-gui a sizeable and
growing userbase, and more and more users are discovering it
each day.  We're now seeing it be translated into many different
languages, and it is a somewhat core part of the MSYS port as many
Windows users prefer to click in GUIs over type in cmd.exe terminal
windows (can't say I blame them, cmd.exe is aweful!).

In other words I think git-gui should get roughly as much attention
from the user manual as git-add/rm/mv/commit/checkout/branch get,
as it offers the same feature set.  But it shouldn't distract from
the command line part of the manual.

Maybe we should write parts of the manual in a "choose your own
adventure style" and use different chapters for different paths.
I think users can easily decide between the command line "i like to
type" vs. the gui "i like to click" paths and focus their attention
to the material they are most interested in.  :-)

-- 
Shawn.
