From: bmitic <bj@infomitic.com>
Subject: Problem pulling large repo, Error: /usr/bin/git-pull: line 277:
  5401 Terminated              git read-tree --reset -u HEAD
Date: Sat, 23 Jun 2012 09:39:28 -0700 (PDT)
Message-ID: <1340469568490-7562027.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 18:39:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiTN0-0001t5-EK
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 18:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab2FWQj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 12:39:29 -0400
Received: from sam.nabble.com ([216.139.236.26]:55963 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496Ab2FWQj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 12:39:29 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bj@infomitic.com>)
	id 1SiTMu-0006v6-I1
	for git@vger.kernel.org; Sat, 23 Jun 2012 09:39:28 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200502>

I can't really explain it, but basically every time I try to pull this
specific repo from my other servers I get the results bellow.  I have two
identical servers where this works, but for some reason on the third one it
doesn't.  I even got another virtual server and tried it and I was getting
the same error.  I don't know how to troubleshoot this. 
If anyone has a suggestion I would appreciate it:  

[root@myserver gittestremote]# git pull -v tst1 master
xxx@xxxxx.xxxxxxxx.com's password: 
remote: Counting objects: 20095, done.
remote: Compressing objects: 100% (18794/18794), done.
remote: Total 20095 (delta 1005), reused 20095 (delta 1005)
Receiving objects: 100% (20095/20095), 1.11 GiB | 11.46 MiB/s, done.
Resolving deltas: 100% (1005/1005), done.
From xxxxxx.xxxxxx.com:/var/www/GITREPO3/fullsites/prd_biq
 * branch            master     -> FETCH_HEAD
/usr/bin/git-pull: line 277:  5401 Terminated              git read-tree
--reset -u HEAD
[root@myserver gittestremote]# 

--
View this message in context: http://git.661346.n2.nabble.com/Problem-pulling-large-repo-Error-usr-bin-git-pull-line-277-5401-Terminated-git-read-tree-reset-u-HEAD-tp7562027.html
Sent from the git mailing list archive at Nabble.com.
