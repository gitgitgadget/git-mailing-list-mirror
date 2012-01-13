From: ruperty <rupert@moonsit.co.uk>
Subject: Commit changes to remote repository
Date: Fri, 13 Jan 2012 12:29:49 -0800 (PST)
Message-ID: <1326486589088-7185551.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 21:29:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlnl6-0005Rb-HQ
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 21:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab2AMU3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 15:29:51 -0500
Received: from sam.nabble.com ([216.139.236.26]:33379 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800Ab2AMU3v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2012 15:29:51 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <rupert@moonsit.co.uk>)
	id 1Rlnkz-0003Uc-49
	for git@vger.kernel.org; Fri, 13 Jan 2012 12:29:49 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188538>

Being new to git I am probably not doing things correctly so pointers in the
right direction would be useful.

What I want to do make changes on my laptop and commit them to a remote
repository. Here is what I have done,

1. Created a repository on my remote linux host, in a folder of cource code,
by,

   git init
   git add *
   git commit

2. On my laptop I did a git clone pointing by ssh to the remote repo which
downloaded all the files to my local system.

3. I changed a file locally and did a commit.

4. I then wanted to update the remote repo with my change, which I did with
a git push, but that didn't work, getting this error,

    remote: error: refusing to update checked out branch:
refs/heads/master[K
    remote: error: By default, updating the current branch in a non-bare
repository[K.......


What am I doing wrong?

I was following the tutorial at
http://book.git-scm.com/3_distributed_workflows.html

I did search for this issue in this list but didn't understand the
responses.

Rupert


--
View this message in context: http://git.661346.n2.nabble.com/Commit-changes-to-remote-repository-tp7185551p7185551.html
Sent from the git mailing list archive at Nabble.com.
