From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH/RFC 3/4] git-shell-commands: Add a help command
Date: Tue, 13 Jul 2010 23:01:14 -0400
Message-ID: <1279076475-27730-4-git-send-email-gdb@mit.edu>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Greg Brockman <gdb@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 05:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYsJ3-0001Rj-UA
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 05:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557Ab0GNDGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 23:06:43 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:57585 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751137Ab0GNDGl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 23:06:41 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jul 2010 23:06:41 EDT
X-AuditID: 1209190c-b7c34ae000000a06-9b-4c3d2894173a
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id E7.ED.02566.4982D3C4; Tue, 13 Jul 2010 23:01:40 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o6E31dHw030242;
	Tue, 13 Jul 2010 23:01:40 -0400
Received: from localhost (EASTCAMPUS-NINE-NINETY-FOUR.MIT.EDU [18.238.6.227])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6E31doe005139;
	Tue, 13 Jul 2010 23:01:39 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1279076475-27730-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150960>

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 git-shell-commands/help |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)
 create mode 100755 git-shell-commands/help

diff --git a/git-shell-commands/help b/git-shell-commands/help
new file mode 100755
index 0000000..a6b1a68
--- /dev/null
+++ b/git-shell-commands/help
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+echo "Commands you may want to run by hand:"
+ls
+if tty -s; then
+    echo "You can leave by running 'exit'"
+fi
-- 
1.7.0.4
