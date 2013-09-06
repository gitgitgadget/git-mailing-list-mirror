From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/5] t2024: Fix inconsequential typos
Date: Fri,  6 Sep 2013 12:40:38 +0200
Message-ID: <1378464042-17476-2-git-send-email-johan@herland.net>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 12:43:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHtW1-0001Cb-6t
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 12:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187Ab3IFKlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 06:41:14 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:46812 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3IFKlL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 06:41:11 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so2586794lab.20
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 03:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PYG9ncoPhyKXqmIZ6Fwc3JUUd6DYVI5FIh/vru6HYf0=;
        b=Yq05wyJJBLTZx2NzzKtoesY8R0TXO79oMQJ8WMLXIUgHtqehoKFwEga89C0jxpTmXz
         TgCdLwxCtgoSP2YhAYSB9F4SDhGbJZkGGSQ479iFlGiXb9rPHJh4tOI8IvSMx7BkdwNT
         4WrIVokuE9jDMfKlk4bZutUAJpXNZukIq9FyVFDGDKmgvOn2U3wabDHlBcPdHj+3jQ0u
         CbTYQ3w7P59JhN+DILJ4lWRJZmD8O32MeZ06kvgY76BDlATCFN2tGGd112xD+Hji0ma4
         0nLENz56fx/M3vb8bxwXPaq5qt7SAQmwTcFD3khLva1q2M6lYOnQtmik9CyysC2sM4xy
         93OQ==
X-Received: by 10.112.172.137 with SMTP id bc9mr2311682lbc.21.1378464070735;
        Fri, 06 Sep 2013 03:41:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-222-129.bredband.comhem.se. [80.216.222.129])
        by mx.google.com with ESMTPSA id vs11sm1000794lac.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 03:41:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1378464042-17476-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234038>

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t2024-checkout-dwim.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index dee55e4..6c78fba 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -113,9 +113,9 @@ test_expect_success 'setup more remotes with unconventional refspecs' '
 		cd repo_d &&
 		test_commit d_master &&
 		git checkout -b baz &&
-		test_commit f_baz
+		test_commit d_baz
 		git checkout -b eggs &&
-		test_commit c_eggs
+		test_commit d_eggs
 	) &&
 	git remote add repo_c repo_c &&
 	git config remote.repo_c.fetch \
-- 
1.8.3.GIT
