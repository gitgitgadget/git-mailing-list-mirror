From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] log: Improve description of '-<n>' option in documentation
Date: Sun, 22 Aug 2010 01:58:51 +0530
Message-ID: <1282422531-29673-3-git-send-email-artagnon@gmail.com>
References: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 22:31:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omuik-0000GE-HH
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 22:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734Ab0HUUbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 16:31:06 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61976 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638Ab0HUUbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 16:31:03 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1723335pvg.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=co/G6rXbTbvdIdMgjZWzvEW740jQX4S6C03M0e4JTSY=;
        b=iOaVbxhi0dCj3LWkU1Nx/IwDMhPublZqA52uxiigyCl2CpIRm0VlbbcCqIujB4TmiC
         OSRlcYrLGDJCCBLL9ntksWSauszMZOWSIiLXsMT7PCsG6Y6HTOhG8vXe6es0bpWcBAgA
         Qn7VJSthK0I/POVLdf4xW1fBd/q9rGzztOxUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=X7xq7EFoA1TxxMtx8Fgm8CGIZeC+LhPgIMZ53JH/tfVD73C0fcXfEqnnahd4h2R0OI
         s5Omk3iQ4N+tLhl82Dn3D20nNUjQd0+wn3Nbhav0S9ANX8Zsv6IRZ3ppsFj0KoW6QYUQ
         S8OimKhYT68VIIA/mI5z+/M7upWVdeexrmUkY=
Received: by 10.114.136.16 with SMTP id j16mr3499100wad.63.1282422663664;
        Sat, 21 Aug 2010 13:31:03 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d35sm8096273waa.9.2010.08.21.13.31.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 13:31:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154157>

The earlier description of the '-<n>' option was misleading- the user
would have expected to be able to use it to limit the number of
commits shown when specifying a revision range, for example. In
reality, the option simply instructs the log to walk the topmost <n>
commits. Also update the meaning of the same option in the
git-format-patch documentation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-format-patch.txt |    2 +-
 Documentation/git-log.txt          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 4b3f5ba..df77474 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -74,7 +74,7 @@ OPTIONS
 include::diff-options.txt[]
 
 -<n>::
-	Limits the number of patches to prepare.
+	Prepare patches from the topmost <n> commits.
 
 -o <dir>::
 --output-directory <dir>::
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 83e4ee3..ca02206 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -28,7 +28,7 @@ OPTIONS
 -------
 
 -<n>::
-	Limits the number of commits to show.
+	Show the topmost <n> commits.
 
 <since>..<until>::
 	Show only commits between the named two commits.  When
-- 
1.7.2.2.409.gdbb11.dirty
