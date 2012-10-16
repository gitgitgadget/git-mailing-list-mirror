From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v3 1/8] Split over-long synopsis in git-fetch-pack.txt into
 several lines
Date: Tue, 16 Oct 2012 19:20:10 +0200 (CEST)
Message-ID: <1405742472.154104.1350408010912.JavaMail.ngmail@webmail15.arcor-online.net>
References: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de, git@drmicha.warpmail.net
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:20:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOAob-0007O2-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab2JPRUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:20:13 -0400
Received: from mail-in-14.arcor-online.net ([151.189.21.54]:38424 "EHLO
	mail-in-14.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754190Ab2JPRUM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 13:20:12 -0400
Received: from mail-in-20-z2.arcor-online.net (mail-in-20-z2.arcor-online.net [151.189.8.85])
	by mx.arcor.de (Postfix) with ESMTP id EE3C19C178;
	Tue, 16 Oct 2012 19:20:10 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-20-z2.arcor-online.net (Postfix) with ESMTP id ECBF2834022;
	Tue, 16 Oct 2012 19:20:10 +0200 (CEST)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id E50FC212EF9;
	Tue, 16 Oct 2012 19:20:10 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-13.arcor-online.net E50FC212EF9
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1350408010; bh=JdSNTcuHEJpRwt9k2KWBGZz7NdgLN3Ayn4vCBxG0ITY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=PWp9AJlG7xFEF8c9HpJaYv+/rVrgbkkswe4kLYppMMzkHI6DfZfdG4yLj67w8hOj5
	 DDSXf6FJuTKXAh9hDyEv6FkWURE74yahXpKln9jNl1vfyxbydflIty+72qQd/f1XVn
	 Gknh0255sYkX0pcAyQimBl9UEaSx+IwrFHceBqW4=
Received: from [188.98.243.159] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Tue, 16 Oct 2012 19:20:10 +0200 (CEST)
In-Reply-To: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.243.159
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207850>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/git-fetch-pack.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 474fa30..12cd8a2 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -9,7 +9,10 @@ git-fetch-pack - Receive missing objects from another repository
 SYNOPSIS
 --------
 [verse]
-'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]
+'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] 
+				[--upload-pack=<git-upload-pack>] 
+				[--depth=<n>] [--no-progress] 
+				[-v] [<host>:]<directory> [<refs>...]
 
 DESCRIPTION
 -----------
-- 
1.7.11.msysgit.1


---
Thomas
