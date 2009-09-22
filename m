From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Documentation: Update the style of 'git-describe' command.
Date: Tue, 22 Sep 2009 19:48:06 -0400
Message-ID: <1253663286-5919-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 01:48:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqF62-0005q5-1M
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 01:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbZIVXsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 19:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbZIVXsZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 19:48:25 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:23871 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbZIVXsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 19:48:24 -0400
Received: by qw-out-2122.google.com with SMTP id 5so89665qwd.37
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 16:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QBcP9XomDls/a7XsbOtqqo0gubpM03xg9PkAGg9l3Y0=;
        b=iAgPy8aoYBIkIrQ5qPLJxveXHR9MFFj0iA9+nVii46AqB0xUfLXjEGAPV6A6zR2/s7
         GtW+i9msIOfC+H8RC1kXtXnw9ayyhO6qPgyzyWKSUk+UL4UZ96Xb+1smS5BRLkiDUjLF
         gNKNpCbUdmNl6vZuoBeJaek+y2dRZmG21q2i8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oW73fTg6VLWlqXgUcTu7G+aOtLZZFSslvKCvm4mhossFB2NnxO4WBqB769wX0TKYLq
         YoTSDRsCmhFx/0LCPGkDQ8EgdiKggYDuwGLMsdRlmcZAHn8HoKKJdFYf0sj/MqX0fBcA
         pHJCn9DohfwQ1Ojf+QcHFucbvwtaLrkaDjHf0=
Received: by 10.224.31.13 with SMTP id w13mr1356772qac.223.1253663308114;
        Tue, 22 Sep 2009 16:48:28 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 8sm248979qwj.43.2009.09.22.16.48.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Sep 2009 16:48:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc1.44.ga1675
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128962>

Update the old version 'git-describe' that appears in the documentation.
Since the new version is prefered, use 'git describe' instead.

Also changes 'committish' to 'commit-ish', since the latter form is the most
used.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 Documentation/gitcli.txt |    2 +-
 builtin-describe.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index be39ed7..b6c0637 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -81,7 +81,7 @@ couple of magic command line options:
 +
 ---------------------------------------------
 $ git describe -h
-usage: git-describe [options] <committish>*
+usage: git describe [options] <commit-ish>*
 
     --contains            find the tag that comes after the commit
     --debug               debug search strategy on stderr
diff --git a/builtin-describe.c b/builtin-describe.c
index df67a73..961deb4 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -10,7 +10,7 @@
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
-	"git describe [options] <committish>*",
+	"git describe [options] <commit-ish>*",
 	NULL
 };
 
-- 
1.6.5.rc1.44.ga1675
