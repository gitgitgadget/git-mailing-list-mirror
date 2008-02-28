From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] cvsimport: document that -M can be used multiple times
Date: Thu, 28 Feb 2008 11:18:23 +0100
Message-ID: <1204193904-3652-4-git-send-email-book@cpan.org>
References: <>
 <1204193904-3652-1-git-send-email-book@cpan.org>
 <1204193904-3652-2-git-send-email-book@cpan.org>
 <1204193904-3652-3-git-send-email-book@cpan.org>
Cc: gitster@pobox.com, "Philippe Bruhat (BooK" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 11:20:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUfrx-0005VB-CN
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 11:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbYB1KTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 05:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbYB1KTD
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 05:19:03 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:34201 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbYB1KS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 05:18:57 -0500
Received: from localhost ([127.0.0.1] helo=plop.home.bruhat.net)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JUfs1-0007q0-A2; Thu, 28 Feb 2008 11:20:09 +0100
Received: from book by plop.home.bruhat.net with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JUfqe-0000aZ-HH; Thu, 28 Feb 2008 11:18:44 +0100
X-Mailer: git-send-email 1.5.4.2.187.gfc276
In-Reply-To: <1204193904-3652-3-git-send-email-book@cpan.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75381>

From: Philippe Bruhat (BooK <book@cpan.org>

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
