From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] shell: Document that 'cvs server' is a valid command
Date: Mon, 19 Jan 2009 18:06:43 +0100
Message-ID: <1232384803-29373-1-git-send-email-lars@public.noschinski.de>
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 18:38:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOy4m-0005Wd-7X
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 18:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbZASRgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 12:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbZASRgr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 12:36:47 -0500
Received: from mta-1.ms.rz.RWTH-Aachen.DE ([134.130.7.72]:33898 "EHLO
	mta-1.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752284AbZASRgq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 12:36:46 -0500
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2009 12:36:46 EST
Received: from ironport-out-1.rz.rwth-aachen.de ([134.130.5.40])
 by mta-1.ms.rz.RWTH-Aachen.de
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008))
 with ESMTP id <0KDQ005RNA77VVD0@mta-1.ms.rz.RWTH-Aachen.de> for
 git@vger.kernel.org; Mon, 19 Jan 2009 18:06:43 +0100 (CET)
X-IronPort-AV: E=Sophos;i="4.37,290,1231110000";   d="scan'208";a="97145229"
Received: from smarthost-1.ms.rz.rwth-aachen.de (HELO smarthost.rwth-aachen.de)
 ([134.130.7.89]) by ironport-in-1.rz.rwth-aachen.de with ESMTP; Mon,
 19 Jan 2009 18:06:43 +0100
Received: from aprove.informatik.rwth-aachen.de
 (aprove.informatik.RWTH-Aachen.DE [137.226.194.201])
	by smarthost.rwth-aachen.de (8.13.8+Sun/8.13.8/1)
 with ESMTP id n0JH6gq8009028; Mon, 19 Jan 2009 18:06:43 +0100 (CET)
Received: by aprove.informatik.rwth-aachen.de (Postfix, from userid 1030)
	id 2F29A11B7C7; Mon, 19 Jan 2009 18:06:43 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106370>

git-shell's man page explicitly lists all allowed commands, but 'cvs
server' was missing. Add it.

Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 Documentation/git-shell.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index ff420f8..3f8d973 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -18,8 +18,9 @@ of server-side GIT commands implementing the pull/push functionality.
 The commands can be executed only by the '-c' option; the shell is not
 interactive.
 
-Currently, only the 'git-receive-pack' and 'git-upload-pack' commands
-are permitted to be called, with a single required argument.
+Currently, only three commands are permitted to be called, 'git-receive-pack'
+'git-upload-pack' with a single required argument or 'cvs server' (to invoke
+'git-cvsserver').
 
 Author
 ------
-- 
1.6.0.6
