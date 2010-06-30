From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 13/13] some document update
Date: Wed, 30 Jun 2010 23:25:26 +0800
Message-ID: <1277911526-12105-13-git-send-email-struggleyb.nku@gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:32:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzGl-0002jw-M8
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145Ab0F3PcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:32:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:35240 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab0F3PcB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:32:01 -0400
Received: by pxi8 with SMTP id 8so417797pxi.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JTJxpV5XhnOdu0VLOEkjIe03lAIFXCl22Eti8R4scSI=;
        b=q32Sc6cex5qxmDcsGb/w4Li30U3Jj+HKjS7GzxoUI8/Cpuq96k7xXhI4JcfRs87NaO
         h1Dpi3ulcYOQ8z0ToI0d0EvRQPlcT+xXq37KCmu6L7Re1AZAdSDde99vwKTevBki53eN
         pLoRe499YwlTWV5rHhKwlk5oe78GTHRRxZXfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YY1msT5cZS0VOtawIzsnysorqSA0MSPxhwhAjjtIbBrF2NMOiFdqQE393dlFaAt+XW
         UWhUwFatJyVYNKU6oT0C97nZWFzKe0QnkjDzOqWp5nP+yHLhkxyTyJMiYu4bxNpjgwCo
         e6zWeA3UZA/TnmboXE9cHs2jlzb+4C/lTVFJ0=
Received: by 10.115.99.2 with SMTP id b2mr9996818wam.131.1277911921415;
        Wed, 30 Jun 2010 08:32:01 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.31.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:32:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
In-Reply-To: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149976>

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
