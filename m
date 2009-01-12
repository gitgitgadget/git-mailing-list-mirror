From: jidanni@jidanni.org
Subject: [PATCH] Documentation/git-push.txt: minor: compress one option
Date: Mon, 12 Jan 2009 11:05:54 +0800
Message-ID: <1231729554-10513-1-git-send-email-jidanni@jidanni.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 04:07:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMD9C-0007OP-H5
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 04:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbZALDGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 22:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbZALDGB
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 22:06:01 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:54458 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751645AbZALDGB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jan 2009 22:06:01 -0500
Received: from jidanni.org (122-127-36-11.dynamic.hinet.net [122.127.36.11])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 0AEB0C47EC;
	Sun, 11 Jan 2009 19:05:58 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105283>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-push.txt |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 6150b1b..3321966 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -86,14 +86,12 @@ nor in any Push line of the corresponding remotes file---see below).
 	line.
 
 --receive-pack=<git-receive-pack>::
+--exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
 	a directory on the default $PATH.
 
---exec=<git-receive-pack>::
-	Same as \--receive-pack=<git-receive-pack>.
-
 -f::
 --force::
 	Usually, the command refuses to update a remote ref that is
-- 
1.6.0.6
