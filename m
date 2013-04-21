From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/7] git-log.txt: order OPTIONS properly; move <since>..<until>
Date: Sun, 21 Apr 2013 14:20:49 +0530
Message-ID: <1366534252-12099-5-git-send-email-artagnon@gmail.com>
References: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:51:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpzR-0008Hv-P0
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab3DUIvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:51:10 -0400
Received: from mail-da0-f41.google.com ([209.85.210.41]:36099 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab3DUIvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:51:07 -0400
Received: by mail-da0-f41.google.com with SMTP id p8so2473184dan.28
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=28OtkPOy+s0TY/USNE21AxuD9jOqee7Xt7L7n/Q0gXc=;
        b=VErtkldr3Y8clLLt5jtQuc0LJHTmK65Xb2CukQsQgwPBbthlg9owmmKydKOX1KK8QF
         8vdshvr2DkzAbg1H2lEpxenMhK/3Xtw+jvBPi1jhqNouc3p3LxCcCUY5WC29KxtCE1HS
         hDkWnXndw+4XCXkcLuphY44ehc2znNizAKg3uCjrBqr2KDaIfheTSADRmlSS7Y3yPiOi
         h1N4EEyNHL4yUnf9WxKqcnCFYCklqwhu/TSHfPMxQ0FipiYN2URCecpGko/uTRgeEstC
         roCKWAowYO5SyEl0zGUjWPCLRrK+Q0dXe4/mc42HwQe4tutLYnQaaJkthoPLJKki4ba3
         fwuw==
X-Received: by 10.68.218.8 with SMTP id pc8mr26480239pbc.115.1366534267247;
        Sun, 21 Apr 2013 01:51:07 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id mm9sm20241909pbc.43.2013.04.21.01.51.05
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:51:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221931>

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
