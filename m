From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] Makefile: some changes for http-related flag documentation
Date: Wed,  3 Aug 2011 20:07:57 +0800
Message-ID: <1312373277-8792-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 14:08:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoaFA-0002HI-Cq
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 14:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168Ab1HCMIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 08:08:06 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62594 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab1HCMIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 08:08:04 -0400
Received: by pzk37 with SMTP id 37so1510257pzk.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3nS9nYfsalLVzoUkFpOPlrYl9bW2dNqJbbu2+rSsqCU=;
        b=NA7mbzY+7PJq7MJ5QYYXbtdvy04gSezndCLQuMJ4gNZ4hmyMfaEJ743T+hZtRrQw//
         /2DKwQ3Hl8dCm1bqi+cTSoH5HzZLgMmZfMFWSpr6MgEbKFGwtSuNWl+ljdttmAbSwTyk
         C4prGUw6xmQosTuM0Ukk4yAnmVot4JAIVYIxg=
Received: by 10.142.139.8 with SMTP id m8mr166570wfd.105.1312373283628;
        Wed, 03 Aug 2011 05:08:03 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id t7sm512642wfl.14.2011.08.03.05.08.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 05:08:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178561>

Rename git-http-pull to git-http-fetch. This was passed over in 215a7ad
(Big tool rename, Wed Sep 7 17:26:23 2005 -0700).

Also, distinguish between dumb and smart in flag docs, as the "warnings"
in NO_CURL and NO_EXPACT are no longer accurate given the introduction
of smart http(s).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4ed7996..9c7c3d0 100644
--- a/Makefile
+++ b/Makefile
@@ -30,15 +30,15 @@ all::
 # Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
-# Define NO_CURL if you do not have libcurl installed.  git-http-pull and
+# Define NO_CURL if you do not have libcurl installed.  git-http-fetch and
 # git-http-push are not built, and you cannot use http:// and https://
-# transports.
+# transports (neither smart nor dumb).
 #
 # Define CURLDIR=/foo/bar if your curl header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
-# not built, and you cannot push using http:// and https:// transports.
+# not built, and you cannot push using http:// and https:// transports (dumb).
 #
 # Define EXPATDIR=/foo/bar if your expat header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
-- 
1.7.6.11.g49037.dirty
