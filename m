From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 5/7] Documentation: describe new cherry-pick --ff option
Date: Sat, 06 Mar 2010 21:34:44 +0100
Message-ID: <20100306203447.2960.15351.chriscool@tuxfamily.org>
References: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 03:28:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No6EC-0003Eu-9W
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 03:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab0CGC2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 21:28:08 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:45510 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418Ab0CGC1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 21:27:51 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 41DE7818043;
	Sun,  7 Mar 2010 03:27:40 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EFE4A81807C;
	Sun,  7 Mar 2010 03:27:36 +0100 (CET)
X-git-sha1: 853f9ec7ced21c2f047eb8a4795e58849fb86a6f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141642>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-cherry-pick.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 78f4714..d71607a 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -7,7 +7,7 @@ git-cherry-pick - Apply the change introduced by an existing commit
 
 SYNOPSIS
 --------
-'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] <commit>
+'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>
 
 DESCRIPTION
 -----------
@@ -70,6 +70,10 @@ effect to your index in a row.
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
 
+--ff::
+	If the current HEAD is the same as the parent of the
+	cherry-pick'ed commit, then a fast forward to this commit will
+	be performed.
 
 Author
 ------
-- 
1.7.0.1.307.g861f4
