From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH 3/4] Demote git-p4import to contrib status.
Date: Sun, 15 Jul 2007 15:52:32 -0400
Message-ID: <20070715155232.fb6ff093.seanlkml@sympatico.ca>
References: <20070715154804.2877361d.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 15 21:55:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAABh-00004s-Jg
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 21:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbXGOTyx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 15:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbXGOTyx
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 15:54:53 -0400
Received: from bay0-omc3-s16.bay0.hotmail.com ([65.54.246.216]:39659 "EHLO
	bay0-omc3-s16.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751483AbXGOTyw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 15:54:52 -0400
Received: from BAYC1-PASMTP10.bayc1.hotmail.com ([65.54.191.183]) by bay0-omc3-s16.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 12:54:52 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 12:55:26 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IAAB8-00016h-QN
	for git@vger.kernel.org; Sun, 15 Jul 2007 15:54:50 -0400
In-Reply-To: <20070715154804.2877361d.seanlkml@sympatico.ca>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 15 Jul 2007 19:55:26.0782 (UTC) FILETIME=[16BB9DE0:01C7C71A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52583>


Move git-p4import.py and Documentation/git-p4import.txt into
a contrib/p4import directory.   Add a README there directing
people to contrib/fast-import/git-p4 as a better alternative.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 contrib/p4import/README                            |    1 +
 .../p4import/git-p4import.py                       |    0 
 .../p4import}/git-p4import.txt                     |    0 
 3 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 contrib/p4import/README
 rename git-p4import.py => contrib/p4import/git-p4import.py (100%)
 rename {Documentation => contrib/p4import}/git-p4import.txt (100%)

diff --git a/contrib/p4import/README b/contrib/p4import/README
new file mode 100644
index 0000000..b9892b6
--- /dev/null
+++ b/contrib/p4import/README
@@ -0,0 +1 @@
+Please see contrib/fast-import/git-p4 for a better Perforce importer.
diff --git a/git-p4import.py b/contrib/p4import/git-p4import.py
similarity index 100%
rename from git-p4import.py
rename to contrib/p4import/git-p4import.py
diff --git a/Documentation/git-p4import.txt b/contrib/p4import/git-p4import.txt
similarity index 100%
rename from Documentation/git-p4import.txt
rename to contrib/p4import/git-p4import.txt
-- 
1.5.3.rc0.826.gc301a3
