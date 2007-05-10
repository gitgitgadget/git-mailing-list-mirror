From: Petr Baudis <pasky@suse.cz>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Fri, 11 May 2007 00:51:37 +0200
Message-ID: <20070510225137.GE4489@pasky.or.cz>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com> <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org> <20070509134151.GT4489@pasky.or.cz> <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org> <7vzm4dplhu.fsf@assigned-by-dhcp.cox.net> <20070510220649.GL3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 11 00:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmHUB-0004jI-Kx
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbXEJWvl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 18:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755679AbXEJWvl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:51:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46741 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbXEJWvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 18:51:40 -0400
Received: (qmail 4558 invoked by uid 2001); 11 May 2007 00:51:38 +0200
Content-Disposition: inline
In-Reply-To: <20070510220649.GL3141@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46916>

On Fri, May 11, 2007 at 12:06:49AM CEST, Shawn O. Pearce wrote:
> Which is why I'm considering shelving support (of some kind) in
> git-gui...  but I'm probably not going to take away the current
> index view, nor am I going to take away the current hunk selection.
> 
> But I would like to make it easier for non-patching-editing gods
> (Linus) to pull hunks in from a shelf, test them, and commit them.
> 
> Said shelf probably would be another branch, much as Linus' nicely
> documented workflow does...

FWIW, Cogito supports shelving of uncommitted changes when switching a
branch (so that they are not retained through the switch but restored
when you switch back to the original branch) by committing the local
changes to refs/shelves/HEADNAME.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
