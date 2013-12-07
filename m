From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 5/6] test-hg.sh: tests are now expected to pass
Date: Sat,  7 Dec 2013 15:08:11 -0600
Message-ID: <1386450492-22348-6-git-send-email-felipe.contreras@gmail.com>
References: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 22:16:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpPEM-0002zd-UC
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 22:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759074Ab3LGVQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 16:16:00 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:32929 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919Ab3LGVP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 16:15:57 -0500
Received: by mail-oa0-f44.google.com with SMTP id m1so2342264oag.31
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a+XPokiJZ/Rlf6WU09fKABUNPT6KyHVtf/f88Zlzd5c=;
        b=RBDu9KR0bsfTUsFktOF5p41wQ4zJpU7lXzsQ0jFH9gvVF1lM+CGZ+qx4+gjOgoBgl3
         IhtyIJM6ltRAZbi+MTr+/xj+bZBKIwEgdBNf/OEvZrI4igv89Xyu6Dw++O4GusgbDkVY
         UhpVSBkZ488aJJHOyiVDCQ0za9TxG+LhIseQ/QGqz/lHR17QcqHIKkrXI7kXyHxv4ZDP
         oXcROOTdmlbuRTYkRdHcsM4XSqbJpD7mA4WpdAyUI7AHFZGxYcsLNQEpN7MinWtAr7U0
         Qovu2IBVYYAwmBpWjkRIzQ6NyNiSeJ43HPrrNon4/d/1wk+9HT07cxiSWsj1ySXGs5M7
         9lew==
X-Received: by 10.182.148.106 with SMTP id tr10mr361795obb.65.1386450956674;
        Sat, 07 Dec 2013 13:15:56 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm5930818obg.13.2013.12.07.13.15.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 13:15:55 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1
In-Reply-To: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239025>

From: Richard Hansen <rhansen@bbn.com>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 72f745d..aacd8a9 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -599,7 +599,7 @@ test_expect_success 'remote big push fetch first' '
 	)
 '
 
-test_expect_failure 'remote big push force' '
+test_expect_success 'remote big push force' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	setup_big_push
@@ -629,7 +629,7 @@ test_expect_failure 'remote big push force' '
 	check_bookmark hgrepo new_bmark six
 '
 
-test_expect_failure 'remote big push dry-run' '
+test_expect_success 'remote big push dry-run' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	setup_big_push
-- 
1.8.5.1+fc1
