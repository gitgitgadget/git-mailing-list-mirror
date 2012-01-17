From: Asuka <c.bauers@gmx.de>
Subject: How to migrate a complex directory structure from SVN to GIT?
Date: Tue, 17 Jan 2012 11:33:57 -0800 (PST)
Message-ID: <1326828837924-7197567.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 20:34:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnEnD-0004qS-Ey
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 20:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904Ab2AQTd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 14:33:59 -0500
Received: from sam.nabble.com ([216.139.236.26]:49620 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118Ab2AQTd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 14:33:58 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <c.bauers@gmx.de>)
	id 1RnEn7-00038P-U3
	for git@vger.kernel.org; Tue, 17 Jan 2012 11:33:57 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188715>

Hi there,

I would like to migrate my svn repository to git. The structure looks like
the following:

svn
   |_Project1
         |_subproject1
               |_branches
                      |_branch1
                      |_branch2
               |_trunk
               |_tags
                      |_tagv1
   |_Non-JavaProject
         |_subproject
   |_Project2
          |_AnotherSubproject
               |_SubSubproject
          |_Subproject2
               |_branches
               |_tags
          |_Subproject3
               |_trunk
          |_Subproject4
               |_Subsubproject
                       |_branches
                       |_tags
                       |_trunk

I would like to migrate all branches and tags .. but unfortunately sometimes
I have just a trunk directory and no branches or tags directory. Sometimes
the branches are in a subdirectory, sometimes in a subsubdirectory. So how
can migrate my svn in an efficient way?

Thanks in advance
Best wishes

--
View this message in context: http://git.661346.n2.nabble.com/How-to-migrate-a-complex-directory-structure-from-SVN-to-GIT-tp7197567p7197567.html
Sent from the git mailing list archive at Nabble.com.
