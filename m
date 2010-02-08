From: Greg Bacon <gbacon@dbresearch.net>
Subject: [PATCH] Documentation: git-add: correct first example
Date: Mon,  8 Feb 2010 11:35:51 -0600
Message-ID: <1265650551-32664-1-git-send-email-gbacon@dbresearch.net>
Cc: gitster@pobox.com, Greg Bacon <gbacon@dbresearch.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 18:44:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeXfF-0007YD-SO
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 18:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620Ab0BHRop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 12:44:45 -0500
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:50523 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab0BHRoo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 12:44:44 -0500
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2010 12:44:44 EST
Received: from relay2.r2.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id CC3B644C0E5;
	Mon,  8 Feb 2010 12:36:16 -0500 (EST)
Received: by relay2.r2.iad.emailsrvr.com (Authenticated sender: gbacon-AT-dbresearch.net) with ESMTPSA id 7A37B44C02B;
	Mon,  8 Feb 2010 12:36:16 -0500 (EST)
X-Mailer: git-send-email 1.6.5.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139302>

The first example for git-add covers recursive adding of patterns but
contains an extra backslash. If copied verbatim, the command fails
with

fatal: pathspec 'Documentation/\*.txt' did not match any files

This patch corrects the problem and adds an equivalent invocation.

Signed-off-by: Greg Bacon <gbacon@dbresearch.net>
---
 Documentation/git-add.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index f74fcf3..93e8f57 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -149,11 +149,12 @@ those in info/exclude.  See linkgit:gitrepository-layout[5].
 EXAMPLES
 --------
 
-* Adds content from all `\*.txt` files under `Documentation` directory
+* Adds content from all `*.txt` files under `Documentation` directory
 and its subdirectories:
 +
 ------------
-$ git add Documentation/\\*.txt
+$ git add Documentation/\*.txt
+$ git add 'Documentation/*.txt'  # same thing
 ------------
 +
 Note that the asterisk `\*` is quoted from the shell in this
-- 
1.6.5.5
