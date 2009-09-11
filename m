From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH 2/2] add documentation for mailinfo.scissors and '--no-scissors'
Date: Fri, 11 Sep 2009 02:09:21 +0200
Message-ID: <33445216edc4c4e1976cdd81521922042955e6eb.1252626034.git.nicolas.s.dev@gmx.fr>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Cc: Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 02:10:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MltiE-0005UP-KO
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 02:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbZIKAJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 20:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbZIKAJn
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 20:09:43 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:49555 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbZIKAJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 20:09:42 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so647358ewy.17
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 17:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:in-reply-to
         :references;
        bh=ZW8OMupmbCFqvH9ZEF2fXpogMxs6qXFRiXCJqWrwB8U=;
        b=PluN2YBGPyywHi9g/0LLNmvVKIuUBmDf84FiIuFyVQHvR++bnJw/njlREjRqMY3w2p
         nO5hQlsZq1B6tyi/gYLINAhxYNj2yLkl2RHVzU89MEx2c+X1PiWaAx30kSQbAQqo9t7C
         +qV9RcoD4KxNk0D9Sy+4qDmHHP7S3y62CPLOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=x3Lfz8JzYMfSOHcdok4tIDEBiYYfynQwYeXuWtqsJypJXnU3yhHNOOzTYQiCbJmx5X
         vDWE/dHt2j+xMsAvMqL52M/FQaSsuWGApfaAptiRqtef1UjUSUh4hZArrdhuBLhjNfyK
         DFIoa3qPx7ouw1v1ODEn3Cu15XYIfg2nO/06g=
Received: by 10.210.96.12 with SMTP id t12mr1665759ebb.71.1252627785733;
        Thu, 10 Sep 2009 17:09:45 -0700 (PDT)
Received: from localhost (91-164-133-105.rev.libertysurf.net [91.164.133.105])
        by mx.google.com with ESMTPS id 7sm98254eyb.10.2009.09.10.17.09.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Sep 2009 17:09:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.164.g5f6b0
In-Reply-To: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <682ef47420f36d8c53e42981370d377b621d7b86.1252626034.git.nicolas.s.dev@gmx.fr>
References: <682ef47420f36d8c53e42981370d377b621d7b86.1252626034.git.nicolas.s.dev@gmx.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128162>

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
 Documentation/git-am.txt       |    2 +-
 Documentation/git-mailinfo.txt |    6 ++++++
 builtin-mailinfo.c             |    2 +-
 git-am.sh                      |    1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 87781f4..8b2897b 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
-	 [--reject] [-q | --quiet] [--scissors]
+	 [--reject] [-q | --quiet] [--scissors | --no-scissors]
 	 [<mbox> | <Maildir>...]
 'git am' (--skip | --resolved | --abort)
 
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 823ab82..55b8c5e 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -62,6 +62,12 @@ This is useful if you want to begin your message in a discussion thread
 with comments and suggestions on the message you are responding to, and to
 conclude it with a patch submission, separating the discussion and the
 beginning of the proposed commit log message with a scissors line.
++
+This can enabled by default with the configuration option mailinfo.scissors.
+
+--no-scissors::
+	Do not obey to a scissors line. This is only useful if mailinfo.scissors is
+	enabled (see --scissors).
 
 <msg>::
 	The commit log message extracted from e-mail, usually
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 7d22fd7..d498b1c 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -1004,7 +1004,7 @@ static int git_mailinfo_config(const char *var, const char *value, void *unused)
 }
 
 static const char mailinfo_usage[] =
-	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] [--scissors] msg patch < mail >info";
+	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] msg patch < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
diff --git a/git-am.sh b/git-am.sh
index 26ffe70..f242d1a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 c,scissors      strip everything before a scissors line
+no-scissors     don't obey to a scissors line (default)
 whitespace=     pass it through git-apply
 ignore-space-change pass it through git-apply
 ignore-whitespace pass it through git-apply
-- 
1.6.5.rc0.164.g5f6b0
