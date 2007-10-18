From: "Evan Carroll" <me@evancarroll.com>
Subject: Application to install man pages.
Date: Thu, 18 Oct 2007 13:59:37 -0500
Message-ID: <428b865e0710181159i7a12f2b7y22619f0eaf36d2c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 20:59:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiab0-0005Xh-E8
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 20:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759000AbXJRS7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 14:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758990AbXJRS7j
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 14:59:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:36471 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758824AbXJRS7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 14:59:39 -0400
Received: by ug-out-1314.google.com with SMTP id z38so490777ugc
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 11:59:37 -0700 (PDT)
Received: by 10.66.243.4 with SMTP id q4mr2173508ugh.1192733977496;
        Thu, 18 Oct 2007 11:59:37 -0700 (PDT)
Received: by 10.67.96.11 with HTTP; Thu, 18 Oct 2007 11:59:37 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61556>

This is a one liner but might help for simply a quick install of the
git manpages.

>From f5797d786fd4a6f9633054bb0f0ce894a06d6650 Mon Sep 17 00:00:00 2001
From: root <root@x60s.(none)>
Date: Thu, 18 Oct 2007 13:45:16 -0500
Subject: [PATCH] install_man.sh script which installs the man pages

---
 install_man.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100755 install_man.sh

diff --git a/install_man.sh b/install_man.sh
new file mode 100755
index 0000000..b722425
--- /dev/null
+++ b/install_man.sh
@@ -0,0 +1,2 @@
+#/bin/sh
+ cp -R --copy-contents ./man* /usr/local/man
-- 
1.5.3.4.206.g58ba4


I was also wondering if it might be useful to have a command in the
master branch of the git repo that switches branches and installs the
man pages.. possibly as run in the makefile if .git exists then switch
branches, and run install_man.sh. Just an idea.

-- 
Evan Carroll
System Lord of the Internets
me@evancarroll.com
832-445-8877
