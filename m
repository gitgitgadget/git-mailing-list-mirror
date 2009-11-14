From: Lorenzo Bettini <bettini@dsi.unifi.it>
Subject: pushing remote branches
Date: Sun, 15 Nov 2009 00:37:04 +0100
Message-ID: <hdneuv$nc8$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 00:40:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9SE0-0001Iy-Tn
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 00:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbZKNXkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 18:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbZKNXj7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 18:39:59 -0500
Received: from lo.gmane.org ([80.91.229.12]:34246 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbZKNXj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 18:39:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N9SDs-0001Gd-3m
	for git@vger.kernel.org; Sun, 15 Nov 2009 00:40:04 +0100
Received: from 93.88.112.188 ([93.88.112.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 00:40:04 +0100
Received: from bettini by 93.88.112.188 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 00:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 93.88.112.188
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132897>

Hi

I recently started to use git, and I experienced problems with branches: 
on my machine I did (on an already cloned repo)

git checkout -b experiments origin/experiments

and thus my config reads

[remote "origin"]
         fetch = +refs/heads/*:refs/remotes/origin/*
         url = git://...
[branch "master"]
         remote = origin
         merge = refs/heads/master
[branch "experiments"]
         remote = origin
         merge = refs/heads/experiments

isn't this enough to be able to push the experiments branch?

I tried

git push origin experiments

It tells me that it is a read-only url...

after adding

[remote "experiments"]
         url = git@...
         fetch = 
+refs/heads/experiments:refs/remotes/experiments/experiments

I can now push that branch with

git push experiments experiments

but I was wondering whether the initial config wasn't enough...

many thanks in advance
	Lorenzo

-- 
Lorenzo Bettini, PhD in Computer Science, DI, Univ. Torino
ICQ# lbetto, 16080134     (GNU/Linux User # 158233)
HOME: http://www.lorenzobettini.it MUSIC: http://www.purplesucker.com
http://www.myspace.com/supertrouperabba
BLOGS: http://tronprog.blogspot.com  http://longlivemusic.blogspot.com
http://www.gnu.org/software/src-highlite
http://www.gnu.org/software/gengetopt
http://www.gnu.org/software/gengen http://doublecpp.sourceforge.net
