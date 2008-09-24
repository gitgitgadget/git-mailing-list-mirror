From: Garry Dolley <gdolley@ucla.edu>
Subject: [PATCH] Fixed some grammatical errors in git-rebase.txt documentation.
Date: Wed, 24 Sep 2008 02:51:27 -0700
Message-ID: <1222249887-11793-1-git-send-email-gdolley@ucla.edu>
Cc: Garry Dolley <gdolley@ucla.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 11:52:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiR32-0000fo-2Y
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 11:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbYIXJva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 05:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbYIXJva
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 05:51:30 -0400
Received: from mail.arpnetworks.com ([205.134.237.79]:41758 "HELO
	penguin.filetron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751545AbYIXJva (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 05:51:30 -0400
Received: (qmail 20985 invoked from network); 24 Sep 2008 09:49:36 -0000
Received: from cpe-98-151-11-125.socal.res.rr.com (HELO garry-thinkpad) (gdolley@arpnetworks.com@98.151.11.125)
  by mail.arpnetworks.com with SMTP; 24 Sep 2008 09:49:36 -0000
Received: by garry-thinkpad (sSMTP sendmail emulation); Wed, 24 Sep 2008 02:51:27 -0700
X-Mailer: git-send-email 1.6.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96627>

Generally, the dependent clause "for example" is suffixed with a comma.
Used present tense where appropriate to be consistent with the other
paragraphs.

Rewrote the paragraph in the second hunk to be more clear.

Signed-off-by: Garry Dolley <gdolley@ucla.edu>
---
 Documentation/git-rebase.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 59c1b02..32f0f12 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -92,7 +92,7 @@ branch to another, to pretend that you forked the topic branch
 from the latter branch, using `rebase --onto`.
 
 First let's assume your 'topic' is based on branch 'next'.
-For example feature developed in 'topic' depends on some
+For example, a feature developed in 'topic' depends on some
 functionality which is found in 'next'.
 
 ------------
@@ -103,9 +103,9 @@ functionality which is found in 'next'.
                             o---o---o  topic
 ------------
 
-We would want to make 'topic' forked from branch 'master',
-for example because the functionality 'topic' branch depend on
-got merged into more stable 'master' branch, like this:
+We want to make 'topic' forked from branch 'master'; for example,
+because the functionality on which 'topic' depends was merged into the
+more stable 'master' branch. We want our tree to look like this:
 
 ------------
     o---o---o---o---o  master
-- 
1.6.0.1
