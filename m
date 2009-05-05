From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 1/3] git-am.txt: add an 'a', say what 'it' is, simplify
 a sentence
Date: Mon, 04 May 2009 22:18:42 -0700
Message-ID: <49FFCC32.6070806@gmail.com>
Reply-To: 49FED4DD.3090103@drmicha.warpmail.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 05 07:19:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1D3Y-0000ii-NN
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 07:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbZEEFSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 01:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbZEEFSx
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 01:18:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:7249 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbZEEFSx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 01:18:53 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3297664rvb.1
        for <git@vger.kernel.org>; Mon, 04 May 2009 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=xq6twtWLN7QpykHYg5MtN1apwVKUtQ1JM9n/jrhripk=;
        b=hLVdE2WZTQAPvsfaZTLGI1Ywg/Ts+/Y0VU6+Q/kS3QIwKIYcB0mLzKnJ9PdV1hOeHA
         bm7Hw5m0X3jv8SCjAgF80RkLErOKtLtBC74YTJdJ9qpvrLePK2bQTTW9Ewc6OqGq5zv5
         YfcA+s09SYtAZfkKNlxalkMn8KyTX4HEBIccU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=ZDQSie20F1xc7m9DjJAoOg2WhuLVgODSGBPBZH/t1iQXgFKkkMWYr1mGMmVVarGByO
         yN2W/7LZzAzbueT3RMHRn53ff355qP72iZomTY88US6dbWTOdR95LMVxFXTfcDSDYsuW
         MmAa7Vm4NIVLdhLU9/eSvgQmJrkutpUjllsvc=
Received: by 10.114.80.18 with SMTP id d18mr4966171wab.147.1241500733534;
        Mon, 04 May 2009 22:18:53 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id n9sm10293233wag.34.2009.05.04.22.18.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 May 2009 22:18:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118278>

It's nice to know that 'it' is git-am or the subject line. Whitespace
implies characters so just remove characters.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-am.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 1e71dd5..a497010 100644
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
+When initially invoking `git am`, you give it the names of the mailboxes
 to process.  Upon seeing the first patch that does not apply, it
 aborts in the middle.  You can recover from this in one of two ways:
 
-- 
1.6.2.3
