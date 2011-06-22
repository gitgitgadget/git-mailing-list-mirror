From: sandy2010 <sandeeptt@yahoo.com>
Subject: Migration from CVS to GIT - Multiple directories in CVS repo to a
 single Git repo
Date: Wed, 22 Jun 2011 02:06:31 -0700 (PDT)
Message-ID: <1308733591425-6503493.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 11:06:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZJOP-00014Q-FR
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 11:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab1FVJGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 05:06:33 -0400
Received: from sam.nabble.com ([216.139.236.26]:40337 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab1FVJGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 05:06:32 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <sandeeptt@yahoo.com>)
	id 1QZJOJ-0000Ax-Dy
	for git@vger.kernel.org; Wed, 22 Jun 2011 02:06:31 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176228>

Hello,

I'm aware of cvs2git and git fast-import utilities to do this. My
requirement is little different.
My CVS Repo is:
/cvs/BFARM

This consists of following directories:
Misc/suite1
Misc/suite2
Misc/suite3

Now, I want to Migrate the suite1 and suite2 into a single Git repo
"/git/Testsuites" and it should look like this:
/git/Testsuites/suite1
/git/Testsuites/suite2

How can I do this? I do not want to make suite1 and suite2 as separate git
repos.

Thanks.

--
View this message in context: http://git.661346.n2.nabble.com/Migration-from-CVS-to-GIT-Multiple-directories-in-CVS-repo-to-a-single-Git-repo-tp6503493p6503493.html
Sent from the git mailing list archive at Nabble.com.
