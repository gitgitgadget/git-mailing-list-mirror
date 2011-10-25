From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] gitweb/Makefile: Remove static/gitweb.js in the clean target
Date: Tue, 25 Oct 2011 18:15:20 +0100
Message-ID: <4EA6EEA8.3000204@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 19:16:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIkcK-0008Ez-NF
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 19:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab1JYRQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 13:16:44 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:60275 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752115Ab1JYRQn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 13:16:43 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1RIkcD-0001U0-cK; Tue, 25 Oct 2011 17:16:42 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184225>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 gitweb/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 1c85b5f..4191c6b 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -185,7 +185,9 @@ install: all
 ### Cleaning rules
 
 clean:
-	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWEB-BUILD-OPTIONS
+	$(RM) gitweb.cgi static/gitweb.js \
+		static/gitweb.min.js static/gitweb.min.css \
+		GITWEB-BUILD-OPTIONS
 
 .PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
 
-- 
1.7.7
