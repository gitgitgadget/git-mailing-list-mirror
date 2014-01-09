From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 0/6] Make 'git help everyday' work
Date: Thu,  9 Jan 2014 23:13:06 +0000
Message-ID: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 10 00:13:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1Omo-0003rV-DC
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 00:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977AbaAIXNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 18:13:01 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:40221 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752633AbaAIXM5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 18:12:57 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AngGAPwrz1JOl3JU/2dsb2JhbABZgwsBgzmvaIg/F3SDAjuBAiSIG5kjqgMXjiGFIgSqLIMtPIEs
X-IPAS-Result: AngGAPwrz1JOl3JU/2dsb2JhbABZgwsBgzmvaIg/F3SDAjuBAiSIG5kjqgMXjiGFIgSqLIMtPIEs
X-IronPort-AV: E=Sophos;i="4.95,634,1384300800"; 
   d="scan'208";a="450940693"
Received: from host-78-151-114-84.as13285.net (HELO localhost) ([78.151.114.84])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 09 Jan 2014 23:12:55 +0000
X-Mailer: git-send-email 1.8.3.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240286>

The "Everyday GIT With 20 Commands Or So" guide is not accessible via the git help system. Fix that.

The git everyday file does not use the appropriate filenaming convention for help files, and is not suitably formatted for display as a man page.

First copy everyday.txt to giteveryday.txt
Second modify giteveryday to fit man page formatting. Include the standard Git footer.
Third add giteveryday to the manpages make list.
Fourth add deprecation note to older everday.txt. Include link to new man page.
Fifth add 'everyday' to the help --guides list.
Finally, update the git(1) link.

The series could be squashed together once any foible have been eliminated.

Philip Oakley (6):
  copy everyday.txt to giteveryday.txt
  Update giteveryday.txt to fit man page formatting
  add giteveryday to the manpages make list
  Add deprecation note to old everyday.txt
  add 'everyday' to the help --guides list
  Update git(1) link to giteveryday

 Documentation/Makefile        |   1 +
 Documentation/everyday.txt    |   4 +
 Documentation/git.txt         |   2 +-
 Documentation/giteveryday.txt | 428 ++++++++++++++++++++++++++++++++++++++++++
 builtin/help.c                |   1 +
 5 files changed, 435 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/giteveryday.txt

-- 
1.8.3.msysgit.0
