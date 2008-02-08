From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH] gitweb: Update gitweb/README to include the new per-repository gitweb.owner
Date: Fri,  8 Feb 2008 02:41:54 -0200
Message-ID: <1202445714-28971-3-git-send-email-ribas@c3sl.ufpr.br>
References: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br>
 <1202445714-28971-2-git-send-email-ribas@c3sl.ufpr.br>
Cc: gitster@pobox.com, Git Managment for C3SL <git@git.c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 05:43:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNL4y-0005L9-9H
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 05:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759685AbYBHEmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 23:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759850AbYBHEmi
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 23:42:38 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:51696 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759308AbYBHEmV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 23:42:21 -0500
Received: from localhost (unknown [189.1.136.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 9F7C17000042E;
	Fri,  8 Feb 2008 02:42:20 -0200 (BRST)
X-Mailer: git-send-email 1.5.4.24.gce08d
In-Reply-To: <1202445714-28971-2-git-send-email-ribas@c3sl.ufpr.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73037>

From: Git Managment for C3SL <git@git.c3sl.ufpr.br>


Signed-off-by: Git Managment for C3SL <git@git.c3sl.ufpr.br>
---
 gitweb/README |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 4c8bedf..2163071 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -233,6 +233,10 @@ You can use the following files in repository:
    Displayed in the project summary page. You can use multiple-valued
    gitweb.url repository configuration variable for that, but the file
    takes precendence.
+ * gitweb.owner
+   You can use the gitweb.owner repository configuration variable to set
+   repository's owner. It is displayed in the project list and summary
+   page. If it's not set, filesystem directory's owner is used.
  * various gitweb.* config variables (in config)
    Read description of %feature hash for detailed list, and some
    descriptions.
-- 
1.5.4.34.g053d9-dirty
