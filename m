From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1] Wrap long lines in docstrings in contrib/emacs/git.el
Date: Thu, 13 Jul 2006 22:22:13 +0200
Message-ID: <11528221343629-git-send-email-jnareb@gmail.com>
References: <11528217463561-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 13 22:22:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G17hk-0003Ah-Lr
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 22:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWGMUW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 16:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWGMUW2
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 16:22:28 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:43434 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030359AbWGMUWV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 16:22:21 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k6DKLgp7022929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Jul 2006 22:21:42 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k6DKMEoo022328;
	Thu, 13 Jul 2006 22:22:14 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k6DKMEYA022327;
	Thu, 13 Jul 2006 22:22:14 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11528217463561-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23849>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 contrib/emacs/git.el |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index ebd00ef..83a845d 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -59,14 +59,16 @@ (defgroup git nil
 
 (defcustom git-committer-name nil
   "User name to use for commits.
-The default is to fall back to the repository config, then to `add-log-full-name' and then to `user-full-name'."
+The default is to fall back to the repository config,
+then to `add-log-full-name' and then to `user-full-name'."
   :group 'git
   :type '(choice (const :tag "Default" nil)
                  (string :tag "Name")))
 
 (defcustom git-committer-email nil
   "Email address to use for commits.
-The default is to fall back to the git repository config, then to `add-log-mailing-address' and then to `user-mail-address'."
+The default is to fall back to the git repository config,
+then to `add-log-mailing-address' and then to `user-mail-address'."
   :group 'git
   :type '(choice (const :tag "Default" nil)
                  (string :tag "Email")))
@@ -86,6 +88,7 @@ (defcustom git-per-dir-ignore-file ".git
   :group 'git
   :type 'string)
 
+
 (defface git-status-face
   '((((class color) (background light)) (:foreground "purple")))
   "Git mode face used to highlight added and modified files."
@@ -149,7 +152,8 @@ (defun git-call-process-env (buffer env 
     (apply #'call-process "git" nil buffer nil args)))
 
 (defun git-call-process-env-string (env &rest args)
-  "Wrapper for call-process that sets environment strings, and returns the process output as a string."
+  "Wrapper for call-process that sets environment strings,
+and returns the process output as a string."
   (with-temp-buffer
     (and (eq 0 (apply #' git-call-process-env t env args))
          (buffer-string))))
-- 
1.4.0
