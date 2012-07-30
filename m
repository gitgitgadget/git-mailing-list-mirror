From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 06/16] Add a symlink 'git-remote-svn' in base dir.
Date: Mon, 30 Jul 2012 16:31:13 +0200
Message-ID: <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:39:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr84-0007vB-UT
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739Ab2G3OjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:23 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53245 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab2G3OjV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:21 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2859181bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JLyrNQdnqOBp/3XWWwO98L2F+MvBrIKZtK8WWwqW5Jc=;
        b=oLSN4zKch47KvRcfSBWCsVNZ+UP7dBs8JMvjipZHYl61r1UHglPLsEhg9t0HBWyQbs
         cRkNnY1llNo5qx2kAMisbmbJ8eBTfpUtcUDJujFsrOHH9nqce9fXqnmesM1stj1GUpIc
         RMzV92f8jWrnYiw6FUcF2p0qIxpbIRVJ5i4Ku0jncJIbIS0lMSzDCLcy8XzwfVWY82wZ
         bLXihcg2tejv4jMTz5pU8K8Ka258gmGiCB3J/vfD3ctVDk6Keai+G7uBP/noueMj4ggr
         iug91eVZTjXP2iPi4ujkemmnukV7wl2jJ70oHcpEd1uUW6EcbxyyuIhZcF1cBSVVVBSf
         N6ug==
Received: by 10.204.13.82 with SMTP id b18mr4071374bka.118.1343659161037;
        Mon, 30 Jul 2012 07:39:21 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.19
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202550>

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
