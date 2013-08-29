From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] completion: update 'git reset' new stage options
Date: Thu, 29 Aug 2013 13:19:57 -0500
Message-ID: <1377800397-5434-4-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
 <1377800397-5434-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:25:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6uU-0008Ez-6E
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699Ab3H2SZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:25:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35148 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212Ab3H2SZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:25:29 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so869940obb.19
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wRspvZlnoCX3f7gx7z/H9+ste1lgIlFtUmhIp7rQfn0=;
        b=DaUJIBB2+4GKnymw40CFjlc9qZCyt1wxiAzqASvM8U5R7Q9K3VPjOi0j6feDCy6+T9
         Q0xYhCxY93xIqNcRbAQlKtm5cZhMi3X4rCPYvhKeUdHmmHOZEaQ8+DjQsdicv+dE2JI6
         J4bmhcfuQiKXgXSs1GFd/jc+nimDl5H+6/FhCb0UW9y15vV78b6L/CADnMfswoRfrBPB
         7nS+Un3Uw6kbOrJLhpTNEmN9pV3SMy/t1V7NHFXb+AaR2OFeTAuj4hE7UOLB36zeJE6V
         BvjBKgyON0gi8dTJDeqPUd5mxuy5NtOLDD20nbxjXvie1BaJ7YLJGUak64eelY0d5tZ5
         IFrA==
X-Received: by 10.60.70.134 with SMTP id m6mr3567004oeu.14.1377800729349;
        Thu, 29 Aug 2013 11:25:29 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm32711345obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:25:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377800397-5434-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233323>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4adc4ed..24b2c22 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2207,7 +2207,8 @@ _git_reset ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "--merge --mixed --hard --soft --patch"
+		__gitcomp "--merge --mixed --hard --soft --patch --keep --merge
+			--stage --no-stage --work --no-work"
 		return
 		;;
 	esac
-- 
1.8.4-fc
