From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Branch "ahead of tracked remote branch"
Date: Thu, 24 Apr 2008 23:59:44 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804242349460.19665@iabervon.org>
References: <18449.15334.88706.45152@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 06:00:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpF6v-0002IC-IY
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 06:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbYDYD7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 23:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbYDYD7q
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 23:59:46 -0400
Received: from iabervon.org ([66.92.72.58]:39794 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402AbYDYD7p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 23:59:45 -0400
Received: (qmail 14524 invoked by uid 1000); 25 Apr 2008 03:59:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2008 03:59:44 -0000
In-Reply-To: <18449.15334.88706.45152@lisa.zopyra.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80321>

On Thu, 24 Apr 2008, Bill Lear wrote:

> I had some work in master, I decided to move to a branch to complete,
> so:
> 
> % git checkout -b branch
> % git commit -a -m "Insightful message"
> 
> Then, I decided this was not such a good idea, so I did a git reset
> --soft HEAD^, then git reset HEAD for each file I committed, thinking
> that this was a complete "undo".  I then switched to branch master
> and got this:
> 
> Switched to branch "master"
> Your branch is ahead of the tracked remote branch 'origin/master' by 1 commit.
> 
> I'm not sure this is accurate.  Does this seem correct?

It's certainly possible. It looks like you committed once on your own 
master branch before you did any of the things mentioned in this message. 
Then you created a new branch, made a commit on it, undid the commit, and 
switched back to "master". "git log origin/master..master" will show you 
the 1 commit that you have on master.

	-Daniel
*This .sig left intentionally blank*
