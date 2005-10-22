From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-rev-list: add "--dense" flag
Date: Sat, 22 Oct 2005 02:37:33 +0200
Message-ID: <20051022003733.GA8351@pasky.or.cz>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 02:38:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET7OF-0004eA-96
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 02:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVJVAhg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 20:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVJVAhg
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 20:37:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11501 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751282AbVJVAhg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 20:37:36 -0400
Received: (qmail 11746 invoked by uid 2001); 22 Oct 2005 02:37:33 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10457>

Dear diary, on Sat, Oct 22, 2005 at 01:40:54AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> When we use a path filter to git-rev-list, the new "--dense" flag asks
> git-rev-list to compress the history so that it _only_ contains commits
> that change files in the path filter.  It also rewrites the parent
> information so that tools like "gitk" will see the result as a dense
> history tree.

There is no documentation for the --dense flag and it is even missing
from the usage string.

But my main concern is - will it be possible to do the rename detection
here as well? Using --dense instead of explicit diff-tree calls in
cg-log would be nice optimization, but I was about to add support for
optional following of renames for cg-log <filename>. That's really
pretty useful to have, every time I hit the Junio's big scripts rename
I keep repeating that to myself. ;-) Now when core GIT got the comfort
of per-file history, I only hope that it will start to annoy you as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
