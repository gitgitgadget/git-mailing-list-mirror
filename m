From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] diff-options.txt: document the new "--dirstat" option
Date: Mon, 21 Apr 2008 18:15:52 +0000
Message-ID: <20080421181552.22887.qmail@f15a5fb7994b18.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 20:16:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo0ZG-0007qw-WF
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 20:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912AbYDUSP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 14:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbYDUSP4
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 14:15:56 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:56775 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754899AbYDUSP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 14:15:56 -0400
Received: (qmail 22888 invoked by uid 1000); 21 Apr 2008 18:15:52 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80032>

7df7c01 Adds "--dirstat" for some directory statistics,
this commit adds the documentation for the new option.

Noticed by Clint Adams, reported through
 http://bugs.debian.org/476437

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/diff-options.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 8dc5b00..01e7a57 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -58,6 +58,14 @@ endif::git-format-patch[]
 	number of modified files, as well as number of added and deleted
 	lines.
 
+--dirstat[=limit]::
+	Output only the sub-directories that are impacted by a diff,
+	and to what degree they are impacted.  You can override the
+	default cut-off in percent (3) by "--dirstat=limit".  If you
+	want to enable "cumulative" directory statistics, you can use
+	the "--cumulative" flag, which adds up percentages recursively
+	even when they have been already reported for a sub-directory.
+
 --summary::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
-- 
1.5.5
