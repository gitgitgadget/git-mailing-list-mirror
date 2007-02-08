From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] qgit4: Removed the monospace font override from the log viewer box
Date: Thu, 8 Feb 2007 23:31:28 +0000
Message-ID: <200702082331.28249.andyparkins@gmail.com>
References: <200702082158.56463.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 00:34:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFImu-00047g-MH
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbXBHXep (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965616AbXBHXep
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:34:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:21943 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965608AbXBHXeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:34:44 -0500
Received: by ug-out-1314.google.com with SMTP id 44so618870uga
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 15:34:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=LSLjeqmgq6agW3Zp6vhDmhUiqd3kXuZRPbDYmCfdhTWOE7jlWphhgqw8YvZjFQ1PD985MrY16F42zfXvVCggSTa3vpa7XQkGaq/2YbfkA2eryhydpPbyf6NvlG4X28FPxRhsWsOGDfJcNmgM5cFWt9extN4fZpHP6S8xHF1cTn4=
Received: by 10.78.97.7 with SMTP id u7mr4657816hub.1170977683382;
        Thu, 08 Feb 2007 15:34:43 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 32sm3930739ugf.2007.02.08.15.34.36;
        Thu, 08 Feb 2007 15:34:40 -0800 (PST)
In-Reply-To: <200702082158.56463.andyparkins@gmail.com>
X-TUID: 05f243f5522097f4
X-UID: 232
X-Length: 1093
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39124>

The font is now set in software and is made up of both variable and
monospaced fonts, therefore this override is no longer appropriate.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 src/revsview.ui |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/src/revsview.ui b/src/revsview.ui
index ad16200..870110e 100644
--- a/src/revsview.ui
+++ b/src/revsview.ui
@@ -63,11 +63,6 @@
          <verstretch>0</verstretch>
         </sizepolicy>
        </property>
-       <property name="font" >
-        <font>
-         <family>Monospace</family>
-        </font>
-       </property>
        <property name="lineWrapMode" >
         <enum>QTextEdit::NoWrap</enum>
        </property>
-- 
1.5.0.rc1.gf4b6c
