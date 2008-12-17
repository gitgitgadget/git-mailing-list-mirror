From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] Documentation: fix description for enabling hooks
Date: Wed, 17 Dec 2008 03:59:23 +0100
Message-ID: <200812170359.24109.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 17 04:00:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCmeE-0006RC-Qj
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 04:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYLQC7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 21:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbYLQC7M
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 21:59:12 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:57875 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYLQC7L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 21:59:11 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id D65B2F57AB0A;
	Wed, 17 Dec 2008 03:59:09 +0100 (CET)
Received: from [91.19.62.172] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1LCmcv-0007PK-00; Wed, 17 Dec 2008 03:59:09 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19QDe+37rAPKxScz3a9zds0u+zW2NK0iv8tMUk2
	npTOenWMC/PU1/HD8fe+jwUcEGfu1jod8Nevs+qQP4ZKV9eHkp
	wxaDQAMBDzFpfnleZfJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103302>

Since f98f8cb (Ship sample hooks with .sample suffix, 2008-06-24) hooks
are not enabled by making them executable anymore, but by removing the
'.sample' suffix from the filename.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/gitrepository-layout.txt |    3 ++-
 Documentation/glossary-content.txt     |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index a969b3f..1befca9 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -134,7 +134,8 @@ hooks::
 	Hooks are customization scripts used by various git
 	commands.  A handful of sample hooks are installed when
 	'git-init' is run, but all of them are disabled by
-	default.  To enable, they need to be made executable.
+	default.  To enable, the `.sample` suffix has to be
+	removed from the filename by renaming.
 	Read linkgit:githooks[5] for more details about
 	each hook.
 
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 9b4a4f4..9afca75 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -183,7 +183,8 @@ to point at the new commit.
 	and potentially aborted, and allow for a post-notification after the
 	operation is done. The hook scripts are found in the
 	`$GIT_DIR/hooks/` directory, and are enabled by simply
-	making them executable.
+	removing the `.sample` suffix from the filename. In earlier versions
+	of git you had to make them executable.
 
 [[def_index]]index::
 	A collection of files with stat information, whose contents are stored
-- 
1.6.1.rc3.23.gaf48b
