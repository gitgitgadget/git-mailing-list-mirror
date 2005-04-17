From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [5/5] Add commit-id to version
Date: Sun, 17 Apr 2005 11:37:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171135240.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 17:33:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNBmG-0004MZ-Ax
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVDQPhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVDQPhY
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:37:24 -0400
Received: from iabervon.org ([66.92.72.58]:15364 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261334AbVDQPhT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 11:37:19 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNBq5-0006bt-00; Sun, 17 Apr 2005 11:37:37 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

For people who run intermediate versions of git, it is useful to know
exactly which post-release version you've installed. This adds the
commit-id to the version info, so you can tell exactly, provided you make
sure to commit before installing.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 08f7700831e056ad710af69f91e3a8a705b6b2b1/Makefile  (mode:100644 sha1:a60fa46404c0487158d232bd021e4798bc8df8de)
+++ 6467ed39f19b48563ff25782ebe2c6f951b0af3c/Makefile  (mode:100644 sha1:0e84e3cd12f836602b420c197e08fabefe975493)
@@ -50,7 +50,7 @@
 	@echo Generating gitversion.sh...
 	@rm -f $@
 	@echo "#!/bin/sh" > $@
-	@echo "echo \"$(shell cat $(VERSION))\"" >> $@
+	@echo "echo \"$(shell cat $(VERSION)) $(shell commit-id)\"" >> $@
 	@chmod +x $@
 
 clean:

