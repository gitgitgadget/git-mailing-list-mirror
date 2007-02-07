From: Bill Lear <rael@zopyra.com>
Subject: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 16:15:31 -0600
Message-ID: <17866.20355.744025.133326@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 23:15:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEv51-0000GJ-Sk
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422912AbXBGWPm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422918AbXBGWPm
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:15:42 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61548 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422916AbXBGWPl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:15:41 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l17MFf306342;
	Wed, 7 Feb 2007 16:15:41 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38980>

Our company recently switched to git.  Our enthusiasm for git outweighs
the problems we have encountered so far, universally those of user
befuddlement, not git problems per se.

I have destroyed several repos by accidentally pulling from or pushing
to the wrong branch, not realizing this until later, and, trying what
I thought the proper way to undo it, failed that miserably.  I have
destroyed a few other repos by pulling from a "polluted" repo of a
co-worker that had mistakenly merged things in, and have had to resort
each time to full-scale reconstructions (again, almost trivially
accomplished thanks to git).  Thankfully, our company repo is so far
pristine, and I have been able to quickly reconstruct things and
continue working.

A co-worker just called to say he apparently had done something
similar, as he tried to pull from our company repo, got a conflict,
and then discovered files and changes to files that should not have
been on the master branch.  These files and changes do not exist in
our company repo, of that we are certain.

I'm not certain how I managed to screw up my repo, and he is equally
unsure of how he managed to screw up his.

I thought that it would be very useful to have a history of git
commands that have been run against a repo, in order to hopefully
debug this sort of thing --- perhaps only those that modify the repo.

I suppose this would need to include information about which branches
were affected as well.

% cat .git/repo.log
[....]
2007-02-07 10:05:44 git pull . .....
** Pull from master branch onto project branch
** Pull from foobar branch onto boobar branch
** ...
2007-02-07 10:05:44 git pull git://source/project master:project
** Your explanation here...

Would this sort of thing be easy to do?  I presume git does not
currently have support for this, but thought I would ask.


Bill
