From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH v3 2/5] git-add.txt: document 'interactive.singlekey'
Date: Thu,  5 May 2011 20:48:45 +0200
Message-ID: <1304621328-17184-2-git-send-email-valentin.haenel@gmx.de>
References: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 20:50:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3cr-0005v4-Rr
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138Ab1EESuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:50:06 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:60223 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab1EESuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:50:05 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p45InsV1017256;
	Thu, 5 May 2011 20:49:54 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p45InsYP017255;
	Thu, 5 May 2011 20:49:54 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172870>

This is documented in the section about the 'Interactive Mode', rather than for
the option '--patch', since this is the section is where people go to learn
about '--patch'.

Signed-off-by: Valentin Haenel <valentin.haenel@gmx.de>
Helped-by: Jeff King <peff@peff.net>
Mentored-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-add.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 35cb5d3..9c1d395 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -274,7 +274,8 @@ patch::
   This lets you choose one path out of a 'status' like selection.
   After choosing the path, it presents the diff between the index
   and the working tree file and asks you if you want to stage
-  the change of each hunk.  You can say:
+  the change of each hunk.  You can select one of the following
+  options and type return:
 
        y - stage this hunk
        n - do not stage this hunk
@@ -293,6 +294,9 @@ patch::
 +
 After deciding the fate for all hunks, if there is any hunk
 that was chosen, the index is updated with the selected hunks.
++
+You can omit having to type return here, by setting the configuration
+variable `interactive.singlekey` to `true`.
 
 diff::
 
-- 
1.7.1
