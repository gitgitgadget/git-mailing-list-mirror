From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitk: map / to focus the search box
Date: Sun, 23 Nov 2008 18:01:30 +0100
Message-ID: <1227459690-9896-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 23 18:02:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4IM0-0007B5-Lm
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 18:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbYKWRBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 12:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbYKWRBU
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 12:01:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:42104 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbYKWRBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 12:01:20 -0500
Received: by ug-out-1314.google.com with SMTP id 39so560929ugf.37
        for <git@vger.kernel.org>; Sun, 23 Nov 2008 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=nYjlvIPT4WfWrP9y+qJYEmtjc727sRPqx3cLANjYKkA=;
        b=US88q3Z+RKihGdDbMXCeS4XJ9NfUOLJ+ae0q0+LY0aqGnMklGl74+J2+g3AdONspfW
         Fc4hSqu9ao5gP9tKRnhvBorjbMfyHuu8M8LSrg6PmgD56rOxpX1SR78/B0T2Mjt5CXni
         NJ2MOn4wwYXDrXOUal4+zDyjs3faXRWv+bnWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=viVAvIvDytdmmDwpV8rOCuWya2BJtpCBxOsOIm8iUsEv+U4jH+PvLgrMWYMTQAOF6I
         LERsT0bF+Ie4NzoRx3wq0U++IYXFr3fVTm+gqW/UPFKgUI83wI9kn5mtIKuhlBXIrwz4
         adRlxuyp9GbOcO9WIKICLBVMTQU82GLNRZ9N8=
Received: by 10.67.40.15 with SMTP id s15mr1363184ugj.89.1227459678361;
        Sun, 23 Nov 2008 09:01:18 -0800 (PST)
Received: from localhost ([94.37.12.39])
        by mx.google.com with ESMTPS id u6sm2937331uge.4.2008.11.23.09.01.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Nov 2008 09:01:17 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101570>

The / key is often used to initiate searches (less, vim, some web
browsers). We change the binding for the / (slash) key from 'find next'
to 'focus the search box' to follow this convention.
---
 gitk-git/gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 6b671a6..8b60632 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2271,7 +2271,7 @@ proc makewindow {} {
     bindkey b prevfile
     bindkey d "$ctext yview scroll 18 units"
     bindkey u "$ctext yview scroll -18 units"
-    bindkey / {dofind 1 1}
+    bindkey / {focus $fstring}
     bindkey <Key-Return> {dofind 1 1}
     bindkey ? {dofind -1 1}
     bindkey f nextfile
-- 
1.5.6.5
