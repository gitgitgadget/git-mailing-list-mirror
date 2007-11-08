From: Sergei Organov <osv@javad.com>
Subject: [PATCH] SubmittingPatches: improve the 'Patch:' section of the checklist
Date: Thu, 08 Nov 2007 19:40:25 +0300
Message-ID: <87ve8c7ksm.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 17:41:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqARb-0006R7-OP
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 17:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875AbXKHQki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 11:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760962AbXKHQkh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 11:40:37 -0500
Received: from javad.com ([216.122.176.236]:1303 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758748AbXKHQkh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 11:40:37 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA8GeW038989;
	Thu, 8 Nov 2007 16:40:32 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IqAQb-00026w-F8; Thu, 08 Nov 2007 19:40:25 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64052>


There were 2 items "send patch to..." but having different set of
addresses to send patch to. Merge them together and move the resulting
item to the end of checklist.

Signed-off-by: Sergei Organov <osv@javad.com>
---
 Documentation/SubmittingPatches |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 61635bf..83bf54c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -20,9 +20,6 @@ Checklist (and a short version for the impatient):
 	Patch:
 
 	- use "git format-patch -M" to create the patch
-	- send your patch to <git@vger.kernel.org>. If you use
-	  git-send-email(1), please test it first by sending
-	  email to yourself.
 	- do not PGP sign your patch
 	- do not attach your patch, but read in the mail
 	  body, unless you cannot teach your mailer to
@@ -31,13 +28,15 @@ Checklist (and a short version for the impatient):
 	  corrupt whitespaces.
 	- provide additional information (which is unsuitable for
 	  the commit message) between the "---" and the diffstat
-	- send the patch to the list (git@vger.kernel.org) and the
-	  maintainer (gitster@pobox.com).
 	- if you change, add, or remove a command line option or
 	  make some other user interface change, the associated
 	  documentation should be updated as well.
 	- if your name is not writable in ASCII, make sure that
 	  you send off a message in the correct encoding.
+	- send the patch to the list (git@vger.kernel.org) and the
+	  maintainer (gitster@pobox.com). If you use
+	  git-send-email(1), please test it first by sending
+	  email to yourself.
 
 Long version:
 
-- 
1.5.3.5.529.ge3d6d
