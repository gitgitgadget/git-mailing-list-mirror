From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/3] git-am.txt: reword extra headers in message body
Date: Sun,  3 May 2009 23:46:58 -0700
Message-ID: <1241419618-20304-4-git-send-email-bebarino@gmail.com>
References: <1241419618-20304-1-git-send-email-bebarino@gmail.com>
 <1241419618-20304-2-git-send-email-bebarino@gmail.com>
 <1241419618-20304-3-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 08:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0rxX-0002t7-0g
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 08:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbZEDGrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 02:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbZEDGrO
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 02:47:14 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:45139 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZEDGrL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 02:47:11 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2980273wfd.4
        for <git@vger.kernel.org>; Sun, 03 May 2009 23:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=Q4InvGT2+UdoQ3KMYjuJDA67J+XzX1tSuUNeTTUng8M=;
        b=HLv7LFPtZkHiXkqRjP5aH9fqTWb+YBD3MF3cp8cZB53tKl+HvnMdbRtdy72JU31wVx
         fv1zUjwqpGBOCnIrHzZ6aUSqnyHbV3CxP2WM353HTB7aShuAkOE3Z6gwSmhlIim3XDZK
         teFBAXno/n8ZqDARwVbo7V4MEYYo9wYPKgy2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xBKYfozdhMfyRos/50AgY0maEuH2Hig/iVAcQ2d9d0LWPXMh4epnDuXVZ7fHoxHcSN
         LF3ON6y0qjolImxx0QD46Tcm1Gjiq/DVi7RBbp9XKZmAeXJ50umc24GCETjhdMIsGWH8
         THfjJbAFJnVxi3/s2oMK2LgD8fwFJcbOfaY+c=
Received: by 10.142.43.7 with SMTP id q7mr1970687wfq.160.1241419631665;
        Sun, 03 May 2009 23:47:11 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 27sm17959803wff.6.2009.05.03.23.47.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 23:47:11 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 03 May 2009 23:47:08 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1241419618-20304-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118211>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-am.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index c141261..95e6089 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -121,10 +121,10 @@ the commit, after stripping common prefix "[PATCH <anything>]".
 The "Subject: " line is supposed to concisely describe what the
 commit is about in one line of text.
 
-The body of the message (the rest of the message after the blank line
-that terminates the RFC2822 headers) can begin with "Subject: " and
-"From: " lines that are different from those of the mail header,
-to override the values of these fields.
+"From: " and "Subject: " lines starting the body (the rest of the
+message after the blank line terminating the RFC2822 headers)
+override the respective commit author name and title values taken
+from the headers.
 
 The commit message is formed by the title taken from the
 "Subject: ", a blank line and the body of the message up to
-- 
1.6.2.3
