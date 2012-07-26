From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 06/16] Add a symlink 'git-remote-svn' in base dir.
Date: Thu, 26 Jul 2012 09:32:27 +0200
Message-ID: <1343287957-22040-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:34:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIao-0004t5-By
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741Ab2GZHed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab2GZHec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:32 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JLyrNQdnqOBp/3XWWwO98L2F+MvBrIKZtK8WWwqW5Jc=;
        b=n+qdy3pncRfMQSAa6hhM7mzykFM/DxVRbWrHAJhtbdPA17LVYT6S2ALgjy3A+x5lVX
         LrpuyqjDIiIM5svQBQ+1Go9c7JUUS5oHXc5kRReIpNUoVr2+PWYs0wOHxCpVSClzuf1L
         EZrhpuCRML3uBRHgktac3ff/f3BzV8E25bGKxINpjHPDgl2iKiYU+jkeX0bGBC14xPZ5
         nblr+JdNNTv/WjEQB1NpQkI6rl5amUBaIkCFC4PNI17c7gxr3+3wtR6l9Fxhzdlynz4w
         LNKN82MM2zXD54XwbcWNAaZkKFV8T10C6AsUjYQD+gxEqrKp3BZorIK0Iy5LS6GLgzV9
         HrGg==
Received: by 10.204.157.144 with SMTP id b16mr13045864bkx.122.1343288071878;
        Thu, 26 Jul 2012 00:34:31 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.29
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202233>

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
