From: Eric Wong <normalperson@yhbt.net>
Subject: Re: "svn switch" equivalent when using git-svn -- git-filter-branch?
Date: Tue, 10 Jul 2007 02:00:03 -0700
Message-ID: <20070710090003.GA18850@muzzle>
References: <86sl7x7nzq.fsf@lola.quinscape.zz> <20070710054038.GA17675@muzzle> <86ejjgzmxl.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 11:01:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Bat-0005MG-EI
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 11:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763315AbXGJJAI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 05:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763314AbXGJJAH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 05:00:07 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37811 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763431AbXGJJAF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 05:00:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 064B92DC032;
	Tue, 10 Jul 2007 02:00:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <86ejjgzmxl.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52056>

David Kastrup <dak@gnu.org> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > David Kastrup <dak@gnu.org> wrote:
> >> Hi,
> >> 
> >> an upstream svn repository that I access with git-svn has moved.  I
> >> seem to be too stupid to use git-filter-branch and/or .git/config
> >> and/or git-reset to make my git mirror follow the switch.
> >
> > Just changing the url key in the [svn-remote] section of the .git/config
> > file should be enough.
> >
> > You'll probably need to fetch at least one revision from the new URL
> > before being able to dcommit, though.
> 
> git-fetch works, but git-rebase -l still complains:
> 
> git-svn rebase -l
> Unable to determine upstream SVN information from working tree history
> 
> And consequently I can't actually update.

Does manually specifying the remote name work?

Try bypassing the auto-detection of "git-svn rebase" and just using
"git rebase <remote name>"

-- 
Eric Wong
