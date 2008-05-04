From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] INSTALL: add a note about GNU interactive tools has been renamed
Date: Sun,  4 May 2008 16:56:20 +0200
Message-ID: <1209912911-17767-1-git-send-email-vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 16:57:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsfeT-00044m-4C
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 16:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbYEDO4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 10:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbYEDO4c
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 10:56:32 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:39505 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbYEDO4b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 10:56:31 -0400
Received: from vmobile.example.net (dsl5401CB57.pool.t-online.hu [84.1.203.87])
	by yugo.frugalware.org (Postfix) with ESMTP id 3EC631DDC5B
	for <git@vger.kernel.org>; Sun,  4 May 2008 16:56:29 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id A91E3185E18; Sun,  4 May 2008 16:56:20 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81176>

In recent versions GNU's git has been renamed to gnuit, document this
while talking about how to resolve the conflict.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 INSTALL |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/INSTALL b/INSTALL
index 6f3bcb4..d9b425f 100644
--- a/INSTALL
+++ b/INSTALL
@@ -38,6 +38,10 @@ Issues of note:
    has been actively developed since 1997, and people have moved over to
    graphical file managers.
 
+   NOTE: As of gnuit-4.9.2, the GNU interactive tools package has been
+         renamed. You can compile gnuit with the --disable-transition
+         option and then it will not conflict with git.
+
  - You can use git after building but without installing if you
    wanted to.  Various git commands need to find other git
    commands and scripts to do their work, so you would need to
-- 
1.5.5.1
