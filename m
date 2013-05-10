From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] test: remote-helper: add missing and
Date: Fri, 10 May 2013 07:08:29 -0500
Message-ID: <1368187710-4434-2-git-send-email-felipe.contreras@gmail.com>
References: <1368187710-4434-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 14:10:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uam9K-0000jF-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 14:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485Ab3EJMKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 08:10:03 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42809 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3EJMKC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 08:10:02 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so4784178oag.19
        for <git@vger.kernel.org>; Fri, 10 May 2013 05:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=qJUFwVUClKJEx2oczzF+beiBsloFAhLJ7Gix7zo4LN0=;
        b=0cb083IagEwcOb6YH14Q7BJhmu7UyZA1poOkAe2WVWejkHEryfLZzTwBOG5Y4d5GbG
         AAqBKjvhDafEcYdQfYGa2bQz5NVWqeFd3G3IoQjPmHXnkf1mmpm6CraOVIILqCB4shkm
         XrYavReLru4Ib73CbuYEPeBNHWl28KLisydo/evw60+hzE25o/Jo5VLUAKOcIf1aCDkQ
         pvz1iCSL+wfcd7euOrvn56XgQXg5wLJ4pGcXFFp4ZR6/21fQOh9Xp4fQGUCuYc96brUl
         b/3+dZtUbdg9ofxjnxwNhjziV07lpY39RsTvZQB5vuhYMhEKl3apNU4PYhKspR3pn9rQ
         p8dA==
X-Received: by 10.60.97.4 with SMTP id dw4mr6683513oeb.75.1368187800790;
        Fri, 10 May 2013 05:10:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id xz9sm2514158oeb.5.2013.05.10.05.09.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 05:09:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368187710-4434-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223834>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 61479c3..352115c 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -175,7 +175,7 @@ test_expect_success 'push update refs' '
 	git checkout -b update master &&
 	echo update >>file &&
 	git commit -a -m update &&
-	git push origin update
+	git push origin update &&
 	git rev-parse --verify remotes/origin/update >expect &&
 	git rev-parse --verify testgit/origin/heads/update >actual &&
 	test_cmp expect actual
-- 
1.8.3.rc1.579.g184e698
