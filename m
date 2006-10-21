From: Jan Hudec <bulb@ucw.cz>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 21:47:03 +0200
Message-ID: <20061021194703.GE29927@artax.karlin.mff.cuni.cz>
References: <45357CC3.4040507@utoronto.ca> <20061021181149.GM75501@over-yonder.net> <20061021191949.GA8096@coredump.intra.peff.net> <200610212130.31414.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 21:47:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbMoB-0008Cc-5g
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 21:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423384AbWJUTq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 15:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423385AbWJUTq6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 15:46:58 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:14294 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1423384AbWJUTq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 15:46:57 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 5AAAA4C58; Sat, 21 Oct 2006 21:47:03 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610212130.31414.jnareb@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29667>

On Sat, Oct 21, 2006 at 09:30:30PM +0200, Jakub Narebski wrote:
> Jeff King wrote:
> 
> > The difference, I think, is that it's easier in git to move the upstream
> > around: you simply start fetching from a different place. I'm not clear
> > on how that works in bzr (if it invalidates revnos or has other side
> > effects).

Moving upstram around does not invalidate revnos. Switching to different
upstream (ie. the head revisions are different) does. And this may
happen by doing a merge with the previous mainline as non-first parent
-- revnos are simply short aliases for revids, not persistent unique
idenfiers.

> That's good example of fully distributed approach. I can fetch directly
> (actually, I cannot) from Junio private repository, I can fetch from
> public git.git repository, either using git:// or http:// protocol,
> I can fetch from somebody else clone of git repository: intermixing
> those fetches, and revids (commit-ids) remain constant and unchanged.

So they (revids) do in bzr.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
