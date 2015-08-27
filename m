From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] git-submodule: remove extraneous space from error message
Date: Wed, 26 Aug 2015 22:26:19 -0600
Message-ID: <1440649579-3513-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org, judge.packham@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 06:26:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUolk-0002FB-B2
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 06:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbbH0E01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 00:26:27 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34421 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbbH0E00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 00:26:26 -0400
Received: by pabzx8 with SMTP id zx8so11035054pab.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 21:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LAZcUmc3jIvvb//aN2CTacTEiyoczPrYFyHQHoEfs24=;
        b=BC1w8Rlcnz5Gu3bwppS8EnSvsNECDU5dTw4iYfJRFGjdqfnRh6yYj1zMrAG/VF2MET
         00MUSXjUQkr/knbT6CQM+y90nyIfdfuixi1pBDupNSIlvSYgPzv6NJ79YA2HRC8Sb6gG
         VvhyrAmLugD/1OJa4U57s/+GpQH5VV16vT903kduKCLEbBgQ2iCogr1TwktS3lQwVME2
         h77Vch52qQ/VuGJiFaykjhnInW8tHw8jnnbQfnmXIMpiJFugVULF3Ll4R48Y7ua9JC7r
         2IXKynTk9bk+VUcAXppKIFG4N2tCF9bOI9IZTE88RXI+zeKFtTzJDaCtNJj4EY4yUKdX
         Oz8Q==
X-Received: by 10.68.98.194 with SMTP id ek2mr3365292pbb.152.1440649585442;
        Wed, 26 Aug 2015 21:26:25 -0700 (PDT)
Received: from alex-wolverine.lan ([2601:681:4d04:75d8:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id hu13sm684427pdb.72.2015.08.26.21.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Aug 2015 21:26:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276657>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 36797c3..25b1ddf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -904,7 +904,7 @@ Maybe you want to use 'update --init'?")"
 				;;
 			!*)
 				command="${update_module#!}"
-				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'")"
+				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$prefix\$sm_path'")"
 				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
 				must_die_on_failure=yes
 				;;
-- 
2.5.0
