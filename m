From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] remote-helpers: rename tests
Date: Fri, 24 May 2013 21:38:25 -0500
Message-ID: <1369449507-18269-3-git-send-email-felipe.contreras@gmail.com>
References: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:40:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4PN-0007Gm-4s
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399Ab3EYCkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:40:17 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:54645 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab3EYCkM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:40:12 -0400
Received: by mail-ob0-f179.google.com with SMTP id wo10so2821133obc.10
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bTusMmjLy3evXOz7x5qjqVAz+f2Z6AfBFzZuYHbF0ss=;
        b=p0f5pNC0wd3ydKYvlTG50PnPNJaxww0jSAlLXhsmHxZxiuIpoNyTD8I/RCaHLwg/3E
         jzQDJ9dhmo6XFLwO097VlR2ACGLbV+vBlKjwojtLdc0GlI0AKiboBqr4vKmbsybtdtLm
         eh+Ht2+PubrVOljSGQ+Zb/ML1jQHnUU2120YVJUaGKtjTG/P5jDSjKwlmeum1/7UFj2t
         E+U5llZ9bKGDZoWY1fcGGCAXXg9ig5srXaZDeaPsu7MZ39EJXXfCvq+b650py8x8YFPH
         PDWikKRf1/rlF+2fs7m6QoasRTqNqE8a1Z0wnfSoP38znkCuergoOx5jBkE3irzYW4du
         xc9g==
X-Received: by 10.60.34.135 with SMTP id z7mr13597071oei.68.1369449612286;
        Fri, 24 May 2013 19:40:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm20112062obb.5.2013.05.24.19.40.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:40:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225467>

The .t extension is more standard for sharness tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/Makefile                                | 2 +-
 contrib/remote-helpers/{test-bzr.sh => test-bzr.t}             | 0
 contrib/remote-helpers/{test-hg-bidi.sh => test-hg-bidi.t}     | 0
 contrib/remote-helpers/{test-hg-hg-git.sh => test-hg-hg-git.t} | 0
 contrib/remote-helpers/{test-hg.sh => test-hg.t}               | 0
 5 files changed, 1 insertion(+), 1 deletion(-)
 rename contrib/remote-helpers/{test-bzr.sh => test-bzr.t} (100%)
 rename contrib/remote-helpers/{test-hg-bidi.sh => test-hg-bidi.t} (100%)
 rename contrib/remote-helpers/{test-hg-hg-git.sh => test-hg-hg-git.t} (100%)
 rename contrib/remote-helpers/{test-hg.sh => test-hg.t} (100%)

diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
index d9b3515..2c91ec6 100644
--- a/contrib/remote-helpers/Makefile
+++ b/contrib/remote-helpers/Makefile
@@ -1,4 +1,4 @@
-TESTS := $(wildcard test*.sh)
+TESTS := $(wildcard test-*.t)
 SCRIPTS := $(wildcard git-remote-*.py)
 
 export T := $(addprefix $(CURDIR)/,$(TESTS))
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.t
similarity index 100%
rename from contrib/remote-helpers/test-bzr.sh
rename to contrib/remote-helpers/test-bzr.t
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.t
similarity index 100%
rename from contrib/remote-helpers/test-hg-bidi.sh
rename to contrib/remote-helpers/test-hg-bidi.t
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.t
similarity index 100%
rename from contrib/remote-helpers/test-hg-hg-git.sh
rename to contrib/remote-helpers/test-hg-hg-git.t
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.t
similarity index 100%
rename from contrib/remote-helpers/test-hg.sh
rename to contrib/remote-helpers/test-hg.t
-- 
1.8.3.rc3.312.g47657de
