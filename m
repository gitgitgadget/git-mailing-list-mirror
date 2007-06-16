From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 05/11] Document that '--no-checkout' is long version of '-n' option of git-clone
Date: Sat, 16 Jun 2007 21:03:41 +0200
Message-ID: <11820206332182-git-send-email-jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdU3-0007JN-0d
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbXFPS6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbXFPS6U
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:8343 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbXFPS6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:13 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1101913ugf
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H3EAOobGZM7mxmWkIvOKXEiLBar2n2nOl4cVlMW1qpmxgn8EnwizxnirES7ZNRDM/dIUOjiJCTdHwKvKV5sb6cthLogUZiUH7tRL6XPcOtoxWw2q17dSkzvX7VZIhNWfM8EwnEaZIHKQ9MRQUBX+w29EJlNNNaL5WYP6bZuYJ+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tA3OzbYu8AoWMEHkPWufAeaQSpUKJHMJzswLkZWef9Bvw6uAiUcY0CAmgHMtJHjnZDkswmvj4wKrcYGLZdU+Wau1wkQDIdX8DR/wq9eIRBHp2UPmJdE3M9qmKOqdmj5v+Br+fHDbi8rADv3oIyvbAC8tO5/axNLJ0L2e6dC4vxo=
Received: by 10.78.131.8 with SMTP id e8mr1724664hud.1182020292541;
        Sat, 16 Jun 2007 11:58:12 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id 35sm7289885nfu.2007.06.16.11.58.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:11 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3sVv004242;
	Sat, 16 Jun 2007 21:03:54 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3rN4004241;
	Sat, 16 Jun 2007 21:03:53 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11820206272990-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50301>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-clone.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 4a5bab5..796cbba 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -64,6 +64,7 @@ OPTIONS
 	Operate quietly.  This flag is passed to "rsync" and
 	"git-fetch-pack" commands when given.
 
+--no-checkout::
 -n::
 	No checkout of HEAD is performed after the clone is complete.
 
-- 
1.5.2
