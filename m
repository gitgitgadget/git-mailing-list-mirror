From: Samuel Tardieu <sam@rfc1149.net>
Subject: [StGIT PATCH] Do not insert an empty line before the diffstat info
Date: Thu, 31 Jul 2008 14:50:10 +0200
Message-ID: <20080731125010.894.84022.stgit@dawn.rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 14:51:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOXck-0004qm-H5
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 14:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756737AbYGaMuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 08:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbYGaMuO
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 08:50:14 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:36161 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882AbYGaMuM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 08:50:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 1EBFAE0500;
	Thu, 31 Jul 2008 14:50:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ZvURDlZaFFJ; Thu, 31 Jul 2008 14:50:10 +0200 (CEST)
Received: from dawn.rfc1149.net (unknown [192.168.9.2])
	by mail.rfc1149.net (Postfix) with ESMTP id D22DAE0486;
	Thu, 31 Jul 2008 14:50:10 +0200 (CEST)
Received: from dawn.rfc1149.net (localhost [127.0.0.1])
	by dawn.rfc1149.net (Postfix) with ESMTP id 8EB278050;
	Thu, 31 Jul 2008 14:50:10 +0200 (CEST)
User-Agent: StGIT/0.14.3.213.g16b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90940>

To make the format of stg output closer to the plain git one, do
not insert an empty line between the "---" separator and the
diffstat information.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 templates/mailattch.tmpl   |    1 -
 templates/patchexport.tmpl |    1 -
 templates/patchmail.tmpl   |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/templates/mailattch.tmpl b/templates/mailattch.tmpl
index 430b341..70d2df0 100644
--- a/templates/mailattch.tmpl
+++ b/templates/mailattch.tmpl
@@ -11,7 +11,6 @@ Content-Disposition: inline
 
 %(fromauth)s%(longdescr)s
 ---
-
 %(diffstat)s
 --MIMEBOUNDARY
 Content-Type: text/plain; name=%(patch)s.patch
diff --git a/templates/patchexport.tmpl b/templates/patchexport.tmpl
index e7f3481..11f2075 100644
--- a/templates/patchexport.tmpl
+++ b/templates/patchexport.tmpl
@@ -4,6 +4,5 @@ From: %(authname)s <%(authemail)s>
 
 %(longdescr)s
 ---
-
 %(diffstat)s
 
diff --git a/templates/patchmail.tmpl b/templates/patchmail.tmpl
index f5c35c2..7d4022a 100644
--- a/templates/patchmail.tmpl
+++ b/templates/patchmail.tmpl
@@ -3,6 +3,5 @@ Subject: [%(prefix)sPATCH%(version)s%(number)s] %(shortdescr)s
 
 %(fromauth)s%(longdescr)s
 ---
-
 %(diffstat)s
 %(diff)s
