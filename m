From: guruprasad <guruprasadkinI@gmail.com>
Subject: Re: Urgent: Issue with GIT ...
Date: Mon, 25 Jun 2012 05:55:25 -0700 (PDT)
Message-ID: <1340628925770-7562100.post@n2.nabble.com>
References: <1340624980925-7562097.post@n2.nabble.com> <20120625160734.d8227e5d.kostix@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 14:55:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj8pH-000245-9q
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 14:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681Ab2FYMz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 08:55:27 -0400
Received: from sam.nabble.com ([216.139.236.26]:35222 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756472Ab2FYMz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 08:55:26 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <guruprasadkinI@gmail.com>)
	id 1Sj8pB-000610-Pf
	for git@vger.kernel.org; Mon, 25 Jun 2012 05:55:25 -0700
In-Reply-To: <20120625160734.d8227e5d.kostix@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200575>

Firstly, I apologize for staring subject with "Urgent" and thank you very
much for your time and response.

As i told in my post earlier i am very much new to GIT, I was bit confused
with the tests i went on. I am sorry for not describing it clearly in my
last post. 

1) Pull command is working fine with both the Linux box. Comp A can pull
updates from comp B, vise versa.

2) Push command is not working with both Linux box, command given below.
       git push A master/git push B master

3) When i tried above command first time got an error saying 
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
remote: error:
remote: error: To squelch this message and still keep the default behaviour,
set
remote: error: 'receive.denyCurrentBranch' configuration variable to
'refuse'.
To user@A:/home/user/workspace/TestProject/.git
 ! [remote rejected] master -> master (branch is currently checked out)
error: failed to push some refs to
'user@A:/home/user/workspace/TestProject/.git'

so i added receive.denyCurrentBranch = ignore into git config and tried
again. I dint get any error.

4) But, modified things in files did not get reflected. i tried to push from
A-->B and B-->A. both dint work.
5) Push command i tried after modifying file, staging and committing.

Please let me know if more information is required.

Yes, I posted the same question to the git-users ML. Sorry for not
mentioning it in my post.

Thanks,
Guruprasad


--
View this message in context: http://git.661346.n2.nabble.com/Urgent-Issue-with-GIT-tp7562097p7562100.html
Sent from the git mailing list archive at Nabble.com.
