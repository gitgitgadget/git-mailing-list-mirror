From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH 5/6] Add documentation for --cover-overwrite
Date: Sat, 18 Apr 2009 18:16:20 +0200
Message-ID: <1240071381-25165-6-git-send-email-ft@bewatermyfriend.org>
References: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
Cc: Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 18:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDRH-0004Mb-2R
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 18:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbZDRQ3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 12:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbZDRQ3N
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 12:29:13 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:38645 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbZDRQ3M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 12:29:12 -0400
X-Greylist: delayed 735 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2009 12:29:12 EDT
Received: from [212.117.84.81] (helo=fsst.voodoo.lan)
	by smtprelay08.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDr-00010O-7k; Sat, 18 Apr 2009 18:16:55 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDL-0006Yi-La; Sat, 18 Apr 2009 18:16:24 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116841>

Signed-off-by: Frank Terbeck <ft@bewatermyfriend.org>
---
 Documentation/git-format-patch.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 65e4089..07a2ee3 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -21,6 +21,7 @@ SYNOPSIS
 		   [--cc=<email>]
 		   [--cover-letter]
 		   [--cover-one-patch]
+		   [--cover-overwrite]
 		   [ <since> | <revision range> ]
 
 DESCRIPTION
@@ -173,6 +174,10 @@ if that is not set.
 	will prevent the creation of cover letters, if disabled.
 	This option can force creating a cover letter in those cases.
 
+--cover-overwrite::
+	If format.overwritecoverletter is unset, this option will
+	temporarily force overwriting cover letters.
+
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
-- 
1.6.2.2.446.gfbdc0
