From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [DRAFT] Branching and merging with git
Date: Tue, 9 Jan 2007 10:49:00 -0500
Message-ID: <20070109154900.GA17179@fieldses.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20070103170411.GB5491@thunk.org> <20070107234411.GD18009@fieldses.org> <7vzm8uz7pz.fsf@assigned-by-dhcp.cox.net> <20070108023511.GI18009@fieldses.org> <20070108140305.GE32756@thunk.org> <20070109024125.GD1686@fieldses.org> <45A3564E.7080003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 16:49:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4JDt-0005OD-73
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 16:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbXAIPtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 10:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbXAIPtJ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 10:49:09 -0500
Received: from mail.fieldses.org ([66.93.2.214]:43861 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932169AbXAIPtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 10:49:08 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H4JDg-0004ig-5r; Tue, 09 Jan 2007 10:49:00 -0500
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <45A3564E.7080003@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36369>

On Tue, Jan 09, 2007 at 09:46:06AM +0100, Andreas Ericsson wrote:
> J. Bruce Fields wrote:
> >	- I tried writing something modeled loosely on the hg quick
> >	  start.  It's a little out of date now, but that could be
> >	  fixed:
> >
> >		http://www.fieldses.org/~bfields/git-quick-start.html
> >
> 
> I like this, although fetch should probably have "--force" instead of 
> the "+branch" notation. --force stands out more and users are familiar 
> with --force possibly destroying things (rm -rf, anyone?).

I started out writing it that way (for the reasons you give), then
changed it on the theory starting out with the "+" notation would make
it simpler explaining how to do the remote configuration.

Now that there's git-remote, and less need to manipulate the remote
configuration by hand, maybe that's less important.

> I think the document is fine as it is, but could probably start off with 
> a link to the tutorial, quickstart or a revised version of everyday.txt, 
> stating that "here's something you might want to read if you prefer to 
> experiment. If you think something goes wrong, come back here and find 
> out why".

Sounds sensible.

> Indeed. I for one like examples that tell me
> 
> # type this
> # this will happen
> # you can see what you just did with this, this, and this command
> # this is because...
> 
> Not only is it good for learning the how and the why, but it also trains 
> the fingers right from the start.

OK.  This is a place where I'd really appreciate any contributions.

--b.
