From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] Clarify tg-log note
Date: Fri, 22 Oct 2010 10:03:36 +0200
Message-ID: <0ecc03501a8282e7c19011ca1cbc138dec502390.1287734568.git.bert.wesarg@googlemail.com>
Cc: Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org,
	pasky@suse.cz, martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 22 10:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9CbO-0005Rc-Rg
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 10:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873Ab0JVIDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 04:03:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43715 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732Ab0JVIDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 04:03:41 -0400
Received: by fxm16 with SMTP id 16so421351fxm.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 01:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=tgZvvFLwvrZqSNet7Pd4VM0XhO4vOoSabC3lxIO9MLM=;
        b=pRH3JaVtOOAZ+G4sAeHMLiMD9uGzqQ+DaQpVTF2X/X6KvGPRvQUaSXbWQQCn0s0PID
         Oo6A81U1iN//exrEhJnMrAdbKl5Ldy9tT7CIZbqCK/eT7b/F6dHDHQcZ2URqCJI65Rc2
         XFJzjPgPB0d0POHfKWlz9lAwE8JdyECUFrTXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qjjMLO3vpv0lZLEZZeBVKUkCn3xMZF/I+6hipSgA21QJsIMopr88cRPYJoEjbZq/Nf
         FQ5RiBbmsrO4n+2AYmk0IHc8IHGix9a67O6EL3eF04tDN0WJBd9zePDTtwOE0H+LJPQA
         l7XpMg9+jqToxGlC9oCaty5Dl8UxDzX4MHQ8k=
Received: by 10.103.192.13 with SMTP id u13mr2231855mup.97.1287734620236;
        Fri, 22 Oct 2010 01:03:40 -0700 (PDT)
Received: from localhost (p3E9916F4.dip.t-dialin.net [62.153.22.244])
        by mx.google.com with ESMTPS id n8sm1290119faa.31.2010.10.22.01.03.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 01:03:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1075.g263d8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159661>

---
 README |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 5ca0424..348f515 100644
--- a/README
+++ b/README
@@ -520,10 +520,15 @@ tg log
 ~~~~~~
 	Prints the git log of the named topgit branch.
 
-	Note: if you have shared the TopGit branch, this command
-	only lists the commits that were made in the current
-	repository, so you will not see work done by your
-	collaborators.
+	Note: that you don't see changes made by the remote
+	when the topic diverged at both sides. Any 'fast-forward'
+	updates from remote topics will shown up. This could also
+	mean, that you 'lose' all your history, because the remote
+	made the merge and you do only a 'fast-forward'. Than you
+	will see only his history from now on. So its best to prevent
+	diverging development if you like to 'preserve' the full
+	history. Please note, that 'lose' and 'preserve' only relates
+	to when showing the log.
 
 TODO: tg rename
 
-- 
1.7.3.1.1075.g263d8
