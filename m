From: Jack Moore <jhmoore719@verizon.net>
Subject: Migrate an svn repo to git - Where did all the branches got? and tags?
Date: Thu, 20 May 2010 21:20:18 -0700
Message-ID: <CFE20E75-F23D-41EA-89AA-2FF59BFA5DF9@verizon.net>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jack Moore <jhmoore719@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 06:20:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFJix-0008IF-K2
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 06:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab0EUEUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 00:20:34 -0400
Received: from vms173013pub.verizon.net ([206.46.173.13]:24781 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab0EUEUd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 00:20:33 -0400
Received: from [192.168.1.102] ([unknown] [173.58.219.82])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2R00MMF5DUIT30@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 20 May 2010 23:20:19 -0500 (CDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147431>

All,

I have a subversion repository with the usual structure

svn-repo
  |
  +-branches
      +-release1
      +-release2
  +-tags
      +-r1dev
      +-r1test
      +-r2dev
      +-r2test
  +-trunk

that I want to migrate to git.

I cloned the svn repo with

   git svn clone --no-metadata -t tags -b branches -T trunk <repo-url>

I used the example in the Pro Git book.

the cloned repo has files 

  git-repo/.git/refs/heads/master
  git-repo/.git/refs/remotes/trunk

directory

  git-repo/.git/refs/tags

is empty.

Directories git-repo/.git/logs/... have files corresponding to the branches and tags, but they do not appear to reference git objects.

There are unhandled.log.gz files in the .git/svn directory for each branch and tag.

If I do a 

	git branch -r

the branches and tags show up as remote branches.
gitk appears to show all of the commits, but I do not see any of the branches and tags.

I would like to make the branches and tags to appear al local to git repo.

Is there a way to do this?
