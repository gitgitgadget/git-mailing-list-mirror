From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [STG PATCH] change usage string of refresh to not refer to removed options
Date: Tue, 8 Jan 2008 21:43:53 +0100
Message-ID: <200801082143.53125.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:42:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCLHJ-0003pg-UT
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 21:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbYAHUl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 15:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbYAHUlz
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 15:41:55 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:33116 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298AbYAHUlx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2008 15:41:53 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 82F7024AE9B;
	Tue,  8 Jan 2008 21:41:52 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 70B5B346CE6;
	Tue,  8 Jan 2008 21:41:52 +0100 (CET)
Received: from fnoheim52.netpark.at (fnoheim52.netpark.at [83.68.151.52])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 3C5C029D4ED;
	Tue,  8 Jan 2008 21:41:52 +0100 (CET)
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.2/5443/Tue Jan  8 18:35:47 2008 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69916>


for changing the patch author, commiter and description

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---

I saw this while doing the refresh --index patch.
There was a discussion about bringing back refresh -e
If that also brings back this options, please do not apply the patch:-)

 stgit/commands/refresh.py |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 952b1b6..4695c62 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -31,11 +31,9 @@ usage = """%prog [options] [<files or dirs>]
 
 Include the latest tree changes in the current patch. This command
 generates a new GIT commit object with the patch details, the previous
-one no longer being visible. The patch attributes like author,
-committer and description can be changed with the command line
-options. The '--force' option is useful when a commit object was
-created with a different tool but the changes need to be included in
-the current patch."""
+one no longer being visible. The '--force' option is useful
+when a commit object was created with a different tool
+but the changes need to be included in the current patch."""
 
 directory = DirectoryHasRepository()
 options = [make_option('-f', '--force',
-- 
1.5.4.rc2
