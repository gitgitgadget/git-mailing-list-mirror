From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/4] ls-remote: fix synopsis
Date: Sun, 17 Jan 2016 12:04:00 +0100
Message-ID: <1453028643-13978-3-git-send-email-t.gummerer@gmail.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Jan 17 12:03:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKl7j-00054T-OD
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 12:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbcAQLDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 06:03:51 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35175 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbcAQLDt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 06:03:49 -0500
Received: by mail-wm0-f68.google.com with SMTP id 123so3885368wmz.2
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 03:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0d0ogHtr4YFoIgSy3uiMwYWUWaNvfVrNKVqTgdN3GMw=;
        b=ul52fa5SSpSExkTUx6z+6YEc8CQz5JSEIcj1dlvIjeA2x3jNFcdjIkhMJ/z8fLxt5T
         LuJ2sik6ADjgdLUrL/41J9xxGoGSdfti/ySMObAj5gS5zoElbzAfB9shpQ/HDkrdCvhb
         h/uSKmGiGdMpOGKyo23gJO4kZ0CLQ1PKv5MtuXsBIPeHqDK4eIYpKeQ0CjBr8R51RY81
         yzbQwEdCd7cHWuRJVZkQl17AWvsynh1NB5YClJnwwBdplkUFZMCkCRwbMOux/u+5QlEk
         vf72EJXFx1u23g8Rp8h10j8IUjb2qi6obtgzVG1syd3SjOKWZxK+YgODA4DsdyZxZ+ti
         94Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0d0ogHtr4YFoIgSy3uiMwYWUWaNvfVrNKVqTgdN3GMw=;
        b=Q1RZWiplNiUAM4SXz/binbx8z/+8QT+9reyfmVu1fkgP2Lak7MW+tVCwEdRurGhJU1
         ed4f8pudC8lTxHH39QHVm6gntrZqXvPD0uBs1/S/n468yFcabX4aOgwCoDiqXp7STKp/
         fpkefFBwwJ3S2vLuaO1yS4AmlrgtwWLMaqREz7spkHtSpLQw+r5adio3p3zi9cL9GFxM
         byMu3HQzNgMeYSXHvBcy7EFI+2Ao9482GdKicnkL5X6FUuKjtmxUcHYyK7uNKqAwCKr1
         2ZBHJiaRw5rpQLh3ppQNekuPo4Tl6d3oMUx/LxErg0JWD8xBcolbQ3H7jqs19nteGOlq
         haew==
X-Gm-Message-State: AG10YOST4up+HxQc+2HpfU5AbqolTn5/J5D7tUQw33yMBSDRJCyA71bEXjH/VxPwo1r/FA==
X-Received: by 10.28.1.210 with SMTP id 201mr7918282wmb.90.1453028628726;
        Sun, 17 Jan 2016 03:03:48 -0800 (PST)
Received: from localhost ([95.233.44.41])
        by smtp.gmail.com with ESMTPSA id f205sm10749046wme.4.2016.01.17.03.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 03:03:47 -0800 (PST)
X-Mailer: git-send-email 2.7.0.14.g2b6d3d6
In-Reply-To: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284250>

git ls-remote takes an optional get-url argument, and specifying the
repository is optional.  Fix the synopsis in the documentation to
reflect this.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-ls-remote.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 27380de..31c1427 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags]  [--upload-pack=<exec>]
-	      [-q | --quiet] [--exit-code] <repository> [<refs>...]
+	      [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]
 
 DESCRIPTION
 -----------
-- 
2.7.0.14.g2b6d3d6
