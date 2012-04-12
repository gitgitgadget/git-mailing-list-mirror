From: cvalusek <clintv2@gmail.com>
Subject: GIT pull
Date: Thu, 12 Apr 2012 07:47:57 -0700 (PDT)
Message-ID: <1334242077960-7459655.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 16:48:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SILJc-0005Qk-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 16:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887Ab2DLOr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 10:47:59 -0400
Received: from sam.nabble.com ([216.139.236.26]:57757 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757703Ab2DLOr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 10:47:58 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <clintv2@gmail.com>)
	id 1SILJV-0005u5-VM
	for git@vger.kernel.org; Thu, 12 Apr 2012 07:47:57 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195330>

My apologies if this isn't the appropriate place to post this. We are using
the windows port msysgit so I understand if I need to post over there first.

I have also posted this on stackoverflow. Here is a link to the question
there:

http://stackoverflow.com/questions/10110401/why-doesnt-git-clean-up-when-aborting-a-merge-triggered-from-pulling-in-changes

My team has had a lot of trouble with GIT lately because of aborted pull
commands.

If a user has local modifications not on the index and does a pull, I have
seen git attempt to start applying the merge to master and abort. The whole
checkout is then left in a terrible state that is nearly unrecoverable. In
the past, I thought GIT would run some sort of check to identify these
problems before it attempts the merge.

Even with a clean state (nothing to commit), I have seen the same thing
randomly happen at least once. I understand that without rebasing, you may
be forced to resolve merge conflicts when you pull, but this is not what is
happening though.

We are using gitolite. I am mainly using command line and have yet to run
into these issues. The rest of the team is using the git-gui or in 1 case
TortoiseGit.

git-gui version 0.13.GITGUI
git version 1.7.8.msysgit.0
Tcl/Tk version 8.5.1
TortoiseGit 1.7.6.0

We are not working with branches as much as we could, but feel like this
should be working.
Why does GIT allow you to try to pull when it is going to train-wreck?
Why does GIT not abort cleanly?

--
View this message in context: http://git.661346.n2.nabble.com/GIT-pull-tp7459655p7459655.html
Sent from the git mailing list archive at Nabble.com.
