From: Alangi Derick <alangiderick@gmail.com>
Subject: [PATCH] Fixed a translation error(die(_()) function)
Date: Sun, 3 May 2015 19:30:13 +0100
Message-ID: <554767a4.e3f3c20a.2d59.ffffb953@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon May 04 14:35:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpFbG-0002ll-OE
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 14:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbbEDMfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 08:35:51 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36102 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbEDMfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 08:35:50 -0400
Received: by wizk4 with SMTP id k4so119777387wiz.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject;
        bh=RoxsGUsm4991qcpwKZdRrTjTaGiUlFipj8qzvF65SnI=;
        b=qUkSvP/Koqw57R7jtZWHqWPebqnMplcTtT4M9UESCbNx13WmE0Ai+aggSRSnCP2+HJ
         n71M5ll4xbmmIMQ0Dtn8ebrVPhuiN+SZFY2y+Wde8IHcm106Fn+ggwGcosYs9OSCb0Mj
         rpB327F7S4/mUvNWD+vltTkfd32kDq3MRz+My6LHFGJ+mXcTY8xjRsnH92XduINugmGp
         aQXXiesYTykWfBI5bBFKuzwC/OctDbXNxRbXjRciZ61WuXaUOlPLOlO+xPG3wijsamrc
         4g5C4xiQ2CkSPn9EQwm4YQdhRdrYQfp+k5gUS91i7uq+Hh5b6nVm8Ca7DBQbdrQ3EOMZ
         i+3g==
X-Received: by 10.180.223.100 with SMTP id qt4mr18865045wic.1.1430742949127;
        Mon, 04 May 2015 05:35:49 -0700 (PDT)
Received: from localhost ([195.24.220.134])
        by mx.google.com with ESMTPSA id xb3sm20429150wjc.38.2015.05.04.05.35.47
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 05:35:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268317>

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 advice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index 575bec2..a8b2909 100644
--- a/advice.c
+++ b/advice.c
@@ -93,7 +93,7 @@ int error_resolve_conflict(const char *me)
 void NORETURN die_resolve_conflict(const char *me)
 {
 	error_resolve_conflict(me);
-	die("Exiting because of an unresolved conflict.");
+	die(_("Exiting because of an unresolved conflict."));
 }
 
 void detach_advice(const char *new_name)
-- 
2.4.0
