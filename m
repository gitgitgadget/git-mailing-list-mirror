From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Fix spelling of overridden in documentation
Date: Tue, 25 Sep 2007 23:12:46 -0500
Message-ID: <11907799662560-git-send-email-shawn.bohrer@gmail.com>
Cc: gitster@pobox.com, Shawn Bohrer <shawn.bohrer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 06:12:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaOG8-0003Q2-03
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 06:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbXIZEMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 00:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXIZEMO
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 00:12:14 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:27496 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXIZEMM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 00:12:12 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1356601nze
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 21:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=+xW4Yrhljfw1i6I30mpYaOaHeUo+/3JM42jJETqp7Tg=;
        b=swX3DHSQYji9zGt1X9Z3twSgIxMTGrWhRLcJECchluUBRSU1Gk7Cy5HTeqYwlHtZfdE7887uol69Px4Cf239p2uXhUBp2EQHFAD0jHsiTRV3tCysQrcHyZzWATPUbaI/6rQ8Yf6+fUk2MivYzRM0Lo8RmyS86Oxng61CY8cdXlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=Q+/cgnuHFYJduAdzK/ZMPy8tJluECQo5DIbno5KZU+ZTIxmgwwCKoX0Sx5QDB8KxoziLBin474RlF+XvceXd7qFoVCLcOKO2RPdgLPGjPolDNCCPa8k5hfOpFXI04eKjF0t5bgQZWjSBnIhxcd3hbcwgBspx/ehn+ZIrd4EogqU=
Received: by 10.143.168.14 with SMTP id v14mr134833wfo.1190779930886;
        Tue, 25 Sep 2007 21:12:10 -0700 (PDT)
Received: from mediacenter ( [70.112.123.114])
        by mx.google.com with ESMTPS id 61sm285443wry.2007.09.25.21.12.09
        (version=SSLv3 cipher=OTHER);
        Tue, 25 Sep 2007 21:12:10 -0700 (PDT)
Received: by mediacenter (sSMTP sendmail emulation); Tue, 25 Sep 2007 23:12:46 -0500
X-Mailer: git-send-email 1.5.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59213>

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 Documentation/git-merge.txt |    2 +-
 Documentation/gitignore.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 144bc16..eae49c4 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -56,7 +56,7 @@ merge.verbosity::
 	message if conflicts were detected. Level 1 outputs only
 	conflicts, 2 outputs conflicts and file changes.  Level 5 and
 	above outputs debugging information.  The default is level 2.
-	Can be overriden by 'GIT_MERGE_VERBOSITY' environment variable.
+	Can be overridden by 'GIT_MERGE_VERBOSITY' environment variable.
 
 
 HOW MERGE WORKS
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 9c83095..e8b8581 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -26,7 +26,7 @@ precedence, the last matching pattern decides the outcome):
 
  * Patterns read from a `.gitignore` file in the same directory
    as the path, or in any parent directory, with patterns in the
-   higher level files (up to the root) being overriden by those in
+   higher level files (up to the root) being overridden by those in
    lower level files down to the directory containing the file.
    These patterns match relative to the location of the
    `.gitignore` file.  A project normally includes such
-- 
1.5.3.GIT
