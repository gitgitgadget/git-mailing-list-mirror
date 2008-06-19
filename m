From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] completion: add --graph to log command completion
Date: Thu, 19 Jun 2008 16:15:53 -0500
Message-ID: <1213910153-10679-1-git-send-email-dpmcgee@gmail.com>
Cc: git@vger.kernel.org, Dan McGee <dpmcgee@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jun 19 23:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9RVp-00059q-3H
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbYFSVQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbYFSVQU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:16:20 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:2060 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbYFSVQI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 17:16:08 -0400
Received: by yw-out-2324.google.com with SMTP id 9so535476ywe.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 14:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=b4vQp9ZzavzoXuuMu61Fh2xvZ9Zjwr1Ez2eZGvpAQ90=;
        b=Tk4RggfkVstnaZQs+CaZWIhnBJ/O7wIrWhQwKzGLl2qeHbtXze+HTmg2+vXRYfNUlP
         DmO9+m1kIcM0cvlWdilZrMDOeLRJMAZWsmqlJ4u6sqQpcGMh5rSTYkdQrMlp1cSQ9LZn
         cfbECC3s+mo/N5oY2o8CPOeAlIwVW1gqAeZM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZBnVQZFb4uijMICz/7dEe6xICFyVW9hCLOfA9jiNLlfwtkDL5rqc6+/jTIDsOa0uek
         m2LLNvXqDmYWztZmYfCHD8vsyXS2JdMKhv+YdKR1PAwpCKxb6LaBTfm6icUPNDpAKeJX
         ScNAtBt3aX53MWRHUcFB4NUkoEEdn0QpjtEfo=
Received: by 10.151.141.16 with SMTP id t16mr3832575ybn.60.1213910163383;
        Thu, 19 Jun 2008 14:16:03 -0700 (PDT)
Received: from localhost ( [76.197.196.93])
        by mx.google.com with ESMTPS id x72sm421958pyg.26.2008.06.19.14.15.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 14:16:01 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85533>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2141b6b..0eb8df0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -761,6 +761,7 @@ _git_log ()
 			--pretty= --name-status --name-only --raw
 			--not --all
 			--left-right --cherry-pick
+			--graph
 			"
 		return
 		;;
-- 
1.5.6
