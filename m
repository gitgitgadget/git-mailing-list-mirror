From: Steffen Prohaska <prohaska@zib.de>
Subject: merge vs rebase: Is visualization in gitk the only problem?
Date: Sat, 27 Oct 2007 09:17:05 +0200
Message-ID: <8E86BDBA-A49A-49BB-8E00-8BF6DD7237E9@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 09:15:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilftg-00032i-6X
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 09:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbXJ0HPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 03:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbXJ0HPj
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 03:15:39 -0400
Received: from mailer.zib.de ([130.73.108.11]:45059 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbXJ0HPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 03:15:39 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9R7FbDF015736
	for <git@vger.kernel.org>; Sat, 27 Oct 2007 09:15:37 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1a4d6.pool.einsundeins.de [77.177.164.214])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9R7Faf9027590
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 27 Oct 2007 09:15:37 +0200 (MEST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62465>

There are some discussions going on about merge vs. rebase. The
suggestions by Dscho is to prefer rebase over merge in a
CVS-style workflow.

Rebase has definitely benefits but not all of its details
are obvious at a first glance. Tell a newbie to read the
git rebase man page and explain what git reabase does and
you know what I mean. Rebase definitely can help to create a
cleaner history. But it rewrites history and therefore destroys
information, for example information about the original code
base a patch was developed against, or merge conflicts that
were resolved. You also need to decide when to use rebase and
when to use merge. So you need to make a choice.

Why not always use git merge?

Is the only problem of git merge that it might create loops
in the history with potentially long running parallel lines
that are insufficiently visualized in gitk?

If so, why not improve the visualization?

Or is there any other deficiency of always using merge and
never using rebase that I don't see?

Obviously you can use git merge only if you want to have _all_
changes from the other branch. But this is often what you
want. In a CVS-style workflow you want to merge all changes
from the shared branch before pushing. Why going through the
hassel of git rebase?

I'm aware that you can do other things with git rebase that
cannot be achieved by using git merge. For example moving a
topic branch to a different stable branch without merging all
of the topic branch's history ("--onto" option). It is easy
to explain that rebase has it's own value.

	Steffen
