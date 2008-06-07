From: rwa000@gmail.com (Robert Anderson)
Subject: [PATCH] improve doc heading for git-bisect
Date: Sat,  7 Jun 2008 00:06:37 -0700 (PDT)
Message-ID: <20080607070637.79B17C7C0E@rwavmlap>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 09:08:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4sWw-0004HC-0M
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 09:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbYFGHGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 03:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbYFGHGg
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 03:06:36 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:56091 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYFGHGf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 03:06:35 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1847383rvb.1
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject
         :message-id:date:from;
        bh=ljFVtICjVfO5SdzKplPDAQVOffri3AjxNd9i8Tdif1I=;
        b=A5iLhHwhWp7/dSRyWqGVjZlIf0iCLePfajZF6a08grpEci0il8u7Iqsevm4jYDfC9B
         pfM//oUixIbLFu2Ab4usZs9zkb4iMpZfx5nOi5N/XAhAi/2GFWcCJfTj04hPdi3rKbCe
         jNdv9rDu10WckTURAmd+WWuW4P3jfOrkCp9VU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:message-id:date:from;
        b=Lq/IF7rR0e0GkH3mz5YE1YJ17jBqGQ+vhy73+mux4rQYfVOImH5AZhl10PLYlw7afW
         QmAv/yi53Qvpu2avT+s6IdnC2Ot5D2HQuhYiq6GycNsYN88Vn+BLiwy1uexyerWzWzuS
         LB51b3UapzV7KwXXMfL1I75nvaDT2sJ0sIxWg=
Received: by 10.141.69.1 with SMTP id w1mr619903rvk.185.1212822395051;
        Sat, 07 Jun 2008 00:06:35 -0700 (PDT)
Received: from rwavmlap ( [69.108.163.191])
        by mx.google.com with ESMTPS id k41sm8465418rvb.3.2008.06.07.00.06.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Jun 2008 00:06:34 -0700 (PDT)
Received: by rwavmlap (Postfix, from userid 1000)
	id 79B17C7C0E; Sat,  7 Jun 2008 00:06:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84178>

>From 7af03a835b7311c501f2147e25f428642fc3acb7 Mon Sep 17 00:00:00 2001
From: Robert W. Anderson <rwa000@gmail.com>
Date: Fri, 6 Jun 2008 23:53:37 -0700
Subject: [PATCH] improve doc heading for git-bisect

Improve awkward heading in git-bisect documentation.

Signed-off-by: Robert W. Anderson <rwa000@gmail.com>
---
 Documentation/git-bisect.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 37c7acb..3ea2527 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -129,8 +129,8 @@ $ git bisect replay that-file
 if you find later you made a mistake telling good/bad about a
 revision.
 
-Avoiding to test a commit
-~~~~~~~~~~~~~~~~~~~~~~~~~
+Changing the revision to test
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If in a middle of bisect session, you know what the bisect suggested
 to try next is not a good one to test (e.g. the change the commit
-- 
1.5.4.3
