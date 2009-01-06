From: jidanni@jidanni.org
Subject: [PATCH] Documentation/git-show-branch.txt: compact -g
Date: Tue,  6 Jan 2009 11:14:02 +0800
Message-ID: <1231211642-14463-1-git-send-email-jidanni@jidanni.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 04:15:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK2Pk-0001Ed-4c
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 04:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbZAFDOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 22:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbZAFDOH
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 22:14:07 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:58142 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751286AbZAFDOH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 22:14:07 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id ACF4BC5985;
	Mon,  5 Jan 2009 19:14:04 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104627>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-show-branch.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 8277577..7e9ff37 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -99,12 +99,12 @@ OPTIONS
 	will show the revisions given by "git rev-list {caret}master
 	topic1 topic2"
 
+-g::
 --reflog[=<n>[,<base>]] [<ref>]::
 	Shows <n> most recent ref-log entries for the given
 	ref.  If <base> is given, <n> entries going back from
 	that entry.  <base> can be specified as count or date.
-	`-g` can be used as a short-hand for this option.  When
-	no explicit <ref> parameter is given, it defaults to the
+	When no explicit <ref> parameter is given, it defaults to the
 	current branch (or `HEAD` if it is detached).
 
 Note that --more, --list, --independent and --merge-base options
-- 
1.6.0.6
