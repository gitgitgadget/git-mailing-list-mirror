From: Leila Muhtasib <muhtasib@gmail.com>
Subject: [PATCH v2] CodingGuidelines: Added note about position of 'else' in C programs.
Date: Wed, 13 Jun 2012 21:42:43 -0400
Message-ID: <1339638163-33870-1-git-send-email-muhtasib@gmail.com>
Cc: Leila Muhtasib <muhtasib@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 03:42:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sez5K-0001fZ-U6
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 03:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977Ab2FNBmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 21:42:51 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36661 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951Ab2FNBmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 21:42:50 -0400
Received: by qcro28 with SMTP id o28so719219qcr.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=V84h3UuFDJpP4hfPWAfDsi5DAfq+E1+80HlKbXP8gAA=;
        b=yGz1z2B78HHDQS3CciWF+vIl10OMj0xiNQtTDJFRd0v78iFhHrC17mM+p8btOBexIm
         jvUWdGkCT5r6yVFmOeWK87bkloQOlKMXPSncGZGF2x9c6w75NqtcmSxvuFK9ThZ5bBcv
         iKeLSYB3fMn7HW+1fXzaGzlgiQWZujOBebNSp4Ze3yGiTkYIwfILoUKoCOlUvtkDAQpD
         zSenxrU888cA3uBdPF89a9hGkzvpdKAVzGf9OcZ7u7vD1e9LB2mkqaxqXTVxA3YTK5wl
         H2iPDLCnRVSKYV6CgZ/IkAmJEUhwSdo6pG0oHa8n8M6uKt14WAw+iEAmtJuESLutRd8T
         eyVg==
Received: by 10.229.106.147 with SMTP id x19mr11523731qco.146.1339638169602;
        Wed, 13 Jun 2012 18:42:49 -0700 (PDT)
Received: from localhost (user-160v4aj.cable.mindspring.com. [76.15.145.83])
        by mx.google.com with ESMTPS id cc16sm13040946qab.16.2012.06.13.18.42.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 18:42:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.5 (Apple Git-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199964>

During code review of some patches, it was noted that 'else' should
appear on the same line as the closing '}' of its 'if' block.

Signed-off-by: Leila Muhtasib <muhtasib@gmail.com>
---
 Documentation/CodingGuidelines |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4557711..99588f0 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -123,6 +123,9 @@ For C programs:
 
  - We try to avoid assignments inside if().
 
+ - "else" should be positioned on the same line as the closing
+   "}" of its "if" block.
+
  - Try to make your code understandable.  You may put comments
    in, but comments invariably tend to stale out when the code
    they were describing changes.  Often splitting a function
-- 
1.7.7.5 (Apple Git-26)
