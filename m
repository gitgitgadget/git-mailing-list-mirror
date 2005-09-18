From: Petr Baudis <pasky@suse.cz>
Subject: Re: first impressions to git
Date: Mon, 19 Sep 2005 00:11:25 +0200
Message-ID: <20050918221125.GD22391@pasky.or.cz>
References: <Pine.LNX.4.63.0509181201220.23242@iabervon.org> <20050918145434.GA22391@pasky.or.cz> <94fc236b050918073351075bb4@mail.gmail.com> <20050918211855.GA1463@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
	Christian Gierke <ch@gierke.de>
X-From: git-owner@vger.kernel.org Mon Sep 19 00:12:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH7Nn-0005rF-LO
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 00:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVIRWL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 18:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVIRWL2
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 18:11:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50373 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932226AbVIRWL1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 18:11:27 -0400
Received: (qmail 20149 invoked by uid 2001); 19 Sep 2005 00:11:25 +0200
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Content-Disposition: inline
In-Reply-To: <20050918211855.GA1463@schottelius.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8815>

Dear diary, on Sun, Sep 18, 2005 at 11:18:56PM CEST, I got a letter
where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> told me that...
> Adrien Beau [Sun, Sep 18, 2005 at 04:33:05PM +0200]:
> > Note that there is a problem if a Git-unaware daemon is used on the
> > server (typical in the case of HTTP and rsync). If someone pulls while
> > a push is in progress, references to not-yet-uploaded objects can be
> > retrieved.
> 
> Well, this will most likely happen often or how do you normally publish
> your famous .git-directory?

I think it should actually never happen, updating the references should
always come as the last thing in the push (or pull, for that matter)
process.

> > I'd be much obliged if you could tell me where the documentation lost you; 
> > it's really hard to document effectively without the assistance of someone 
> > who doesn't already know the program.
> 
> Well, my way was:
> 
> - find git [http://www.kernel.org/pub/software/scm/git/]
> - find documentation [http://www.kernel.org/pub/software/scm/git/docs/]
> - find step-by-step doc
>    [http://www.kernel.org/pub/software/scm/git/docs/tutorial.html]
> 
> So far so fine, than I found the git-update-index/cache thing, which confused
> me, I was not sure, whether this documentation fits only partly to git
> or absolutely not. Still, I was continuing with git-update-cache.

I believe it'd be a much more reasonable and less confusing policy for
Git to have the docs for the last release on the web. (Cogito always had
it this way, for that matter. ;-)

> > ".git/remotes" is the current one; ".git/branches" is obsolete.
> 
> Will .git/branches be complety removed later?

If that'd be the case, .git/branches is so widespread that at least
Cogito would move its content to .git/remotes automagically at some
point (it was doing such things in the past and it worked out well).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
