From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/10] revision: add missing include
Date: Sat, 28 Sep 2013 16:51:41 -0500
Message-ID: <1380405106-29430-6-git-send-email-felipe.contreras@gmail.com>
References: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 23:57:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2WR-0002J4-5u
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab3I1V5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:57:49 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:50889 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143Ab3I1V5s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:57:48 -0400
Received: by mail-ob0-f173.google.com with SMTP id vb8so4180148obc.32
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iVpKRs+Y2v54PwMuSH8HoVqS075tlhWFR3LaT5lzKIg=;
        b=rbqv3jJ+omKrYfIqNzxLJuTsOvQpwewePtYJTN2IZ8ZZ8/a3ukpj8l9LvNm+DsZOtZ
         6SK5tItk4+D4J6X0cgmHHXd1VxnjmeCz5D5DuWzQ/RdtO39RyjESi3t5y45dkIsQdFQa
         Y4sJJgp4WCnLHoOO/wOP6/VINPcYo/IThGxA68BSuRWtx60dr2n/izskhRUy/Xo3QmFW
         GeeZJaVpim6soETesy/2OvYfMtpZ/chPhh2GBqt7YJs8dORwJCw2tsmTOZgCoRkp6Llc
         5A8Fy4QvAHJRCgb4NVK2EyIYK8sLh3jYFsckb5GUfTZ3N34XiJ7X1ydAPEiPVP9HLFCg
         nGmg==
X-Received: by 10.60.118.41 with SMTP id kj9mr12197759oeb.31.1380405467653;
        Sat, 28 Sep 2013 14:57:47 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm19422623obc.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:57:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235514>

Otherwise we might not have 'struct diff_options'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 revision.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.h b/revision.h
index e7f1d21..89132df 100644
--- a/revision.h
+++ b/revision.h
@@ -5,6 +5,7 @@
 #include "grep.h"
 #include "notes.h"
 #include "commit.h"
+#include "diff.h"
 
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
-- 
1.8.4-fc
