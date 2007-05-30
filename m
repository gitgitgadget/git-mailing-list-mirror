From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/2] gitview: Use new-style classes
Date: Wed, 30 May 2007 14:47:08 +1000 (EST)
Message-ID: <f623da83269ba030fabc64777cdb1071e5ab00bf.1180500418.git.michael@ellerman.id.au>
Cc: <git@vger.kernel.org>
To: <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 06:47:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtG5g-00061J-Ia
	for gcvg-git@gmane.org; Wed, 30 May 2007 06:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbXE3ErK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 00:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbXE3ErK
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 00:47:10 -0400
Received: from ozlabs.org ([203.10.76.45]:53413 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbXE3ErJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 00:47:09 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
	id 3106DDDFD4; Wed, 30 May 2007 14:47:08 +1000 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48737>


Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 contrib/gitview/gitview |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 2d80e2b..6b54bc0 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -259,7 +259,7 @@ class CellRendererGraph(gtk.GenericCellRenderer):
 				self.set_colour(ctx, colour, 0.0, 0.5)
 			ctx.show_text(name)
 
-class Commit:
+class Commit(object):
 	""" This represent a commit object obtained after parsing the git-rev-list
 	output """
 
@@ -339,7 +339,7 @@ class Commit:
 		fp.close()
 		return diff
 
-class AnnotateWindow:
+class AnnotateWindow(object):
 	"""Annotate window.
 	This object represents and manages a single window containing the
 	annotate information of the file
@@ -519,7 +519,7 @@ class AnnotateWindow:
 		self.io_watch_tag = gobject.io_add_watch(fp, gobject.IO_IN, self.data_ready)
 
 
-class DiffWindow:
+class DiffWindow(object):
 	"""Diff window.
 	This object represents and manages a single window containing the
 	differences between two revisions on a branch.
@@ -674,7 +674,7 @@ class DiffWindow:
 			fp.close()
 		dialog.destroy()
 
-class GitView:
+class GitView(object):
 	""" This is the main class
 	"""
 	version = "0.9"
-- 
1.5.1.3.g7a33b
