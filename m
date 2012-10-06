From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch 1/5] Fix some asciidoc layout problems
Date: Sat, 6 Oct 2012 17:53:59 +0200 (CEST)
Message-ID: <244418682.269701.1349538839518.JavaMail.ngmail@webmail08.arcor-online.net>
References: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 17:54:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKWhh-0002qU-92
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 17:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab2JFPyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 11:54:03 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:38281 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753421Ab2JFPyA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 11:54:00 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id 8F1D226599
	for <git@vger.kernel.org>; Sat,  6 Oct 2012 17:53:59 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id 7E95A2E6056
	for <git@vger.kernel.org>; Sat,  6 Oct 2012 17:53:59 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 7FDBE212C5A
	for <git@vger.kernel.org>; Sat,  6 Oct 2012 17:53:59 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-13.arcor-online.net 7FDBE212C5A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349538839; bh=One1RC9dpYvzEaisFnGyXhSqwGzDH+uLR2oBuLzQ/Mw=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=pGWVovE9ajs9sRHtoymcvycv7quwCwgN4VME9BigKhBFBf3m+D43aFpBr61Mpc3OI
	 s2II3B6YpWqnYetjHCDtcyjtrIrn+W8g5A2lS/mVCLYo7GFVqncJ6dAelbb6P+V9OM
	 oAun9YWgL5EF9Nra7opKJ30EwAYf/47Pe0mZml50=
Received: from [94.217.29.222] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 6 Oct 2012 17:53:59 +0200 (CEST)
In-Reply-To: <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.29.222
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207152>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/git-bisect-lk2009.txt | 12 ++++++------
 Documentation/git-fetch-pack.txt    |  5 ++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 8a2ba37..99bdb46 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -248,7 +248,7 @@ Bisecting: 5480 revisions left to test after this (roughly 13 steps)
 And after a few more steps like that, "git bisect" will eventually
 find a first bad commit:
 
--------------
+------------------------------------------------------------------------------------------------------------
 $ git bisect bad
 2ddcca36c8bcfa251724fe342c8327451988be0d is the first bad commit
 commit 2ddcca36c8bcfa251724fe342c8327451988be0d
@@ -257,8 +257,8 @@ Date:   Sat May 3 11:59:44 2008 -0700
 
     Linux 2.6.26-rc1
 
-:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M      Makefile
--------------
+:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M  Makefile
+------------------------------------------------------------------------------------------------------------
 
 At this point we can see what the commit does, check it out (if it's
 not already checked out) or tinker with it, for example:
@@ -305,7 +305,7 @@ to launch a script or command at each bisection step to know if the
 current commit is "good" or "bad". To do that, we use the "git bisect
 run" command. For example:
 
--------------
+------------------------------------------------------------------------------------------------------------
 $ git bisect start v2.6.27 v2.6.25
 Bisecting: 10928 revisions left to test after this (roughly 14 steps)
 [2ec65f8b89ea003c27ff7723525a2ee335a2b393] x86: clean up using max_low_pfn on 32-bit
@@ -331,9 +331,9 @@ Date:   Sat May 3 11:59:44 2008 -0700
 
     Linux 2.6.26-rc1
 
-:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M      Makefile
+:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M  Makefile
 bisect run success
--------------
+------------------------------------------------------------------------------------------------------------
 
 In this example, we passed "grep '^SUBLEVEL = 25' Makefile" as
 parameter to "git bisect run". This means that at each step, the grep
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 474fa30..12cd8a2 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -9,7 +9,10 @@ git-fetch-pack - Receive missing objects from another repository
 SYNOPSIS
 --------
 [verse]
-'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]
+'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] 
+				[--upload-pack=<git-upload-pack>] 
+				[--depth=<n>] [--no-progress] 
+				[-v] [<host>:]<directory> [<refs>...]
 
 DESCRIPTION
 -----------
-- 
1.7.11.msysgit.1
