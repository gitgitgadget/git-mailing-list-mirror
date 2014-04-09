From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] add missing accent grave in git-http-backend.txt
Date: Wed, 9 Apr 2014 20:17:38 +0200 (CEST)
Message-ID: <878875030.1352677.1397067458743.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 20:17:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXx4C-0006Xc-Uc
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 20:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933881AbaDISRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 14:17:41 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:53590 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932847AbaDISRk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2014 14:17:40 -0400
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id C361415D7F2;
	Wed,  9 Apr 2014 20:17:38 +0200 (CEST)
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net [151.189.21.56])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id BFBB428E028;
	Wed,  9 Apr 2014 20:17:38 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id B7AA18578;
	Wed,  9 Apr 2014 20:17:38 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-16.arcor-online.net B7AA18578
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1397067458; bh=jBw4V7u6tH5w6QfKb5yjrs2M9DIz2hanMTC8FV2es9A=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=BLSskvbKnY28tb8ECAMnSqAfxz0SwTQkZRVJrHqZDVjzN6vYlMKTL0AXlttV0035Q
	 WbSrqZmeVa9okFyEI+5/ZxWX2WQIPToh/h5e31y1y5ARaByDRJQf/KlIcK7bqcS6Zq
	 9ckfWja3J+9j6r8+/0E0vg7SU1bQQwJo3BOH+ncA=
Received: from [94.217.26.7] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Wed, 9 Apr 2014 20:17:38 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.26.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245985>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>

---
 Documentation/git-http-backend.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index e8c13f6..d422ba4 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -191,7 +191,7 @@ ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ----------------------------------------------------------------
 
 Lighttpd::
-	Ensure that `mod_cgi`, `mod_alias, `mod_auth`, `mod_setenv` are
+	Ensure that `mod_cgi`, `mod_alias`, `mod_auth`, `mod_setenv` are
 	loaded, then set `GIT_PROJECT_ROOT` appropriately and redirect
 	all requests to the CGI:
 +
-- 
1.9.0.msysgit.0


---
Thomas
