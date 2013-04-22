From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/7] git-log.txt: order OPTIONS properly; move <since>..<until>
Date: Mon, 22 Apr 2013 11:00:27 +0530
Message-ID: <1366608631-21734-4-git-send-email-artagnon@gmail.com>
References: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 07:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU9L2-0005j7-Ii
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 07:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab3DVFao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 01:30:44 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:50097 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3DVFam (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 01:30:42 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so3328532pdi.15
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 22:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=28OtkPOy+s0TY/USNE21AxuD9jOqee7Xt7L7n/Q0gXc=;
        b=oVZYZM69CgeZplg6Wy8LwvaUQt0F1yieMIL8ODI4l95r3UO/JP58AAIgml7+ul9maS
         8MTOGVLkFSOVTvVQODy8LDMkHFCXHfZMh4eNUP0Y2nWcHhU2fbgyNPAhHonjqSY5PoyZ
         +8mTwwapaj9mkiYCmFQxyMXDDV26DAV+rMla4HzRxMROODhtLBOj/DL8RfuyRo7hZG8e
         kDZd2+Uw3WRl0QQ7cp77EQnA9qZiPdM8gsrurIUp8KGGtucJNntgJI3D7aMfwWuLZd55
         +QZKPp7UPBSNrTxP02M+kszQ7MN5p3b1lnioLOuajxlJhbGMpAqWPvAeb6f3K52Y5LUM
         WgZg==
X-Received: by 10.66.251.101 with SMTP id zj5mr10709710pac.122.1366608642254;
        Sun, 21 Apr 2013 22:30:42 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id em2sm11144653pbb.0.2013.04.21.22.30.40
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 22:30:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221992>

The OPTIONS section lists <since>..<until> as the first item, but this
is inconsistent with the ordering in SYNOPSIS.  Move it down until it
appears just before [[--] <path>...].

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-log.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 69db578..64cc337 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -24,13 +24,6 @@ each commit introduces are shown.
 OPTIONS
 -------
 
-<since>..<until>::
-	Show only commits between the named two commits.  When
-	either <since> or <until> is omitted, it defaults to
-	`HEAD`, i.e. the tip of the current branch.
-	For a more complete list of ways to spell <since>
-	and <until>, see linkgit:gitrevisions[7].
-
 --follow::
 	Continue listing the history of a file beyond renames
 	(works only for a single file).
@@ -69,6 +62,13 @@ produced by --stat etc.
 	Note that only message is considered, if also a diff is shown
 	its size is not included.
 
+<since>..<until>::
+	Show only commits between the named two commits.  When
+	either <since> or <until> is omitted, it defaults to
+	`HEAD`, i.e. the tip of the current branch.
+	For a more complete list of ways to spell <since>
+	and <until>, see linkgit:gitrevisions[7].
+
 [\--] <path>...::
 	Show only commits that are enough to explain how the files
 	that match the specified paths came to be.  See "History
-- 
1.8.2.1.501.gd2949c7
