From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH] RelNotes: noted the addition of contrib/diffall
Date: Fri,  9 Mar 2012 08:35:27 -0500
Message-ID: <1331300127-21169-1-git-send-email-tim.henigan@gmail.com>
References: <7v8vjadfgg.fsf@alter.siamese.dyndns.org>
Cc: tim.henigan@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 14:36:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5zzx-0007QT-Pt
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 14:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237Ab2CINgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 08:36:41 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44322 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab2CINgk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 08:36:40 -0500
Received: by vcqp1 with SMTP id p1so1334962vcq.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 05:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6Pl+7lyHMUuaSsFjL1OkINc8G2FiJkJ4hEjRmROMIcQ=;
        b=Npe7nPBQ8j1NDkNBNN/GMmGO3nVAWFNNbLSBNMklR2ivcq1Hr62FbR0pTcI2NlPYVP
         dBmu6qTbz8Lk0NN/0GXat2668gxI7Omdzu+7N6ZVNHtm/kDhDC3DlTPukghwlGvy8glj
         EYNflgVyzIuh4kPAvrX9HsflFR/+BRen8XDeN1kkpAWd1KHCHbPQ7mvhg83hBs7L2YbB
         y4+yLndP8leDkolABztCT3MKXIG16zGXN8stBfaLyfYctyeSgBPJUybR41VzkWkupTzZ
         SMLUiq5APv5EnXS+a6I93DK/2Y7VdmgfBxzx9+i9UqIZnX+lmUYuMYe7+QrkN3lJ37mc
         /6aQ==
Received: by 10.52.180.74 with SMTP id dm10mr3458875vdc.67.1331300199406;
        Fri, 09 Mar 2012 05:36:39 -0800 (PST)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id h5sm10667448vdk.0.2012.03.09.05.36.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 05:36:38 -0800 (PST)
X-Mailer: git-send-email 1.7.10.rc0
In-Reply-To: <7v8vjadfgg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192718>

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

I wasn't sure if you wanted an actual patch or just wanted me to write
up the paragraph.  If you squash this in to some other commit, that is
fine with me.


 Documentation/RelNotes/1.7.10.txt |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/RelNotes/1.7.10.txt b/Documentation/RelNotes/1.7.10.txt
index ae446e0..60722e2 100644
--- a/Documentation/RelNotes/1.7.10.txt
+++ b/Documentation/RelNotes/1.7.10.txt
@@ -106,6 +106,9 @@ UI, Workflows & Features
  * Project search in "gitweb" shows the substring that matched in the
    project name and description highlighted.
 
+ * "git diffall" can now be installed from contrib/. The script drives
+   an external tool to perform a directory diff of two Git revisions.
+
 Foreign Interface
 
  * Improved handling of views, labels and branches in "git-p4" (in contrib).
-- 
1.7.10.rc0
