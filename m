From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 15:47:40 -0500
Message-ID: <20070129204740.GA30963@spearce.org>
References: <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org> <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org> <20070129192911.GA12903@thunk.org> <epll4j$iil$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 29 21:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBdPr-0002X2-I0
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 21:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbXA2Urs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 15:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbXA2Urs
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 15:47:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53238 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbXA2Urr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 15:47:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBdOw-0005gS-A2; Mon, 29 Jan 2007 15:46:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5B5B220FBAE; Mon, 29 Jan 2007 15:47:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <epll4j$iil$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38097>

Jakub Narebski <jnareb@gmail.com> wrote:
> Theodore Tso wrote:
> > On Mon, Jan 29, 2007 at 08:24:52AM -0800, Linus Torvalds wrote:
> >> Anyway, all of these issues makes me suspect that the proper blame 
> >> interface is to basically *hide* the blame almost entirely, in order to 
> >> make the important parts much more visible, and in order to encourage 
> >> people to start looking for the piece of code that they are actually 
> >> interested in.
> > 
> > One approach which might work is where you hover your mouse over a
> > line, and it pops up a tiny window with the blame information if the
> > mouse remains stationary for more than a second or two.
> > 
> > Another thing which would be really useful is where the lines that
> > have been changed in the last n commits (where n is probably between
> > 3-5) are highlighted using different colors.  That way you can see
> > what was changed recently, which is often what you are most interested
> > in.  (As in, what changed recently that might have caused this file to
> > get all screwed up?)
> 
> It would be also nice to have window split into two, and for example
> have at bottom details of the commit which changed current line, like
> author, description, date, how many commits ago, branch name (e.g. taken
> from commit message if it was merged), perhaps also patch...

These are some really good ideas.  I knew that if I made pretty
technicolor crap available, people would tell me what they really
needed.  :-)

I'll like steal them (er, uhm, implement them) in git-gui in the next
day or so.  The current blame UI was sort of a prototype.  Once I
tossed the original filename and original line number into that
thing it started to become pretty obvious its just too cluttered.
But at that point I wanted pretty colors, and uh, it was late... :-)

-- 
Shawn.
