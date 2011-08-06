From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 10/40] whitespace: remediate t4010-diff-pathspec.sh
Date: Sat,  6 Aug 2011 18:44:24 +1000
Message-ID: <1312620294-18616-10-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVw-000510-Pg
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab1HFIpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:39 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53446 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab1HFIp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:28 -0400
Received: by iye16 with SMTP id 16so5182831iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c1sESGLWggYp42fIHF/hJpjnDozTQ9oQxajxomVWQ4U=;
        b=j+iahdl/nzuWxd8lHnPme+UwZSudLiPOd80tYQbvyffgQA5QwlNCEu1tlfDT8ytdqj
         Kf0VfCA0X7FNrMVKULMa8g8t/YDrEsDc6HK+7fCozvhvxFQtUEVOeNXwCsNo2KUY6Upg
         SAQSpsvWULbBYmdAWkHwaUq35j7DkQOXSWSFc=
Received: by 10.42.96.4 with SMTP id h4mr1609551icn.115.1312620327787;
        Sat, 06 Aug 2011 01:45:27 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178839>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t4010-diff-pathspec.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index fbc8cd8..7e0e6cc 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -6,8 +6,8 @@
 test_description='Pathspec restrictions
 
 Prepare:
-        file0
-        path1/file1
+	file0
+	path1/file1
 '
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
-- 
1.7.6.362.gf0e6
