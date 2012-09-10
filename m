From: Yacine Belkadi <yacine.belkadi.1@gmail.com>
Subject: [PATCH] completion: add --no-edit option for git-commit
Date: Mon, 10 Sep 2012 23:23:08 +0200
Message-ID: <504E5A3C.3000309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 23:23:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBRx-0003MN-6t
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab2IJVXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:23:13 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60026 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab2IJVXL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 17:23:11 -0400
Received: by eaac11 with SMTP id c11so1142870eaa.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=0bUZ8wypEqIU/GxGDcfcNzJEtHSrKAU5lDL603U+r4E=;
        b=dIU4ALaadmX4fQNGYVCMAiSJoxFZB4i10R0zOJbms/pFc7Ygb+c3mz1m1OrLFCSbJb
         5epqaWchYG9oaxdkntvKFjFQBdJN3N0b15FgB2RxrPSxw8GUWKmZO0+mNsAndA4uqB7p
         alp1c3mSp4ZBpEaeNw10XoszOKw+jPLDGHSj50ZWmK8/YpyREPYForO+seue9xDvg5q+
         Qb1R3ItEUIzqxMhs0KjhVjXduDmQUn7BNzEDEG/pJU/cig0yYXbvHGtlWuIJpT67F0ye
         Jm5rI2plniZv1zawXz0uPL6tguGF49jtAywAM9DEoB5RL29WKkiGXVvOuN2CXPUAZbkS
         vniA==
Received: by 10.14.205.6 with SMTP id i6mr21754471eeo.13.1347312190518;
        Mon, 10 Sep 2012 14:23:10 -0700 (PDT)
Received: from [192.168.1.81] (238.5.81.79.rev.sfr.net. [79.81.5.238])
        by mx.google.com with ESMTPS id i41sm41495539eem.7.2012.09.10.14.23.09
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Sep 2012 14:23:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205193>

Signed-off-by: Yacine Belkadi <yacine.belkadi.1@gmail.com>
---
 contrib/completion/git-completion.bash |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 222b804..d1f905e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1014,7 +1014,8 @@ _git_commit ()
 	--*)
 		__gitcomp "
 			--all --author= --signoff --verify --no-verify
-			--edit --amend --include --only --interactive
+			--edit --no-edit
+			--amend --include --only --interactive
 			--dry-run --reuse-message= --reedit-message=
 			--reset-author --file= --message= --template=
 			--cleanup= --untracked-files --untracked-files=
-- 
1.7.9.5
