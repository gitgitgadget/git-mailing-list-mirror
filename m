From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] Added new git-gui library files to rpm spec
Date: Thu, 10 May 2007 17:03:15 +1000
Message-ID: <4642C3B3.7040205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 09:03:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm2gQ-0000bc-0Z
	for gcvg-git@gmane.org; Thu, 10 May 2007 09:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbXEJHDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 03:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbXEJHDV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 03:03:21 -0400
Received: from pecan.exetel.com.au ([220.233.0.17]:45329 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbXEJHDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 03:03:20 -0400
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95] helo=[192.168.64.35])
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1Hm2gH-0007SA-Hd; Thu, 10 May 2007 17:03:17 +1000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
X-Enigmail-Version: 0.94.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46831>

"make rpm" breaks without these files.

Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---
 git.spec.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 9de655c..16148d4 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -163,6 +163,7 @@ rm -rf $RPM_BUILD_ROOT
 %defattr(-,root,root)
 %{_bindir}/git-gui
 %{_bindir}/git-citool
+%{_datadir}/git-gui/
 # Not Yet...
 # %{!?_without_docs: %{_mandir}/man1/git-gui.1}
 # %{!?_without_docs: %doc Documentation/git-gui.html}
-- 
1.5.2.rc2.4q
