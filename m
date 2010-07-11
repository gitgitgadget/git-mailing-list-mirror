From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v3 13/13] some document update
Date: Sun, 11 Jul 2010 14:19:01 +0800
Message-ID: <1278829141-11900-13-git-send-email-struggleyb.nku@gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:22:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXpvS-0002Bb-4t
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab0GKGVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:21:53 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40135 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab0GKGVv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:21:51 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so1399328pwi.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JTJxpV5XhnOdu0VLOEkjIe03lAIFXCl22Eti8R4scSI=;
        b=IOXC93Zqw1H5XNzdEXLf4QvnsX8RjPzihnkCIUvj/M3OVtqzH6W3ABu6qJoFk5lkiA
         wDcMoHTiLW1C7YZXCia1QekR4pp8DCKk3Kyjd4kd9lC1tTIyPkn1SlR8T/6v8ceZgod9
         yxHqI1YzkOvnaxaf8RpcX0VcbnCkJz0uVXz7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qi2WEtS6gidPpw5eAVrJ2Y3DlZtKPC5E/DSrjAEFyCvqqy8AgAhoX3cfyXhYZKA+X7
         p5YDVOMpMc4CYmfBLXh62Z6yAyKAVv7QQmReC8kjbETE/2WmaQbolPyUbELuwM6QVbWS
         0bM/ljsWHmx6CcVBOm+pEk/LP1CNLh1JHvFLM=
Received: by 10.114.103.4 with SMTP id a4mr14038793wac.52.1278829310984;
        Sat, 10 Jul 2010 23:21:50 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id c15sm2927911rvi.11.2010.07.10.23.21.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:21:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
In-Reply-To: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150755>

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
1.7.0.2.273.gc2413.dirty
