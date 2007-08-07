From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Add a note about the index being updated by git-status in some cases
Date: Mon, 6 Aug 2007 22:57:47 -0700
Message-ID: <20070807055747.GA27417@midwinter.com>
References: <46B80993.3080409@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 07:57:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1III4o-0007JA-E5
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 07:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbXHGF5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 01:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbXHGF5t
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 01:57:49 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:48709 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751973AbXHGF5r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 01:57:47 -0400
Received: (qmail 27567 invoked by uid 1001); 7 Aug 2007 05:57:47 -0000
Content-Disposition: inline
In-Reply-To: <46B80993.3080409@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55220>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 Documentation/git-status.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 6f16eb0..8fd0fc6 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -27,6 +27,13 @@ The command takes the same set of options as `git-commit`; it
 shows what would be committed if the same options are given to
 `git-commit`.
 
+If any paths have been touched in the working tree (that is,
+their modification times have changed) but their contents and
+permissions are identical to those in the index file, the command
+updates the index file. Running `git-status` can thus speed up
+subsequent operations such as `git-diff` if the working tree
+contains many paths that have been touched but not modified.
+
 
 OUTPUT
 ------
-- 
1.5.3.rc2.4.g726f9
