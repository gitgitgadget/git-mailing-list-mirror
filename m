From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] cvsimport: document that -M can be used multiple times
Date: Thu, 21 Feb 2008 15:41:46 +0100
Message-ID: <1203604906-29113-1-git-send-email-book@cpan.org>
Cc: gitster@pobox.com, "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 15:42:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSCdH-0001DC-5k
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 15:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbYBUOmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 09:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbYBUOmF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 09:42:05 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:57020 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbYBUOmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 09:42:04 -0500
Received: from localhost ([127.0.0.1] helo=plop.home.bruhat.net)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JSCXi-0004n4-B8; Thu, 21 Feb 2008 15:36:58 +0100
Received: from book by plop.home.bruhat.net with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JSCcR-0007Zu-9v; Thu, 21 Feb 2008 15:41:51 +0100
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74619>

Also document the capture behaviour (source branch name in $1)

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
---
 Documentation/git-cvsimport.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 6f91b9e..5e0a314 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -102,7 +102,7 @@ If you need to pass multiple options, separate them with a comma.
 
 -m::
 	Attempt to detect merges based on the commit message. This option
-	will enable default regexes that try to capture the name source
+	will enable default regexes that try to capture the source
 	branch name from the commit message.
 
 -M <regex>::
@@ -110,6 +110,11 @@ If you need to pass multiple options, separate them with a comma.
 	regex. It can be used with '-m' to enable the default regexes
 	as well. You must escape forward slashes.
 
+	The regex must capture the source branch name in $1.
+
+	This option can be used several times to provide several
+	detection regexes.
+
 -S <regex>::
 	Skip paths matching the regex.
 
-- 
1.5.4.1
