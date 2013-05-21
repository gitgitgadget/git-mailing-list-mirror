From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] remote-hg: trivial configuration note cleanup
Date: Mon, 20 May 2013 22:47:52 -0500
Message-ID: <1369108073-29275-2-git-send-email-felipe.contreras@gmail.com>
References: <1369108073-29275-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 05:49:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueda1-0000nP-N8
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 05:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab3EUDtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 23:49:33 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43256 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab3EUDtc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 23:49:32 -0400
Received: by mail-ob0-f174.google.com with SMTP id fb19so190724obc.19
        for <git@vger.kernel.org>; Mon, 20 May 2013 20:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iEqS4G627Azr7Taw8ljmUswtrk9Gvmf3yMYWqjpP6TE=;
        b=IenjPVY3cAjgy/H0MFx2ssqhjA6hoI6wh5EKgpIeeb0wK2c3Tv0oCnKEXMIM3lwGZJ
         1LuFpmuBtNrS+tNZtIpEo3yasGNU06PcQPOvTbCduM1bxOFdCSkIzzU6Q4lnLJZMa43e
         WZxS6Gb1u5woZZfm+wWuakwKz/6RjCt6vWz6npz/hLT/uCRWBslFGtN8O+xri6aacC0D
         gCRD+omeVpOxU+kKAZjlgDX9nnb+TaDBJEkgRWamuZinQLtzEPy8FXOPvcKaJsLC7/Lf
         aXhg6JRa/S0rV4uLQzoFzR6FxLfM7WH3YhLw4Yh8KRCHJkhfj6aA+XL6cwMvjCFaGfBS
         ncPw==
X-Received: by 10.60.125.132 with SMTP id mq4mr233353oeb.79.1369108172149;
        Mon, 20 May 2013 20:49:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm961601oez.4.2013.05.20.20.49.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 20:49:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.1.gf11a2b7.dirty
In-Reply-To: <1369108073-29275-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225015>

Follow the style of the previous configurations.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index beb864b..88db7c4 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -36,7 +36,7 @@ import urlparse, hashlib
 # git config --global remote-hg.force-push false
 #
 # If you want the equivalent of hg's clone/pull--insecure option:
-# git config remote-hg.insecure true
+# git config --global remote-hg.insecure true
 #
 # git:
 # Sensible defaults for git.
-- 
1.8.3.rc3.1.gf11a2b7.dirty
