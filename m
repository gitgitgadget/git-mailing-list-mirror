From: Lawrence Mitchell <wence@gmx.li>
Subject: [PATCH v2 3/3] git-blame.el: Do not use bare 0 to mean (point-min)
Date: Thu, 14 Jun 2012 10:38:00 +0100
Message-ID: <1339666680-4381-3-git-send-email-wence@gmx.li>
References: <87k3za9rwj.fsf@gmx.li>
 <1339666680-4381-1-git-send-email-wence@gmx.li>
 <1339666680-4381-2-git-send-email-wence@gmx.li>
Cc: jrnieder@gmail.com, git@vger.kernel.org, davidk@lysator.liu.se,
	user42@zip.com.au, osv@javad.com, gitster@pobox.com
To: =?UTF-8?q?R=C3=BCdiger=20Sonderfeld?= <ruediger@c-plusplus.de>
X-From: git-owner@vger.kernel.org Thu Jun 14 11:38:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf6W1-0004Gl-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 11:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab2FNJin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 05:38:43 -0400
Received: from treacle.ucs.ed.ac.uk ([129.215.16.102]:37728 "EHLO
	treacle.ucs.ed.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab2FNJim (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 05:38:42 -0400
Received: from lmtp1.ucs.ed.ac.uk (lmtp1.ucs.ed.ac.uk [129.215.149.64])
	by treacle.ucs.ed.ac.uk (8.13.8/8.13.4) with ESMTP id q5E9cBXQ007646;
	Thu, 14 Jun 2012 10:38:15 +0100 (BST)
Received: from e4300lm.epcc.ed.ac.uk (e4300lm.epcc.ed.ac.uk [129.215.63.156])
	(authenticated user=lmitche4 mech=PLAIN bits=0)
	by lmtp1.ucs.ed.ac.uk (8.13.8/8.13.7) with ESMTP id q5E9c1H0025947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jun 2012 10:38:10 +0100 (BST)
X-Mailer: git-send-email 1.7.11.rc2.9.g10afb6c
In-Reply-To: <1339666680-4381-2-git-send-email-wence@gmx.li>
X-Edinburgh-Scanned: at treacle.ucs.ed.ac.uk
    with MIMEDefang 2.60, Sophie, Sophos Anti-Virus, Clam AntiVirus
X-Scanned-By: MIMEDefang 2.60 on 129.215.16.102
X-Scanned-By: MIMEDefang 2.52 on 129.215.149.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199992>

Signed-off-by: Lawrence Mitchell <wence@gmx.li>
---
 contrib/emacs/git-blame.el | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

No change from v1

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index bb6d7bb..e671f6c 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -341,7 +341,7 @@ See also function `git-blame-mode'."
     (save-excursion
       (goto-char (process-mark proc))
       (insert-before-markers str)
-      (goto-char 0)
+      (goto-char (point-min))
       (unless in-blame-filter
         (let ((more t)
               (in-blame-filter t))
-- 
1.7.11.rc2.9.g10afb6c
