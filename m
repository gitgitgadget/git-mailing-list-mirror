From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 40/40] whitespace: remediate t6120-describe.sh
Date: Sat,  6 Aug 2011 18:44:54 +1000
Message-ID: <1312620294-18616-40-git-send-email-jon.seymour@gmail.com>
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
	id 1QpcX1-0005WP-TS
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932Ab1HFIqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:40 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53446 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914Ab1HFIqj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:39 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182831iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4n7QaWNT1gJctC03DI4DaggEgFgCmz8N39OyzAs+elA=;
        b=P39yODg+4ZGnSV0IpdOx+Exx/dKnNxod+ZsGLyvBRolLlM0mVZwwZjB0y6ksPv4r1/
         A6VnmnzHV2Th6DeeAri+xACvWV7rNAexhgunrZODni5bWY3x0v7rzHyGrSWVp+/ezW/y
         cEx85Cyr0pz/U9uObpbXKQg9MGlRfttnSjHw8=
Received: by 10.42.29.198 with SMTP id s6mr2956506icc.296.1312620398981;
        Sat, 06 Aug 2011 01:46:38 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178864>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6120-describe.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index f67aa6f..d8838b4 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -2,13 +2,13 @@
 
 test_description='test describe
 
-                       B
-        .--------------o----o----o----x
+		       B
+	.--------------o----o----o----x
        /                   /    /
  o----o----o----o----o----.    /
        \        A    c        /
-        .------------o---o---o
-                   D,R   e
+	.------------o---o---o
+		   D,R   e
 '
 . ./test-lib.sh
 
-- 
1.7.6.362.gf0e6
