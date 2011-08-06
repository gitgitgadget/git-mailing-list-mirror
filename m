From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 37/40] whitespace: remediate t9500-gitweb-standalone-no-errors.sh
Date: Sat,  6 Aug 2011 18:44:51 +1000
Message-ID: <1312620294-18616-37-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcX1-0005WP-CB
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925Ab1HFIqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:39 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab1HFIqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:31 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=awIifcVHqulQCIaoV1Uzu6ldkYJw/+MsxIn/vM9d9mA=;
        b=AdXWYxyhqJBEv3AhA2kuHi39mi38W6ANDx6XleQpuXroTc1LesanNlOqdz/Wi4/426
         4weHcjxKfg0xA1mKlIwTSAPVgFM2DyPBvswbPwHH4V7uKJnkEI9E4Gots3tMUophD0aJ
         nC7ZE70xfc5G9SK5HUxgM3xBpYD62X1Y5xyq0=
Received: by 10.231.117.35 with SMTP id o35mr937926ibq.23.1312620391294;
        Sat, 06 Aug 2011 01:46:31 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178860>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9500-gitweb-standalone-no-errors.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 5329715..d81764c 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -502,8 +502,8 @@ test_expect_success \
 test_expect_success \
        'URL: project URLs via gitweb.url' \
        'git config --add gitweb.url git://example.com/git/trash.git &&
-        git config --add gitweb.url http://example.com/git/trash.git &&
-        gitweb_run "p=.git;a=summary"'
+	git config --add gitweb.url http://example.com/git/trash.git &&
+	gitweb_run "p=.git;a=summary"'
 
 cat >.git/cloneurl <<\EOF
 git://example.com/git/trash.git
-- 
1.7.6.362.gf0e6
