From: Yakov Lerner <iler.ml@gmail.com>
Subject: [PATCH] Mention the [user@] part in documentation of ssh:// urls.
Date: Tue, 11 Jul 2006 21:02 +0000
Message-ID: <0J29004B83DK6QD0@mxout4.netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: iler.ml@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 11 20:01:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0MXg-0003Fe-6s
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 20:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWGKSA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 14:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWGKSA6
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 14:00:58 -0400
Received: from mxout4.netvision.net.il ([194.90.9.27]:50084 "EHLO
	mxout4.netvision.net.il") by vger.kernel.org with ESMTP
	id S1751158AbWGKSA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 14:00:58 -0400
Received: from main ([62.90.164.62]) by mxout4.netvision.net.il
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0J29004B73DK6QD0@mxout4.netvision.net.il> for
 git@vger.kernel.org; Tue, 11 Jul 2006 21:00:56 +0300 (IDT)
To: git@vger.kernel.org
X-Mailer: Mail::SendEasy/1.2 Perl/5.008008-linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23721>

Mention the [user@] part in documentation of ssh:// urls.

Signed-off-by: Yakov Lerner <iler.ml@gmail.com>

---

--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -10,9 +10,9 @@
 - https://host.xz/path/to/repo.git/
 - git://host.xz/path/to/repo.git/
 - git://host.xz/~user/path/to/repo.git/
-- ssh://host.xz/path/to/repo.git/
-- ssh://host.xz/~user/path/to/repo.git/
-- ssh://host.xz/~/path/to/repo.git
+- ssh://[user@]host.xz/path/to/repo.git/
+- ssh://[user@]host.xz/~user/path/to/repo.git/
+- ssh://[user@]host.xz/~/path/to/repo.git
 ===============================================================
 
 SSH Is the default transport protocol and also supports an
