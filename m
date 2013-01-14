From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC v2 2/8] contrib/subtree: Add vim modeline
Date: Mon, 14 Jan 2013 11:52:15 +0800
Message-ID: <1358135541-10349-3-git-send-email-techlivezheng@gmail.com>
References: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
 <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 04:59:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TubCk-0006Wq-BD
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 04:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474Ab3AND6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 22:58:30 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:33982 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473Ab3AND62 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 22:58:28 -0500
Received: by mail-da0-f48.google.com with SMTP id k18so1617390dae.35
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 19:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1MIZOfC+phHT12qtXbnXj69n3Q1RFV3z99kNCQW9B7w=;
        b=K7o/bNLdtj5Yi5VU0JhkDQvL5dsQtUnJd2gLsKlV9131dSfFu4R8b4D9jr1+3sb5Ia
         0M7m259yoGvkOsOLD74RMIpBgV1jBDJkROno3jhMKQETzVD8/FTCKN0k2DoPnkli0Gub
         h8REyOZ9pRB23+ppR80/5qsdIK0sLiMfKNmx/8UCNvi1YndumPHlHpDtX5F0jDRr1Q1A
         tIV3q+ULYYMB0hdzfm+7p/CfsUM3bldJmAJB4ggW0CCdXOW/lm5OiSYf02eY2jAk2dQ/
         R5WIPUcrzkf43xfgk80nbQKu/b35NnejaNtRaoN8+kcGPZWfpMm3ksWGt3oJVb6txMCt
         S9GA==
X-Received: by 10.68.216.201 with SMTP id os9mr35417037pbc.36.1358135907357;
        Sun, 13 Jan 2013 19:58:27 -0800 (PST)
Received: from home.techlive.me ([122.244.159.146])
        by mx.google.com with ESMTPS id kl3sm7400598pbc.15.2013.01.13.19.58.23
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 19:58:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <1358135541-10349-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213424>

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
---
 contrib/subtree/git-subtree.sh     | 2 ++
 contrib/subtree/t/t7900-subtree.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 70f86ea..88903c0 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -710,3 +710,5 @@ cmd_push()
 }
 
 "cmd_$command" "$@"
+
+# vim: set ts=4 sw=4 noet
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index b98f7d0..e32d31a 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -506,3 +506,5 @@ test_expect_success 'verify one file change per commit' '
 '
 
 test_done
+
+# vim: set ts=4 sw=4 noet
-- 
1.8.1
