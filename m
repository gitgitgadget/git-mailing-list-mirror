From: jidanni@jidanni.org
Subject: Re: [PATCH,v3] git-checkout(1): mention fate of extraneous files
Date: Tue, 20 Jan 2009 07:31:46 +0800
Message-ID: <87hc3uvpnh.fsf_-_@jidanni.org>
References: <200901191716.59373.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de
To: bss@iguanasuicide.net
X-From: git-owner@vger.kernel.org Tue Jan 20 00:33:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3cL-0003Zi-3n
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbZASXbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbZASXbu
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:31:50 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:51754 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752892AbZASXbt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 18:31:49 -0500
Received: from jidanni.org (122-127-34-185.dynamic.hinet.net [122.127.34.185])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id E7EE6119DCF;
	Mon, 19 Jan 2009 15:31:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106402>

Signed-off-by: jidanni <jidanni@jidanni.org>
---
Thanks Boyd.
 Documentation/git-checkout.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 9cd5151..56e1ec9 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -17,7 +17,8 @@ DESCRIPTION
 When <paths> are not given, this command switches branches by
 updating the index and working tree to reflect the specified
 branch, <branch>, and updating HEAD to be <branch> or, if
-specified, <new_branch>.  Using -b will cause <new_branch> to
+specified, <new_branch>. (To also delete untracked content
+use linkgit:git-clean[1].) Using -b will cause <new_branch> to
 be created; in this case you can use the --track or --no-track
 options, which will be passed to `git branch`.
 
-- 
1.6.0.6
