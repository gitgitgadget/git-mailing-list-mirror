From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Clarify commit-tree documentation
Date: Fri, 17 Aug 2007 22:13:36 +0200
Organization: glandium.org
Message-ID: <20070817201336.GA20300@glandium.org>
References: <20070817163034.GA11151@glandium.org> <Pine.LNX.4.64.0708171751360.20400@racer.site> <20070817170411.GF28529@fieldses.org> <20070817172323.GA14145@glandium.org> <20070817173622.GI28529@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 22:14:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM8Dg-0004iP-Ra
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 22:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbXHQUOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 16:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbXHQUOx
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 16:14:53 -0400
Received: from vawad.err.no ([85.19.200.177]:35306 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbXHQUOw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 16:14:52 -0400
Received: from aputeaux-153-1-51-63.w82-124.abo.wanadoo.fr ([82.124.11.63] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IM8DW-0002Cp-F8; Fri, 17 Aug 2007 22:14:47 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IM8CO-0005Nj-CH; Fri, 17 Aug 2007 22:13:36 +0200
Content-Disposition: inline
In-Reply-To: <20070817173622.GI28529@fieldses.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.8): Status=No hits=0.8 required=5.0 tests=INFO_TLD version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56082>

As per http://marc.info/?l=git&m=118737219702802&w=2 , clarify
git-commit-tree documentation.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 Documentation/git-commit-tree.txt |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 5870c2c..6a328f4 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -51,9 +51,9 @@ A commit encapsulates:
 - author name, email and date
 - committer name and email and the commit time.
 
-If not provided, "git-commit-tree" uses your name, hostname and domain to
-provide author and committer info. This can be overridden by
-either `.git/config` file, or using the following environment variables.
+While parent object ids are provided on the command line, author and
+commiter information is taken from the following environment variables,
+if set:
 
 	GIT_AUTHOR_NAME
 	GIT_AUTHOR_EMAIL
@@ -65,12 +65,9 @@ either `.git/config` file, or using the following environment variables.
 
 (nb "<", ">" and "\n"s are stripped)
 
-In `.git/config` file, the following items are used for GIT_AUTHOR_NAME and
-GIT_AUTHOR_EMAIL:
-
-	[user]
-		name = "Your Name"
-		email = "your@email.address.xz"
+In case (some of) these environment variables are not set, the information
+is taken from the configuration items user.name and user.email, or, if not
+present, system user name and fully qualified hostname.
 
 A commit comment is read from stdin. If a changelog
 entry is not provided via "<" redirection, "git-commit-tree" will just wait
-- 
1.5.3.rc4
