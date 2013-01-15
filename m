From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 08/14] git p4 doc: fix branch detection example
Date: Mon, 14 Jan 2013 19:47:02 -0500
Message-ID: <1358210828-2369-9-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:50:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuujF-0002J7-LH
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235Ab3AOAtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:49:53 -0500
Received: from honk.padd.com ([74.3.171.149]:52479 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757217Ab3AOAtx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:49:53 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id D03292F3F;
	Mon, 14 Jan 2013 16:49:52 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4FCB528EC2; Mon, 14 Jan 2013 19:49:49 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213559>

Make sure that the example on how to use git-p4.branchList
works if typed directly.  In particular, it does not make sense
to set a config variable until the git repository has been
initialized.

Reported-by: Olivier Delalleau <shish@keba.be>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 2623bee..7c5230e 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -393,8 +393,10 @@ the path elements in the p4 repository.  The example above relied on the
 presence of the p4 branch.  Without p4 branches, the same result will
 occur with:
 ----
+git init depot
+cd depot
 git config git-p4.branchList main:branch1
-git p4 clone --detect-branches //depot@all
+git p4 clone --detect-branches //depot@all .
 ----
 
 
-- 
1.8.1.350.gdbf6fd0
