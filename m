From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Update git-archive documentation
Date: Wed, 18 Apr 2007 22:03:14 -0500
Message-ID: <20070419030313.GA19402@bowser.ruder>
References: <20070416053525.GA18821@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 05:05:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeMxq-0005R0-0f
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 05:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031065AbXDSDFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 23:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031076AbXDSDFc
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 23:05:32 -0400
Received: from www.aeruder.net ([65.254.53.245]:3019 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031065AbXDSDFb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 23:05:31 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id EA1BF40164;
	Wed, 18 Apr 2007 22:05:29 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070416053525.GA18821@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44980>

Documentation/git-archive.txt: Document -v/--verbose option.
Add -l as short form of --list.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/git-archive.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 8d10415..d3ca9a9 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -33,9 +33,12 @@ OPTIONS
 	Format of the resulting archive: 'tar', 'zip'...  The default
 	is 'tar'.
 
---list::
+--list, -l::
 	Show all available formats.
 
+--verbose, -v::
+	Report progress to stderr.
+
 --prefix=<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
 
-- 
1.5.1.1.116.g8c4c
