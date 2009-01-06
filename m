From: jidanni@jidanni.org
Subject: [PATCH] Documentation/git-rebase.txt: effect of Control-C interrupt
Date: Tue, 06 Jan 2009 09:17:47 +0800
Message-ID: <87tz8dnsg4.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 02:19:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK0bD-00023a-Mp
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 02:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbZAFBRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 20:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbZAFBRw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 20:17:52 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:52464
	"EHLO homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751303AbZAFBRv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 20:17:51 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id DF087119E08;
	Mon,  5 Jan 2009 17:17:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104614>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-rebase.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c8ad86a..91ca138 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -210,6 +210,9 @@ OPTIONS
 
 --abort::
 	Restore the original branch and abort the rebase operation.
+	(If you interrupt a rebase with control-C, you will still have
+	to issue a subsequent git rebase --abort to restore the
+	initial state.)
 
 --skip::
 	Restart the rebasing process by skipping the current patch.
-- 
1.6.0.6
