From: Paul Witt <paul.witt@oxix.org>
Subject: glossary doc correction
Date: Fri, 12 Jan 2007 15:11:33 +0000
Message-ID: <20070112151133.GA29908@v-svr-deb.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 12 16:44:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5OZd-0006eE-3z
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 16:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbXALPoG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 10:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbXALPoG
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 10:44:06 -0500
Received: from v-svr-deb.vm.bytemark.co.uk ([80.68.95.141]:3078 "EHLO
	v-svr-deb.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932123AbXALPoF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jan 2007 10:44:05 -0500
X-Greylist: delayed 1950 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 10:44:05 EST
Received: by v-svr-deb.vm.bytemark.co.uk (Postfix, from userid 1001)
	id 541A914066; Fri, 12 Jan 2007 15:11:33 +0000 (GMT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36679>

Hi,

In the glossary, the second example given in the definition of 
"refspec" seems to have its wording a bit confused.  I've pasted 
a one line patch into this mail.

  Paul.


diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index cd61aa2..6202148 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -259,7 +259,7 @@ refspec::
        means "grab the master branch head from the $URL and store
        it as my origin branch head".
        And `git push $URL refs/heads/master:refs/heads/to-upstream`
-       means "publish my master branch head as to-upstream master head
+       means "publish my master branch head as to-upstream branch head
        at $URL".   See also gitlink:git-push[1]

 repository::
