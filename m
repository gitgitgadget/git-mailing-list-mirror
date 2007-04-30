From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Checklist clarifications: added "Commits", "Patch:" headings
Date: Mon, 30 Apr 2007 14:04:03 +0300
Organization: Private
Message-ID: <r6q2xgws.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 13:25:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiU0Y-0007dn-Q1
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 13:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030948AbXD3LX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 07:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031014AbXD3LX7
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 07:23:59 -0400
Received: from main.gmane.org ([80.91.229.2]:54530 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030948AbXD3LX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 07:23:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HiTnN-0007gT-Po
	for git@vger.kernel.org; Mon, 30 Apr 2007 13:11:53 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 13:11:53 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 13:11:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:AJhtUMKZuV686ODhKdOFEuI9fT0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45859>


Added email address and message 'Send your patch to...'

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/SubmittingPatches |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 2386f49..238d410 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -1,5 +1,7 @@
 Checklist (and a short version for the impatient):
 
+	Commits:
+
 	- make commits of logical units
 	- check for unnecessary whitespace with "git diff --check"
 	  before committing
@@ -12,8 +14,13 @@ Checklist (and a short version for the impatient):
 	  commit message (or just use the option "-s" when
 	  committing) to confirm that you agree to the Developer's
 	  Certificate of Origin
+
+	Patch:
+
+	- send your patch to <git@vger.kernel.org> by using
+	  git-format-patch(1) with option "-M". See also
+	  git-send-email(1).
 	- do not PGP sign your patch
-	- use "git format-patch -M" to create the patch
 	- do not attach your patch, but read in the mail
 	  body, unless you cannot teach your mailer to
 	  leave the formatting of the patch alone.
-- 
1.5.1.2.GIT
