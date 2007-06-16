From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 02/11] Document git log --full-diff
Date: Sat, 16 Jun 2007 21:03:38 +0200
Message-ID: <11820206312866-git-send-email-jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdU2-0007JN-Gj
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbXFPS6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986AbXFPS6T
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:7911 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbXFPS6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:13 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1101911ugf
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A3gHkcjDU4D32PVJldyWiBUMEwWdsQN63zRnSk+9HGEcaU7ZLFgGuvCb/Bz+qZlAjLhO8ER7YbbtrcH/cT4K4fo4x1mH7TjwkYQ8mvMqY4sbfmnbmfwhNDeZzu/ZTi4BszfR1+WGu5lhhdbdEdW78/0wyqS3XExqu4FgO5QtRpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fphoSMFzrFUAGfWaK0bWvZYkZbEhnbSgTpZo43T2LTJd8+6F1hmqKQ9TM+LFy8/EsKpHva3LbrE5+7WIqC00FjfuvTqVLTIL8Kj0k7NGIdUnxHccVx+WucAHQksS1VDc44MsEErTPv+7XEXkdh8SsIwOuBNR7Uebn153dnOV96Y=
Received: by 10.82.146.14 with SMTP id t14mr8159789bud.1182020291641;
        Sat, 16 Jun 2007 11:58:11 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id k9sm6674821nfh.2007.06.16.11.58.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:10 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3qdW004230;
	Sat, 16 Jun 2007 21:03:52 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3pJ4004229;
	Sat, 16 Jun 2007 21:03:51 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11820206272990-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50297>

Based on description of commit 477f2b41310c4b1040a9e7f72720b9c39d82caf9
"git log --full-diff" adding this option.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-log.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index c072441..7adcdef 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -54,6 +54,13 @@ include::pretty-options.txt[]
 --decorate::
 	Print out the ref names of any commits that are shown.
 
+--full-diff::
+	Without this flag, "git log -p <paths>..." shows commits that
+	touch the specified paths, and diffs about the same specified
+	paths.  With this, the full diff is shown for commits that touch
+	the specified paths; this means that "<paths>..." limits only
+	commits, and doesn't limit diff for those commits.
+
 <paths>...::
 	Show only commits that affect the specified paths.
 
-- 
1.5.2
