From: vra5107 <venkatram.akkineni@gmail.com>
Subject: Problems with HG to GIT coversion using hg-fast-export
Date: Sun, 6 Nov 2011 14:10:16 -0800 (PST)
Message-ID: <1320617416265-6968770.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 23:10:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNAv1-0006PS-E3
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 23:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab1KFWKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 17:10:17 -0500
Received: from sam.nabble.com ([216.139.236.26]:49769 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252Ab1KFWKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 17:10:17 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <venkatram.akkineni@gmail.com>)
	id 1RNAuu-0004n4-8n
	for git@vger.kernel.org; Sun, 06 Nov 2011 14:10:16 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184935>

Hi

               I am trying to convert a hg repo to git using HG fast export.
It is a fairly large repository with 4000 + commits. The problem is that the
repo has a few parentless children. hg-fast-export throws an error while
trying to convert the repo. 
I am able to proceed with conversion using --force option. Although, I am
not sure how well the conversion happened. 

I couldn't find a mailing list for hg-fast-export so I am posting this
question here hoping to find somebody who ran into a similar problem.
Attached to the post is the error I saw. 

*venkat@venkat-0358:/usr/src/gitrepo$ hg-fast-export -r
/usr/src/community-ruby/ --force Error: repository has at least one unnamed
head: hg r4336 Error: repository has at least one unnamed head: hg r4335
Error: repository has at least one unnamed head: hg r4334 Error: repository
has at least one unnamed head: hg r4333 Error: repository has at least one
unnamed head: hg r4332 Error: repository has at least one unnamed head: hg
r4331 Error: repository has at least one unnamed head: hg r4329 Error:
repository has at least one unnamed head: hg r4328 Error: repository has at
least one unnamed head: hg r4327 Error: repository has at least one unnamed
head: hg r4315 Error: repository has at least one unnamed head: hg r4308
Error: repository has at least one unnamed head: hg r4304 Error: repository
has at least one unnamed head: hg r4302 Error: repository has at least one
unnamed head: hg r4285 Error: repository has at least one unnamed head: hg
r4281 Error: repository has at least one unnamed head: hg r4280 Error:
repository has at least one unnamed head: hg r4279 Error: repository has at
least one unnamed head: hg r4275 Error: repository has at least one unnamed
head: hg r4256 Error: repository has at least one unnamed head: hg r4255
Error: repository has at least one unnamed head: hg r4253 Error: repository
has at least one unnamed head: hg r4250 Error: repository has at least one
unnamed head: hg r4249 Error: repository has at least one unnamed head: hg
r4248 Error: repository has at least one unnamed head: hg r4247 Error:
repository has at least one unnamed head: hg r4246 Error: repository has at
least one unnamed head: hg r4245 Error: repository has at least one unnamed
head: hg r4147 *

Thanks in advance
Venkat
 

--
View this message in context: http://git.661346.n2.nabble.com/Problems-with-HG-to-GIT-coversion-using-hg-fast-export-tp6968770p6968770.html
Sent from the git mailing list archive at Nabble.com.
