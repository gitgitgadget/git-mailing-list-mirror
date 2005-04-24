From: Zack Brown <zbrown@tumblerings.org>
Subject: unseeking?
Date: Sun, 24 Apr 2005 08:47:54 -0700
Message-ID: <20050424154754.GA11094@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 24 17:44:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPjHZ-0006yg-8c
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 17:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVDXPtU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 11:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVDXPtU
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 11:49:20 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:16026 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S262346AbVDXPtM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 11:49:12 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DPjKs-0001uC-9u
	for git@vger.kernel.org; Sun, 24 Apr 2005 08:47:54 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I've been pulling cogito and the kernel, and just fumbling around trying to
learn the tool. My latest cogito is version 0.7, tracking

pasky   rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
linus   rsync://www.kernel.org/pub/linux/kernel/people/torvalds/git.git

I have many questions.

1) I saw some discussion of 'seek' as a way to get to an earlier version of a
tree; so I tried it on my own test directory. I 'seek'ed to the first patch, and
it worked - but now all I have is that very early version of my test directory.
All subsequent changes are apparently gone. How can I seek back to the most
recent state of the dir?

2) How can I 'check out' my local repository? i.e. I want to pretend to be
two developers, one of whom wants to grab a copy of the project leader's work. I
tried things like:

mkdir mygitdir2
git init ../mygitdir

where mydir is my test git repository. This didn't work. I tried rephrasing the
command with an rsync url:

git init rsync://home/zbrown/site/gitstuff/mygitdir

but that didn't work either. It just said:

defaulting to local storage area
rsync: getaddrinfo: home 873: Name or service not known
rsync error: error in socket IO (code 10) at clientserver.c(94)
gitpull.sh: unable to get the head pointer of branch master
gitinit.sh: pull failed

3) How can I do a rename with cogito? There doesn't seem to be a rename command,
and if I manually do a mv and 'git add', I can commit the result, but what
actually happened? Did I really do a rename? Is the file's history preserved?
How can I verify these things?

4) fork, seek, tag, and track are a little mysterious to me. I can guess at what
these things do in general, but the specifics are confusing, and the README is a
little vague.

5) I'm a little confused about how to use a git repository to follow along with
a project. I have no problem pulling the latest version, but I'm interested in
generating changelogs for specific releases like 2.6.12-rc3. How can I

   a) identify the proper 'c83b95297c2a6336c2007548f909769e0862b509' string that
   represents the release I'm interested in

   b) generate the changelog between that version and the previous one,
   once I've solved (a)

Many thanks,
Zack





-- 
Zack Brown
