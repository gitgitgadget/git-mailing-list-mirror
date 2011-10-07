From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/2] submodule: whitespace fix
Date: Fri,  7 Oct 2011 17:04:54 +0800
Message-ID: <1317978295-4796-1-git-send-email-rctay89@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 11:05:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC6Mk-0007FZ-SU
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 11:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759639Ab1JGJFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 05:05:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47276 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759637Ab1JGJFE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 05:05:04 -0400
Received: by iakk32 with SMTP id k32so3980735iak.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ZtNMH9x5ERjSeQeXdYrgvxI/LVZg1Gn8jkZUWn/M7bA=;
        b=azK4AAB0T1MGeUJ/W/25XBT17VBl1tj5TBvgal1rhLwKYP8ur9X225x0JpDEE1p5aS
         scN4X5C2IpOQfUUPl612M0qMSIUJdbEF21fMEFJMLht5oQj0H0SR8d9bsXcFpqqB1GYM
         6B9UxtvzeiCwAxd3i2buurt+o0KAdtBDjJIBs=
Received: by 10.231.50.204 with SMTP id a12mr2912267ibg.11.1317978303881;
        Fri, 07 Oct 2011 02:05:03 -0700 (PDT)
Received: from localhost (nusnet-198-15.dynip.nus.edu.sg. [137.132.198.15])
        by mx.google.com with ESMTPS id r14sm18412791ibe.7.2011.10.07.02.05.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 02:05:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.msysgit.0.584.g2cbf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183068>

Replace SPs with TAB.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 git-submodule.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 928a62f..ebea35b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -104,9 +104,9 @@ module_name()
 	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
 	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
-       test -z "$name" &&
-       die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$path'")"
-       echo "$name"
+	test -z "$name" &&
+	die "$(eval_gettext "No submodule mapping found in .gitmodules for path '\$path'")"
+	echo "$name"
 }
 
 #
-- 
1.7.7.584.g16d0ea
