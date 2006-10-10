From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Approxidate licensing
Date: Tue, 10 Oct 2006 13:39:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610101246241.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 19:40:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXLa4-0002ko-Cw
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 19:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWJJRjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 13:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWJJRjt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 13:39:49 -0400
Received: from iabervon.org ([66.92.72.58]:33799 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751024AbWJJRjs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 13:39:48 -0400
Received: (qmail 10689 invoked by uid 1000); 10 Oct 2006 13:39:47 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Oct 2006 13:39:47 -0400
To: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, dwmw2@infradead.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28638>

I'm working on an LGPL project (for my company; it's obscure enough and 
we're lazy enough that we're not really distributing it in general in 
either source or binary form), and I'm running into the usual date parsing 
issue (i.e., all the standard functions are broken in various ways). My 
plan has been to write my own, but it's hard to get the motivation when 
approxidate exists, works well, and is open source.

Would the three of you agree to license date.c under the LGPL or BSD? It 
looks like you're the only authors of non-trivial changes [1]. And it seems 
reasonable to want the date parsing thing under non-GPL terms outside of 
git.

	-Daniel
*This .sig left intentionally blank*

[1] git log and git blame are pretty impressive, but they don't quite 
catch that most of date.c was written by David as part of commit-tree.c, 
then Tony replaced it with a version that uses curl, then Edgar separated 
it out into a date.c and simultaneously reverted Tony's changes. On the 
other hand, the commit messages do say this, and you can use git log and 
git blame to verify that they're true. The only thing they don't let 
you verify is what the differences are between the date.c added in 
ecee9d9e and the similar part of commit-tree.c in 812666c8. If someone 
wants to make git blame *really* magic, date.c would be a good test case.
