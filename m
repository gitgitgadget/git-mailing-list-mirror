From: Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] t6031-test-merge-recursive: Forgot to add file to be committed
Date: Sun, 21 Sep 2014 22:38:17 +0200
Message-ID: <1411331897-17674-1-git-send-email-stefanbeller@gmail.com>
Cc: Stefan Beller <stefanbeller@gmail.com>
To: drizzd@aon.at, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 22:38:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVnto-0004ov-UL
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 22:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbaIUUiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 16:38:21 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33771 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaIUUiU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 16:38:20 -0400
Received: by mail-wg0-f47.google.com with SMTP id y10so2038489wgg.30
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8hAfLYDZ//2qh71zdZwUDpLSq6zzJW7Fui/xeCSwQTs=;
        b=TCXi0WRQLkPqsRZpHjNWn3nqqiydG14SWnzRbKRMexVXEMgje/b+gUd5oQElud3M3+
         pyRy+uNfs02J0LQPwbzYp64jSX2HpvBsdh0Kpt3CoNbDiuXwkXNAOXgJCZjs7APbN+XO
         jEdvO3aKs6dlK08PvCZ0w3MbxVm89Vmq5ia5LJOq35nM4qQOyCVt4mqkeZUMr6Pj5Tjp
         U+/CcJcOmehH7PtdJrD8cqENXbockESKWUnsMlLidJ/IWbXa59Ky40gbxAw8kgBy7gIh
         m4qhduKxNkissGobdJeNJFKtFfuTev5xPKUIooWeOiZXyUbzZlLouFa76QfbhCtpGFfA
         +FcA==
X-Received: by 10.194.95.66 with SMTP id di2mr15559886wjb.47.1411331899547;
        Sun, 21 Sep 2014 13:38:19 -0700 (PDT)
Received: from localhost (p578F81B0.dip0.t-ipconnect.de. [87.143.129.176])
        by mx.google.com with ESMTPSA id ia3sm1639380wjb.12.2014.09.21.13.38.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 21 Sep 2014 13:38:18 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.238.gce1d3a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257356>

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 t/t6031-merge-recursive.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
index a953f1b..6464a16 100755
--- a/t/t6031-merge-recursive.sh
+++ b/t/t6031-merge-recursive.sh
@@ -13,6 +13,7 @@ test_expect_success 'mode change in one branch: keep changed version' '
 	git commit -m a &&
 	git checkout -b b1 master &&
 	test_chmod +x file1 &&
+	git add file1 &&
 	git commit -m b1 &&
 	git checkout a1 &&
 	git merge-recursive master -- a1 b1 &&
-- 
2.1.0.238.gce1d3a9
