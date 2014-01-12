From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] t1507 (rev-parse-upstream): fix typo in test title
Date: Sun, 12 Jan 2014 22:41:04 +0530
Message-ID: <1389546666-17438-2-git-send-email-artagnon@gmail.com>
References: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 12 18:10:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2OYn-0007jf-6C
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 18:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbaALRKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jan 2014 12:10:50 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:39173 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbaALRKs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 12:10:48 -0500
Received: by mail-pd0-f175.google.com with SMTP id r10so2519243pdi.20
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lzFRqTebUO2LS3UHqkHolP6mdrEUQ5h/e0gyKcTfY+8=;
        b=CNNHl6IvDDaygN+qkSuXz8S70ni8dUu1hxoxUqYAf4DmG9BnOwWXxvwekxBVFYeJzG
         BKZej5qDWFG3TBPG5rJgSHDdg/0/NwgnfULugam8uHtwfQJ7gOxGAOzDTZYHEaPiL3PW
         6R+WR/VaEs72YKoCjHP/VugpoZVpE/00ebG0pBYcjziQn7D4Eve59mkxhNsC/XGqY5pH
         0cnBa4xweb9xBAvM5tlGH0W6lLoPx891zGA49Qa+gqQui5rT8Nu/9SYeAmA5WRw7ao6G
         o9gohZLCqXltsvaOV97YLSYfHQS4c7ETJE6MWg8FboKOFrRzxtU1zO3MYJw5f3qnnlpT
         GHUg==
X-Received: by 10.68.204.161 with SMTP id kz1mr2518784pbc.156.1389546647753;
        Sun, 12 Jan 2014 09:10:47 -0800 (PST)
Received: from localhost.localdomain ([122.164.134.24])
        by mx.google.com with ESMTPSA id gn5sm14690070pbc.29.2014.01.12.09.10.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Jan 2014 09:10:47 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.313.g5abf4c0.dirty
In-Reply-To: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240350>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1507-rev-parse-upstream.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 2a19e79..15f2e7e 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -54,7 +54,7 @@ test_expect_success 'my-side@{upstream} resolves to correct full name' '
 	test refs/remotes/origin/side = "$(full_name my-side@{u})"
 '
 
-test_expect_success 'refs/heads/my-side@{upstream} does not resolve to my-side{upstream}' '
+test_expect_success 'refs/heads/my-side@{upstream} does not resolve to my-side@{upstream}' '
 	test_must_fail full_name refs/heads/my-side@{upstream}
 '
 
-- 
1.8.5.2.313.g5abf4c0.dirty
