From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] completion: clarify difftool completion
Date: Sun,  2 Jun 2013 19:33:41 +0530
Message-ID: <1370181822-23450-6-git-send-email-artagnon@gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 02 16:06:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uj8vO-0000xD-Er
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 16:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab3FBOGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 10:06:17 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:64725 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab3FBOGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 10:06:09 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so4487511pbc.9
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 07:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CJuqXum389y4zbf3jRiHHl3a7h1kToSm3hvL5MEuxyQ=;
        b=LG9nQUcN6JXiB5ZYja/+6kcEAZCdwNGzooWOPwLXf7b9iI2uxoIqsd34jN4EwiMeo5
         Ke1NnZGOGwVdrdqFGcIeCPYddRXfXT5WYXI9fIrHS8YDi6CfG4154sd7FFnhqDJ20LE7
         Gi22DT1j3M+dS1zrOb9OWlDxBbkcq8T+DZPUAE0D7YrYTrhqk9oZIexGaHmlf5vEiKUe
         HNInbMuoLWDEOnaE/5+0u/7Pz8yN86BImnhPPewrkKPXx5eDHzFjB60fL9ao8ssfdEf0
         DgzLEjamN070aaOVT/sEJCVkFCskXYxLeLYiPVXw0lT+7UXEFsWER7GoPY/8Ktnp5rVo
         Xffw==
X-Received: by 10.66.197.165 with SMTP id iv5mr21308414pac.67.1370181969281;
        Sun, 02 Jun 2013 07:06:09 -0700 (PDT)
Received: from localhost.localdomain ([122.164.162.188])
        by mx.google.com with ESMTPSA id aj2sm55150689pbc.1.2013.06.02.07.06.07
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 07:06:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.457.g2410d5e
In-Reply-To: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226157>

'git difftool' is clearly a frontend to 'git diff' and is used in
exactly the same way, but it uses a misleading completion function name
__git_complete_file (aliased to to __git_complete_revlist_file).  Change
it to use __git_complete_revlist_file, just like 'git diff'.  No
functional changes.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f46964d..8d70c30 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1305,7 +1305,7 @@ _git_difftool ()
 		return
 		;;
 	esac
-	__git_complete_file
+	__git_complete_revlist_file
 }
 
 __git_fetch_options="
-- 
1.8.3.457.g2410d5e
