From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Sat, 9 Feb 2008 11:22:35 -0500
Message-ID: <20080209162234.GA25533@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 17:23:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNsU1-0005Pi-BS
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 17:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbYBIQWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 11:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbYBIQWn
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 11:22:43 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56292 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967AbYBIQWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 11:22:42 -0500
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JNsTM-0006gx-4V; Sat, 09 Feb 2008 11:22:36 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73238>

From: J. Bruce Fields <bfields@citi.umich.edu>

This will change the notion of "bad" whitespace for the git project to
include initial whitespace that uses spaces where tabs could have been
used.

This only changes which whitespace is considered "bad".  It doesn't
change the behavior when bad whitespace is found.  By default, commands
like git-apply, git-am, and git-rebase will print a warning but
otherwise do nothing.
---
 .gitattributes |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 .gitattributes

Is there any reason not to use this now that we have it?

diff --git a/.gitattributes b/.gitattributes
new file mode 100644
index 0000000..dd65501
--- /dev/null
+++ b/.gitattributes
@@ -0,0 +1 @@
+* whitespace
-- 
1.5.4.rc2.60.gb2e62
