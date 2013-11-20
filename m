From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH] Documentation/gitcli.txt: fix double quotes
Date: Tue, 19 Nov 2013 20:34:40 -0500
Message-ID: <1384911280-20175-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 02:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Viwgy-0001VG-Ud
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 02:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab3KTBet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 20:34:49 -0500
Received: from mailhub129.itcs.purdue.edu ([128.210.5.129]:56615 "EHLO
	mailhub129.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753683Ab3KTBer (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Nov 2013 20:34:47 -0500
Received: from megahurtz.itap.purdue.edu (pal-nat184-049-011.itap.purdue.edu [10.184.49.11])
	(authenticated bits=0)
	by mailhub129.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAK1YgcT032328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 19 Nov 2013 20:34:46 -0500
X-Mailer: git-send-email 1.8.4.2
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238061>

Replace double quotes around literal examples with backticks

Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
 Documentation/gitcli.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 3146413..41bed29 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -83,12 +83,12 @@ scripting Git:
    `git log -1 HEAD` but write `git log -1 HEAD --`; the former will not work
    if you happen to have a file called `HEAD` in the work tree.
 
- * many commands allow a long option "--option" to be abbreviated
+ * many commands allow a long option `--option` to be abbreviated
    only to their unique prefix (e.g. if there is no other option
-   whose name begins with "opt", you may be able to spell "--opt" to
-   invoke the "--option" flag), but you should fully spell them out
+   whose name begins with `opt`, you may be able to spell `--opt` to
+   invoke the `--option` flag), but you should fully spell them out
    when writing your scripts; later versions of Git may introduce a
-   new option whose name shares the same prefix, e.g. "--optimize",
+   new option whose name shares the same prefix, e.g. `--optimize`,
    to make a short prefix that used to be unique no longer unique.
 
 
@@ -149,7 +149,7 @@ prefix of a long option as if it is fully spelled out, but use this
 with a caution.  For example, `git commit --amen` behaves as if you
 typed `git commit --amend`, but that is true only until a later version
 of Git introduces another option that shares the same prefix,
-e.g `git commit --amenity" option.
+e.g. `git commit --amenity` option.
 
 
 Separating argument from the option
-- 
1.8.4.2
