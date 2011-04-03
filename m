From: Alenoosh <hope2end@gmail.com>
Subject: git checkout in a subdirectory
Date: Sun, 3 Apr 2011 11:53:13 -0700 (PDT)
Message-ID: <1301856793041-6236473.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 20:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6SQL-0000OQ-Ph
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 20:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab1DCSxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 14:53:14 -0400
Received: from sam.nabble.com ([216.139.236.26]:56583 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235Ab1DCSxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 14:53:14 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <hope2end@gmail.com>)
	id 1Q6SQD-0000tD-1V
	for git@vger.kernel.org; Sun, 03 Apr 2011 11:53:13 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170767>

Hi all

I have recently converted my svn repository to git repository (A) but I did
not convert the svn branches , here is my problem :

One of my svn branches is a branch of a subdirectory , I have converted that
to a separate git repo (B) and
created a git branch from that in the (A) git repo but the problem is that I
can't checkout that branch in the corresponding subdirectory of my git repo
(A) ...

my git repo (A) looks something like this :

----------------------------------------------------------------------
git-repo
    |-- dir1
    |-- dir2
    |-- dir3 -- dir31

here's what I have done :
    cd /tmp
    git svn clone   B
    git clone --bare /tmp/B   B
    cd git-repo
    git remote add remote-git-branch B
    git fetch remote-git-branch
    git branch git-branch remotes/remote-git-branch

I want to do the git checkout in for example dir31 directory :

    cd dir3/dir31
    git checkout git-branch
-----------------------------------------------------------------------

How can I solve this problem ?
I've checked all 'git checkout' options but couldn't find anything ...

Thanks in advance

Alenoosh

--
View this message in context: http://git.661346.n2.nabble.com/git-checkout-in-a-subdirectory-tp6236473p6236473.html
Sent from the git mailing list archive at Nabble.com.
