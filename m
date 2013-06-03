From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v5 6/7] t3406: modernize style
Date: Mon,  3 Jun 2013 13:42:14 -0700
Message-ID: <1370292135-1236-7-git-send-email-martinvonz@gmail.com>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
 <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 03 22:42:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbaW-0000k0-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757895Ab3FCUmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:42:35 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:64966 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757732Ab3FCUm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:42:29 -0400
Received: by mail-vc0-f202.google.com with SMTP id ha11so325365vcb.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=sEUL4VZZyzEkraNj1z0h/8pk1B9wrHQamefJUEcXEG4=;
        b=cHszehff/SRI9rlXFtU3xxEcW1Hf0C5cYYVVapov2p+B4NlpMQ/MJcnu+13/9KCYQH
         F/ecy8SUxZ9KRA3a3w+kNALgwLo0nZ+2wfaPtjgzvrXhvTEcVLkBRJBWmVdrgCeAQ1ch
         V5z2jV4ffqrVL9NSvf8QoWFqqm8XA8k/lwN/Rgwr0pusOM5aPgBYcm9BySvjnBvZT3Ik
         ov/ctVcE3uCSojvos+fGdALPj916lkJAPmEKC18xt5r9Ss293SIJZZt9wN/J24LpgFPY
         bDS4reborYgqkAyBtUlHyVBlKspJlTuVO/VMLBckHd4PDg3AGVj2DpYSYG4r8Yk2Zku/
         L4cQ==
X-Received: by 10.236.175.234 with SMTP id z70mr4818244yhl.50.1370292146577;
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r76si4037644yhe.2.2013.06.03.13.42.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jun 2013 13:42:26 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6847C5A4217;
	Mon,  3 Jun 2013 13:42:26 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id A7EB2100A85; Mon,  3 Jun 2013 13:42:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQl6v3Qw2hh741XnlX46FV0ySoqTQhR0hMZfWKWFE3C8pHkWaahoUoqhyck5/qk4YAhkbOXZGP3hXb6ZWMxcxaunq3Nm0paUHEvCuj5XiS/Y5Oir2p43SeDrQnsbI9mOb/hohtuLgb6098+vqBCw96zBr44Da6/FDC6bjWQS/4gNKtx4l9H0ZguPdNK9gKgmtghe7F/L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226283>

Update the following:

 - Quote 'setup'
 - Remove blank lines within test case body
 - Use test_commit instead of custom quick_one
 - Create branch "topic" from tag created by test_commit
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
