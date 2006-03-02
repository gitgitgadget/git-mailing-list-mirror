From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Problems with using git
Date: Thu, 02 Mar 2006 00:25:32 +0000
Message-ID: <44063B7C.40609@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Mar 02 01:25:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEbdC-0006w7-3s
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 01:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWCBAZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 19:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWCBAZS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 19:25:18 -0500
Received: from alf.nbi.dk ([130.225.212.55]:4625 "EHLO alf.nbi.dk")
	by vger.kernel.org with ESMTP id S1751136AbWCBAZQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 19:25:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by alf.nbi.dk (8.9.3/8.9.3) with ESMTP id BAA31501
	for <git@vger.kernel.org>; Thu, 2 Mar 2006 01:25:14 +0100 (MET)
User-Agent: Thunderbird 1.5 (X11/20060111)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17032>

Hello all,

I'm a physics PhD student, not much experienced in serious software
writing, but I've got to the point where I felt learning to use a
version control system would be worthwhile.  I decided to go for git
rather than CVS or Subversion because I felt a distributed VCS would
have more potential for future projects.

However, I've been experiencing some difficulties with using git, with
the results of commands not always being what the tutorial
<http://www.kernel.org/pub/software/scm/git/docs/tutorial.html> says it
should be.  So, I'm hoping someone here can advise me!

I'm using openSUSE 10.0 and the package installed is git-core version
0.99.3git20050905-2.

The problem is to do with branches.  Wanting to make some trial
revisions, I typed,

    git branch trial

to create an appropriate branch.  However, typing "git branch"
afterwards results in an error message: "git branch: I want a branch
name".  No list of branches as the tutorial suggests!

However, I can use git checkout trial, make edits, and then go back to
git checkout master, and switch between the two, with the revisions in
one but not in the other.  So the branches do seem to exist, and I can
modify them separately as one should be able to.

Now, having played around with the changes and found that they really
work very well, I'd like to merge the changes in the trial branch back
into the master.  So, as per the tutorial, I type, git pull trial; and
am told, "No such remote branch: trial".  I've also tried, git pull .
trial, which has the result, "No such remote branch: .".

I also note that when I'm in the master branch, having used git checkout
master, if I go into gitk, it does not show the existence of the trial
branch: but if I go into git checkout trial, it does.  But the two
appear to be shown as completely separate entities.

Just as a test, I tried creating a throwaway branch,

    git branch silly

which I then tried to delete with git branch -D silly.  However, this
didn't delete the silly branch: it created a new one called -D (and both
of these *did* show up in gitk under the master branch).  Using
git-branch instead of git branch results in an error message: "bash:
git-branch: command not found".

The result is that I'm kind of confused.  I'd like to understand why the
commands I've tried from the tutorial haven't produced the results the
tutorial claims they will; but I'd also like to solve the original
problem: how just to merge the stuff in my trial branch back into the
master.

I suspect this might be simply that the SUSE package has some problems. 
For example, it doesn't appear to have any man pages included. :-(

Thanks for any advice,

Best wishes,

        -- Joe
