From: jhapk <pradeep.kumar.jha@gmail.com>
Subject: Deleting branches
Date: Fri, 26 Mar 2010 06:41:20 -0800 (PST)
Message-ID: <1269614480145-4804268.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 15:41:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvAj2-0004PB-JF
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 15:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852Ab0CZOlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 10:41:22 -0400
Received: from kuber.nabble.com ([216.139.236.158]:50950 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab0CZOlV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 10:41:21 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <pradeep.kumar.jha@gmail.com>)
	id 1NvAiu-0007SR-6K
	for git@vger.kernel.org; Fri, 26 Mar 2010 07:41:20 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143232>


Hi,
I wanted to see the all the branches of a remote repository and so in my
.git/config file I had something like
[remote "jeff"]
        url = /nfs/kris/d1/people/jeff/cffc
        fetch = +refs/heads/*:refs/remotes/jeff/*

But then I decided that I only need to see one particular_branch and I
changed it to
[remote "jeff"]
        url = /nfs/kris/d1/people/jeff/cffc
        fetch =
+refs/heads/particular_branch:refs/remotes/jeff/particular_branch

But even now, when I do a $git branch -a, I see this
[pradeep@scaramanga cffc]$ git branch -a
  jeff
  master
* work
  jeff/local
  jeff/master
  jeff/particular_branch
  origin/HEAD
  origin/master
  origin/work

Why am I still getting the other jeff branches in my list and how do I
delete them?
THanks
-- 
View this message in context: http://n2.nabble.com/Deleting-branches-tp4804268p4804268.html
Sent from the git mailing list archive at Nabble.com.
