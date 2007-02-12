From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PATCH] Add note about needing to do 'git checkout -f master'.
Date: Mon, 12 Feb 2007 17:49:41 +0000
Message-ID: <25613.923095125$1171381513@news.gmane.org>
Cc: Richard Jones <rjones@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 16:45:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGzpx-0004b1-HA
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 16:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbXBMPoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 10:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbXBMPoz
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 10:44:55 -0500
Received: from 87-127-66-208.no-dns-yet.enta.net ([87.127.66.208]:41806 "EHLO
	oirase.home.annexia.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbXBMPox (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 10:44:53 -0500
X-Greylist: delayed 3599 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Feb 2007 10:44:36 EST
Received: from oirase.home.annexia.org (localhost [127.0.0.1])
	by oirase.home.annexia.org (8.13.8/8.13.8) with ESMTP id l1CHnfio016989;
	Mon, 12 Feb 2007 17:49:42 GMT
Received: (from rjones@localhost)
	by oirase.home.annexia.org (8.13.8/8.13.8/Submit) id l1CHnfAx016988;
	Mon, 12 Feb 2007 17:49:41 GMT
X-Mailer: git-send-email 1.4.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39537>

From: Richard Jones <rjones@redhat.com>

---
 Documentation/git-cvsimport.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index f5450de..7b43ed4 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -138,6 +138,12 @@ If '-v' is specified, the script reports what it is doing.
 Otherwise, success is indicated the Unix way, i.e. by simply exiting with
 a zero exit status.
 
+NOTES
+-----
+If importing for the first time into a directory (-C option),
+after the import do 'git checkout -f master' in the new
+directory.
+
 
 Author
 ------
-- 
1.4.4.2
