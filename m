From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 2/4] grep docs: use AsciiDoc literals consistently
Date: Thu, 25 Feb 2010 22:40:11 -0500
Message-ID: <1267155613-22134-3-git-send-email-lodatom@gmail.com>
References: <1267155613-22134-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 04:37:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkr0f-0000l8-61
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 04:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935118Ab0BZDg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 22:36:58 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:24497 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935114Ab0BZDgz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 22:36:55 -0500
Received: by qw-out-2122.google.com with SMTP id 8so171547qwh.37
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 19:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SmmmNfy8LJoh4/4takTCnUcEx5sk0yzQ6K1LcjGtajU=;
        b=lZ5W1cb4yuUqIGyc+U55HSWZe8oeMoOuHjreONzDu9Iwh0n8hJOQtBjsOvTc86813U
         0om53YyUwwpS6wQjirlrGhdOAuHjLkshkcaP1WNifXh6KYf5QyM36rztvMoUKMrkSnKQ
         t/SSL08+TF7K24NbQijE2wuE3IMtXetVmFZJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tsnZiWfCWUztFxb4Hnpy29eD3BW7vvmFfnpnbIIMieZL4j53/0cRB3YbbiSzTCuIt4
         YYYa526U8dwkYqaoG3ouh+qB9jE8XWTcFCvpaiApwg4wk3/Zu6QIP+fE9he+n+ttJ0Kx
         MbJSol8Jgkr76hpSr56H0Mzv6dXZSabjyelX0=
Received: by 10.224.31.212 with SMTP id z20mr122217qac.265.1267155414864;
        Thu, 25 Feb 2010 19:36:54 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1593622qyk.6.2010.02.25.19.36.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 19:36:54 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267155613-22134-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141095>

The convention for this particular page is to use AsciiDoc literal
strings only for options (`-x` or `--long`), but not for definition list
terms and not for <meta-vars>.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-grep.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index ae663b0..2e16130 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -98,8 +98,8 @@ OPTIONS
 --files-without-match::
 	Instead of showing every matched line, show only the
 	names of files that contain (or do not contain) matches.
-	For better compatibility with 'git diff', --name-only is a
-	synonym for --files-with-matches.
+	For better compatibility with 'git diff', `--name-only` is a
+	synonym for `--files-with-matches`.
 
 -z::
 --null::
@@ -125,7 +125,7 @@ OPTIONS
 	matches.
 
 -<num>::
-	A shortcut for specifying -C<num>.
+	A shortcut for specifying `-C<num>`.
 
 -p::
 --show-function::
@@ -140,7 +140,7 @@ OPTIONS
 
 -e::
 	The next parameter is the pattern. This option has to be
-	used for patterns starting with - and should be used in
+	used for patterns starting with `-` and should be used in
 	scripts passing user input to grep.  Multiple patterns are
 	combined by 'or'.
 
@@ -163,7 +163,7 @@ OPTIONS
 	Do not output matched lines; instead, exit with status 0 when
 	there is a match and with non-zero status when there isn't.
 
-`<tree>...`::
+<tree>...::
 	Search blobs in the trees for specified patterns.
 
 \--::
-- 
1.7.0
