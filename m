From: Nikolaj Schumacher <n_schumacher@web.de>
Subject: [PATCH] Don't cut off last character of commit descriptions.
Date: Mon, 30 Jun 2008 12:08:16 +0200
Message-ID: <m2abh3z14f.fsf@nschum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 12:09:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDGJv-0001qe-UG
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 12:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167AbYF3KIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 06:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbYF3KIT
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 06:08:19 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:58734 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbYF3KIS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 06:08:18 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 710A4E1D47F9;
	Mon, 30 Jun 2008 12:08:17 +0200 (CEST)
Received: from [77.135.94.229] (helo=thursday)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1KDGIz-0003wu-00; Mon, 30 Jun 2008 12:08:17 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2.50 (darwin)
X-Sender: n_schumacher@web.de
X-Provags-ID: V01U2FsdGVkX1+n+YUMV1dJ9P81J2/yhNEebMmo/NLb9ySeRMXH
	X3vPIeWMqDJmCJkDv/48Tz2PpbGTJIqHFyA5buRg+SpHhCpEsu
	/pQa2bYFYWIClPY5Ub7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86899>

>From d485d9c86cba49671b74c7c1571a6ad7ec6d09b6 Mon Sep 17 00:00:00 2001
From: Nikolaj Schumacher <git@nschum.de>
Date: Mon, 30 Jun 2008 12:06:01 +0200
Subject: [PATCH] Don't cut off last character of commit descriptions.

---
 contrib/emacs/git-blame.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 9f92cd2..4fa70c5 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -381,7 +381,7 @@ See also function `git-blame-mode'."
                   "log" "-1"
 		  (concat "--pretty=" git-blame-log-oneline-format)
                   hash)
-    (buffer-substring (point-min) (1- (point-max)))))
+    (buffer-substring (point-min) (point-max))))
 
 (defvar git-blame-last-identification nil)
 (make-variable-buffer-local 'git-blame-last-identification)
-- 
1.5.5.3
