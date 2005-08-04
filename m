From: barkalow@iabervon.org
Subject: Re: git-local-pull?
Date: Thu, 4 Aug 2005 16:35:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0508041632220.23721@iabervon.org>
References: <Pine.LNX.4.62.0508031259430.23721@iabervon.org>
 <20050804201230.GC24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 22:38:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0mSk-0001uC-CW
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 22:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVHDUgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 16:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVHDUeF
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 16:34:05 -0400
Received: from iabervon.org ([66.92.72.58]:28178 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262679AbVHDUcD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 16:32:03 -0400
Received: (qmail 27359 invoked by uid 1000); 4 Aug 2005 16:35:03 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Aug 2005 16:35:03 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050804201230.GC24479@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 4 Aug 2005, Petr Baudis wrote:

> Dear diary, on Wed, Aug 03, 2005 at 07:11:00PM CEST, I got a letter
> where barkalow@iabervon.org told me that...
> > IIRC, git-local-pull still doesn't work for a packed source repository, 
> > because it doesn't include the possibility of copying a pack (or 
> > extracting an object) if the requested object is in a pack.
> > 
> > I can probably fix it if anyone cares, but it's not something I use 
> > personally, so I don't know if it's worthwhile. It should probably be 
> > removed if we don't fix it, since it will fail on any popular repository 
> > at this point.
> 
> I want to use it in Cogito again, since copying everything obviously
> sucks and I want to hardlink, so repacking is not a solution either.
> Didn't you post some patches to fix this long time ago, actually?

Not for local-pull; I only did the other two. local-pull is special, 
because it's actually dealing with files on disk, and it also has to look 
at a repository that isn't what you're using.

	-Daniel
*This .sig left intentionally blank*
