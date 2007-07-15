From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH 4/4] Update 1.5.3 release notes: git-p4import has been
 deprecated
Date: Sun, 15 Jul 2007 15:53:35 -0400
Message-ID: <20070715155335.2784dd0f.seanlkml@sympatico.ca>
References: <20070715154804.2877361d.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 15 21:56:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAACF-0000Ev-U1
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 21:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbXGOTz4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbXGOTz4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 15:55:56 -0400
Received: from bay0-omc1-s35.bay0.hotmail.com ([65.54.246.107]:52958 "EHLO
	bay0-omc1-s35.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751032AbXGOTzz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 15:55:55 -0400
Received: from BAYC1-PASMTP01.bayc1.hotmail.com ([65.54.191.161]) by bay0-omc1-s35.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 12:55:55 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP01.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 12:55:54 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IAAC9-000178-NS
	for git@vger.kernel.org; Sun, 15 Jul 2007 15:55:53 -0400
In-Reply-To: <20070715154804.2877361d.seanlkml@sympatico.ca>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 15 Jul 2007 19:55:55.0021 (UTC) FILETIME=[27908BD0:01C7C71A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52584>


Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 Documentation/RelNotes-1.5.3.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/RelNotes-1.5.3.txt b/Documentation/RelNotes-1.5.3.txt
index e2e809e..00b2b93 100644
--- a/Documentation/RelNotes-1.5.3.txt
+++ b/Documentation/RelNotes-1.5.3.txt
@@ -172,6 +172,11 @@ Updates since v1.5.2
     concatenate them into a single line and treat the result as
     "oneline".
 
+  - "git p4import" has been demoted to contrib status.  For
+    a superior option, checkout the git-p4 front end to
+    git-fast-import (also in contrib).  The man page and p4
+    rpm have been removed as well.
+
 * Builds
 
   - old-style function definitions (most notably, a function
-- 
1.5.3.rc0.826.gc301a3
