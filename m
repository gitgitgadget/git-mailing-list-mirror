From: Jim Radford <radford@blackbean.org>
Subject: [PATCH] Add missing git-core and cvsps RPM dependencies
Date: Thu, 10 Nov 2005 11:03:08 -0800
Message-ID: <20051110190308.GA8012@blackbean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 10 20:07:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaHhZ-0005cS-Vs
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVKJTDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVKJTDK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:03:10 -0500
Received: from cpe-66-74-186-186.socal.res.rr.com ([66.74.186.186]:49353 "EHLO
	mail.blackbean.org") by vger.kernel.org with ESMTP id S932154AbVKJTDI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 14:03:08 -0500
Received: from home.blackbean.org (localhost.localdomain [127.0.0.1])
	by mail.blackbean.org (8.13.4/8.13.4) with ESMTP id jAAJ38Kk008147
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 11:03:08 -0800
Received: (from jim@localhost)
	by home.blackbean.org (8.13.4/8.13.4/Submit) id jAAJ38Eb008144
	for git@vger.kernel.org; Thu, 10 Nov 2005 11:03:08 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11504>

Add missing git-core and cvsps RPM dependencies.

Signed-off-by: Jim Radford <radford@blackbean.org>

diff --git a/git-core.spec.in b/git-core.spec.in
index 26846d0..ce9acd8 100644
--- a/git-core.spec.in
+++ b/git-core.spec.in
@@ -22,20 +22,21 @@ elsewhere for tools for ordinary humans 
 %package svn
 Summary:        Git tools for importing Subversion repositories.
 Group:          Development/Tools
-Requires:       subversion
+Requires:       git-core, subversion
 %description svn
 Git tools for importing Subversion repositories.
 
 %package cvs
 Summary:        Git tools for importing CVS repositories.
 Group:          Development/Tools
-Requires:       cvs
+Requires:       git-core, cvs, cvsps
 %description cvs
 Git tools for importing CVS repositories.
 
 %package email
 Summary:        Git tools for sending email.
 Group:          Development/Tools
+Requires:       git-core
 %description email
 Git tools for sending email.
 
