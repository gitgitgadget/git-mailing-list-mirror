From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn trouble finding all branches/tags
Date: Sun, 11 May 2008 01:51:45 -0700
Message-ID: <20080511085145.GD23929@untitled>
References: <20080506201602.GB10561@marlowe.visv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Michael Fischer <michael@visv.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 10:52:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv7IP-0005yq-B2
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 10:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbYEKIvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 04:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbYEKIvq
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 04:51:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53304 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbYEKIvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 04:51:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 504642DC08B;
	Sun, 11 May 2008 01:51:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080506201602.GB10561@marlowe.visv.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81751>

Michael Fischer <michael@visv.net> wrote:
> 
> Scenario is initialization  of a local git repo from a remote
> SVN repo.
> 
> 
> $ git svn init -s https://svn.our.office/projname
> 
> $ git svn fetch
> .........................
> 
> Now, git branch -r shows trunk, one branch, 3 tags. There ought to be
> 7 branches, and about 20 tags.
> 
> If I go into .git/svn/.metadata and change the 
> 
> branches-maxRev
> tags-maxRev 
> 
> values to something much larger than anything in SVN (e.g. 1000000), 
> and repeat 'git svn fetch', lather, rinse repeat, then I eventually
> have all the branches and tags.
> 
> Surely this isn't the way its supposed to happen?

No, I've never actually heard of this problem.  Which version of git-svn
are you using?

Without further details about your repository layout, I'm not sure how
to help you, either.  Is there anything non-standard in your layout
or how the repository was created?

Thanks.

-- 
Eric Wong
