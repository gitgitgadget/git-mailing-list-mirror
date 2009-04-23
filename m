From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 6/8] config.txt: add missing 'the's and make words plural
Date: Thu, 23 Apr 2009 02:38:00 -0700
Message-ID: <1240479482-31366-7-git-send-email-bebarino@gmail.com>
References: <1240479482-31366-1-git-send-email-bebarino@gmail.com>
 <1240479482-31366-2-git-send-email-bebarino@gmail.com>
 <1240479482-31366-3-git-send-email-bebarino@gmail.com>
 <1240479482-31366-4-git-send-email-bebarino@gmail.com>
 <1240479482-31366-5-git-send-email-bebarino@gmail.com>
 <1240479482-31366-6-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 11:40:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvQA-0001FG-7q
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbZDWJia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754217AbZDWJi3
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:38:29 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:4161 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbZDWJi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:38:27 -0400
Received: by wf-out-1314.google.com with SMTP id 26so389637wfd.4
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=cKS0X53U+fTbprbkM5iMyApI5aQSg6+g0Uxq0WlL1CU=;
        b=t4uwEQY2/fMbRsuGzGFo/2Z5OKqSgQn0S9vwAy+yGGYzLFbhp2AG5dnGuJH1gcXwr6
         4JtY6Hs7/MNfjh9qTfwLS6CVknrdMVKUtcywqEqCrs7uotZbOja1Rt68ftsEENOz8zmq
         Dp+5bYBJsa6cQl4IGByDXDBb9Le3NJS6fQEiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KkO0Oa1Kw/cwCDxDMM08kQiVVWQMqWBrt+p4FCXVcnuHOU2oK6426eVEKffuziC7RJ
         B2TNtsHIP9LQuajLsAHaaviumsZ0ll6keiLS6DF7Tl5+OGSvvp82uGBLdWRK8dE67roo
         VUVRYIWqVZ90Xkl6ZlIEdoSRQGfcMe3LWiqeA=
Received: by 10.142.101.17 with SMTP id y17mr286535wfb.69.1240479506613;
        Thu, 23 Apr 2009 02:38:26 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 30sm2951993wfd.1.2009.04.23.02.38.24
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 02:38:26 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 23 Apr 2009 02:38:23 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1240479482-31366-6-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117323>


Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/config.txt |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cabac97..1f17e7a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2,10 +2,10 @@ CONFIGURATION FILE
 ------------------
 
 The git configuration file contains a number of variables that affect
-the git command's behavior. `.git/config` file for each repository
+the git command's behavior. The `.git/config` file in each repository
 is used to store the information for that repository, and
-`$HOME/.gitconfig` is used to store per user information to give
-fallback values for `.git/config` file. The file `/etc/gitconfig`
+`$HOME/.gitconfig` is used to store per user information as
+fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store system-wide defaults.
 
 They can be used by both the git plumbing
@@ -26,28 +26,28 @@ The file consists of sections and variables.  A section begins with
 the name of the section in square brackets and continues until the next
 section begins.  Section names are not case sensitive.  Only alphanumeric
 characters, `-` and `.` are allowed in section names.  Each variable
-must belong to some section, which means that there must be section
-header before first setting of a variable.
+must belong to some section, which means that there must be a section
+header before the first setting of a variable.
 
 Sections can be further divided into subsections.  To begin a subsection
 put its name in double quotes, separated by space from the section name,
-in the section header, like in example below:
+in the section header, like in the example below:
 
 --------
 	[section "subsection"]
 
 --------
 
-Subsection names can contain any characters except newline (doublequote
+Subsection names can contain any character except newline (doublequote
 `"` and backslash have to be escaped as `\"` and `\\`,
-respectively) and are case sensitive.  Section header cannot span multiple
+respectively) and are case sensitive.  Section headers cannot span multiple
 lines.  Variables may belong directly to a section or to a given subsection.
 You can have `[section]` if you have `[section "subsection"]`, but you
 don't need to.
 
-There is also (case insensitive) alternative `[section.subsection]` syntax.
-In this syntax subsection names follow the same restrictions as for section
-name.
+There is also a case insensitive alternative `[section.subsection]` syntax.
+In this syntax, subsection names follow the same restrictions as for section
+names.
 
 All the other lines are recognized as setting variables, in the form
 'name = value'.  If there is no equal sign on the line, the entire line
@@ -66,10 +66,10 @@ converting value to the canonical form using '--bool' type specifier;
 'git-config' will ensure that the output is "true" or "false".
 
 String values may be entirely or partially enclosed in double quotes.
-You need to enclose variable value in double quotes if you want to
-preserve leading or trailing whitespace, or if variable value contains
-beginning of comment characters (if it contains '#' or ';').
-Double quote `"` and backslash `\` characters in variable value must
+You need to enclose variable values in double quotes if you want to
+preserve leading or trailing whitespace, or if the variable value contains
+comment characters (i.e. it contains '#' or ';').
+Double quote `"` and backslash `\` characters in variable values must
 be escaped: use `\"` for `"` and `\\` for `\`.
 
 The following escape sequences (beside `\"` and `\\`) are recognized:
@@ -77,10 +77,10 @@ The following escape sequences (beside `\"` and `\\`) are recognized:
 and `\b` for backspace (BS).  No other char escape sequence, nor octal
 char sequences are valid.
 
-Variable value ending in a `\` is continued on the next line in the
+Variable values ending in a `\` are continued on the next line in the
 customary UNIX fashion.
 
-Some variables may require special value format.
+Some variables may require a special value format.
 
 Example
 ~~~~~~~
-- 
1.6.2.3
