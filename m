From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 12/12] some document update
Date: Sat, 26 Jun 2010 06:27:37 -0700
Message-ID: <1277558857-23103-13-git-send-email-struggleyb.nku@gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 15:28:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVR3-0007yz-Mc
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121Ab0FZN2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 09:28:30 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58519 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107Ab0FZN22 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 09:28:28 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1277102pvg.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5qhpIXoPZBtDLrCPdMwKTzL3DCff8zefXFeryCBelMc=;
        b=n4ntjFVrAX/F7MWIqdURCjFCf2EAwWZp1ipWnDRUjYu3rykvwFyT58J+5WrEThYdUq
         kCa0G7Hvg2tiOim2kqGy0ZaB9ciy/xFfjOC5U+s489vU251XDwv6V59kdtCKn/XZ2ZBB
         qsXiGMG4S0Vx2wAsDSysVPnK9Ysw7hqHFrawc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T1MQDBcZCO9SiLk8Fe+c0ycylsN3Gl6WK35XHIq2AljqxfKgZiLjgxqNH6SsByeP0H
         GidMNC1ayBWZoOxvZZDkucHyk2FAb5SwZoHdtNi+1WrosZMyTfbv5tt+kFyc32x6nziD
         zPJ+HvYeEb1rYQu7HVUIPINSGckPtBV24IqQ0=
Received: by 10.142.56.17 with SMTP id e17mr2690967wfa.12.1277558908271;
        Sat, 26 Jun 2010 06:28:28 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id b23sm1553667wfj.0.2010.06.26.06.28.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 06:28:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.577.g36cf0.dirty
In-Reply-To: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149753>

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/git-log.txt |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0e6ff31..14a9703 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -9,6 +9,7 @@ git-log - Show commit logs
 SYNOPSIS
 --------
 'git log' [<options>] [<since>..<until>] [[\--] <path>...]
+'git log' [<options>] -L n,m <path>
 
 DESCRIPTION
 -----------
@@ -19,6 +20,9 @@ command to control what is shown and how, and options applicable to
 the 'git diff-*' commands to control how the changes
 each commit introduces are shown.
 
+With '-L' option, the command will help to trace the history of user specified
+line ranges. It can trace multiple ranges coming from multiple files.
+
 
 OPTIONS
 -------
@@ -72,6 +76,32 @@ include::diff-options.txt[]
 	to be prefixed with "\-- " to separate them from options or
 	refnames.
 
+-L <start>,<end>::
+	The line range.  <start> and <end> can take one of these forms:
+
+- number
++
+If <start> or <end> is a number, it specifies an
+absolute line number (lines count from 1).
++
+
+- /regex/
++
+This form will use the first line matching the given
+POSIX regex.  If <end> is a regex, it will search
+starting at the line given by <start>.
++
+
+- +offset or -offset
++
+This is only valid for <end> and will specify a number
+of lines before or after the line given by <start>.
++
+
+--always-print::
+	Always print the interesting range even if the current commit
+	does not change any line of the range.
+
 
 include::rev-list-options.txt[]
 
-- 
1.7.1.577.g36cf0.dirty
