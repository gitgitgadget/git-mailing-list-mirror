From: jidanni@jidanni.org
Subject: [PATCH,v2] git-checkout(1): mention fate of extraneous files
Date: Tue, 20 Jan 2009 06:45:12 +0800
Message-ID: <87priivrt3.fsf_-_@jidanni.org>
References: <877i4teq78.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 23:46:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP2tH-0007uB-Aa
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 23:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbZASWpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 17:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZASWpQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 17:45:16 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:55856 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752680AbZASWpP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 17:45:15 -0500
Received: from jidanni.org (122-127-34-185.dynamic.hinet.net [122.127.34.185])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 4D04BD26FE;
	Mon, 19 Jan 2009 14:45:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106395>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-checkout.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9cd5151..58abdc6 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -17,7 +17,8 @@ DESCRIPTION
 When <paths> are not given, this command switches branches by
 updating the index and working tree to reflect the specified
 branch, <branch>, and updating HEAD to be <branch> or, if
-specified, <new_branch>.  Using -b will cause <new_branch> to
+specified, <new_branch>. (No files are deleted, use linkgit:git-clean[1]
+for a pristine checkout.) Using -b will cause <new_branch> to
 be created; in this case you can use the --track or --no-track
 options, which will be passed to `git branch`.
 
-- 
1.6.0.6
