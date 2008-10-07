From: Mikael Magnusson <mikachu@gmail.com>
Subject: [PATCH] Fix a few typos in relnotes
Date: Tue, 7 Oct 2008 20:15:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0810072014120.32207@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:18:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnH6w-00041A-9P
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 20:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbYJGSPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 14:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbYJGSPb
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 14:15:31 -0400
Received: from mail.bredband2.net ([82.209.166.4]:23634 "EHLO
	smtp.bredband2.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753717AbYJGSPa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 14:15:30 -0400
Received: (qmail 22054 invoked from network); 7 Oct 2008 18:14:23 -0000
Received: from lkf-194-200-233-83.3.cust.bredband2.com (HELO mika.l3ib.org) ([83.233.200.194])
          (envelope-sender <mikachu@gmail.com>)
          by smtp.bredband2.net (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 7 Oct 2008 18:14:23 -0000
User-Agent: Alpine 2.00 (LNX )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97738>

---
  Documentation/RelNotes-1.6.0.3.txt |    8 ++++----
  1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RelNotes-1.6.0.3.txt b/Documentation/RelNotes-1.6.0.3.txt
index edd5e45..6cf8ae4 100644
--- a/Documentation/RelNotes-1.6.0.3.txt
+++ b/Documentation/RelNotes-1.6.0.3.txt
@@ -53,7 +53,7 @@ Fixes since v1.6.0.2
  * Stale temporary files under $GIT_DIR/objects/pack are now cleaned up
    automatically by "git prune".

-* "git merge" once agrain removes directories after the last file has
+* "git merge" once again removes directories after the last file has
    been removed from it during the merge.

  * "git blame -C -C" no longer segfaults while trying to pass blame if
@@ -68,10 +68,10 @@ Fixes since v1.6.0.2
  * The "git commit" error message when there are still unmerged
    files present was clarified to match "git write-tree".

-* Some segfaults due to uncaught NULL pointers were fixed multiple
+* Some segfaults due to uncaught NULL pointers were fixed in multiple
    tools such as apply, reset, update-index.

-* Solaris bulds now default to OLD_ICONV=1 to avoid compile warnings.
+* Solaris builds now default to OLD_ICONV=1 to avoid compile warnings.

  * "Git.pm" tests relied on unnecessarily more recent version of Perl.

@@ -80,7 +80,7 @@ Fixes since v1.6.0.2
  * "gitweb" triggered undef warnings on missing trees.

  * "gitweb" now removes PATH_INFO from its URLs so users don't have
-  to manually set the url in the gitweb configuration.
+  to manually set the URL in the gitweb configuration.

  * Bash completion removed support for legacy "git-fetch", "git-push"
    and "git-pull" as these are no longer installed.  Dashless form
-- 
1.6.0.2.GIT


--
Mikael Magnusson
