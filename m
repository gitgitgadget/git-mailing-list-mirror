From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v6 6/7] t3406: modernize style
Date: Thu,  6 Jun 2013 23:11:42 -0700
Message-ID: <1370585503-11374-7-git-send-email-martinvonz@gmail.com>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
 <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 08:12:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukpuy-0003fH-0a
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab3FGGMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 02:12:39 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:60413 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab3FGGMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 02:12:12 -0400
Received: by mail-qa0-f73.google.com with SMTP id hu14so128226qab.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=iwsbk5hHRupidDxZvcQhAm5l5kq9wDxfjQGeloAU0wE=;
        b=Xs9UH3vrnDsTZhoc7g2gSlMzNkX+Ql7tCCtbNck3tPMqGaLAQKzBzPUDSAbIeLE3qp
         mtZ//CBQv1nNJPwQcC/aZfTyXvnTgTUjHeZPjBtUduBMX1w1IVCBcjBR05gIfVg55Boo
         ZsLBkTHcMW1QP2pHkHCQwsYVuvWHPJvB3cqQlU7HF+Dfp1CkPC6kTfWFgmm0sG6xhZgj
         eKOfrmUx4hKAV/EKtEiwvszhDBtLzYR+tlyFj9XwFMYtLyLaqEhq847scBjU4/Ba8xkt
         7K+PxKg3KQ2tuDS+BSG56tXz+rNrwQFAczCKtj9YcheSM0OOGLROGSKCM7NxHEiCi5rp
         Qdqg==
X-Received: by 10.236.139.134 with SMTP id c6mr23044313yhj.7.1370585510652;
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y4si5472293yhi.3.2013.06.06.23.11.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7527D31C1EF;
	Thu,  6 Jun 2013 23:11:50 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 086AB100D7A; Thu,  6 Jun 2013 23:11:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmMggyhR1y+D+LJDuLs9mQDpmsxm/AB02M9eVoRrTCUVZvtTdH72K0jVR4h1xgC6PCHNOGTDKVS0CdsICZW2RuPn7kT73ueHl+IeA1q+wmnIQ4EQr9j4HTbXSmM9+OYK15JrBDSb2QFsAiML3GYzdAk54Zeg0VNzc+q1792/7/mDTVTppotwZkwDTEJBx/ZrXg2ty7v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226604>

Update the following:

 - Quote 'setup'
 - Remove blank lines within test case body
 - Use test_commit instead of custom quick_one
 - Create branch "topic" from tag created by test_commit

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 t/t3406-rebase-message.sh | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index e6a9a0d..fe8c27f 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -4,27 +4,17 @@ test_description='messages from rebase operation'
 
 . ./test-lib.sh
 
-quick_one () {
-	echo "$1" >"file$1" &&
-	git add "file$1" &&
-	test_tick &&
-	git commit -m "$1"
-}
+test_expect_success 'setup' '
+	test_commit O fileO &&
+	test_commit X fileX &&
+	test_commit A fileA &&
+	test_commit B fileB &&
+	test_commit Y fileY &&
 
-test_expect_success setup '
-	quick_one O &&
-	git branch topic &&
-	quick_one X &&
-	quick_one A &&
-	quick_one B &&
-	quick_one Y &&
-
-	git checkout topic &&
-	quick_one A &&
-	quick_one B &&
-	quick_one Z &&
+	git checkout -b topic O &&
+	git cherry-pick A B &&
+	test_commit Z fileZ &&
 	git tag start
-
 '
 
 cat >expect <<\EOF
@@ -34,12 +24,10 @@ Committed: 0003 Z
 EOF
 
 test_expect_success 'rebase -m' '
-
 	git rebase -m master >report &&
 	sed -n -e "/^Already applied: /p" \
 		-e "/^Committed: /p" report >actual &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'rebase --stat' '
-- 
1.8.3.497.g83fddbe
