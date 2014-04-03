From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH] MSVC: allow using ExtUtils::MakeMaker
Date: Thu,  3 Apr 2014 11:34:03 +0400
Message-ID: <1396510443-29087-1-git-send-email-marat@slonopotamus.org>
Cc: Marat Radchenko <marat@slonopotamus.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 14:32:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVf1s-00026s-Cq
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162432AbaDCHeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 03:34:17 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:60284 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1162401AbaDCHeR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 03:34:17 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WVcA8-0006BQ-GU; Thu, 03 Apr 2014 11:34:13 +0400
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245729>

Drop NO_PERL_MAKEMAKER from config.mak.uname for the MSVC platform.

MakeMaker is available on Windows Perl implementations and
installs modules to correct location, unlike NO_PERL_MAKEMAKER Makefile.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index fc5616d..6db4193 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -338,7 +338,6 @@ ifeq ($(uname_S),Windows)
 	NO_MKSTEMPS = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_SVN_TESTS = YesPlease
-	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
-- 
1.9.1
