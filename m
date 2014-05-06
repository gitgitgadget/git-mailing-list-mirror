From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 1/5] contrib/subtree/Makefile: scrap unused $(gitdir)
Date: Tue,  6 May 2014 22:41:45 +1000
Message-ID: <1399380109-3805-2-git-send-email-nod.helm@gmail.com>
References: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Cc: git@vger.kernel.org, James Denholm <nod.helm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 21:26:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiQj-0008Bg-Gv
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757491AbaEFMmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 08:42:20 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48080 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361AbaEFMmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 08:42:18 -0400
Received: by mail-pa0-f47.google.com with SMTP id fa1so11029062pad.34
        for <git@vger.kernel.org>; Tue, 06 May 2014 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t557CVoRJAv0RyH4io2DD+sQpz1QgUyMPtcaw75K2kg=;
        b=w6ryurKXotZBhm5enFX6SadG62UaTL64VTqcSTtx99m71leL41MZXigfSz7CIsqE2a
         Q8WF7yNfF2rekJe7PSA++Vve8wf4QIY1P9jvGlTJl70Bu1B+zbo+66mFt30Q03xs+Zrp
         KTg6fd4kGJYIt1m6fbJPKdUP+Mugz7B1wtcMNYw9cu60VaLiVTbqV5tGGQLfvbtW/aU/
         nqj33cmCbgsY/rRYFQyFzhcDVJ8xUSUT8if0HZwXzqJlvWm/MQ46IoUnI2OI0/r3R1QA
         xCktXhMNya7r07eKGDw+xkxR4maPRAe9bNhChDBurNtb0VuF+G12I0bt5j2KoQBGLM1/
         bazg==
X-Received: by 10.66.120.201 with SMTP id le9mr5768211pab.98.1399380137640;
        Tue, 06 May 2014 05:42:17 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.162])
        by mx.google.com with ESMTPSA id iv2sm133398pbc.19.2014.05.06.05.42.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 May 2014 05:42:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
In-Reply-To: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248221>

In 7ff8463dba0d74fc07a766bed457ae7afcc902b5, the references to gitdir
were removed but the assignment itself wasn't. Hence, drop the gitdir
assignment.

Reviewed-by: Jeff King <peff@peff.net>
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
