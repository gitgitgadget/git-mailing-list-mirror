From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 14:04:49 -0700
Message-ID: <7vodmzv6dq.fsf@assigned-by-dhcp.cox.net>
References: <20070311043250.GA21331@moooo.ath.cx>
	<7vabykxs15.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703111326170.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:05:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVDq-0005fm-Sc
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbXCKVEw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbXCKVEv
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:04:51 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:61358 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbXCKVEu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:04:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070311210450.OYDU1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Mar 2007 17:04:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZZ4p1W00T1kojtg0000000; Sun, 11 Mar 2007 17:04:50 -0400
In-Reply-To: <Pine.LNX.4.64.0703111326170.9690@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 11 Mar 2007 13:37:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41982>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So let's say that you have a git repository for tracking all that. The 
> "working tree" for that git repository would be your home directory.
>
> Now, imagine that you *also* want to track something else in git, that you 
> *also* have in your home directory. Say your ".bashrc" files etc. They 
> have nothing to do with your music tracking setup, so you don't want to 
> track it in the same git repository, and you want to have a totally 
> different .git/index file for those. But again, the *working*tree* is 
> actually your home directory.

That is a good example usage schenario; we would need to think
about what to do with .gitignore (and .gitattributes if we will
have that in-tree), though.
