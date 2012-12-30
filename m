From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: [PATCH 2/2] Provide better guidance for submitting patches against git-gui, gitk
Date: Sun, 30 Dec 2012 13:18:55 -0500
Message-ID: <1356891535-5647-3-git-send-email-jason.k.holden.swdev@gmail.com>
References: <1356891535-5647-1-git-send-email-jason.k.holden.swdev@gmail.com>
Cc: gitster@pobox.com, paulus@samba.org,
	patthoyts@users.sourceforge.net,
	Jason Holden <jason.k.holden.swdev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 19:20:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpNUe-0008Ru-R3
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 19:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab2L3STw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 13:19:52 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:41941 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab2L3STu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 13:19:50 -0500
Received: by mail-vc0-f176.google.com with SMTP id fo13so12235021vcb.35
        for <git@vger.kernel.org>; Sun, 30 Dec 2012 10:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4Zb2/shzXWgwZR4foO3Yk6kEW4jAkTUGnPQH8iZvZ18=;
        b=uU+F7RQkgeu38X3ylg0ASGUjLRfgiXuROLxHBO2f2BiUtU4IHMiXU3E3TEEWshP3iF
         SYDcXTCNQNnQHJGB8Bcfp3OzSqnceTTjHf/RK1Wm/HpQQgAAGuHBIMb7PDQkJo2CUeYn
         MpTWINx9P3dVtuf2vvNW2+Pta1SZLhauMGslWLHHGTqkZb+jCll6YHOwgTrwZUuSBsSH
         Cj9vDaYCVxAUdvpcA7EWtYrC7ygccgwlESoSEk/iMu7j66tNpWYh5DGu3Mvp3Qb01UJ/
         SfNT4njV5yGQA/0hpyNGpvFUkRMPIfw6pZ2hPTMx2uTdw/mVittgnV2Duw4YHRiLUXUx
         xlDA==
X-Received: by 10.58.168.135 with SMTP id zw7mr61546756veb.4.1356891589813;
        Sun, 30 Dec 2012 10:19:49 -0800 (PST)
Received: from rowblue.hsd1.nh.comcast.net (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id a10sm34079005vez.10.2012.12.30.10.19.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Dec 2012 10:19:49 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.28.g0ab5d1f
In-Reply-To: <1356891535-5647-1-git-send-email-jason.k.holden.swdev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212337>

git-gui and gitk are maintained upstream of git.  Document this, and the
procedure for submitting patches to these tools

Signed-off-by: Jason Holden <jason.k.holden.swdev@gmail.com>
---
 Documentation/SubmittingPatches | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 75935d5..b82d426 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -58,6 +58,17 @@ Checklist (and a short version for the impatient):
 	  please test it first by sending email to yourself.
 	- see below for instructions specific to your mailer
 
+	Improving the GUI's
+	- gitk and git-gui are maintained upstream of Git despite being 
+	  included in Git's git repository
+	- Patches should be made against the upstream gui repository, 
+	  and not against the version in Git's git repository
+	- The resulting patch should still be emailed for review
+	  to the git mailing list (git@vger.kernel.org), cc'ing the 
+	  applicable gui maintainer
+	- Please see the MAINTAINER's file for the gui maintainer's contact 
+	  information and canonical repository location
+
 Long version:
 
 I started reading over the SubmittingPatches document for Linux
-- 
1.8.1.rc3.28.g0ab5d1f
