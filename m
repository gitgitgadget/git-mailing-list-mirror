From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv5 1/6] Gitweb: add ignore and clean rules for minified files
Date: Thu, 01 Apr 2010 01:35:28 -0400
Message-ID: <4BB430A0.7040700@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 01 07:36:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxD4g-0002nw-Vv
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 07:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab0DAFgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 01:36:10 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:50285 "EHLO
	mailchk-m04.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752824Ab0DAFgH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 01:36:07 -0400
Received: from karakura.local (bas1-toronto01-1177657512.dsl.bell.ca [70.49.160.168])
	(authenticated bits=0)
	by mailchk-m04.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o315ZSAe025516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Apr 2010 01:35:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
X-UUID: 355cb538-de5f-4d8c-ab78-6f2352f6c1f4
X-Miltered: at mailchk-m04 with ID 4BB430A0.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m04
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m04.uwaterloo.ca [129.97.128.141]); Thu, 01 Apr 2010 01:35:36 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143709>

Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---

	No changes since the previous version.

 .gitignore |    1 +
 Makefile   |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7b3acb7..4c24152 100644
--- a/.gitignore
+++ b/.gitignore
@@ -156,6 +156,7 @@
 /git-core-*/?*
 /gitk-git/gitk-wish
 /gitweb/gitweb.cgi
+/gitweb/gitweb.min.*
 /test-chmtime
 /test-ctype
 /test-date
diff --git a/Makefile b/Makefile
index 6d73a8c..5384d33 100644
--- a/Makefile
+++ b/Makefile
@@ -2089,7 +2089,7 @@ clean:
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
-	$(RM) gitweb/gitweb.cgi
+	$(RM) gitweb/gitweb.{cgi,min.*}
 	$(MAKE) -C perl clean
 endif
 ifndef NO_PYTHON
-- 
1.7.0.3.436.g45b2d
