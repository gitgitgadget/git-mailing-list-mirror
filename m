From: Nicolas Dermine <nicolas.dermine@gmail.com>
Subject: [PATCH] config.txt: fix typo
Date: Sun, 9 Nov 2014 17:19:33 +0100
Message-ID: <5ABE5B46-7EE9-4748-8244-84981390AC2C@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 17:19:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnVDK-0005Dj-J5
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 17:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbaKIQTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 11:19:38 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:47982 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbaKIQTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 11:19:37 -0500
Received: by mail-wi0-f169.google.com with SMTP id n3so8062980wiv.2
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 08:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=lYEOHYNM+AOE8F9KTqZ1Y7tkFSszDCFLw/ZNgXESp8U=;
        b=wzuKT5+tlUDcsDZmTcVbqt1zQWoHUsOqXLq7NP8HQwFKv47t1uFvkwx20mTS66Cin2
         bSG62acl/RRGMFevAcGc32RC2TbxyPhMege0OHtyI4oenitCEDIDN7Zu4Ewl8Cbm93el
         pGOCtz1CoVq2/ZW0bIMmMcJ874ORjXqlX5E1ieL+pCTQZjWenf4FWhm5Xt569RQT26h1
         Dp9Mw4zCIBPoDNUs3ebHvEXAAlWpkWBG95jprc0jnuyYHL3pOBvSf7txKocoC9FFhV/L
         TY8PQ4V4++80kteI0OtOf+Gp2nujF9qLc3HeJyGnVYxERaTNMIVJHd13ZaHGzN5YP686
         CixA==
X-Received: by 10.194.92.42 with SMTP id cj10mr34578381wjb.6.1415549976405;
        Sun, 09 Nov 2014 08:19:36 -0800 (PST)
Received: from pc6.home (cgy173.neoplus.adsl.tpnet.pl. [83.30.252.173])
        by mx.google.com with ESMTPSA id s10sm13951116wjw.29.2014.11.09.08.19.35
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Nov 2014 08:19:35 -0800 (PST)
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nicolas Dermine <nicolas.dermine@gmail.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 382e12c..0fda2b5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2295,7 +2295,7 @@ status.showUntrackedFiles::
 	files which are not currently tracked by Git. Directories which
 	contain only untracked files, are shown with the directory name
 	only. Showing untracked files means that Git needs to lstat() all
-	all the files in the whole repository, which might be slow on some
+	the files in the whole repository, which might be slow on some
 	systems. So, this variable controls how the commands displays
 	the untracked files. Possible values are:
 +
-- 
1.8.5.2
