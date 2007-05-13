From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] RPM spec: include files in technical/ to package.
Date: Sun, 13 May 2007 21:41:45 +1000
Message-ID: <4646F979.3070706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 13:42:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnCT7-0006iG-Pa
	for gcvg-git@gmane.org; Sun, 13 May 2007 13:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbXEMLmY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 07:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757337AbXEMLmY
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 07:42:24 -0400
Received: from pecan.exetel.com.au ([220.233.0.17]:40845 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbXEMLmX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 07:42:23 -0400
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95] helo=[192.168.64.35])
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1HnCSy-0004Xm-Sc; Sun, 13 May 2007 21:42:21 +1000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
X-Enigmail-Version: 0.94.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47143>


Not only that they are interesting to users, some of the
files are linked to by the included "Git User's Manual"

Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---
 git.spec.in |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 16148d4..3a45eb8 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -185,8 +185,13 @@ rm -rf $RPM_BUILD_ROOT
 %{_datadir}/git-core/
 %doc README COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html Documentation/howto}
+%{!?_without_docs: %doc Documentation/technical}
 
 %changelog
+* Tue May 13 2007 Quy Tonthat <qtonthat@gmail.com>
+- Added lib files for git-gui
+- Added Documentation/technical (As needed by Git Users Manual)
+
 * Tue May 8 2007 Quy Tonthat <qtonthat@gmail.com>
 - Added howto files
 
-- 
1.5.2.rc3.1q
