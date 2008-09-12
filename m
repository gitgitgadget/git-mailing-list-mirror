From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] Update RPM spec for the new location of git-cvsserver.
Date: Sat, 13 Sep 2008 02:22:44 +1000
Message-ID: <1221236564-11856-1-git-send-email-qtonthat@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 20:03:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeCyx-0005P3-Ph
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 20:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbYILSBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 14:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbYILSBw
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 14:01:52 -0400
Received: from pecan2.exetel.com.au ([220.233.0.70]:58963 "EHLO
	pecan2.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbYILSBv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 14:01:51 -0400
X-Greylist: delayed 5942 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Sep 2008 14:01:51 EDT
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95] helo=localhost.localdomain)
	by pecan2.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <qtonthat@gmail.com>)
	id 1KeBPw-0005gP-Vw; Sat, 13 Sep 2008 02:22:45 +1000
X-Mailer: git-send-email 1.6.0.2.1q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95756>

git-cvsserver has been moved from libexecdir to bindir.

Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---
 git.spec.in |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index c6492e5..6733b6f 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -145,6 +145,7 @@ rm -rf $RPM_BUILD_ROOT
 %files cvs
 %defattr(-,root,root)
 %doc Documentation/*git-cvs*.txt
+%{_bindir}/git-cvsserver
 %{_libexecdir}/git-core/*cvs*
 %{!?_without_docs: %{_mandir}/man1/*cvs*.1*}
 %{!?_without_docs: %doc Documentation/*git-cvs*.html }
@@ -188,6 +189,9 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
 
 %changelog
+* Fri Sep 12 2008 Quy Tonthat <qtonthat@gmail.com>
+- move git-cvsserver to bindir.
+
 * Sun Jun 15 2008 Junio C Hamano <gitster@pobox.com>
 - Remove curl from Requires list.
 
-- 
1.6.0.2.1q
