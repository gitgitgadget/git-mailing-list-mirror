From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Fix typo in "Reverted file" message.
Date: Sun, 28 Oct 2007 11:05:11 +0100
Message-ID: <87hckbd06g.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 11:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im51e-0004kW-24
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 11:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbXJ1KFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 06:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbXJ1KFW
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 06:05:22 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:52168 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbXJ1KFW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 06:05:22 -0400
Received: from adsl-62-167-50-148.adslplus.ch ([62.167.50.148] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1Im519-0005iH-1K
	for git@vger.kernel.org; Sun, 28 Oct 2007 05:05:21 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id DE97E1E7146; Sun, 28 Oct 2007 11:05:11 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62544>

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 4286d16..8cfbdd7 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -955,7 +955,7 @@ Return the list of files that haven't been handled."
       (when modified
         (apply #'git-call-process-env nil nil "checkout" "HEAD" modified))
       (git-update-status-files (append added modified) 'uptodate)
-      (git-success-message "Reverted" files))))
+      (git-success-message "Reverted" (git-get-filenames files)))))
 
 (defun git-resolve-file ()
   "Resolve conflicts in marked file(s)."
-- 
1.5.3.4.404.g5a866

-- 
Alexandre Julliard
julliard@winehq.org
