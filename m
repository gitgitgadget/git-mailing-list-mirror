From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH v2 3/3] Documentation: add --abbrev option to the man page of git blame
Date: Wed,  6 Apr 2011 11:20:52 +0900
Message-ID: <1302056452-5387-3-git-send-email-namhyung@gmail.com>
References: <1302056452-5387-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 04:21:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7IN3-0004UH-Em
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 04:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab1DFCVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 22:21:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45962 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab1DFCVE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 22:21:04 -0400
Received: by gwaa18 with SMTP id a18so227730gwa.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 19:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=amnOKN3vB1MsC1jgdmQHygZ54nXKN9H+Rs8fKBODh1A=;
        b=i1sbE9k5PxI1bqPJTPsNjhrxBodUDIkxxYy4SGi/RlisgWz2Ed+Di6A03gI/JGDiJm
         U+nYZrPRcQpBn5x1nFhkw0Wwzfm5fS+X3ZUu3nyOBnfZ/2AOf+Ko/YieiIKXcUAgkdF9
         k86lIZdf4i4ar6cjIl3VC1Xlr0dNGleoVoJqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VbOshzOg/SPxjNTmDB83QvEq/NQ/HRciG7OlIMLS1UlLuIj0Kndu6zWQThIzbTFWyv
         9XofhCIlDSYr9KTtihJko26poO6z8RSjKY3+18yzvIJ9MoJijEftyMy8b9KgHAZh4thw
         YSzeT8bWbkTfvtJbuhrtvf6gYPiNGCSUuJ61k=
Received: by 10.150.144.12 with SMTP id r12mr1245137ybd.216.1302056463773;
        Tue, 05 Apr 2011 19:21:03 -0700 (PDT)
Received: from localhost.localdomain ([118.176.76.173])
        by mx.google.com with ESMTPS id p23sm443416ybk.24.2011.04.05.19.21.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 19:21:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1302056452-5387-1-git-send-email-namhyung@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170948>

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 Documentation/git-blame.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index c4d1ff8..27ce6bd 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental] [-L n,m]
-	    [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
+	    [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>] [--abbrev=<n>]
 	    [<rev> | --contents <file> | --reverse <rev>] [--] <file>
 
 DESCRIPTION
@@ -73,6 +73,12 @@ include::blame-options.txt[]
 	Ignore whitespace when comparing the parent's version and
 	the child's to find where the lines came from.
 
+--abbrev=<n>::
+	Instead of using the default 7+1 hexadecimal digits as the
+	abbreviated object name, use <n>+1 digits. Note that git
+	will add 1 for the boundary commit to be distinguished (with
+	a caret at the beginning).
+
 
 THE PORCELAIN FORMAT
 --------------------
-- 
1.7.4
