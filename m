From: supadhyay <supadhyay@imany.com>
Subject: Re: how to clone/checkout branch/tag vesion from GIT repository
Date: Sat, 12 May 2012 03:26:32 -0700 (PDT)
Message-ID: <1336818392259-7553161.post@n2.nabble.com>
References: <1336657187852-7546744.post@n2.nabble.com> <20120510135605.GA1495@sigill.intra.peff.net> <49A2AA38871E7B41841AA7D659D626A62E2098A2@njexch01.imany.com> <20120510143911.GB14711@sigill.intra.peff.net> <1336740319206-7550370.post@n2.nabble.com> <20120511172214.GC26916@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 12:26:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST9X5-0001nZ-21
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 12:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188Ab2ELK0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 06:26:34 -0400
Received: from sam.nabble.com ([216.139.236.26]:33931 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748Ab2ELK0d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 06:26:33 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <supadhyay@imany.com>)
	id 1ST9Wy-0007EJ-8g
	for git@vger.kernel.org; Sat, 12 May 2012 03:26:32 -0700
In-Reply-To: <20120511172214.GC26916@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197718>

Hi Jeff,

I follow below steps to do clone from git to gitolite (I did the cvs2git
migration of individual repository successfully).

1- login to gitolite user and  add repository entry in to gitolite.conf file
and do add,commit and push.  In push operation output it shows the path of
the repository.

2- from gitolite_home I run below command
git clone ssh://git@mygitserver.com/ora/data/test.git
(tis is do the clone of my repository so I can see the actual data inside
the repository)

3- then cd to test and push all the changes ;
git push --all gitolite@mygitserver.com:test

4- push all tags also;
git push --tags gitolite@mygitserver.com:test


5- lastly do the clone of test repository to my workstation using tortoise
git tool;
ssh://gitolite@mygitserver/test



Please guide me if anything missing or needs to add.

Thanks.


--
View this message in context: http://git.661346.n2.nabble.com/how-to-clone-checkout-branch-tag-vesion-from-GIT-repository-tp7546744p7553161.html
Sent from the git mailing list archive at Nabble.com.
