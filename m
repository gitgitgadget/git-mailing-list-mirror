From: mav007ar <mav007ar@yahoo.com.ar>
Subject: Problem with git bundle.
Date: Wed, 30 Mar 2011 05:36:31 -0700 (PDT)
Message-ID: <1301488591248-6222619.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 14:36:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4udY-0002Z6-9t
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 14:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab1C3Mgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 08:36:31 -0400
Received: from sam.nabble.com ([216.139.236.26]:56806 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798Ab1C3Mgb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 08:36:31 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <mav007ar@yahoo.com.ar>)
	id 1Q4udT-0007v8-8K
	for git@vger.kernel.org; Wed, 30 Mar 2011 05:36:31 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170379>

Hi everyone. I am using git-svn and I want transfer a repository using git
bundle create ...
Does anyone has the right steps to perform this task?
Currently I'm doing the following.

1- git bundle create  --all
2- git clone 
3- cd into repository's directory just created.
4- Add [svn-remote "svn"]
        url = https://svn.swacorp.com/svn/commerce/trunk/commerce-project
        fetch = :refs/remotes/git-svn
into the .git/config file.
5- git svn fetch svn.

The problem is when I do the last step, I get ALL revisions with out
considering the revision included into the bundle.

Someone can help me?

Thanks in advance


--
View this message in context: http://git.661346.n2.nabble.com/Problem-with-git-bundle-tp6222619p6222619.html
Sent from the git mailing list archive at Nabble.com.
