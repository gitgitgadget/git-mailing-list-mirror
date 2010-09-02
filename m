From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 17/25] builtin: use builtin.h in git-reset
Date: Thu,  2 Sep 2010 19:40:38 +0000
Message-ID: <1283456446-22577-18-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFgR-0006jt-ON
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab0IBTmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 15:42:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61967 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756629Ab0IBTmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:42:23 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1282023wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CEgdY4FsvSUYvgILePlUWOyXPsFjU/JvoUMDNU/k8cU=;
        b=Rc9QanNTmm1zXF5sRM5zvcxvqCufaoMUkJBu+mxjVzi2P3l7Nj0E43cYTyM0xLV03c
         bJg9vThs+SHKFFiyKcTFkW4jFup0I/osmMnB1oSpGR6TazcSHBO83IFrmdWLYpvGo17g
         a+ggLKbGKcn4pTGBmBjBcCzRtazYSY7SjxlzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PaGF/CNbYOiOqcqUFM6LaJ66Un0LhryWx1rXwxrKM9rPLB34Au4WV8cl716aS9pWDb
         i0OUVuEdvHC0cOrJD4Z1ybwVVQFwgDZiSt7IawWuPEW1qZKxIJkZQPs0N7SaUjr68riF
         nWy+bK6TgeYo4+hDBdsVvC2pOC4IzYLqdr7A8=
Received: by 10.227.142.139 with SMTP id q11mr45814wbu.103.1283456542477;
        Thu, 02 Sep 2010 12:42:22 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.42.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:42:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155175>

---
 builtin/reset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 0037be4..c198b8e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
-#include "cache.h"
+#include "builtin.h"
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
-- 
1.7.2.2.614.g1dc9
