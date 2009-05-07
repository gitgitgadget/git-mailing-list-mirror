From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH] Documentation: cloning to empty directory is allowed
Date: Thu,  7 May 2009 16:04:08 +0400
Message-ID: <1241697848-9263-1-git-send-email-aspotashev@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 14:03:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M22K6-0006Gr-9N
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 14:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666AbZEGMDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 08:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbZEGMDZ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 08:03:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:59237 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbZEGMDY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 08:03:24 -0400
Received: by wa-out-1112.google.com with SMTP id j5so420605wah.21
        for <git@vger.kernel.org>; Thu, 07 May 2009 05:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=O0FGwn7iQInsZtX8eeT23SNH3txYFZCU98r6/aUBWpg=;
        b=DgrxetUhEChomQRpr5jpA3yYJbzpUQgQd/IKJ7hfQTXc071osFFHdgtfhH21VCAMUZ
         fwRydSi+MLFwX0h3S6UJ1IToQPsPHrH0g1ljhhqzP8et7WuDOwYJkgDdDqvhtxVOEsiH
         31Y6gfVMM35RwsbJlTwdU7Cdg1cI32mLnOQiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZrmJbRnG4t8GhbYaHMQyL7cCVMjB7+omJp+njilAE0l48VQsSvpAZ9VKG9yK5EnCvX
         Sjz4mNlBeu5y39fMVyCVkwf/e8FdHhfDHpwJD735BHWz2l/OZm/2DDTbfJxB7EwkbwG/
         WnSmilX1RkrLXhKij0DqvXKVC4leoqWU8qhS0=
Received: by 10.114.94.1 with SMTP id r1mr2231064wab.130.1241697804777;
        Thu, 07 May 2009 05:03:24 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-100-127.pppoe.mtu-net.ru [91.78.100.127])
        by mx.google.com with ESMTPS id q18sm9430654pog.19.2009.05.07.05.03.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 05:03:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118465>

Cloning into an existing empty directory is now allowed:
commit 55892d23981917aefdb387ad7d0429f90cbd446a
("Allow cloning to an existing empty directory")

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 Documentation/git-clone.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 4072f40..b14de6c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -149,7 +149,7 @@ then the cloned repository will become corrupt.
 	part of the source repository is used if no directory is
 	explicitly given ("repo" for "/path/to/repo.git" and "foo"
 	for "host.xz:foo/.git").  Cloning into an existing directory
-	is not allowed.
+	is only allowed if the directory is empty.
 
 :git-clone: 1
 include::urls.txt[]
-- 
1.6.2.3
