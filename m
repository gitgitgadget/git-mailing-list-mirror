From: Sips <kirillosipov@msn.com>
Subject: Tracking a remote branch in git
Date: Thu, 29 Oct 2009 12:45:46 -0700 (PDT)
Message-ID: <26119537.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 20:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3awZ-00016z-Kr
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 20:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbZJ2Tpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 15:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754361AbZJ2Tpm
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 15:45:42 -0400
Received: from kuber.nabble.com ([216.139.236.158]:35971 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbZJ2Tpl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 15:45:41 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1N3awM-000820-G5
	for git@vger.kernel.org; Thu, 29 Oct 2009 12:45:46 -0700
X-Nabble-From: kirillosipov@msn.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131648>


Hello everyone.
My git setup is as follows:

One local repository residing at D:\Dev\ProjectName
One remote repository residing at W:\ProjectName

W is actually a removable disk.

Now, both repositories are connected through remotes. For example, git
remote -v in the local repository gives:

storengo    W:\ProjectName (fetch)
storengo    W:\ProjectName (push)

The same command in the remote repository gives:

origin    D:\Dev\ProjectName (fetch)
origin    D:\Dev\ProjectName (push)

Obviously, when I am in the master branch, I can synchronize repositories
between each other through git push and git pull.

Then I created a branch in the repository on the removable drive W and named
it newfeature. The question is: How can I work with this branch on the local
repository as well? I mean, I need the same 'relationship' between branches
as in case of the master branch.

I tried the following command on the local repository (which was checked out
to the master branch at that time):

git branch --track newfeature storengo/newfeature,

but received an error fatal: Not a valid object name: 'storengo/newfeature'.

With this command I was hoping to create a local branch which would be
'connected' to the same remote branch. As I've said, no luck there.
Strangely, the following command works without errors:

git branch --track newfeature storengo/master.

I mean, I am able to track the master branch from the remote repository. Why
can't I track some other branch as well? Any ideas what I'm doing wrong?

Thanks,
Kirill
-- 
View this message in context: http://www.nabble.com/Tracking-a-remote-branch-in-git-tp26119537p26119537.html
Sent from the git mailing list archive at Nabble.com.
