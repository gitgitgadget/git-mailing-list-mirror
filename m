From: Fabian Molder <fm122@arcor.de>
Subject: git svn with non-standard svn layout
Date: Fri, 9 Oct 2009 22:24:48 +0000 (UTC)
Message-ID: <loom.20091010T001433-536@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 10 06:46:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwTqY-0000X8-3A
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 06:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbZJJEpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 00:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZJJEpl
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 00:45:41 -0400
Received: from lo.gmane.org ([80.91.229.12]:56536 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbZJJEpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 00:45:41 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MwTpI-0008SW-Fl
	for git@vger.kernel.org; Sat, 10 Oct 2009 06:45:04 +0200
Received: from p579FC476.dip.t-dialin.net ([87.159.196.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 06:45:04 +0200
Received: from fm122 by p579FC476.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 06:45:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.159.196.118 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.3) Gecko/20090909 Fedora/3.5.3-1.fc11 Firefox/3.5.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129870>

Hello,

- want to use git inside an huge SVN project
 --> so git-svn could do the job ..


- I struggle with two things:
   A) - the SVN project has an non-standard layout
   B) - want to have (several) git's for just the (few) peaces I work on

for A)
======
- svn layout looks like this (simplified):
  - trunk  (not really used, all interesting work in branches)
  - branches
    - r1.2
     - development
     - integration
    - r1.3
     - development
     - integration
    ...

- inside development and integration is:
       - xapplication1
       - xapplication2
       - xapplication3
       ...
       - aa
        -bb
         -cc
          - zapplication1
          - zapplication2
          - zapplication3
          ...

- I created an simplified svn test (from scratch; import/repo/workdir) 
  via this bash-script:   http://pastebin.ca/1608231

for B)
======
- the svn repo is very huge, but I'm only interested in these dirs:
         xapplication2/
         aa/bb/cc/zapplication1
- my objectives: 
   - have several local git's, just the ones I need:
     --> xapplication2/.git
     --> aa/bb/cc/zapplication1/.git


I tried to use "git config svn-remote.svn.branches" to do this,
 please see in function "do_git_svn" in bash-script - but no success

any hints appreciated 

regards,
Fabian
