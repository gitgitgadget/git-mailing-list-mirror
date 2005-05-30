From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-update with local uncommitted changes
Date: Mon, 30 May 2005 12:25:41 -0700
Message-ID: <20050530192541.GA27047@tumblerings.org>
References: <1117463114.7072.185.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 21:29:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcpro-00038c-4p
	for gcvg-git@gmane.org; Mon, 30 May 2005 21:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVE3T0W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 15:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVE3T0W
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 15:26:22 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:13241 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261647AbVE3TZx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 15:25:53 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DcptN-0003MO-As; Mon, 30 May 2005 12:25:41 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1117463114.7072.185.camel@pegasus>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 30, 2005 at 04:25:14PM +0200, Marcel Holtmann wrote:
> Hi Petr,
> 
> when doing a cg-update and I have local uncommitted changes it fails
> with the "... needs update" message.

I don't see failures, but I do see the "needs update" message often when
I do cg-update. If I run cg-update a second time it says the tree is fully
up-to-date. However, if I then do a cg-diff, I will see tons of diff output.
This is on a tree (the kernel) that I haven't modified at all, I only track it
with cg-update.

I also track Cogito, and I use the latest form of all git and Cogito tools.
Maybe somewhere along the line I've corrupted my repo by using incompatible
versions of the git/Cogito toolset.

I've noticed if I do a fresh cg-clone the problem seems to go away.

Be well,
Zack

> From some previous posts on the
> mailing list I got the impression that it is possible to pull updates
> into the local repository with changed files. At the moment I am using
> the following sequence:
> 
> 	cg-diff > patch
> 	cg-cancel
> 	cg-update origin
> 	cat patch | patch -p1
> 	rm patch
> 
> The problem with this sequence is when I have added or removed files
> from my repository. This needs a lot of manual fixing.
> 
> With Bitkeeper it was possible to pull changes as long as they don't
> affect local uncommitted files.
> 
> Any ideas on how to implement or if it exists on how to use it?
> 
> Regards
> 
> Marcel
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
