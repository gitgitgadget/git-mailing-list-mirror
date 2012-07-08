From: pbGit <pblakeley@gmail.com>
Subject: Problems pushing???
Date: Sun, 8 Jul 2012 02:12:46 -0700 (PDT)
Message-ID: <1341738766823-7562695.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 08 11:13:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnnXz-0007C8-7d
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 11:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148Ab2GHJMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 05:12:48 -0400
Received: from sam.nabble.com ([216.139.236.26]:40815 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab2GHJMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 05:12:47 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <pblakeley@gmail.com>)
	id 1SnnXq-0008Ji-Sj
	for git@vger.kernel.org; Sun, 08 Jul 2012 02:12:46 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201170>

Hi,
  I have installed git locally to my machine.  It is running mac os lion. 
This is intended to be the remote machine too. I have followed, what I think
is the correct way to do this, using 
http://www.petermac.com/setup-git-local-and-remote-repositories/ this .  All
seemed to be ok until I tried to push.  When I try the following command.

git push --all --repo=<project>

I get the following output

Counting objects: 12, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (11/11), done.
Writing objects: 100% (12/12), 5.23 KiB, done.
Total 12 (delta 1), reused 0 (delta 0)
remote: error: refusing to update checked out branch: refs/heads/master
remote: error: By default, updating the current branch in a non-bare
repository
remote: error: is denied, because it will make the index and work tree
inconsistent
remote: error: with what you pushed, and will require 'git reset --hard' to
match
remote: error: the work tree to HEAD.
remote: error: 
remote: error: You can set 'receive.denyCurrentBranch' configuration
variable to
remote: error: 'ignore' or 'warn' in the remote repository to allow pushing
into
remote: error: its current branch; however, this is not recommended unless
you
remote: error: arranged to update its work tree to match what you pushed in
some
remote: error: other way.
  
Hope someone can help with this because I have spent a bit of time trying to
solve this and still stuck!!!

Thanks for your time,
 Paul

--
View this message in context: http://git.661346.n2.nabble.com/Problems-pushing-tp7562695.html
Sent from the git mailing list archive at Nabble.com.
