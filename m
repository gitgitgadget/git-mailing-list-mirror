From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 6/7] Documentation: reset: describe new "--keep" option
Date: Sat, 12 Dec 2009 05:32:57 +0100
Message-ID: <20091212043259.3930.41408.chriscool@tuxfamily.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 05:31:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJJdo-0000Ke-6z
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 05:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758514AbZLLEbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 23:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760974AbZLLEbH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 23:31:07 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36867 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757018AbZLLEax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 23:30:53 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 88ACC818072;
	Sat, 12 Dec 2009 05:30:48 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3E159818064;
	Sat, 12 Dec 2009 05:30:46 +0100 (CET)
X-git-sha1: 91a6d60bed9475d722be67bcdcfc7b361b22b70f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135118>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-reset.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 2d27e40..f8724d0 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,7 +8,7 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [verse]
-'git reset' [--mixed | --soft | --hard | --merge] [-q] [<commit>]
+'git reset' [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]
 'git reset' [-q] [<commit>] [--] <paths>...
 'git reset' --patch [<commit>] [--] [<paths>...]
 
@@ -52,6 +52,11 @@ OPTIONS
 	and updates the files that are different between the named commit
 	and the current commit in the working tree.
 
+--keep::
+	This does the same thing as --merge, but it keeps changes in
+	the working tree and the index or it aborts if it is not
+	possible.
+
 -p::
 --patch::
 	Interactively select hunks in the difference between the index
-- 
1.6.6.rc1.8.gd33ec
