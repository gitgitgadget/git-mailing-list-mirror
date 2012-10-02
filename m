From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH v2 2/2] gitk: Use bindshiftfunctionkey to bind Shift-F5
Date: Tue,  2 Oct 2012 11:04:45 -0400
Message-ID: <1349190285-7788-3-git-send-email-andrew.kw.w@gmail.com>
References: <7vwqzacdb7.fsf@alter.siamese.dyndns.org>
 <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
Cc: gitster@pobox.com, szeder@ira.uka.de, paulus@samba.org,
	Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 17:05:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ425-0006xZ-Tv
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 17:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab2JBPE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 11:04:59 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64255 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab2JBPE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 11:04:58 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so14848778iea.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pxlHqt0KGKpijumadI7/+graQ3Fz8wU99e0+h5jdCTA=;
        b=K5bZriiXXQ/176y9wM/j5I6qApBs0LI/FYF5ukuSNx+RHlcX9hl6691QV+aS/xl9qU
         7SCIt/t2LpD6ikZOO3zs8R0gUEUmfEuUWaDw3tSFHUtO4PaO5vqkhT0t4tLMDZ3lQBXz
         9M1i3bKXDUTz3ixd7XkCbSSWhYo1ubXSMPOLQ9vsE3TjBNWHS/g4hE4sL3s7DbZLD28t
         hmqAfME+QNa6YyOeaK5Pv2yrGfQ87UIYNGa7BhQOV9jeBUe+aVfbWoKXQxBvIgU9B/8d
         JW/65UswCAiZGTQLWks1/xS44xyyYoDPPX8C5/vG/Gq/6kvlbsFSH/KBc2s8zjiYX6Zy
         sVBQ==
Received: by 10.42.43.1 with SMTP id v1mr14065126ice.23.1349190297366;
        Tue, 02 Oct 2012 08:04:57 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id t4sm8973635igt.1.2012.10.02.08.04.55
        (version=SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 08:04:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.382.gb0576a6
In-Reply-To: <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206803>

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index f8f89a5..d53fdb2 100755
--- a/gitk
+++ b/gitk
@@ -2501,7 +2501,7 @@ proc makewindow {} {
     bindkey ? {dofind -1 1}
     bindkey f nextfile
     bind . <F5> updatecommits
-    bind . <Shift-F5> reloadcommits
+    bindmodfunctionkey Shift 5 reloadcommits
     bind . <F2> showrefs
     bindmodfunctionkey Shift 4 {newview 0}
     bind . <F4> edit_or_newview
-- 
1.7.12.1.382.gb0576a6
