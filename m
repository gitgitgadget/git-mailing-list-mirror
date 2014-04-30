From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/6] completion: zsh: don't hide ourselves
Date: Wed, 30 Apr 2014 06:07:42 -0500
Message-ID: <1398856065-2982-4-git-send-email-felipe.contreras@gmail.com>
References: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 13:18:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfSX9-0003UH-VX
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 13:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758770AbaD3LSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 07:18:32 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:40523 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758656AbaD3LSb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 07:18:31 -0400
Received: by mail-yh0-f51.google.com with SMTP id f73so1446495yha.10
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ScLg815hCacWM+Bf1DSBs2wgCoWCWX3BnXGO64NVnm0=;
        b=YZ5+BDMcO29sKxnHbIeOBWYgtRz3bEXY1yGlSF1xqVplaqM9rmVwHFMP2jvoLgf3vA
         qd2LaLrEjgmqLFlZi7fauz7PQmI+Dgjf1cMXCGVH5agNjgSIJbOKEJbUEl6+kHuqa0HQ
         HEnIwSBF3a14HE05sR57rIGieK6N72Uu8zMDV1CW46N3Emk5ggZPOqQevs5LG2k5lE06
         tErYKhwi3KoSIUnh4AJpoZ66CIPwJX+zau051S41geaF3voULxFtlW7fYL7gS+niDi93
         HgbgFt6qbT46p9AjT5c195X9Wu78AykLMWbxA8FR9HiH8cWE6abiGj3DipHXAfmJ44x4
         etTg==
X-Received: by 10.236.128.47 with SMTP id e35mr4691973yhi.96.1398856710980;
        Wed, 30 Apr 2014 04:18:30 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id n5sm42276384yhn.43.2014.04.30.04.18.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 04:18:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.11.g71fb719
In-Reply-To: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247702>

There's no need to hide the fact that we are on zsh any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6b77968..6432b3f 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -39,7 +39,7 @@ if [ -z "$script" ]; then
 		test -f $e && script="$e" && break
 	done
 fi
-ZSH_VERSION='' . "$script"
+. "$script"
 
 __gitcomp ()
 {
-- 
1.9.2+fc1.11.g71fb719
