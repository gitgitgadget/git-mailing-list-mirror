From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] everyday: use the dashless form of git-init
Date: Sun, 22 Mar 2009 02:15:13 -0700
Message-ID: <1237713313-16433-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 22 10:16:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlJmr-0000I2-QU
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 10:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbZCVJOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 05:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZCVJOj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 05:14:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:27470 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbZCVJOi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 05:14:38 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1339683rvb.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 02:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dJyGOjIZo3zXRnn1Mbbgaeh4MbsDKATQXRY0ZpjeQp0=;
        b=FAtkZu3CWqP2Yrjo/7j4AK5P27dBcWpGycjDAF4N80wAhwzDQxvv8p078XUHXAuuE7
         ZxtbIwlZ6aLbEZHsFIf8OwXqkdvaG2oKWlf0F0+oNkTlXdX82mBg9O1ooxuogRvro8VB
         w4EcbJ2Jx1zk1GcPNnQ0ycLLVknVJ/prJ5bio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sk2Gg+wcMZSvxUxhJtsILRnIbd16GZ5NmHcnePVT8VITod+km0HlNuoKwh5jE/F32E
         MvoxUJ5E7RQ2sN4zx97JET/6KjipTajMqf7J3VelvQfRGwJgOe0BhNM0Q66xx7lRwbDj
         7dMmBEaix/p071/YYzXKmQznycRfxl6DT3YV0=
Received: by 10.114.149.8 with SMTP id w8mr3918315wad.39.1237713276489;
        Sun, 22 Mar 2009 02:14:36 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v25sm4077440wah.16.2009.03.22.02.14.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 02:14:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.77.g8cc3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114132>

The 'Everyday GIT' guide was using the old dashed form
of git-init.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/everyday.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index e598cdd..9310b65 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -98,7 +98,7 @@ Use a tarball as a starting point for a new repository.::
 ------------
 $ tar zxf frotz.tar.gz
 $ cd frotz
-$ git-init
+$ git init
 $ git add . <1>
 $ git commit -m "import of frotz source tree."
 $ git tag v2.43 <2>
-- 
1.6.2.77.g8cc3f
