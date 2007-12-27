From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Point out merged submodule maintainers as better addresses for patches
Date: Wed, 26 Dec 2007 23:12:20 -0500
Message-ID: <20071227041220.GA22256@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Dec 27 05:13:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7k7F-0003Di-0B
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 05:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbXL0EMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 23:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbXL0EMg
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 23:12:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55986 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbXL0EMf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 23:12:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J7k6V-0003vW-V7; Wed, 26 Dec 2007 23:12:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A0FEC20FBAE; Wed, 26 Dec 2007 23:12:20 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69256>

Junio doesn't directly manage the git-gui or gitk-git subdirectories
within git.git; these are currently managed by other individuals
and then periodically merged to git.git.  Users often send patches
to Junio for these directories when they should be directed at the
current maintainer instead, so we should point out these special
cases in the SubmittingPatches documentation.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Just a suggestion.  Might help people who are new to the Git
 community to get involved.

 Documentation/SubmittingPatches |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index de08d09..b7c886c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -34,10 +34,16 @@ Checklist (and a short version for the impatient):
 	- if your name is not writable in ASCII, make sure that
 	  you send off a message in the correct encoding.
 	- send the patch to the list (git@vger.kernel.org) and the
-	  maintainer (gitster@pobox.com). If you use
+	  active maintainer (see below). If you use
 	  git-send-email(1), please test it first by sending
 	  email to yourself.
 
+	Active maintainers:
+
+	- git-gui/ submodule:     spearce@spearce.org
+	- gitk-git/ submodule:    paulus@samba.org
+	- Everything else:        gitster@pobox.com
+
 Long version:
 
 I started reading over the SubmittingPatches document for Linux
-- 
1.5.4.rc2.1097.gb6e0d
