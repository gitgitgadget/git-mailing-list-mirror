From: "Stephen & Linda Smith" <ischis2@cox.net>
Subject: git svn hangs on a rebase or clone when presented with a large commit.
Date: Wed, 10 Feb 2010 18:25:41 -0700
Message-ID: <201002101825.41500.ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 02:33:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfNw7-0002H4-S1
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 02:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab0BKBdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 20:33:37 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:54579 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab0BKBdh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 20:33:37 -0500
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Feb 2010 20:33:37 EST
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.8.00.01.00 201-2244-105-20090324) with ESMTP
          id <20100211012445.QTPK19579.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Wed, 10 Feb 2010 20:24:45 -0500
Received: from thunderbird.smith.home ([70.190.153.17])
	by fed1rmimpo02.cox.net with bizsmtp
	id gRQl1d0050Nn4ZA04RQlRM; Wed, 10 Feb 2010 20:24:45 -0500
X-VR-Score: -30.00
X-Authority-Analysis: v=1.1 cv=zS9SgV63hfBKgCfMNmcWTXDxxMKGbBeTgNVRdCpsi3s=
 c=1 sm=1 a=7-wuF35vrpYA:10 a=rkXgBksUGZfaqPZcRv0v5g==:17
 a=2mF8TaH4Z5rtaIsaVksA:9 a=SBNjBVj0Rky45Up7CnW-GvGrHcMA:4
 a=rkXgBksUGZfaqPZcRv0v5g==:117
X-CM-Score: 0.00
Received: from thunderbird.localnet (thunderbird.smith.home [127.0.1.1])
	by thunderbird.smith.home (Postfix) with ESMTP id A7ED175A072
	for <git@vger.kernel.org>; Wed, 10 Feb 2010 18:25:41 -0700 (MST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139570>

I have to use git svn to pull from a subversion repository in a local git 
repository.  I don't have any local subversion repositories to debug the 
problem that I will describe below.

I do a git svn clone (or if I've already done a clone an git svn rebase) from 
the repository.   There is one particular subversion commit that is quite 
large  (revision 15300).   Anyway both the git svn clone  and the git svn 
rebase commands hang.

     ...  - r15259 - r15300 - r15301 - ...

I know there are commits in the subversion repoistory beyond the bad 
repository and I would like to be able do manually what git svn rebase would 
do with the commit and then be able to run git svn rebase to get revisions 
15301 and following.

Are the steps necessary to manually fetch 15300 so that I don't screw up 
future git svn rebase commands documented?
