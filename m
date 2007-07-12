From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] Document git commit --untracked-files and --verbose
Date: Fri, 13 Jul 2007 01:54:08 +0200
Message-ID: <11842844544017-git-send-email-jnareb@gmail.com>
References: <11842844481113-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 01:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I98UR-0006r5-Ii
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 01:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009AbXGLXyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 19:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757467AbXGLXyV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 19:54:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:60049 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbXGLXyR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 19:54:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so457431ugf
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 16:54:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HTbclSXJABJ+lYnGlwpn4o0SzSDUbDTQ2nC9Z9hyWfGGTpp80JFa9uk6n5lc9mGwd93/0cWpn9MrmADi+7mvU4IkonywfRwb014OAF/98gJT9cc8smdvVp3mqM4A0F6wSfqqNY7eiNVeoQBA5XrGsGrTY1WKbWWdhHmtFAHrnfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EwlWAPfHxa/q4tQwPvCJHFXMR54pPO7xQSjA14EO/acTz1W/LGrGI9I0Kc/CtOc18GTcpuOcx0KBRR6oCFoNyYqZjWVSY/I4mQ94+XzYgApAwjoZFZTJFX+62/9jri1GC8gaa6X/JCdZvbBDwtAc8a+U1lOvUTZMbEjiTB1WyjY=
Received: by 10.66.224.19 with SMTP id w19mr1558288ugg.1184284455781;
        Thu, 12 Jul 2007 16:54:15 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTP id c24sm35646467ika.2007.07.12.16.54.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jul 2007 16:54:15 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l6CNsFnZ002399;
	Fri, 13 Jul 2007 01:54:15 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l6CNsEMi002398;
	Fri, 13 Jul 2007 01:54:14 +0200
X-Mailer: git-send-email 1.5.2.2
In-Reply-To: <11842844481113-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52344>

Documentation based on description of commit 443f8338 which added
'-u'|'--untracked-files' option to git-status, and on git-runstatus(1)
man page.

Note that those options apply also to git-status.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> +-u|--untracked-files::
>> +    Show all untracked files, also those in uninteresting
>> +    directories.
>> +
>> +-v|--verbose::
>> +    Show the diff output between the HEAD commit and what
>> +    would be committed.
>> +
> 
> Thanks -- "show" sounds a bit funny, though, don't you think?

Is this one, with a longer description of options, better?
The previous version of this patch got skipped...

 Documentation/git-commit.txt |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 352a494..f96142f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,7 +8,7 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git-commit' [-a | --interactive] [-s] [-v]
+'git-commit' [-a | --interactive] [-s] [-v] [-u]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
 	   [--no-verify] [-e] [--author <author>]
 	   [--] [[-i | -o ]<file>...]
@@ -115,6 +115,19 @@ but can be used to amend a merge commit.
 	as well.  This is usually not what you want unless you
 	are concluding a conflicted merge.
 
+-u|--untracked-files::
+	Show all untracked files, also those in uninteresting
+	directories, in the "Untracked files:" section of commit
+	message template.  Without this option only its name and
+	a trailing slash are displayed for each untracked
+	directory.
+
+-v|--verbose::
+	Show unified diff between the HEAD commit and what
+	would be committed at the bottom of the commit message
+	template.  Note that this diff output doesn't have its
+	lines prefixed with '#'.
+
 -q|--quiet::
 	Suppress commit summary message.
 
-- 
1.5.2.2
