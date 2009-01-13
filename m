From: jidanni@jidanni.org
Subject: [PATCH/RFC] Documentation/git-blame.txt, git-gui.txt: link SEE ALSOs
Date: Tue, 13 Jan 2009 09:13:20 +0800
Message-ID: <87bpucovnz.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 02:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMXrl-0006ET-Bs
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 02:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921AbZAMBNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 20:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756898AbZAMBNX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 20:13:23 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:39600 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756130AbZAMBNX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 20:13:23 -0500
Received: from jidanni.org (122-127-34-152.dynamic.hinet.net [122.127.34.152])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 2E4EB119DEA
	for <git@vger.kernel.org>; Mon, 12 Jan 2009 17:13:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105434>

As git gui is heavily blame focused, we link its SEE ALSO to
git-blame, and add a link back while we're at it.

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-blame.txt |    1 +
 Documentation/git-gui.txt   |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index fba374d..d71a2c3 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -186,6 +186,7 @@ commit commentary), a blame viewer won't ever care.
 
 SEE ALSO
 --------
+linkgit:git-gui[1],
 linkgit:git-annotate[1]
 
 AUTHOR
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index d0bc98b..3a71074 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -105,6 +105,9 @@ linkgit:gitk[1]::
 	and file differences.  gitk is the utility started by
 	'git-gui''s Repository Visualize actions.
 
+linkgit:git-blame[1]::
+	Command-line blame viewer.
+
 Other
 -----
 'git-gui' is actually maintained as an independent project, but stable
-- 
1.6.0.6
