From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 07/16] Add a symlink 'git-remote-svn' in base dir.
Date: Tue, 14 Aug 2012 21:13:09 +0200
Message-ID: <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:17:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1McK-0003cZ-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642Ab2HNTRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:17:18 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab2HNTRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:17:14 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so265503bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JLyrNQdnqOBp/3XWWwO98L2F+MvBrIKZtK8WWwqW5Jc=;
        b=agruz08+Ho5gOEh4H9aJAkeiWrXpqElb7+ikAKMi9VvOQ8ZkSPNTZRjTGKWwrfYMGF
         D6TF++CAIbzdg+ltQY1lmDeFfRicF5NMU6gKrLXidmOD0IMYpn5LNoSs7eweRUrc9N7u
         jB/3qsLg5HjQETJN3RnYe6SpulgHtMytRTLxgcfAaDWc9tEmRscUbfN6jIXgFNkOsFsT
         7mbsHksHDZjLjB8l03mm9EB9XGN237bjOjzDdywtNsogsHgsLxD6ZBy+nhSlxL3KGfUb
         QzQiW9nRk8FaRrtIL4+1Wvnc07Nb9gUm9g0hqvMVqTUk3XsLcuG4ONhtKEwq8oUeQ+mg
         9HLw==
Received: by 10.205.132.12 with SMTP id hs12mr6789382bkc.47.1344971833570;
        Tue, 14 Aug 2012 12:17:13 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.17.11
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:17:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344971598-8213-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203431>

Allow execution of git-remote-svn even if the binary
currently is located in contrib/svn-fe/.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 git-remote-svn |    1 +
 1 file changed, 1 insertion(+)
 create mode 120000 git-remote-svn

diff --git a/git-remote-svn b/git-remote-svn
new file mode 120000
index 0000000..d3b1c07
--- /dev/null
+++ b/git-remote-svn
@@ -0,0 +1 @@
+contrib/svn-fe/remote-svn
\ No newline at end of file
-- 
1.7.9.5
