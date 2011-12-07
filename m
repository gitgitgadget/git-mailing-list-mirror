From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/15] t1300 (repo-config): fix && chaining
Date: Thu,  8 Dec 2011 01:06:38 +0530
Message-ID: <1323286611-4806-3-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNJh-0000zp-15
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757081Ab1LGTiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:04 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36108 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757066Ab1LGTiC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:02 -0500
Received: by qadb40 with SMTP id b40so3739668qad.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9dxeF0gqG/DIgn5wVL7A+LWhXocoJ7FwNCMFcluNR74=;
        b=gL+f60XUQpr5cZvGfe91VzU6jUuZWFCklg3Qck/qyerOV/OuBVd3sPbXmDOjGKVFat
         DtshZsU+9QKwLI1MyF2T3t6E5P3N12AaYy74EzRUwazvWdgkZ4YByyutdjEOJsP91sYh
         namGH1SjWrYA4yQCglMexgMhoQb/UdMzOSiYw=
Received: by 10.50.196.137 with SMTP id im9mr244222igc.32.1323286681126;
        Wed, 07 Dec 2011 11:38:01 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.37.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:00 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186482>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1300-repo-config.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 51caff0..0690e0e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -38,7 +38,7 @@ cat > expect << EOF
 	WhatEver = Second
 EOF
 test_expect_success 'similar section' '
-	git config Cores.WhatEver Second
+	git config Cores.WhatEver Second &&
 	test_cmp expect .git/config
 '
 
-- 
1.7.7.3
