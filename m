From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: rev-list: change a few instances of
 "git-cmd" to "git cmd"
Date: Sun, 9 Nov 2008 14:46:35 +0100
Message-ID: <20081109144635.45a62b30.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 14:45:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzAbi-0001DB-M9
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 14:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbYKINoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 08:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754867AbYKINoX
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 08:44:23 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:49569 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829AbYKINoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 08:44:22 -0500
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id A2B6C3EA0F6;
	Sun,  9 Nov 2008 14:44:17 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id 46D1D3EA109;
	Sun,  9 Nov 2008 14:44:17 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100443>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/rev-list-options.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 966276b..68a253f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -285,7 +285,7 @@ See also linkgit:git-reflog[1].
 History Simplification
 ~~~~~~~~~~~~~~~~~~~~~~
 
-When optional paths are given, 'git-rev-list' simplifies commits with
+When optional paths are given, 'git rev-list' simplifies commits with
 various strategies, according to the options you have selected.
 
 Suppose you specified `foo` as the <paths>.  We shall call commits
@@ -466,14 +466,14 @@ Limit output to the one commit object which is roughly halfway between
 the included and excluded commits. Thus, if
 
 -----------------------------------------------------------------------
-	$ git-rev-list --bisect foo ^bar ^baz
+	$ git rev-list --bisect foo ^bar ^baz
 -----------------------------------------------------------------------
 
 outputs 'midpoint', the output of the two commands
 
 -----------------------------------------------------------------------
-	$ git-rev-list foo ^midpoint
-	$ git-rev-list midpoint ^bar ^baz
+	$ git rev-list foo ^midpoint
+	$ git rev-list midpoint ^bar ^baz
 -----------------------------------------------------------------------
 
 would be of roughly the same length.  Finding the change which
-- 
1.6.0.3.614.g0f3b9
