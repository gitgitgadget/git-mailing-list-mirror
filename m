From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] Document git-check-attr
Date: Sat, 14 Apr 2007 21:27:20 -0400
Message-ID: <117660044024-git-send-email-jbowes@dangerouslyinc.com>
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Apr 15 03:31:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HctaW-0004we-GW
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 03:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbXDOBbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 21:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbXDOBbK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 21:31:10 -0400
Received: from ms-smtp-01.southeast.rr.com ([24.25.9.100]:51576 "EHLO
	ms-smtp-01.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751951AbXDOBbJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2007 21:31:09 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-01.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l3F1V71T025134;
	Sat, 14 Apr 2007 21:31:07 -0400 (EDT)
X-Mailer: git-send-email 1.5.1.1.824.gcdc9-dirty
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44479>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 Documentation/cmd-list.perl      |    1 +
 Documentation/git-check-attr.txt |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-check-attr.txt

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 0381590..443802a 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -84,6 +84,7 @@ git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-checkout-index                      plumbingmanipulators
 git-checkout                            mainporcelain
+git-check-attr                          purehelpers
 git-check-ref-format                    purehelpers
 git-cherry                              ancillaryinterrogators
 git-cherry-pick                         mainporcelain
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
new file mode 100644
index 0000000..ceb5195
--- /dev/null
+++ b/Documentation/git-check-attr.txt
@@ -0,0 +1,37 @@
+git-check-attr(1)
+=================
+
+NAME
+----
+git-check-attr - Display gitattributes information.
+
+
+SYNOPSIS
+--------
+'git-check-attr' attr... [--] pathname...
+
+DESCRIPTION
+-----------
+For every pathname, this command will list if each attr is 'unspecified',
+'set', or 'unset' as a gitattribute on that pathname.
+
+OPTIONS
+-------
+\--::
+	Interpret all preceding arguments as attributes, and all following
+	arguments as path names. If not supplied, only the first argument will
+	be treated as an attribute.
+
+
+Author
+------
+Written by Junio C Hamano <junkio@cox.net>
+
+Documentation
+--------------
+Documentation by James Bowes.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
-- 
1.5.1.1.824.gcdc9-dirty
