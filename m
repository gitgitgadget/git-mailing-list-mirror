From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] INSTALL: Update section about git-frotz form.
Date: Sun,  6 Jul 2008 06:28:41 +0200
Message-ID: <1215318521-23901-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 06:31:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFLuF-0003Bt-F9
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 06:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbYGFE2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 00:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbYGFE2c
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 00:28:32 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36482 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbYGFE2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 00:28:32 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 8E11A1DDC5B;
	Sun,  6 Jul 2008 06:28:30 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 503311A9CEF; Sun,  6 Jul 2008 06:28:41 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.322.ge904b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87495>

The old text stated that 'git-frotz' can be always used instead of 'git
frotz' which is no longer true.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 INSTALL |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/INSTALL b/INSTALL
index 4a4e13f..0efb4b7 100644
--- a/INSTALL
+++ b/INSTALL
@@ -27,20 +27,14 @@ Issues of note:
  - git normally installs a helper script wrapper called "git", which
    conflicts with a similarly named "GNU interactive tools" program.
 
-   Tough.  Either don't use the wrapper script, or delete the old GNU
-   interactive tools.  None of the core git stuff needs the wrapper,
-   it's just a convenient shorthand and while it is documented in some
-   places, you can always replace "git commit" with "git-commit"
-   instead.
-
-   But let's face it, most of us don't have GNU interactive tools, and
-   even if we had it, we wouldn't know what it does.  I don't think it
-   has been actively developed since 1997, and people have moved over to
+   Let's face it, most of us don't have GNU interactive tools, and even
+   if we had it, we wouldn't know what it does.  I don't think it has
+   been actively developed since 1997, and people have moved over to
    graphical file managers.
 
-   NOTE: As of gnuit-4.9.2, the GNU interactive tools package has been
-         renamed. You can compile gnuit with the --disable-transition
-         option and then it will not conflict with git.
+   In addition, as of gnuit-4.9.2, the GNU interactive tools package has
+   been renamed. You can compile gnuit with the --disable-transition
+   option and then it will not conflict with git.
 
  - You can use git after building but without installing if you
    wanted to.  Various git commands need to find other git
-- 
1.5.6.1.322.ge904b.dirty
