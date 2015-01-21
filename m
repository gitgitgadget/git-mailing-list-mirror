From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 2/2] t/lib-terminal.sh: fix typo
Date: Wed, 21 Jan 2015 15:14:01 +0600
Message-ID: <1421831641-28784-1-git-send-email-kuleshovmail@gmail.com>
References: <1421831604-28674-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:14:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDrMd-0003bp-0b
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 10:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbbAUJOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 04:14:11 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:40501 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbbAUJOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 04:14:09 -0500
Received: by mail-la0-f44.google.com with SMTP id s18so5777871lam.3
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 01:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i1ZTOmsQ7C9qKRPLYNc7V3EC3JLbZhhkwGCWvwiGuic=;
        b=gXUw9+oxfY576b1L0C2FFq0depiNo1cfnwVWwMOSKUusWMvSd1Qz0vWNqPML1Y4ryz
         a0F36ZOcBpdvybsco66nxgLkSMmHzAu2C3OhmcJblIKcymxidU4wnxYASFxhwiO/37i5
         FgHNxVfZ9m7zq5o85SFiMDTGAX3ObWy/jkaX/Pyb1futzkHs5r8fEAdZ6iNfdRxVOEZS
         kVs1B50Q/trAzk7ApcViQEcZyNSgiSM69horjBHxu6YbssPFZ5YHwU66XunYsT6DV6/4
         wawr3dsx/BTcsc1vCuC/6BGABZdZ6I1HNyhr0FwBPyYf5rTqEuMiDfZrcPtT5I9kf1Pd
         N6og==
X-Received: by 10.112.8.69 with SMTP id p5mr42720349lba.97.1421831646529;
        Wed, 21 Jan 2015 01:14:06 -0800 (PST)
Received: from localhost.localdomain ([147.30.53.164])
        by mx.google.com with ESMTPSA id qg5sm4729404lbb.42.2015.01.21.01.14.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jan 2015 01:14:05 -0800 (PST)
X-Mailer: git-send-email 2.3.0-rc1
In-Reply-To: <1421831604-28674-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262723>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 t/lib-terminal.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 5184549..cd220e3 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -1,7 +1,7 @@
 # Helpers for terminal output tests.
 
 # Catch tests which should depend on TTY but forgot to. There's no need
-# to aditionally check that the TTY prereq is set here.  If the test declared
+# to additionally check that the TTY prereq is set here.  If the test declared
 # it and we are running the test, then it must have been set.
 test_terminal () {
 	if ! test_declared_prereq TTY
-- 
2.3.0-rc1
