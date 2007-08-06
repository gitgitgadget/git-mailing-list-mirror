From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Mon, 6 Aug 2007 00:06:26 -0400
Message-ID: <20070806040626.GI9527@spearce.org>
References: <608102.66070.qm@web38905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Brett Schwarz <brett_schwarz@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 06:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHtrj-0003DV-AO
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 06:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbXHFEGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 00:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbXHFEGc
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 00:06:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49392 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbXHFEGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 00:06:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHtrE-0001mw-KR; Mon, 06 Aug 2007 00:06:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 27DC320FBAE; Mon,  6 Aug 2007 00:06:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <608102.66070.qm@web38905.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55106>

Brett Schwarz <brett_schwarz@yahoo.com> wrote:
> > From: Shawn O. Pearce <spearce@spearce.org>
> > 
> > I haven't explored any in-Tk rendering options yet, been too busy
> > with other projects.  Ideally I'd like to just render the asciidoc
> > markup directly, but I don't think anyone has done an asciidoc
> > viewer for Tk.  I can't imagine it would be that difficult to get
> > some sort of parser working though...
> > 
> > 
> 
> So, I took a stab at this earlier today, and it is fairly straight forward. I have 
> something that is semi working (I haven't tested all the scenarios yet), but 
> the rest is just really filling in the blanks.

Yea, I thought it would be really straight-forward.  The Tk text
widget is a really wonderful tool.  Makes these sorts things almost
write themselves...
 
> Question though: I was going to have a index tree on a side panel...but do
>  you want this thing to only bring up the git-gui.txt file, and show the table 
> of contents, or do you want all *.txt files in the index? Or .... ?

Yea, that's a good question.  I think I want all of that.  ;-)

I mean:

I'd like to be able to allow users to browse all of the Git manual
pages and the user manual, directly from within git-gui.  Then I
can setup a new subcommand `git gui help commit` to bring up the
git-commit manual page in this renderer (for example).  So in that
sense showing all of the manuals in an index is really useful.
This may make it easier for some users (e.g me!) as they don't have
to render the manuals, or rely upon the man/html branches from Junio.

I'd like to let users also browse the git user manual.  This is
a fairly large set of documentation, so the table of contents for
this thing is not just a list; a proper tree that one can browse
through is really nice.

And I'd like to start writing git-gui specific documentation,
and let users browse through that as well.

So whatever you can provide is great.  And you don't have to get
everything at once either; just showing single files would be a
great start.  Showing single files with the various section headers
in an "outline" view to the left would be even better.


I think one of the worst manuals we have is git-fast-import.
Its huge.  It uses a number of asciidoc features, and it has
a fairly large outline.  The user manual is actually a lot
more complex, but isn't a single file manual page.  ;-)

-- 
Shawn.
