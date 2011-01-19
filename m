From: julia <deborave@gmail.com>
Subject: Opinions on my GIT model
Date: Wed, 19 Jan 2011 11:33:55 -0800 (PST)
Message-ID: <1295465635148-5941048.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 20:34:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfdn8-0000KC-0u
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab1ASTd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:33:56 -0500
Received: from sam.nabble.com ([216.139.236.26]:33042 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977Ab1ASTd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 14:33:56 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <deborave@gmail.com>)
	id 1Pfdn1-0005h4-59
	for git@vger.kernel.org; Wed, 19 Jan 2011 11:33:55 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165283>


Hi All,

Working on a GIT model for my projects.

1.  Three main repositories, bare public repo, maintainer repo, developer
repo
2.  Developer1 clones the public repo and makes feature1 branch, updates,
commits changes and pulls/pushes.
3.  Developer2 on their local repo does the same thing and pushes updates.
4.  Maintainer get the green light to rebase feature1 branch with master -
they pull the whole repo, rebase the feature1 branch with master and then
push feature1.
5.  Developer1 pulls feature1 brach again and continues to work, does a
pull/push to feature1 on public repo.

Now, main question is - given that in step 4 maintainer rebase the feature
branch with master then pushed, he is committing a cardinal sin by rebasing
a branch that has already been pushed to the public repo, so if anyone has
made any changes based on the commits originally pushed that now have been
rebased - developer who tries to push those changes will have issues.

Will these be solved by executing of a pull? 

Sorry if these are trivial questions...still trying to wrap my head around
GIT.

Thank you for your help.

Cheers,

Julia
-- 
View this message in context: http://git.661346.n2.nabble.com/Opinions-on-my-GIT-model-tp5941048p5941048.html
Sent from the git mailing list archive at Nabble.com.
