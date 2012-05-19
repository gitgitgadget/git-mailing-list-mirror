From: Subho Sankar Banerjee <subs.zero@gmail.com>
Subject: [PATCH][GIT.PM 1/3] Ignore files produced from exuberant-ctags
Date: Sat, 19 May 2012 12:38:35 +0530
Message-ID: <1337411317-14931-1-git-send-email-subs.zero@gmail.com>
References: <7vobpulhbk.fsf@alter.siamese.dyndns.org>
Cc: Subho Sankar Banerjee <subs.zero@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 09:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVdmx-0006ae-IH
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 09:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757257Ab2ESHJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 03:09:06 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46365 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406Ab2ESHJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 03:09:05 -0400
Received: by dady13 with SMTP id y13so4725603dad.19
        for <git@vger.kernel.org>; Sat, 19 May 2012 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UIkkZV976qJJnu6s6WxmPfnM3BzssQ8EfmSOyQ7j/d8=;
        b=fEzhOPMVZS0S2EqbkgIUJ/p9qHVQXGPfTc4DHVzEl4NuY8c6UzvQd2+qlN0DwP/5wj
         fa/QeE1k6t6kA3p+UCeXXMdTLiVBGjx5UW8+nu00p/1PBaq7Xhz56HgN4UPyw4g/CkMR
         FoYiz7u36xh+BnMeUumT8Z5wqOJwe8HEGp/9cvOoHdm5aytyPmjnIxUNSH1W2nqB+UVG
         UXbJ2LFQuFLGc1cF5dhHAzr4QeEnXcvGupDw0RXM67e/RvKKYgAisL0ho2lwx6f2Xpbb
         UECbjq4Wlwnqg494bnJKulr8xueL+F9p56FaUtDAsk1nKbU29zyaqBS4LfdLk26aEOFC
         rtOw==
Received: by 10.68.217.233 with SMTP id pb9mr47297403pbc.59.1337411344797;
        Sat, 19 May 2012 00:09:04 -0700 (PDT)
Received: from localhost.localdomain (triband-mum-120.61.158.30.mtnl.net.in. [120.61.158.30])
        by mx.google.com with ESMTPS id rj4sm15424408pbc.30.2012.05.19.00.09.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 May 2012 00:09:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vobpulhbk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198020>


Signed-off-by: Subho Sankar Banerjee <subs.zero@gmail.com>
---
 .gitignore |    1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index fb7d559..8ecd336 100644
--- a/.gitignore
+++ b/.gitignore
@@ -219,6 +219,7 @@
 /configure
 /tags
 /TAGS
+tags
 /cscope*
 *.obj
 *.lib
-- 
1.7.9.5
