From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH 2/6] Add documentation for format-patch's --cover-one-patch
Date: Sat, 18 Apr 2009 18:16:17 +0200
Message-ID: <1240071381-25165-3-git-send-email-ft@bewatermyfriend.org>
References: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
Cc: Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 18:18:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDFW-0000ZQ-3A
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 18:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbZDRQQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 12:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbZDRQQ5
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 12:16:57 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:47783 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbZDRQQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 12:16:56 -0400
Received: from [212.117.84.81] (helo=fsst.voodoo.lan)
	by smtprelay11.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDq-0001N3-FF; Sat, 18 Apr 2009 18:16:54 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDL-0006YZ-I2; Sat, 18 Apr 2009 18:16:23 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116836>

Signed-off-by: Frank Terbeck <ft@bewatermyfriend.org>
---
 Documentation/git-format-patch.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index eb2fbcf..65e4089 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,6 +20,7 @@ SYNOPSIS
 		   [--subject-prefix=Subject-Prefix]
 		   [--cc=<email>]
 		   [--cover-letter]
+		   [--cover-one-patch]
 		   [ <since> | <revision range> ]
 
 DESCRIPTION
@@ -167,6 +168,11 @@ if that is not set.
 	containing the shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--cover-one-patch::
+	If a patch series is only one patch long, the format.coveronepatch
+	will prevent the creation of cover letters, if disabled.
+	This option can force creating a cover letter in those cases.
+
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
-- 
1.6.2.2.446.gfbdc0
