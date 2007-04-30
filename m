From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: GIT vs Other: Need argument
Date: Mon, 30 Apr 2007 00:31:36 -0400
Message-ID: <20070430043136.GA17639@fieldses.org>
References: <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org> <4627ABBB.8060709@softax.com.pl> <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org> <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net> <87vefm7l6g.wl%cworth@cworth.org> <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org> <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net> <20070424142309.GD18538@fieldses.org> <alpine.LFD.0.98.0704240752030.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Carl Worth <cworth@cworth.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 30 06:32:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiNYW-0005XS-Ni
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 06:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422927AbXD3Ebp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 00:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161632AbXD3Ebp
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 00:31:45 -0400
Received: from mail.fieldses.org ([66.93.2.214]:55497 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161630AbXD3Ebo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 00:31:44 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HiNY0-0004wb-I3; Mon, 30 Apr 2007 00:31:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704240752030.9964@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45852>

On Tue, Apr 24, 2007 at 08:01:50AM -0700, Linus Torvalds wrote:
> Well, I think they really should be documents of their own, so that you 
> can read about the "CVS tracking" or so without even worrying about the 
> fact that you didn't read the whole thing.

Sure.  There may be some tension between making more separate documents
and keeping them all findable.  Well, it just means we need some easy
way to index them.

> And they should be easy to find. I agree that we do actually have a fair 
> amount of docs, but it seems that people don't tend to *find* them. The 
> user-manual, for example, is great, but I've seen people on the #git logs 
> apparently not realize it exists ;)
> 
> For example, the git homepage has a "documentation" thing, which only 
> lists the tutorial, not the user manual explicitly. You _can_ get to the 
> user manual (go to the online version of the Documentation directory and 
> note the "still work in progress"), but even if you do actually find 
> yourself there, the user manual itself is actually a bit scary to start 
> with.
> 
> So I think we could just make the initial impression a bit easier. The 
> tutorial comes fairly close to the "tracking your own" thing, I agree, 
> but maybe we could have the documentation listed in order of complexity, 
> and having a way for people to know *which* doc they should start with 
> when they are at http://git.or.cz/ (or the wikipedia page), so that if 
> you're only interested in the "tracking somebody else", you could easily 
> find and read just a single simple documentation thing. Hmm?

Yeah.  So we can try to figure out a small set of clearly labeled entry
points into the documentation, and I'll work with Petr Baudis to make
sure they're at the top of the git home page.  And I suppose the same
set should appear on the main git man page.  Anywhere else?  Maybe
Documentation/ needs its own index.html....

--b.
