From: Jack Moore <jhmoore719@verizon.net>
Subject: git-svn clone -- runs out of memory
Date: Tue, 18 May 2010 22:51:27 -0700
Message-ID: <F47FB1C2-3EEB-475C-8874-CBEC45582386@verizon.net>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jack Moore <jhmoore719@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 19 07:51:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEcC1-0000nu-80
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 07:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605Ab0ESFvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 01:51:39 -0400
Received: from vms173017pub.verizon.net ([206.46.173.17]:33829 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab0ESFvi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 May 2010 01:51:38 -0400
Received: from [192.168.1.102] ([unknown] [173.58.219.82])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2N002UJK9RIX70@vms173017.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 19 May 2010 00:51:28 -0500 (CDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147318>

I'm trying to transition from subversion to git.  I have a very poorly structured subversion repository.  It has multiple (dozens) copies of many (thousands) of binary files that don't change from version to version.  When I "git-svn clone" the repository it takes about 30 hour (yes hours)  to (appears to) retrieve the files.  Then git goes into either a packing or garbage collecting phase and eventually runs out of memory.  I get an error relating to "mmap ... out of memory".  When it runs out of memory the "cloned" repository is ~2.4 GBi.

I don't know what files it's failing on.  I've tried excluding the directories that contain the binary files.  Does anyone have suggestions on isolating the problem or working around the memory limitation?

Thanks
Jack