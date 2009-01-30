From: David Mann <mannd@epstudiossoftware.com>
Subject: question re dcommit problem
Date: Thu, 29 Jan 2009 19:14:08 -0500
Message-ID: <49824650.2070209@epstudiossoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 01:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSh2o-0008Iu-MS
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 01:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099AbZA3AOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 19:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757417AbZA3AOO
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 19:14:14 -0500
Received: from mxsf04.insightbb.com ([74.128.0.74]:45716 "EHLO
	mxsf04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599AbZA3AON (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 19:14:13 -0500
X-IronPort-AV: E=Sophos;i="4.37,347,1231131600"; 
   d="scan'208";a="579339453"
Received: from unknown (HELO asav00.insightbb.com) ([172.31.249.123])
  by mxsf04.insightbb.com with ESMTP; 29 Jan 2009 19:14:09 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvQAAI/VgUlKgLqc/2dsb2JhbAAIy0SEEAY
X-IronPort-AV: E=Sophos;i="4.37,347,1231131600"; 
   d="scan'208";a="68991005"
Received: from 74-128-186-156.dhcp.insightbb.com (HELO [192.168.1.33]) ([74.128.186.156])
  by asav00.insightbb.com with ESMTP; 29 Jan 2009 19:14:09 -0500
User-Agent: Thunderbird 2.0.0.19 (X11/20081227)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107756>

I created a git repository from my svn repository, later uploaded it to
GitHub, and after some branching and merging, can no longer dcommit back
to the svn repository.  I notice that somewhere along the way the
git-svn-id: messages no longer appear on my master branch.  When I try
to git svn dcommit I get weird messages like this:

mannd@SuperSluggo:~/dev/git/epsimulator> git svn dcommit
Committing to
https://epsimulator.svn.sourceforge.net/svnroot/epsimulator/epsimulator/trunk
...
Filesystem has no item: File not found: transaction '435-24', path
'/epsimulator/trunk/epsimulator.kdevses' at
/home/mannd/libexec/git-core/git-svn line 480

Any way to fix this?  If not, I will just abandon SVN and stick with
git, which I really enjoy using.

Thanks,
David Mann
