From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH 1/5] t/t5520: change rebase.autoStash to rebase.autostash
Date: Tue, 29 Mar 2016 18:59:56 +0530
Message-ID: <1459258200-32444-2-git-send-email-mehul.jain2029@gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:31:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktjj-0004uX-9Z
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbcC2NbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 09:31:07 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35798 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbcC2NbG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:31:06 -0400
Received: by mail-pf0-f196.google.com with SMTP id u190so2350616pfb.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gJ/8SZT6pKZJwastvZE3iqJjWgJnDuX4r4eUWgN3aUw=;
        b=ZcK+2TfkS+0aKNS1MTZLEgvKYe0IlZGxcLE5Zz8+7qJlzFbEnb83ybP+UcpCKb5fE2
         g5IvEPPdAjt5FopUa+QqhJVsBlzW75rO85zwLJq4Y4wSiw2Hi40k61LkHcm2WaVGIXkz
         3fGnYW1Oew5tlkArdwZ+ziFsHkQOXG9um/+06/U3ErIlnLOs7xyFmmkqr8W65qvV4e0O
         EjpY5yrdVWl/fcEWf9Q5QA516H7hgZ1/WSbv67we8NbKi0JunKxgaZTUcrRfZIBwNlD4
         YovY1PXX21IKrS2rBbqGgChlB4QfTuIGuu1AkxGiuVH5r8hEwr5ldExsKVuxlBL6TgWQ
         b9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gJ/8SZT6pKZJwastvZE3iqJjWgJnDuX4r4eUWgN3aUw=;
        b=Yb2XmL/NINrZv8B26HQ4bcxLj3CoojbiCcAff9Eln8wGWXuqNW5QV+FnZJtW6PqUcu
         MGtrEslA2tZ76ecmPSYQuJ5fJ5Ebuavuj/pZceZdWhXKgk6ZKw7+BNyPxfPYVyCHaVrG
         38IvxpQsDfxmaz7FVB3XF3z0K38SNmGZ5NxgPA4mHvlQko4kF/d7q3LvgJjUVUoGJhlF
         rIU6Vi+YIFhR7pihpyxdD4SQfq5oUZHWaTxPEMRAp56Sb3qLaCPrHYoo1dVX6pIc9Gcg
         UZbsu9IlOUSrQTN5othc212+Mv1ggM6o9vAx0sXu7SWh6FJ90jAaiG2b7OgaEDqxEt3y
         918g==
X-Gm-Message-State: AD7BkJLyxlppe0eEd/Zf5I+CN0z+ODc/ghOXsxVvxx8yq7z/c/Ty8OiCx4pcyDQgVV45cQ==
X-Received: by 10.98.32.23 with SMTP id g23mr3522370pfg.74.1459258265231;
        Tue, 29 Mar 2016 06:31:05 -0700 (PDT)
Received: from localhost.localdomain ([1.39.38.29])
        by smtp.gmail.com with ESMTPSA id s66sm43430514pfi.3.2016.03.29.06.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 06:31:04 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290135>

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
