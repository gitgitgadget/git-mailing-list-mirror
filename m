From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Fix spelling mistakes in user manual
Date: Tue,  4 Dec 2007 22:25:11 -0600
Message-ID: <1196828711-7826-1-git-send-email-shawn.bohrer@gmail.com>
Cc: gitster@pobox.com, Shawn Bohrer <shawn.bohrer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 05:25:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izlp3-0000sm-Qv
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 05:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbXLEEZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 23:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbXLEEZB
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 23:25:01 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:5309 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbXLEEZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 23:25:00 -0500
Received: by an-out-0708.google.com with SMTP id d31so984395and
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 20:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=V1exouYwfGTbP/k1jUyfJoUlA/FtdKllTmtn07x64gQ=;
        b=LzC2UhBgiZHYSKgsv4Pi1EkbfY57BB0T97Zs59oa3O1rXnJD7pL2xXxn+/BX+Izvuyc5VA+pUreEVJUog0AhY6+lAdRAyZRFZ5+nRiZ6VUxmDTPLYiN5V4HmqKULz4+fmoG+AgAYo+KdGQG3TclaqSQaAdMQwv65gmlHFUvbfwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=NT3O0pBqG0YyVCiY1TClfDXj5LdMSI9A90YNcQSBcgayqzyLqdhfpwfaRhynFg6Jn/J4H0X/RsmbelxapksOCagGPiTLYf0mjECGNf7PT0AJjcExFSgphzYlbNR0Lvmmdu8oBUB4KmfEb2H5OFAu8Y4bkAZSFhDILOiHi05BFvg=
Received: by 10.100.250.12 with SMTP id x12mr3145103anh.1196828699310;
        Tue, 04 Dec 2007 20:24:59 -0800 (PST)
Received: from mediacenter ( [70.112.149.232])
        by mx.google.com with ESMTPS id 3sm1056494wrs.2007.12.04.20.24.57
        (version=SSLv3 cipher=OTHER);
        Tue, 04 Dec 2007 20:24:57 -0800 (PST)
Received: by mediacenter (sSMTP sendmail emulation); Tue,  4 Dec 2007 22:25:11 -0600
X-Mailer: git-send-email 1.5.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67100>

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 Documentation/user-manual.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 93a47b4..f2b4206 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1994,7 +1994,7 @@ $ git push ssh://yourserver.com/~you/proj.git +master
 -------------------------------------------------
 
 Normally whenever a branch head in a public repository is modified, it
-is modified to point to a descendent of the commit that it pointed to
+is modified to point to a descendant of the commit that it pointed to
 before.  By forcing a push in this situation, you break that convention.
 (See <<problems-with-rewriting-history>>.)
 
@@ -2921,7 +2921,7 @@ As you can see, a commit is defined by:
 - a tree: The SHA1 name of a tree object (as defined below), representing
   the contents of a directory at a certain point in time.
 - parent(s): The SHA1 name of some number of commits which represent the
-  immediately prevoius step(s) in the history of the project.  The
+  immediately previous step(s) in the history of the project.  The
   example above has one parent; merge commits may have more than
   one.  A commit with no parents is called a "root" commit, and
   represents the initial revision of a project.  Each project must have
@@ -3242,7 +3242,7 @@ to replace them by hand.  Back up your repository before attempting this
 in case you corrupt things even more in the process.
 
 We'll assume that the problem is a single missing or corrupted blob,
-which is sometimes a solveable problem.  (Recovering missing trees and
+which is sometimes a solvable problem.  (Recovering missing trees and
 especially commits is *much* harder).
 
 Before starting, verify that there is corruption, and figure out where
-- 
1.5.3.6
