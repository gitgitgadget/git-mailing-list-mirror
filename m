From: Adam Monsen <haircut@gmail.com>
Subject: [PATCH] git-commit doc: say -t requires editing commit message
Date: Thu, 29 Mar 2012 10:57:56 -0700
Message-ID: <1333043876-19966-1-git-send-email-haircut@gmail.com>
Cc: Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 19:58:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJby-00048j-HN
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 19:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169Ab2C2R6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 13:58:07 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:46887 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab2C2R6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 13:58:04 -0400
Received: by qadc11 with SMTP id c11so263424qad.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ARPqrkhvkNRm9vaUeZ595AGfU3IRt/bItrBoO10t94Y=;
        b=mefGhoMv6waiA3umCMznTsv2a7hIOgYtII3YA11pkCN/IL5aXjOIT03zutKBk6/CL+
         0mOxcjK0ARy3tVM3F8nAPVOm5FEW6a9o347sCmrHDFZJZotvnrNOry5NuvXaj6hXAkxa
         EEPMBl+t6Rn5gi8FsJEYYeDe5WZjrbhHb6MLDEmMAil3ZkHAW7D0gC1ZQc7bDYcSMzFG
         KGXr5otdJh57EQAwMNyv7u5bDil9mvMH7tloRLgogLDg0ZoX9VlIrqEjXunQEtocJHyv
         OVjmQ5oYjGI39+MzEH1lQ8vX0mD2QYuGTh+pk9zPoASm59MROzf3KPkL9VXhdXY97pli
         1VyQ==
Received: by 10.224.39.211 with SMTP id h19mr1574012qae.24.1333043883672;
        Thu, 29 Mar 2012 10:58:03 -0700 (PDT)
Received: from localhost.localdomain (c-67-183-137-177.hsd1.wa.comcast.net. [67.183.137.177])
        by mx.google.com with ESMTPS id gv7sm13592046qab.5.2012.03.29.10.58.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 10:58:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194280>

Make it clear that, when using a commit template, the message *must* be
changed or the commit will be aborted "due to empty commit message".

Signed-off-by: Adam Monsen <haircut@gmail.com>
---

I found it confusing that the commit template itself, even if
non-empty, must be edited. Hopefully this clears that up a bit.

 Documentation/git-commit.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 5cc84a1..44947ab 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -133,7 +133,7 @@ OPTIONS
 -t <file>::
 --template=<file>::
 	Use the contents of the given file as the initial version
-	of the commit message. The editor is invoked and you can
+	of the commit message. The editor is invoked and you must
 	make subsequent changes. If a message is specified using
 	the `-m` or `-F` options, this option has no effect. This
 	overrides the `commit.template` configuration variable.
-- 
1.7.5.4
