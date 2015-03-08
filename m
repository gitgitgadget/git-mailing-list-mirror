From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] git-instaweb: allow running in a working tree subdirectory
Date: Sat,  7 Mar 2015 21:04:09 -0800
Message-ID: <cbd51684029b73293740badfb3ee318@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 06:05:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUTPV-00061j-CI
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 06:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbbCHFES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 00:04:18 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:41678 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbbCHFES (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 00:04:18 -0500
Received: by pablj1 with SMTP id lj1so57140642pab.8
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 21:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2DJllRN+yUS8M/Nwd3bf6XeBPLJppI5V6hlJD9Sla+4=;
        b=CBLHPMngoER3Is64pjZlydaT87jwU3Hf5E0F+v8+uiA/zaouNBKOEACZVU/XwUOoJm
         imUt2FdaCEK/+IGoxY9llp9T2MXtMXdvxhrMnleSQe+jlGa/PWxPghMnYMCQfmTnW4yY
         VC7Kxzd2XbTZOSEeqwBc0J7DBxuwpKoxuYZT23Nh0k7S4e8TRWzIXWyJ+r0XhFoyRGZk
         9MHgFFcPSr6aYMPWqWA6FITxekR6q3lOcNyIYrWeU3FgC1lQburowGQYing2d7wweOCo
         WRaGavjwuTzRztS4snlhIwOxbwNvRVScA71sbPnK+NjtLn+Qa9dTcob3XSKlllmBLSoF
         JmGA==
X-Received: by 10.70.53.40 with SMTP id y8mr8836254pdo.61.1425791057540;
        Sat, 07 Mar 2015 21:04:17 -0800 (PST)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id d4sm13747625pds.60.2015.03.07.21.04.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 07 Mar 2015 21:04:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265026>

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 git-instaweb.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 513efa66..4c0af04f 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -20,6 +20,7 @@ start          start the web server
 restart        restart the web server
 "
 
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
 fqgitdir="$GIT_DIR"
---
