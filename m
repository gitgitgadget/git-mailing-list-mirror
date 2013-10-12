From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/20] revision: add missing include
Date: Sat, 12 Oct 2013 02:07:10 -0500
Message-ID: <1381561636-20717-15-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOh-0005u7-AS
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab3JLHNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:55 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37564 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab3JLHNx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:53 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so3107924oag.5
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iVpKRs+Y2v54PwMuSH8HoVqS075tlhWFR3LaT5lzKIg=;
        b=GkCWfVb3junHnGt4jlYJv113oVxm64QXaOq8ZDZOBGO4OThqRUsOwR3Uk39rykjNDk
         WblghKXsT1xcdrBVw90cjtsvIIIj0QMhZGSDQ9f1iFnsCWtLAKx3TAXGe9LgkddCneDJ
         ThRUyxdvPGEh2tJlNK6IGCotSb1A2Hobr6sD0MF3znCY6ZDgT1/DLofhA+6vgmc9PD/5
         jWlyMfRuNWXN4O8KzANfgLBCoYYRHBLYAhI/uUBy2GVHMXcuvnItYY86u7v2Yg+Efyrg
         q14fyp6dSNnUj1ofjWTk21rbpTO8qVxk8lxHS/2vEu9wTTJte7QK6plCIWXevuO7y1NO
         gZrQ==
X-Received: by 10.60.51.196 with SMTP id m4mr17700798oeo.1.1381562032706;
        Sat, 12 Oct 2013 00:13:52 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm101401008oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236022>

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
