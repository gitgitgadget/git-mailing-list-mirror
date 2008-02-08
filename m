From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH] gitweb: Update gitweb/README to include the new per-repository gitweb.owner
Date: Fri,  8 Feb 2008 14:38:04 -0200
Message-ID: <1202488684-13266-3-git-send-email-ribas@c3sl.ufpr.br>
References: <1202488684-13266-1-git-send-email-ribas@c3sl.ufpr.br>
 <1202488684-13266-2-git-send-email-ribas@c3sl.ufpr.br>
Cc: gitster@pobox.com, Bruno Ribas <ribas@c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 17:40:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNWGN-0002NA-VR
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 17:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933871AbYBHQio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 11:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933863AbYBHQim
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 11:38:42 -0500
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:45737 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933859AbYBHQik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 11:38:40 -0500
Received: from localhost (unknown [189.1.130.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id B9C867000043B;
	Fri,  8 Feb 2008 14:38:38 -0200 (BRST)
X-Mailer: git-send-email 1.5.4.24.gce08d
In-Reply-To: <1202488684-13266-2-git-send-email-ribas@c3sl.ufpr.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73110>


Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
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
1.5.4.24.gce08d
