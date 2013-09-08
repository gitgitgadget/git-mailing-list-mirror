From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 1/5] t2024: Fix &&-chaining and a couple of typos
Date: Sun,  8 Sep 2013 22:58:11 +0200
Message-ID: <1378673895-23127-2-git-send-email-johan@herland.net>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
 <1378673895-23127-1-git-send-email-johan@herland.net>
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 08 22:58:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIm3z-0002xK-Qm
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab3IHU62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:58:28 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:43147 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab3IHU61 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 16:58:27 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so4244034lab.40
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 13:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EU2MWylHP+e5PDY+HN57VOcH6egWW+jguFaA/h+nHpk=;
        b=hMsCO7Vj+aItY47kG+p83u20eHx7ypvxEQ2eGqoLYYjwViRl5NZcAwUJNO79rJQY0P
         TJo59PntsuABw7Ne55Xg/RKwH2JV8xm5km+abLXTSjXxrhkng1n4xXGIUbNhx1YjVWbq
         zrPxENhC1m+pxq+lmBky9NUEGojurL9zxksaBbR1PvcLyVbZN3Vnj9kG4FIOBXrAk+ol
         IrOegSShZLftGnTXVfH7i+M+mXR5K3coH4EzFyDEBtehJh+wj8/Pd0/+t8XH9WM4NwXx
         E3G1Fe0qmou4W4M/epVsAj5+OeIPi/BHFSvUWG+rJ5zbqqHeZ0/alQ/GbZEoYMv3b5Qp
         lsjQ==
X-Received: by 10.112.51.166 with SMTP id l6mr13410260lbo.5.1378673905704;
        Sun, 08 Sep 2013 13:58:25 -0700 (PDT)
Received: from beta.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPSA id vo1sm4292384lbb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 13:58:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1378673895-23127-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234265>

Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t2024-checkout-dwim.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index dee55e4..094b92e 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -104,7 +104,7 @@ test_expect_success 'setup more remotes with unconventional refspecs' '
 		cd repo_c &&
 		test_commit c_master &&
 		git checkout -b bar &&
-		test_commit c_bar
+		test_commit c_bar &&
 		git checkout -b spam &&
 		test_commit c_spam
 	) &&
@@ -113,9 +113,9 @@ test_expect_success 'setup more remotes with unconventional refspecs' '
 		cd repo_d &&
 		test_commit d_master &&
 		git checkout -b baz &&
-		test_commit f_baz
+		test_commit d_baz &&
 		git checkout -b eggs &&
-		test_commit c_eggs
+		test_commit d_eggs
 	) &&
 	git remote add repo_c repo_c &&
 	git config remote.repo_c.fetch \
-- 
1.8.3.GIT
