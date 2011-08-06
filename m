From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 06/40] whitespace: remediate t3040-subprojects-basic.sh
Date: Sat,  6 Aug 2011 18:44:20 +1000
Message-ID: <1312620294-18616-6-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVl-0004uu-9V
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab1HFIp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:29 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab1HFIpS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:18 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TvOseAipXQ8kA0+q7o+UVHoP0ZeFHqWpYYvliqoKtZE=;
        b=UpN17ylYo3GbehF+mr4dkOUFI1e8x5iM22tl3eu+UB17PLl+QVca0XQ2PJ0V/NxQm4
         PQO/IyrebsqGWK6suVifaMbDxeddpyxP1vYg7n2z2ZvvaiYtsBAA1GRlT2j7uZf3KfW8
         twurohAtlxwH+YsWWjfI/UlSyiJY4WpniNkzY=
Received: by 10.42.29.198 with SMTP id s6mr2955445icc.296.1312620317894;
        Sat, 06 Aug 2011 01:45:17 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178836>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3040-subprojects-basic.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index f6973e9..a0e80b1 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -36,7 +36,7 @@ test_expect_success 'check if commit in a subproject detected' \
     echo "all:" >>Makefile &&
     echo "	true" >>Makefile &&
     git commit -q -a -m "make all" ) && {
-        git diff-files --exit-code
+	git diff-files --exit-code
 	test $? = 1
     }'
 
-- 
1.7.6.362.gf0e6
