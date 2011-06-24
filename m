From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] completion: replace core.abbrevguard to core.abbrev
Date: Fri, 24 Jun 2011 15:17:42 +0900
Message-ID: <1308896262-6948-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 08:17:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZziD-00063E-OX
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 08:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab1FXGRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jun 2011 02:17:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62369 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab1FXGRs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2011 02:17:48 -0400
Received: by iwn6 with SMTP id 6so2164037iwn.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 23:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=1m02k26TsZF2b3F+svnD2fKhtId2CuC9Auv2yc4rxRs=;
        b=fl9kzoUTpF4FV0aNbjBpPG5l1ve9QVLx7npakxJ9TIEP7hS12u/eiAnKPrT/xu1PKA
         BkLMN5EW4i83EWZcHN5hh0YHFly74ayCDv9yidqJ5k6Xr6a773AZZkjKkHg8ZvYhZ00v
         8UJRkXcDOudC6mVWhTevmJeyGTXH6jyD1/zZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sUH/j78U1CO8Bfj5+nbaQwWwa+Wfq4Y5/LUXNDA59o5568wfag8OcoEMJJT0LIWQfm
         fC6vssc0F9t7MTXMknNzpBN4WOkzU+phtEd6cKQHF+Jgz7QP9HnQc5KidG6Bw3zIKjrO
         cUACpnXtaIrhMPJeLjDWbR0/5keSwWIlY8GSA=
Received: by 10.42.155.4 with SMTP id s4mr2921298icw.32.1308896267838;
        Thu, 23 Jun 2011 23:17:47 -0700 (PDT)
Received: from localhost.localdomain ([118.176.77.244])
        by mx.google.com with ESMTPS id s2sm1312930ibe.18.2011.06.23.23.17.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 23:17:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176304>

The core.abbrevguard config variable had removed and
now core.abbrev has been used instead. Teach it.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b36290f..5a83090 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2058,7 +2058,7 @@ _git_config ()
 		color.ui
 		commit.status
 		commit.template
-		core.abbrevguard
+		core.abbrev
 		core.askpass
 		core.attributesfile
 		core.autocrlf
-- 
1.7.5.2
