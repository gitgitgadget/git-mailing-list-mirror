From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH] Fix typesetting in Bugs section of 'git-rebase' man page (web version)
Date: Tue, 19 Nov 2013 19:14:43 -0500
Message-ID: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 01:15:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VivRb-00088w-28
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 01:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab3KTAOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 19:14:54 -0500
Received: from mailhub129.itcs.purdue.edu ([128.210.5.129]:45378 "EHLO
	mailhub129.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753288Ab3KTAOy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Nov 2013 19:14:54 -0500
Received: from megahurtz.itap.purdue.edu (pal-nat184-049-011.itap.purdue.edu [10.184.49.11])
	(authenticated bits=0)
	by mailhub129.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAK0EkpE000480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 19 Nov 2013 19:14:52 -0500
X-Mailer: git-send-email 1.8.4.2
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238056>

Documentation/git-rebase.txt: add a blank line after the two AsciiDoc
    listing blocks

Without these blank lines, AsciiDoc thinks the opening "-----" is a
section heading and typesets the word "to" as such, which causes
cascading formatting/typesetting issues until the end of the document.

Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
You can see the carnage here:
http://git-scm.com/docs/git-rebase#_bugs

This fixes GitHub issue github/gitscm-next#281
https://github.com/github/gitscm-next/issues/281


 Documentation/git-rebase.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 94e07fd..88d0afb 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -743,9 +743,11 @@ For example, an attempt to rearrange
 1 --- 2 --- 3 --- 4 --- 5
 ------------
 to
+
 ------------
 1 --- 2 --- 4 --- 3 --- 5
 ------------
+
 by moving the "pick 4" line will result in the following history:
 ------------
 	3
-- 
1.8.4.2
