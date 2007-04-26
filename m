From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/2] bookmarks
Date: Thu, 26 Apr 2007 19:09:08 +0200
Message-ID: <20070426170908.GS4489@pasky.or.cz>
References: <200704252004.45112.andyparkins@gmail.com> <Pine.LNX.4.64.0704260816480.27356@beast.quantumfyre.co.uk> <200704260923.26637.andyparkins@gmail.com> <200704260933.38677.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 19:11:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh7Ur-00086D-Hc
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 19:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031358AbXDZRJs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 13:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031348AbXDZRJd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 13:09:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55306 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031354AbXDZRJL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 13:09:11 -0400
Received: (qmail 17881 invoked by uid 2001); 26 Apr 2007 19:09:08 +0200
Content-Disposition: inline
In-Reply-To: <200704260933.38677.andyparkins@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45641>

On Thu, Apr 26, 2007 at 10:33:36AM CEST, Andy Parkins wrote:
> On Thursday 2007 April 26, Andy Parkins wrote:
> 
> > Actually how about this: an option in the remote section to turn off
> > auto-following and then add fetch and push lines for the tags too - that
> > means very minimal changes and then everyone's happy (where everyone =
> > me ;-)).
> 
> Funny.  I went looking to add the above facility, and lo-and-behold, it's 
> already there in the form of the remote.$remote.tagopt parameter.
> 
> [remote "origin"]
>    tagopt = --no-tags
>    push = refs/tags/public:refs/tags/*
>    fetch = refs/tags/*:refs/tags/public/*
> 
> This does exactly what I want.  Once again, git is waaaay ahead of me :-)

Still, I think it would be nice to have an "out-of-the-box" general
solution for this. And since as Junio said, it might be nice to have
private heads as well, I might mention my ancient proposal to just keep
refs with filename starting with a dot (refs/tags/.foo, ...) private by
default. I have discussed this with Junio and IIRC he wasn't very happy
with this proposal, but I can't remember his arguments now. :-(

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
