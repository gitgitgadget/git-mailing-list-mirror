From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 4/6] Documentation: Update manpage for pre-commit hook
Date: Mon, 10 Jun 2013 20:36:03 +0200
Message-ID: <1370889365-6239-5-git-send-email-richih.mailinglist@gmail.com>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 20:36:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6xJ-0005Gp-8W
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274Ab3FJSg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:36:29 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:39143 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab3FJSgS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:36:18 -0400
Received: by mail-ea0-f180.google.com with SMTP id k10so5695800eaj.25
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tVcq5owwdKS7Dd11o7+112vhH9T565UNqWUz77FRYPg=;
        b=UlX2VpMKICNTascDAZEtA0cVufSZVu1DUuNgfgRVZvqDi5jpLB+3tAcgSbkOzoW4Gj
         R/uiTtyO3NOS1tSj/WvdXU2xWcmSg+ryCiLmc4SuJs8iqb2LoPP38FEpoZr28Nzf3FJ/
         81de8Icw37riyiASw0zsP+q1hyD1mcLilBM5aQycmmXKW7Kp5RTbuvCBx+fYtsqsAMg9
         MAhxE7xNLT8a5vetU0U2mgI8Zl584s6vuxUefkqktvJNR6+4gX5drEuo3Vd6xujg/zUG
         RgXCLWbLGe1iwdo4sYB/nPm7qFRAWG17cjlohG5zkX6XsYCbNt/ntSMNLZMTaG98RMqm
         G7LA==
X-Received: by 10.14.107.200 with SMTP id o48mr12587299eeg.35.1370889377197;
        Mon, 10 Jun 2013 11:36:17 -0700 (PDT)
Received: from rockhopper.fritz.box (p54998111.dip0.t-ipconnect.de. [84.153.129.17])
        by mx.google.com with ESMTPSA id ba7sm24960845eeb.0.2013.06.10.11.36.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Jun 2013 11:36:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227353>

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 Documentation/githooks.txt |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b9003fe..1276730 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -80,7 +80,8 @@ causes the 'git commit' to abort.
 
 The default 'pre-commit' hook, when enabled, catches introduction
 of lines with trailing whitespaces and aborts the commit when
-such a line is found.
+such a line is found. It will also prevent addition of non-ASCII
+file names.
 
 All the 'git commit' hooks are invoked with the environment
 variable `GIT_EDITOR=:` if the command will not bring up an editor
-- 
1.7.10.4
