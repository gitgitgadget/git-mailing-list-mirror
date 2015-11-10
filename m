From: Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH v2] contrib/subtree: remove "push" command from the "todo" file
Date: Tue, 10 Nov 2015 19:02:41 +0100
Message-ID: <1447178561-16738-1-git-send-email-fabio.porcedda@gmail.com>
Cc: git@vger.kernel.org, James Denholm <nod.helm@gmail.com>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Danny Lin <danny0838@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Thomas Ackermann <th.acker@arcor.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 19:03:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwDGS-0000rI-LD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 19:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbbKJSC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 13:02:56 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35958 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005AbbKJSCx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 13:02:53 -0500
Received: by pabfh17 with SMTP id fh17so495108pab.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 10:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8dr+X63hoq1Zn/HmvnJvSDdTnDUFKW4nl9iUN20De4A=;
        b=TX9EikHh07tyAmRvyI7VYlZlwUFVFGZ+5+lHMY+fD1joLgweO98j695kAIaNRyknb1
         hUi5B5yzUOt7NEEx09ufaejbS0JIejLajNuwyx/XNYiBbCCq3Y0i5vc7JCSzsTFAIhNo
         /4n+mr3LU7fa3G3xfjPvKzqq3b+ta0h7+xRIW1YwlIoOsXVwVsdyzppZ92yj5tkCs7yT
         /yEaUr1OULaBu5pFvkAiuh8x/9yOGf3EBO0lJVs41QDIfIWUHwqfhXHsWwsUwE45K9jz
         SKCzlteNa5xHIXxapyXI5pQUaRsBu4uOtRTbkSakxCbJMAm+7h6gTowNbAl4QNZWakf+
         QMjw==
X-Received: by 10.68.87.4 with SMTP id t4mr7648881pbz.61.1447178572920;
        Tue, 10 Nov 2015 10:02:52 -0800 (PST)
Received: from ld2077.tmt.telital.com ([213.205.6.118])
        by smtp.gmail.com with ESMTPSA id y3sm5299609pbt.23.2015.11.10.10.02.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Nov 2015 10:02:50 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281126>

Because the "push" command is already available, remove it from the
"todo" file.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 contrib/subtree/todo | 2 --
 1 file changed, 2 deletions(-)

diff --git a/contrib/subtree/todo b/contrib/subtree/todo
index 7e44b00..0d0e777 100644
--- a/contrib/subtree/todo
+++ b/contrib/subtree/todo
@@ -12,8 +12,6 @@
 		exactly the right subtree structure, rather than using
 		subtree merge...)
 
-	add a 'push' subcommand to parallel 'pull'
-	
 	add a 'log' subcommand to see what's new in a subtree?
 
 	add to-submodule and from-submodule commands
-- 
2.6.2
