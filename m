From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 1/7] t5520: use consistent capitalization in test titles
Date: Sat,  2 Apr 2016 23:28:26 +0530
Message-ID: <1459619912-5445-2-git-send-email-mehul.jain2029@gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 20:00:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amPqA-0008LQ-P2
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 20:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbcDBSAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 14:00:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34929 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbcDBSAA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 14:00:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id r187so7509005pfr.2
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gJ/8SZT6pKZJwastvZE3iqJjWgJnDuX4r4eUWgN3aUw=;
        b=b20wOT0IYTrS6ytfAVTE8k/52VV/rfg/ufP/9sW9m1vVyW6jiOAQnRoFXAqHPOSBVO
         CXpwYw9/eoAhM5qtdDHIyi1/SH0NS6SWYmIj/SELtmcp+5TuVQEJEYJUELa1U+L3PbyX
         3P0NRYBuE+nVEU5NVZH7dJ8uAQABtDQADVsmbl/vIHQScSjM2KSYVZCbQo0v/KYvv22S
         NfehxeYTUQpqC3lh4rsKhpDCDTYxLKdh43golM5SNh4+M3rhj/jyqt/9HDCympsWvZqt
         XTSJmDVqssxgHqJd3Ha359pMKfl7Oh955xxEaZFDoqB0T7DKmBslWmfZbnBlNWHoqU8T
         w+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gJ/8SZT6pKZJwastvZE3iqJjWgJnDuX4r4eUWgN3aUw=;
        b=AZ7U3oJe0ZU6lKls3vavFLCmhsMxGjPfRKxqhONkx6I1tXmg+NhSezWuo/juJii2RX
         Um4WpZRXp8qmhIPGCgg+fpZQ42VEK6NB2SxYtVLkrzveMrxOJ+NBlAWyuO748r/wMkLM
         r5soo6rQIHvyAj972Ftt+ieX2ndIZHjwvxgy3bYw/QYHAdRTxiLvVkz3RtCzk8wTEhVL
         IfH+TI2dm0HmwqbSDyV+/zupJD27gzSzjaFI7ofmaKZ31QfPwtlhDf9/gb3G2TOk5l2i
         anc6xJdc2FByVUc6lwyR7Ze05yz6zEeLiqA//LJTbGTaHzKKuS0fvPpse2ejJw9qKLZo
         kPYw==
X-Gm-Message-State: AD7BkJIKHYf1tPswsFxqOrmeQ0kT6YTq8oGLxcqKVjIFsUkLsfczSxv479axWal2DxC/Ng==
X-Received: by 10.98.73.132 with SMTP id r4mr7834518pfi.118.1459619999522;
        Sat, 02 Apr 2016 10:59:59 -0700 (PDT)
Received: from localhost.localdomain ([1.39.37.116])
        by smtp.gmail.com with ESMTPSA id v3sm30495734par.17.2016.04.02.10.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 10:59:58 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290597>

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 745e59e..5be39df 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -267,7 +267,7 @@ test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
 	test "$(cat file)" = "modified again"
 '
 
-test_expect_success 'pull --rebase --autostash & rebase.autoStash=false' '
+test_expect_success 'pull --rebase --autostash & rebase.autostash=false' '
 	test_config rebase.autostash false &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
@@ -278,7 +278,7 @@ test_expect_success 'pull --rebase --autostash & rebase.autoStash=false' '
 	test "$(cat file)" = "modified again"
 '
 
-test_expect_success 'pull --rebase: --autostash & rebase.autoStash unset' '
+test_expect_success 'pull --rebase: --autostash & rebase.autostash unset' '
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
-- 
2.7.1.340.g69eb491.dirty
