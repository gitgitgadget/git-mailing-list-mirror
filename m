From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 4/6] Fix places where 'Git' should be 'git
Date: Fri, 1 Feb 2013 19:10:25 +0100 (CET)
Message-ID: <253726098.1090112.1359742225624.JavaMail.ngmail@webmail18.arcor-online.net>
References: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net> <7vzjzodfp1.fsf@alter.siamese.dyndns.org> <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Fri Feb 01 19:10:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1L4a-0004XV-Sa
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab3BASK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:10:28 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:43690 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753109Ab3BASK0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 13:10:26 -0500
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id 9AFD93073C;
	Fri,  1 Feb 2013 19:10:25 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 91E7919711;
	Fri,  1 Feb 2013 19:10:25 +0100 (CET)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net [151.189.8.76])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 937D9107C11;
	Fri,  1 Feb 2013 19:10:25 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 937D9107C11
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1359742225; bh=1QcfhD34LFRJ7ZGDm9ueBgVjUcZB5jIXF2hrMj/LXdw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=JWXSg1F1X3/8ofdPyGETNd7JL1uUc2Rb5MjOPeO7IYn3OkmlAKXRjXf4XMELNcA8T
	 +AGwwhjeYWA7GnLR/z/nGfC7ywjvevrhvUUFAsbPBVWvqqiddpKK6FLDuQGXTrDhU3
	 u/ER4JDth8atuHQSwKAnFkhbwt+vJpv13BohcxwY=
Received: from [188.105.106.49] by webmail18.arcor-online.net (151.189.8.76) with HTTP (Arcor Webmail); Fri, 1 Feb 2013 19:10:25 +0100 (CET)
In-Reply-To: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215242>

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/git-p4.txt        | 4 ++--
 Documentation/git-remote-fd.txt | 2 +-
 Documentation/gittutorial.txt   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 1d1b020..3417cb3 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -334,11 +334,11 @@ configuration file.  This allows future 'git p4 submit' commands to
 work properly; the submit command looks only at the variable and does
 not have a command-line option.
 
-The full syntax for a p4 view is documented in 'p4 help views'.  'Git p4'
+The full syntax for a p4 view is documented in 'p4 help views'.  'git p4'
 knows only a subset of the view syntax.  It understands multi-line
 mappings, overlays with '+', exclusions with '-' and double-quotes
 around whitespace.  Of the possible wildcards, 'git p4' only handles
-'...', and only when it is at the end of the path.  'Git p4' will complain
+'...', and only when it is at the end of the path.  'git p4' will complain
 if it encounters an unhandled wildcard.
 
 Bugs in the implementation of overlap mappings exist.  If multiple depot
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index 9bfe12c..933c2ad 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 This helper uses specified file descriptors to connect to a remote Git server.
-This is not meant for end users but for programs and scripts calling Git
+This is not meant for end users but for programs and scripts calling git
 fetch, push or archive.
 
 If only <infd> is given, it is assumed to be a bidirectional socket connected
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 6091988..8262196 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -462,7 +462,7 @@ Exploring history
 
 Git history is represented as a series of interrelated commits.  We
 have already seen that the 'git log' command can list those commits.
-Note that first line of each Git log entry also gives a name for the
+Note that first line of each git log entry also gives a name for the
 commit:
 
 -------------------------------------
-- 
1.8.0.msysgit.0


---
Thomas
