From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/1] clean: typo fixed
Date: Fri, 19 Dec 2014 14:37:47 +0600
Message-ID: <1418978267-15282-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 09:38:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1t57-0003yT-DT
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 09:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbaLSIih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 03:38:37 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:48084 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbaLSIig (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 03:38:36 -0500
Received: by mail-la0-f51.google.com with SMTP id ms9so436950lab.10
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 00:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=u5jKIn3PWo56OYqp5EwlzZugcTQNX4F8ENjnFyDBK6k=;
        b=dBWAsqEfyvpUIsxHNib3gLxn3Ek5TJqHorvuH5/tQaBySiqtQW4Fu5OHbBkAkCMGKP
         ollCer1rC+fVwPXVqyHghqZb/iejirQDEp9pQtU7zNoBB+gk/197LgDk4jLSPhQNW2gl
         WuIdhbqn62XzoH03rYtPL22eExbkf3DoI+1uJcoqcT2E2MEQSuh3tfM2nQGZ6TRwFoyd
         uFfVXGsHGeail1sSJwkH0gt4z9azEYvp9z6f8eTytV8SVHNYNoMyI8N+Hn8L1k63c5lO
         q5dxDmoT6jnmkp+D0LqTXdITK5ZQDNN87n5i+arEvP2qqUp9Q5Fvz8uP/PH/9giLet3z
         XaVg==
X-Received: by 10.152.7.180 with SMTP id k20mr6783813laa.4.1418978315060;
        Fri, 19 Dec 2014 00:38:35 -0800 (PST)
Received: from localhost.localdomain ([178.91.244.30])
        by mx.google.com with ESMTPSA id y5sm2514570lag.7.2014.12.19.00.38.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Dec 2014 00:38:04 -0800 (PST)
X-Mailer: git-send-email 2.2.0.66.gda9d48c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261550>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/clean.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 7784676..7e7fdcf 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -321,7 +321,7 @@ static void print_highlight_menu_stuff(struct menu_stuff *stuff, int **chosen)
 
 	switch (stuff->type) {
 	default:
-		die("Bad type of menu_staff when print menu");
+		die("Bad type of menu_stuff when print menu");
 	case MENU_STUFF_TYPE_MENU_ITEM:
 		menu_item = (struct menu_item *)stuff->stuff;
 		for (i = 0; i < stuff->nr; i++, menu_item++) {
-- 
2.2.0.66.gda9d48c.dirty
