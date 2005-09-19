From: Junio C Hamano <junkio@cox.net>
Subject: Re: omitted test scripts?
Date: Mon, 19 Sep 2005 09:19:05 -0700
Message-ID: <7v1x3lrpxi.fsf@assigned-by-dhcp.cox.net>
References: <200509102027.28812.blaisorblade@yahoo.it>
	<1126427087.8457.33.camel@localhost.localdomain>
	<200509142019.04667.blaisorblade@yahoo.it> <tnxslw6d4qt.fsf@arm.com>
	<7vvf10hji1.fsf@assigned-by-dhcp.cox.net>
	<1126949517.6941.19.camel@localhost.localdomain>
	<432EDE3F.7070407@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 18:19:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHOMJ-0006NI-A7
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 18:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVISQTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVISQTI
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 12:19:08 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37801 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932488AbVISQTH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 12:19:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919161907.HOPJ24382.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 12:19:07 -0400
To: cel@citi.umich.edu
In-Reply-To: <432EDE3F.7070407@citi.umich.edu> (Chuck Lever's message of "Mon,
	19 Sep 2005 11:50:23 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8880>

Chuck Lever <cel@citi.umich.edu> writes:

> i noticed while testing the new cache API that there are no tests under 
> t/ for git-merge-index.

In the past, when I did any major butchering of existing code or
made nontrivial additions, I wrote test scripts to cover what
should happen (and what to be preserved) first to make sure the
changes or additions would not introduce regression.  I think we
have been reasonably successful (Daniel could fill us in with
experiences with read-tree tests).

I have been expecting people to follow suit, without explicitly
asking them to do, so when I took over the project.  Further I
got sloppy when accepting any sizable patches.  Sorry about
that.

> there is also no test script that covers the prune_cache() function in 
> ls-files.c.

That's one of the item on the TODO list and patches to extend
test coverage are always welcomed.
