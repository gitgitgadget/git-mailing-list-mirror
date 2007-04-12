From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Document the new 'stg branch --description' features.
Date: Thu, 12 Apr 2007 22:15:36 +0200
Message-ID: <20070412201536.21560.26933.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 22:16:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc5iq-0005Xl-1j
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 22:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbXDLUQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 16:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbXDLUQS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 16:16:18 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46658 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbXDLUQR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 16:16:17 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D84955DFC3;
	Thu, 12 Apr 2007 22:16:16 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id E0BEC1F058;
	Thu, 12 Apr 2007 22:15:36 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44350>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg-branch.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/stg-branch.txt b/Documentation/stg-branch.txt
index 2efe7b1..25c9c19 100644
--- a/Documentation/stg-branch.txt
+++ b/Documentation/stg-branch.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 'stg' branch --create <newstack> [<commit-id>]
 'stg' branch --clone [<newstack>]
 'stg' branch --rename <oldname> <newname>
+'stg' branch --description=<description> [<branch>]
 'stg' branch --protect [<branch>]
 'stg' branch --unprotect [<branch>]
 'stg' branch --delete [--force] <branch>
@@ -66,6 +67,9 @@ a new stack off the current branch.
 'stg' branch [-r | --rename]::
 	Rename the stack named <oldname> to <newname>.
 
+'stg' branch [-d <desc> | --description=<desc>]::
+	Set the branch description.
+
 'stg' branch [-p | --protect]::
 	Protect the named stack or the current one, preventing
 	further StGIT operations from modifying this stack.
