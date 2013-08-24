From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 05/13] Fix some typos
Date: Sat, 24 Aug 2013 09:28:48 +0200 (CEST)
Message-ID: <1171853844.1090991.1377329328622.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:28:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8HF-0007bw-P2
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab3HXH2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:28:50 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:43308 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755188Ab3HXH2t (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:28:49 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id A3DFB35A346;
	Sat, 24 Aug 2013 09:28:48 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 9E5267FEA81;
	Sat, 24 Aug 2013 09:28:48 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 9B4501975CA;
	Sat, 24 Aug 2013 09:28:48 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net 9B4501975CA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329328; bh=7C3AC7TM2qBAWPB3Hug/tnI4YENiInp5Z3WNK0VqpNw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=q82xRdgGxWW5qQsZEGO5Qig4J2N0JAtFsD/aFM3V+OnMK/NGEqWxeF+2ehRHTa5MD
	 1lsacVRGCAtEHj2Gw5rvFN8iM+3R0qRouGvkZcopd6QQ9/61Gigy/lZIXKaijgYsrH
	 FldMVDIQyGJK7dqM3NFgYYYXGlSbvP0nPmEj6xz8=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:28:48 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232872>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ca78333..ccbddc7 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -219,7 +219,7 @@ of development leading to that point.
 
 The best way to see how this works is using the linkgit:gitk[1]
 command; running gitk now on a Git repository and looking for merge
-commits will help understand how the Git organizes history.
+commits will help understand how Git organizes history.
 
 In the following, we say that commit X is "reachable" from commit Y
 if commit X is an ancestor of commit Y.  Equivalently, you could say
@@ -793,7 +793,7 @@ e05db0fd4f31dde7005f075a84f96b360d05984b
 -------------------------------------------------
 
 Or you could recall that the `...` operator selects all commits
-contained reachable from either one reference or the other but not
+reachable from either one reference or the other but not
 both; so
 
 -------------------------------------------------
@@ -820,7 +820,7 @@ You could just visually inspect the commits since e05db0fd:
 $ gitk e05db0fd..
 -------------------------------------------------
 
-Or you can use linkgit:git-name-rev[1], which will give the commit a
+or you can use linkgit:git-name-rev[1], which will give the commit a
 name based on any tag it finds pointing to one of the commit's
 descendants:
 
@@ -3525,7 +3525,7 @@ with Git 1.5.2 can look up the submodule commits in the repository and
 manually check them out; earlier versions won't recognize the submodules at
 all.
 
-To see how submodule support works, create (for example) four example
+To see how submodule support works, create four example
 repositories that can be used later as a submodule:
 
 -------------------------------------------------
@@ -3897,7 +3897,7 @@ fact that such a commit brings together ("merges") two or more
 previous states represented by other commits.
 
 In other words, while a "tree" represents a particular directory state
-of a working directory, a "commit" represents that state in "time",
+of a working directory, a "commit" represents that state in time,
 and explains how we got there.
 
 You create a commit object by giving it the tree that describes the
-- 
1.8.3.msysgit.0


---
Thomas
