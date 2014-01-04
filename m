From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Improve user-manual html and pdf formatting
Date: Sat, 4 Jan 2014 10:07:51 +0100 (CET)
Message-ID: <352636633.1492236.1388826471175.JavaMail.ngmail@webmail10.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 04 10:08:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzNDQ-000193-JY
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jan 2014 10:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbaADJHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 04:07:55 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:46421 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138AbaADJHw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jan 2014 04:07:52 -0500
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 4014DD9273;
	Sat,  4 Jan 2014 10:07:51 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 3696733B2B0;
	Sat,  4 Jan 2014 10:07:51 +0100 (CET)
Received: from webmail10.arcor-online.net (webmail10.arcor-online.net [151.189.8.93])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 308F5198863;
	Sat,  4 Jan 2014 10:07:51 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net 308F5198863
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1388826471; bh=Q6h44ADo7ucOKRM9FWrkgYIK0Ce51kjgE/XQrxJLqE0=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=NcKX7bS09jzYeXYdQDBKKojxLZ0ddIav/Qf9jw526M3iwQ5zOT8zO8nWJgqFlJ96o
	 OOAeIB39xg47mVns/FFSRQZPMZdKVZjpK+njVJs6MFuLnmDSk/389/9Km1CPy7/WzM
	 DcsMaB7BEEIPdV0Q6Nkes0fQpvdujnYcNWM/D4uk=
Received: from [94.217.18.252] by webmail10.arcor-online.net (151.189.8.93) with HTTP (Arcor Webmail); Sat, 4 Jan 2014 10:07:51 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.18.252
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239942>


Use asciidoc style 'article' instead of 'book' and change asciidoc title level.
This removes blank first page and superfluous "Part I" page (there is no "Part II")
in pdf output. Also pdf size is decreased by this from 77 to 67 pages.
In html output this removes unnecessary sub-tocs and chapter numbering.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/Makefile        | 2 +-
 Documentation/user-manual.txt | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 91a12c7..36c58fc 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -324,7 +324,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 
 user-manual.xml: user-manual.txt user-manual.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d book -o $@+ $< && \
+	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d article -o $@+ $< && \
 	mv $@+ $@
 
 technical/api-index.txt: technical/api-index-skel.txt \
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index cbb01a1..130c2f4 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1,5 +1,5 @@
-Git User Manual
-_______________
+&#65279;Git User Manual
+===============
 
 Git is a fast distributed revision control system.
 
-- 
1.8.5.2.msysgit.0


---
Thomas
