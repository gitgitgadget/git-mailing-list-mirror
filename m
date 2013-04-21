From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/7] git-shortlog.txt: remove (-h|--help) from OPTIONS
Date: Sun, 21 Apr 2013 14:20:46 +0530
Message-ID: <1366534252-12099-2-git-send-email-artagnon@gmail.com>
References: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:51:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpzJ-0008EI-Lc
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab3DUIvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:51:03 -0400
Received: from mail-da0-f51.google.com ([209.85.210.51]:57156 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab3DUIvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:51:01 -0400
Received: by mail-da0-f51.google.com with SMTP id g27so430025dan.38
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=qGMhXkpWawq5Pb0BE/LMCDf7eei8H9r8EgygTOw+/50=;
        b=xVLfh2WvMfVDyrE0u3REbYQlSEL0vH/lYyHbIkWJFyKSy+3TSOKDcLyOtVY9tXBEPJ
         trl5DEdwMlgZBQHxMzZTDIcUkRXSnqZKXGcT+vb8y6h5+loJP0NzE9opX3lleKFeKL7r
         UGNUb/LNIq88bFpahuLSz39wPluYZyUC1RQjItJ+v28gk9iTL2BjJChF3kmcizEdrEox
         AceQocU4+rYlEhMSa06UVSps92JwG3y79kCh7CaYlKUGYCCGmHT/I+47+7rjXUAsilFr
         vkIR7gjLSw8b18sBnzZVLsAutqbraUlyVPryRHKdAjxmUGAghpTA3PCWUKvyifxc4B2/
         Z/zw==
X-Received: by 10.66.197.136 with SMTP id iu8mr10573483pac.0.1366534260624;
        Sun, 21 Apr 2013 01:51:00 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id mm9sm20241909pbc.43.2013.04.21.01.50.58
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:50:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221928>

To be consistent with the documentation of all the other commands,
remove (-h|--help) from the OPTIONS section.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-shortlog.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c308e91..c7f7f51 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -26,10 +26,6 @@ reference to the current repository.
 OPTIONS
 -------
 
--h::
---help::
-	Print a short usage message and exit.
-
 -n::
 --numbered::
 	Sort output according to the number of commits per author instead
-- 
1.8.2.1.501.gd2949c7
