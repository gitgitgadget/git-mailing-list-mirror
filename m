From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] gitk-git/.gitignore: add rule for gitk-wish
Date: Tue, 29 Jan 2013 16:22:30 +0530
Message-ID: <1359456750-29342-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 11:51:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U08nE-0004WC-7q
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 11:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab3A2Kvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 05:51:35 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:42490 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab3A2Kvd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 05:51:33 -0500
Received: by mail-pb0-f50.google.com with SMTP id ro8so211817pbb.9
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 02:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer;
        bh=mh3AabNVRRevX0+7SQzwLjcnqip7tTuVuRFvYE78BV8=;
        b=G3vh4NraklzmX1anUyqRmbcQhBOpVJy2Qj359ZHJo/deibXVl0zkueBQ4AtpBKiUv3
         gP+g0CnAdoIaOlj6raefPUd4VexocNsMS0Ww9RV2JgrLoSV8l3jAxx0X4+a/4zv1ekra
         h9kCm0irR6uR5/ErddEDwcBDHKaoW5O16nLNy+n5pu7FVtG16nwoOHkArrHW40+Az04d
         iMDAgnLyJGYxzbWY5WKj95Q/N8zmHUFDXurfGWGt3p2W+5Yot4HVWv7vmyRTG86WUf5s
         DJUOQoyDGsH4fzoJTJmwOH2S8cokMUFaTL0E1NOMlPmkGGkeBszLXXwwiJ7GXGJKpDGj
         TSsA==
X-Received: by 10.68.132.232 with SMTP id ox8mr1318609pbb.46.1359456693287;
        Tue, 29 Jan 2013 02:51:33 -0800 (PST)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id q4sm8709099paz.20.2013.01.29.02.51.31
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 02:51:32 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214926>

8f26aa4 (Makefile: remove tracking of TCLTK_PATH, 2012-12-18) removed
"/gitk-git/gitk-wish" from the toplevel .gitignore, with the intent of
moving it to gitk-git/.gitignore in a later patch.  This was never
realized.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Minor patch, so I didn't bother sending it through Paul.

 gitk-git/.gitignore |    1 +
 1 file changed, 1 insertion(+)
 create mode 100644 gitk-git/.gitignore

diff --git a/gitk-git/.gitignore b/gitk-git/.gitignore
new file mode 100644
index 0000000..1dc38be
--- /dev/null
+++ b/gitk-git/.gitignore
@@ -0,0 +1 @@
+/gitk-wish
-- 
1.7.10.4
