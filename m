From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/7] git-shortlog.txt: remove (-h|--help) from OPTIONS
Date: Mon, 22 Apr 2013 11:00:25 +0530
Message-ID: <1366608631-21734-2-git-send-email-artagnon@gmail.com>
References: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 07:30:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU9L1-0005j7-Jk
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 07:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343Ab3DVFaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 01:30:39 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:43391 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3DVFai (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 01:30:38 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so130955pbb.27
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 22:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=qGMhXkpWawq5Pb0BE/LMCDf7eei8H9r8EgygTOw+/50=;
        b=aBvApEXf0jeeditqQx355mdT1xb1G16jz4jyQTEfhxI2ixuxrNXoSu3qHz33AMuaCH
         U2Lcj9N42xQqfntAHhoMag+XWpyl4eUpfpWsl4XMTQ52tVtjkgzDrJqlDDkV+Bt6S6oD
         cpHoEDme4b/DothqjCVEFavqLgEDFIAS2G2Umto9J2CFz6DCAcai0RfVFT6ncaj1oYRl
         Op0GoEhSap2HfcqWG9QE0+Qlm3n+dP0KhQj57uea+6OxKP4TWTMIK3kg+fAqtVjv3kFB
         rmnKzdzUgQHWsceT86Hl1ZQHWOHONun7JhfDcJ1Hka5iz8kr3DI2FH0u9HOqladAx3fY
         bCGA==
X-Received: by 10.69.0.132 with SMTP id ay4mr30491769pbd.62.1366608638003;
        Sun, 21 Apr 2013 22:30:38 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id em2sm11144653pbb.0.2013.04.21.22.30.35
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 22:30:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221991>

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
