From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] Change from using email.com to example.com as example domain, as per RFC 2606.
Date: Fri,  7 Dec 2007 10:36:45 +1100
Message-ID: <11969842052283-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org, David Symonds <dsymonds@gmail.com>
To: Junio Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 00:37:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0QHP-0005xl-Eo
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 00:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbXLFXg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 18:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbXLFXg5
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 18:36:57 -0500
Received: from ipmail04.adl2.internode.on.net ([203.16.214.57]:27814 "EHLO
	ipmail04.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752088AbXLFXg5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Dec 2007 18:36:57 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAOMWWEd5LDSh/2dsb2JhbACBWo9P
X-IronPort-AV: E=Sophos;i="4.23,264,1194183000"; 
   d="scan'208";a="12823776"
Received: from ppp121-44-52-161.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.52.161])
  by ipmail04.adl2.internode.on.net with ESMTP; 07 Dec 2007 10:06:51 +1030
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67354>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 Documentation/SubmittingPatches |    2 +-
 ident.c                         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 83bf54c..d234c8d 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -10,7 +10,7 @@ Checklist (and a short version for the impatient):
 	- the first line of the commit message should be a short
 	  description and should skip the full stop
 	- if you want your work included in git.git, add a
-	  "Signed-off-by: Your Name <your@email.com>" line to the
+	  "Signed-off-by: Your Name <your@example.com>" line to the
 	  commit message (or just use the option "-s" when
 	  committing) to confirm that you agree to the Developer's
 	  Certificate of Origin
diff --git a/ident.c b/ident.c
index 07b4998..7631698 100644
--- a/ident.c
+++ b/ident.c
@@ -175,7 +175,7 @@ static const char *env_hint =
 "\n"
 "Run\n"
 "\n"
-"  git config --global user.email \"you@email.com\"\n"
+"  git config --global user.email \"you@example.com\"\n"
 "  git config --global user.name \"Your Name\"\n"
 "\n"
 "to set your account\'s default identity.\n"
-- 
1.5.3.1
