From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/3] git-am.txt: Use date instead of time or timestamp
Date: Sun,  3 May 2009 23:46:57 -0700
Message-ID: <1241419618-20304-3-git-send-email-bebarino@gmail.com>
References: <1241419618-20304-1-git-send-email-bebarino@gmail.com>
 <1241419618-20304-2-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 08:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0rxW-0002t7-8k
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 08:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbZEDGrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 02:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbZEDGrK
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 02:47:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:45139 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZEDGrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 02:47:07 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2980273wfd.4
        for <git@vger.kernel.org>; Sun, 03 May 2009 23:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=3vtn3CYyPwrk2b7KtQcGUfSef9eBFjjazd7/yXDn+0k=;
        b=ccic+cxa5NBWLyZz8nL3zCouB3H7EJFWW1cYahAfXWfhL1eztcfTjWkwyTMAn3qhSo
         hko9AhYX3JPQZetEU+KNguJnX/VRgk1uAKDYAMtgsd1gWGILKqhoiu9x7Kd31NePHTyP
         mV/gyQXMpZidHQHu781Kk8rffmkv9j6ieJOo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rLURn7CEIzDtXOikRls2sWOh3iMM7ts3Fc6awXqCrSIDrNLgilHYlsl/RyfOoYo+ig
         HacMvRVuYQ13rnPCEp2tQikyKxl/V/Jh7YodQVIzi/ZEFI5a9smKIMg/cj9+iMJP0x93
         G7WFKNAPY8ssRVanvDYwUOb66EZdGRapMghMM=
Received: by 10.142.162.9 with SMTP id k9mr2029029wfe.129.1241419628438;
        Sun, 03 May 2009 23:47:08 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 30sm761133wfg.10.2009.05.03.23.47.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 23:47:07 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 03 May 2009 23:47:05 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1241419618-20304-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118212>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-am.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 715531b..c141261 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -85,7 +85,7 @@ default.   You can use `--no-utf8` to override this.
 	By default the command records the date from the e-mail
 	message as the commit author date, and uses the time of
 	commit creation as the committer date. This allows the
-	user to lie about author timestamp by using the same
+	user to lie about the author date by using the same
 	timestamp as the committer date.
 
 --skip::
@@ -115,7 +115,7 @@ DISCUSSION
 ----------
 
 The commit author name is taken from the "From: " line of the
-message, and commit author time is taken from the "Date: " line
+message, and commit author date is taken from the "Date: " line
 of the message.  The "Subject: " line is used as the title of
 the commit, after stripping common prefix "[PATCH <anything>]".
 The "Subject: " line is supposed to concisely describe what the
-- 
1.6.2.3
