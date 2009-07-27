From: Johan Herland <johan@herland.net>
Subject: [RFC 07/11] Preliminary clarifications to git-vcs documentation
Date: Mon, 27 Jul 2009 03:04:15 +0200
Message-ID: <1248656659-21415-8-git-send-email-johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 03:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVEfU-0004JH-6w
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 03:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbZG0BFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 21:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbZG0BFs
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 21:05:48 -0400
Received: from mx.getmail.no ([84.208.15.66]:47216 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755460AbZG0BFp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 21:05:45 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF00L2B1PL7K70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:45 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF004SX1O2UG30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:45 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.27.5416
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1248656659-21415-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124149>

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-vcs.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-vcs.txt b/Documentation/git-vcs.txt
index 402c927..febe415 100644
--- a/Documentation/git-vcs.txt
+++ b/Documentation/git-vcs.txt
@@ -22,13 +22,15 @@ capabilities (limited both by the particular helper and by the
 capabilities of the system they connect to), and they report what
 capabilities they support.
 
-These programs can store refs in refs/<system>/*, and arbitrary
-information in info/<system>.
+These programs can store refs in refs/<system>/*, note refs in
+refs/notes/<system>/*, and arbitrary information in info/<system>/*.
 
 COMMANDS
 --------
 
 Commands are given by the caller on the helper's standard input, one per line.
+The output of each command must be produced on the helper's standard output.
+The helper's standard error stream can be used for status/progress messages.
 
 'capabilities'::
 	Outputs a single line with a list of feature names separated
@@ -45,6 +47,7 @@ Commands are given by the caller on the helper's standard input, one per line.
 	operations, such as importing the content, to see whether it
 	matches.) Other information, not yet supported, may be output
 	as well, separated by single spaces.
+	The output list shall be terminated with a blank line.
 
 'import' ref::
 	Imports the given ref by outputting it in git-fast-import
-- 
1.6.4.rc3.138.ga6b98.dirty
