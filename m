From: Stefan Beller <sbeller@google.com>
Subject: [PATCHV2 2/2] t3404: cleanup double empty lines between tests
Date: Thu, 17 Mar 2016 14:44:20 -0700
Message-ID: <1458251060-311-3-git-send-email-sbeller@google.com>
References: <1458251060-311-1-git-send-email-sbeller@google.com>
Cc: j6t@kdbg.org, johannes.schindelin@gmail.com, gitster@pobox.com,
	Matthieu.Moy@grenoble-inp.fr, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 22:44:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agfie-00017F-Gz
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 22:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031182AbcCQVoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 17:44:32 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35625 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031069AbcCQVo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 17:44:27 -0400
Received: by mail-pf0-f182.google.com with SMTP id n5so137332377pfn.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TZ6azhBcSymouASMt2j5UrnufakM4oNNX2TSvPCE5Zw=;
        b=QQeqvqvntNiDymIeM7LJmvplm4QKrX7y5u5ZpQrxbDtkvPojpJWfv0NKZjq77OQOiN
         HgdZbNujLg/c82hjhH5Ru4qVIq9yMlpcIn6VB/ixo7VtIs3wQnPkQzeBl0nZg0JbQ310
         K5hyA+AjXJmJmjQbPpTOz97ZB25cH+WTrdv58rHavpx/BOy8qoZbUaxJG74oYODzE82P
         5Bw84AKu0eKpzREzNq6GeURHDyDORHD5cBuo+3563gdJp+TN6JoSnNJdX2NW/GYLBkmq
         Tm/zJpCOjXLI6M4qozJXXUkyhxgDW+fsntn3jeY125aG1ogw5PLDonqGLVWSs7yY7n68
         IhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TZ6azhBcSymouASMt2j5UrnufakM4oNNX2TSvPCE5Zw=;
        b=cJqcuQk+QHIJb8lFQss7eLY+xi+/+D5cD7imL20LUqohSAyKhhSXLqDlsVQdiq1qsB
         90eCbSu1nALOfkPFpKFjgoZpVVCMjpff04/tqqNYK820hq3pffnnjbZqtLajMoO1Ktdz
         nEaREhaOICZHaFwnsj/qhDnCLhWyJJcoNy52CfjsySivft5tg6ZAXMIeWASIGyo4ejX9
         gzmUtnAGk+JNJGchh28kfPmY22AbuFUL1vws7hC0HZOkPyV02C+LA2zng/pG5LUS5iah
         O9uhhN2fBKe0se2VNrqqyikHIWhhYSxv1r2CDYVF9LkUGB5vqfWF1JO/7xR9rtVzoI9N
         BD5A==
X-Gm-Message-State: AD7BkJLxE5RD4nfawMFrp7d/YsHouoF2ATJx4nlc3H8B+WPpXxjJ8CV5WKgKFd3tYhkvbafR
X-Received: by 10.66.220.66 with SMTP id pu2mr18391138pac.115.1458251067103;
        Thu, 17 Mar 2016 14:44:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d62:319:527b:e183])
        by smtp.gmail.com with ESMTPSA id qy7sm15615582pab.34.2016.03.17.14.44.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 14:44:26 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.2.ga804a9e
In-Reply-To: <1458251060-311-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289158>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t3404-rebase-interactive.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c8cc03d..f932639 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -771,7 +771,6 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
 '
 
-
 test_expect_success 'prepare for rebase -i --exec' '
 	git checkout master &&
 	git checkout -b execute &&
@@ -780,7 +779,6 @@ test_expect_success 'prepare for rebase -i --exec' '
 	test_commit three_exec main.txt three_exec
 '
 
-
 test_expect_success 'running "git rebase -i --exec git show HEAD"' '
 	set_fake_editor &&
 	git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
@@ -793,7 +791,6 @@ test_expect_success 'running "git rebase -i --exec git show HEAD"' '
 	test_cmp expected actual
 '
 
-
 test_expect_success 'running "git rebase --exec git show HEAD -i"' '
 	git reset --hard execute &&
 	set_fake_editor &&
@@ -807,7 +804,6 @@ test_expect_success 'running "git rebase --exec git show HEAD -i"' '
 	test_cmp expected actual
 '
 
-
 test_expect_success 'running "git rebase -ix git show HEAD"' '
 	git reset --hard execute &&
 	set_fake_editor &&
@@ -835,7 +831,6 @@ test_expect_success 'rebase -ix with several <CMD>' '
 	test_cmp expected actual
 '
 
-
 test_expect_success 'rebase -ix with several instances of --exec' '
 	git reset --hard execute &&
 	set_fake_editor &&
@@ -850,7 +845,6 @@ test_expect_success 'rebase -ix with several instances of --exec' '
 	test_cmp expected actual
 '
 
-
 test_expect_success 'rebase -ix with --autosquash' '
 	git reset --hard execute &&
 	git checkout -b autosquash &&
-- 
2.8.0.rc3.2.ga804a9e
