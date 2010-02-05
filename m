From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/9] Documentation: describe new cherry-pick --ff option
Date: Sat, 06 Feb 2010 00:11:09 +0100
Message-ID: <20100205231112.3689.48965.chriscool@tuxfamily.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:12:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXLh-0008Fb-8c
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933210Ab0BEXMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:12:13 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53995 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757639Ab0BEXMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:12:03 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A885E8180A3;
	Sat,  6 Feb 2010 00:11:52 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9FA25818089;
	Sat,  6 Feb 2010 00:11:49 +0100 (CET)
X-git-sha1: 765d347018c67d3712c040eaf9519c1c07306b93 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139114>


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
1.6.6.1.557.g77031
