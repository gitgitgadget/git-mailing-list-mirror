From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] cvsimport: document that -M can be used multiple times
Date: Fri, 22 Feb 2008 08:19:31 +0100
Message-ID: <1203664771-7327-1-git-send-email-book@cpan.org>
Cc: gitster@pobox.com, "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 08:20:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSSCh-00024G-Dj
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 08:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbYBVHTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 02:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbYBVHTl
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 02:19:41 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:58660 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbYBVHTk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 02:19:40 -0500
Received: from localhost ([127.0.0.1] helo=plop.home.bruhat.net)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JSS73-0006S6-Ef; Fri, 22 Feb 2008 08:14:29 +0100
Received: from book by plop.home.bruhat.net with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JSSBw-0001uZ-2f; Fri, 22 Feb 2008 08:19:32 +0100
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74697>

Also document the capture behaviour (source branch name in $1)

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
---
 Documentation/git-cvsimport.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 6f91b9e..58eefd4 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -102,13 +102,17 @@ If you need to pass multiple options, separate them with a comma.
 
 -m::
 	Attempt to detect merges based on the commit message. This option
-	will enable default regexes that try to capture the name source
+	will enable default regexes that try to capture the source
 	branch name from the commit message.
 
 -M <regex>::
 	Attempt to detect merges based on the commit message with a custom
 	regex. It can be used with '-m' to enable the default regexes
 	as well. You must escape forward slashes.
++
+The regex must capture the source branch name in $1.
++
+This option can be used several times to provide several detection regexes.
 
 -S <regex>::
 	Skip paths matching the regex.
-- 
1.5.4.2.187.gfc276
