From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/3] git-am.txt: add an 'a', say what 'it' is, simplify a sentence
Date: Sun,  3 May 2009 23:46:56 -0700
Message-ID: <1241419618-20304-2-git-send-email-bebarino@gmail.com>
References: <1241419618-20304-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 08:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0rxV-0002t7-I2
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 08:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbZEDGrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 02:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbZEDGrH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 02:47:07 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:45139 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbZEDGrF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 02:47:05 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2980273wfd.4
        for <git@vger.kernel.org>; Sun, 03 May 2009 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=QCXatNLlZT7m0Gn9m1vmD67LGYlYHWCkY9VoNTeY5w8=;
        b=wsh4nlKXC8yEIUtzEHQKx5O2aUzvus6jBa39WqZQ1Gb/kNjbJO3Ov9t+x1CInamBX2
         i363nYm84bkAyCNuE236caIcWyobiO9KGK4Ey+jOwREBmjrV9bLJBkRxKRtX+OyvqCHp
         MFh013vGDElbfuQM1eYzw8YnSEHyRF9m7P6v8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bdNOIUGBQRNFR+kkRyanIkVq+HIS1YnKN2HSKRIrsA+ncQqx8bL1a6LOnlpoLnW7lz
         533lui6Z39/9uhSJLfZkZElGgmylC4ij4MK9F5aJYNjrfAVUa+tpSuxZttS1+MLL8lb6
         QS7ILxa6BpxK3WclKHjpCmdMnS+brplGJFOEY=
Received: by 10.142.13.14 with SMTP id 14mr2193740wfm.52.1241419625103;
        Sun, 03 May 2009 23:47:05 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id k2sm8512198rvb.10.2009.05.03.23.47.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 23:47:04 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 03 May 2009 23:47:01 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1241419618-20304-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118213>

It's nice to know that 'it' is git-am or the subject line. Whitespace
implies characters so just remove characters.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-am.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 1e71dd5..715531b 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -32,7 +32,7 @@ OPTIONS
 
 -s::
 --signoff::
-	Add `Signed-off-by:` line to the commit message, using
+	Add a `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
 
 -k::
@@ -118,8 +118,8 @@ The commit author name is taken from the "From: " line of the
 message, and commit author time is taken from the "Date: " line
 of the message.  The "Subject: " line is used as the title of
 the commit, after stripping common prefix "[PATCH <anything>]".
-It is supposed to describe what the commit is about concisely as
-a one line text.
+The "Subject: " line is supposed to concisely describe what the
+commit is about in one line of text.
 
 The body of the message (the rest of the message after the blank line
 that terminates the RFC2822 headers) can begin with "Subject: " and
@@ -128,8 +128,8 @@ to override the values of these fields.
 
 The commit message is formed by the title taken from the
 "Subject: ", a blank line and the body of the message up to
-where the patch begins.  Excess whitespace characters at the end of the
-lines are automatically stripped.
+where the patch begins.  Excess whitespace at the end of each
+line is automatically stripped.
 
 The patch is expected to be inline, directly following the
 message.  Any line that is of the form:
@@ -141,7 +141,7 @@ message.  Any line that is of the form:
 is taken as the beginning of a patch, and the commit log message
 is terminated before the first occurrence of such a line.
 
-When initially invoking it, you give it the names of the mailboxes
+When initially invoking 'git-am', you give it the names of the mailboxes
 to process.  Upon seeing the first patch that does not apply, it
 aborts in the middle.  You can recover from this in one of two ways:
 
-- 
1.6.2.3
