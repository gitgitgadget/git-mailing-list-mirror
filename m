From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v3 6/8] Prerequisites for creating nice html for all files
 in Documentation/RelNotes
Date: Tue, 16 Oct 2012 19:26:23 +0200 (CEST)
Message-ID: <580942178.154247.1350408383667.JavaMail.ngmail@webmail15.arcor-online.net>
References: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de, git@drmicha.warpmail.net
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:26:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOAua-0006Cx-JT
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab2JPR0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:26:25 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:58236 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755091Ab2JPR0Y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 13:26:24 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id C2D0AE435C;
	Tue, 16 Oct 2012 19:26:23 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id B37C82E60B2;
	Tue, 16 Oct 2012 19:26:23 +0200 (CEST)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id AB4B535A9D3;
	Tue, 16 Oct 2012 19:26:23 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-11.arcor-online.net AB4B535A9D3
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1350408383; bh=n7dujNLlFxe8aNVNSP5aJN24RcwfoMtTsR9irdmG67M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=rjGgcrMTHFZgqngyWpw1BUu7Ap3cT29rz7P4SyONPVQFI10Ic0cVFXDsHH4hhnc1K
	 N6vrRxMepai1xl5yyuCo9CjrCcK87iBBCfxS9tWG3h0mP7KYX+ft7T/kjUX7o2p+7h
	 lxbv96F5qHeg35iQBmF8y0HXiT7/RRD2aLzTo78c=
Received: from [188.98.243.159] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Tue, 16 Oct 2012 19:26:23 +0200 (CEST)
In-Reply-To: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.243.159
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207859>


- remove left-over shell-script fragments from some files

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/RelNotes/1.5.2.1.txt | 6 ------
 Documentation/RelNotes/1.6.0.2.txt | 6 ------
 Documentation/RelNotes/1.6.1.3.txt | 4 ----
 Documentation/RelNotes/1.6.1.4.txt | 3 ---
 Documentation/RelNotes/1.6.1.txt   | 6 ------
 5 files changed, 25 deletions(-)

diff --git a/Documentation/RelNotes/1.5.2.1.txt b/Documentation/RelNotes/1.5.2.1.txt
index ebf20e2..d41984d 100644
--- a/Documentation/RelNotes/1.5.2.1.txt
+++ b/Documentation/RelNotes/1.5.2.1.txt
@@ -45,9 +45,3 @@ Fixes since v1.5.2
   - git-fastimport --import-marks was broken; fixed.
 
   - A lot of documentation updates, clarifications and fixes.
-
---
-exec >/var/tmp/1
-O=v1.5.2-65-g996e2d6
-echo O=`git describe refs/heads/maint`
-git shortlog --no-merges $O..refs/heads/maint
diff --git a/Documentation/RelNotes/1.6.0.2.txt b/Documentation/RelNotes/1.6.0.2.txt
index e1e24b3..7d8fb85 100644
--- a/Documentation/RelNotes/1.6.0.2.txt
+++ b/Documentation/RelNotes/1.6.0.2.txt
@@ -79,9 +79,3 @@ Fixes since v1.6.0.1
   packfile.
 
 Also contains many documentation updates.
-
---
-exec >/var/tmp/1
-O=v1.6.0.1-78-g3632cfc
-echo O=$(git describe maint)
-git shortlog --no-merges $O..maint
diff --git a/Documentation/RelNotes/1.6.1.3.txt b/Documentation/RelNotes/1.6.1.3.txt
index 6f0bde1..cd08d81 100644
--- a/Documentation/RelNotes/1.6.1.3.txt
+++ b/Documentation/RelNotes/1.6.1.3.txt
@@ -26,7 +26,3 @@ Fixes since v1.6.1.2
 * RPM binary package installed the html manpages in a wrong place.
 
 Also includes minor documentation fixes and updates.
-
-
---
-git shortlog --no-merges v1.6.1.2-33-gc789350..
diff --git a/Documentation/RelNotes/1.6.1.4.txt b/Documentation/RelNotes/1.6.1.4.txt
index 0ce6316..ccbad79 100644
--- a/Documentation/RelNotes/1.6.1.4.txt
+++ b/Documentation/RelNotes/1.6.1.4.txt
@@ -39,6 +39,3 @@ Fixes since v1.6.1.3
   This fix was first merged to 1.6.2.3.
 
 Also includes minor documentation fixes and updates.
-
---
-git shortlog --no-merges v1.6.1.3..
diff --git a/Documentation/RelNotes/1.6.1.txt b/Documentation/RelNotes/1.6.1.txt
index adb7cca..7b152a6 100644
--- a/Documentation/RelNotes/1.6.1.txt
+++ b/Documentation/RelNotes/1.6.1.txt
@@ -278,9 +278,3 @@ release, unless otherwise noted.
 
 * "gitweb" did not mark non-ASCII characters imported from external HTML fragments
   correctly.
-
---
-exec >/var/tmp/1
-O=v1.6.1-rc3-74-gf66bc5f
-echo O=$(git describe master)
-git shortlog --no-merges $O..master ^maint
-- 
1.7.11.msysgit.1


---
Thomas
