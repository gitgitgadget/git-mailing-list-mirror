From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 1/5] contrib/subtree/Makefile: scrap unused $(gitdir)
Date: Sat,  3 May 2014 22:49:31 +1000
Message-ID: <1399121375-14727-2-git-send-email-nod.helm@gmail.com>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
Cc: greend@obbligato.org, apenwarr@gmail.com, gpmcgee@gmail.com,
	peff@peff.net, mmogilvi_git@miniinfo.net,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 14:50:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgZOf-0002ev-DL
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 14:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbaECMuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 08:50:13 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:54190 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECMuK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 08:50:10 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so4666858pde.12
        for <git@vger.kernel.org>; Sat, 03 May 2014 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jm/kM/9BVA+dtHlzALYjF0/z2BdWwLY/GPW82/JJkFo=;
        b=Y+kr6ndFZZq3siDoGgCgUUwVSQxrcm+zyDdfvLEKEvQvWZQ35nCvMrWnf5B+z4aWh7
         OJF8x0jgdHX1A0Oil4dhax6jskNFM8yt6qIqMEsYyzSYfN78OkP4KmvzAd9ukuKnw9N/
         aD4fyu4WngAVAJHJDW2WjeR19l4ulsJ5vT0FTcsiF+z6kgeU11JjlVtqKe4u17sn+Nk6
         wBEXNxjXURqy8qiWYixmYW/WWnIqrWwh94w8KrW1WWED7nNvh0cqJaSH7ibM/nVtI7RN
         hDfKNQh1A2xLj8oQyGKddTKRlAxgMtMwiIWd9TIaL5mJXb0Cu2fCGKAUxnyblykwsb66
         XYBw==
X-Received: by 10.66.147.99 with SMTP id tj3mr17228614pab.47.1399121410051;
        Sat, 03 May 2014 05:50:10 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.56])
        by mx.google.com with ESMTPSA id lr3sm18047379pab.4.2014.05.03.05.50.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 May 2014 05:50:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
In-Reply-To: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248039>

All references were removed in 7ff8463dba0d74fc07a766bed457ae7afcc902b5,
but the assignment itself wasn't. Hence, drop gitdir assignment.

Signed-off-by: James Denholm <nod.helm@gmail.com>
---
 contrib/subtree/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 4030a16..87797ed 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -4,7 +4,6 @@
 prefix ?= /usr/local
 mandir ?= $(prefix)/share/man
 libexecdir ?= $(prefix)/libexec/git-core
-gitdir ?= $(shell git --exec-path)
 man1dir ?= $(mandir)/man1
 
 gitver ?= $(word 3,$(shell git --version))
-- 
1.9.2
