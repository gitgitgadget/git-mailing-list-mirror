From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: cogito "origin" vs. HEAD
Date: Tue, 03 May 2005 17:13:28 +1000
Message-ID: <1115104408.6156.100.camel@gaston>
References: <1115090660.6156.56.camel@gaston>
	 <20050503064943.GB10244@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 09:10:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSrXF-0005I1-EB
	for gcvg-git@gmane.org; Tue, 03 May 2005 09:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVECHPq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 03:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVECHPq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 03:15:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:54956 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261415AbVECHPl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 03:15:41 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j4379igJ006583;
	Tue, 3 May 2005 02:09:45 -0500
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050503064943.GB10244@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


> when accessing the remote repository, Cogito always looks for remote
> refs/heads/master first - if that one isn't there, it takes HEAD, but
> there is no correlation between the local and remote branch name. If you
> want to fetch a different branch from the remote repository, use the
> fragment identifier (see cg-help cg-branch-add).

Ok, that I'm getting. So then, what happen of my local
refs/heads/<branchname> and refs/heads/master/ ? I'm still a bit
confused by the whole branch mecanism... It's my understanding than when
I cg-init, it creates both "master" (a head without matching branch)
and "origin" (a branch  + a head) both having the same sha1. It also
checks out the tree.

Now, when I cg-update origin, what happens exactly ? I mean, I know it's
pulls all objects, then get the master from the remote pointed by the
origin branch, but then, I suppose it updates both my local "origin" and
my local "master" pointer, right ? I mean, they are always in sync ? Or
is this related to what branch my current checkout is tracking ?

Ben.


