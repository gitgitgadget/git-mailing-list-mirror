From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 19:10:47 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701301853300.20138@iabervon.org>
References: <87odognuhl.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 01:11:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC34R-0007Vo-Fc
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 01:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbXAaAKw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 19:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbXAaAKw
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 19:10:52 -0500
Received: from iabervon.org ([66.92.72.58]:2489 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbXAaAKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 19:10:51 -0500
Received: (qmail 674 invoked by uid 1000); 30 Jan 2007 19:10:49 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jan 2007 19:10:49 -0500
In-Reply-To: <87odognuhl.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38216>

On Tue, 30 Jan 2007, Carl Worth wrote:

> Also, if I'm willing to assume (or insist) that users have git 1.5 or
> newer, it'd be nice to be able to drop the "-b build" thing thanks to
> the new detached HEAD support. But if I suggest doing just:
> 
> 		git checkout origin/proposed-fix
> 
> the user is presented with the following message which is much more
> scary than useful in this situation:
> 
> 	warning: you are not on ANY branch anymore.
> 	If you meant to create a new branch from the commit, you need -b to
> 	associate a new branch with the wanted checkout.  Example:
> 	  git checkout -b <new_branch_name> origin/proposed-fix

I think the warning should just be something where a user following your 
instructions will say, "ah, yes, that's actually what I want." Maybe:

  warning: you are now browsing the history without a local branch. You 
  will not be able to commit changes unless you create a new local branch 
  with "git checkout -b <new_branch_name>".

It's a bit silly for us to simply warn people that they're using this 
feature, rather than telling them what the potential downside is. Since 
it's marked as a warning, with no further information, the intuitive 
inference is that all sorts of bad things could happen (like, too many for 
us to list). At least we don't say "warning: your HEAD is now detatched" 
but still...

	-Daniel
*This .sig left intentionally blank*
