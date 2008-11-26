From: Jens Neuhalfen <JensNeuhalfen@gmx.de>
Subject: git svn dcommit crashed -- how do I resume?
Date: Wed, 26 Nov 2008 09:22:36 +0100
Message-ID: <E8293DEF-109A-4F57-BD4F-7F189976DA79@gmx.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 09:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Fgi-00005D-L1
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 09:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYKZIWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 03:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYKZIWl
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 03:22:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:35231 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751364AbYKZIWk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 03:22:40 -0500
Received: (qmail invoked by alias); 26 Nov 2008 08:22:38 -0000
Received: from static-87-79-238-78.netcologne.de (EHLO [172.20.0.119]) [87.79.238.78]
  by mail.gmx.net (mp036) with SMTP; 26 Nov 2008 09:22:38 +0100
X-Authenticated: #1271396
X-Provags-ID: V01U2FsdGVkX19NVqRLBZpNBoMee2OHFD9gMCuz5M4PaZCe4bRDze
	Ru838psHly/7CP
X-Mailer: Apple Mail (2.929.2)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101711>

Hi,

I am using git as a frontend to my SVN-Repository. When I tried to  
"git svn dcommit" several changes from my local git-repository, git  
crashed (SEGFAULT, AFAIR).

Now I have a working copy (master branch) that points "somewhere in  
the past" (at least my files are old). I have a git-svn remote branch  
that points to the same SHA1.

$ git branch -a
   dokument-zusammenfuehren
* master
   git-svn

I cannot dcommit
$ git svn dcommit
Cannot dcommit with a dirty index.  Commit your changes first, or  
stash them with `git stash'.
  at /Users/jens/libexec/git-core/git-svn line 415

And, indeed, the index is dirty.


I am confused (an slightly panicked), because my old commits seem to  
be "gone", my WC does not contain the most recent files and there  
seems to be no "backup-branch" with my old HEAD.

Any idea, how I might get my data back and how to 'resume' the dead  
dcommit? Google did not turn up anything usefull, unfortunally.


BTW: I am currently using git version 1.6.0.rc0.24.gf45e0.dirty.


Jens
