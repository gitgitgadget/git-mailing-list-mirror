From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] Add howto files to rpm packages.
Date: Wed, 09 May 2007 00:19:41 +1000
Message-ID: <464086FD.6010303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 17:51:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRyW-0000uH-Ik
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966829AbXEHPvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 11:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755021AbXEHPvd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:51:33 -0400
Received: from pecan.exetel.com.au ([220.233.0.17]:35835 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbXEHPvc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 11:51:32 -0400
X-Greylist: delayed 5496 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 May 2007 11:51:32 EDT
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95] helo=[192.168.64.35])
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1HlQXg-000148-OI; Wed, 09 May 2007 00:19:53 +1000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
X-Enigmail-Version: 0.94.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46597>


RPM packages did not include howto files which causes broken
links in howto-index.html

Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---

diff --git a/git.spec.in b/git.spec.in
index 556bdda..9de655c 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -183,9 +183,12 @@ rm -rf $RPM_BUILD_ROOT
 %defattr(-,root,root)
 %{_datadir}/git-core/
 %doc README COPYING Documentation/*.txt
-%{!?_without_docs: %doc Documentation/*.html }
+%{!?_without_docs: %doc Documentation/*.html Documentation/howto}
 
 %changelog
+* Tue May 8 2007 Quy Tonthat <qtonthat@gmail.com>
+- Added howto files
+
 * Tue Mar 27 2007 Eygene Ryabinkin <rea-git@codelabs.ru>
 - Added the git-p4 package: Perforce import stuff.
 
