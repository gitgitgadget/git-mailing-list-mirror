From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 3/3] Amend new-command.txt to be processed correctly by
 howto-index.sh
Date: Fri, 21 Dec 2012 19:07:35 +0100 (CET)
Message-ID: <992343281.286729.1356113255572.JavaMail.ngmail@webmail14.arcor-online.net>
References: <1595193006.286662.1356112971883.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 19:07:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm70k-0000t3-TX
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 19:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226Ab2LUSHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 13:07:38 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:55108 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751130Ab2LUSHg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 13:07:36 -0500
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mx.arcor.de (Postfix) with ESMTP id 99479AA9CA
	for <git@vger.kernel.org>; Fri, 21 Dec 2012 19:07:35 +0100 (CET)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id 978ED10C01C;
	Fri, 21 Dec 2012 19:07:35 +0100 (CET)
Received: from webmail14.arcor-online.net (webmail14.arcor-online.net [151.189.8.67])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 92C1810BC19;
	Fri, 21 Dec 2012 19:07:35 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-06.arcor-online.net 92C1810BC19
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1356113255; bh=cbECb7O6jexdDAxEk/bfjR08wXm5UwDCW6SO9E6ywH8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=g/JB32reHb9gvbkaX5sQx8r+XzS2z0Q82KLW/NmWk56KkLOhG8iXKbgntXxx44hhL
	 5FLQyMzB5Eah+nK8UW5wNW20xAWywXPCcrLOD1yBTBBplb660ABEd3YdaTxwF5EGfM
	 qEklxGck+v3a9iy2rM8NIYTJPW7nhLBnKHqpI/U4=
Received: from [178.7.24.61] by webmail14.arcor-online.net (151.189.8.67) with HTTP (Arcor Webmail); Fri, 21 Dec 2012 19:07:35 +0100 (CET)
In-Reply-To: <1595193006.286662.1356112971883.JavaMail.ngmail@webmail14.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.24.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211996>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/howto/new-command.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/new-command.txt
index d3b9781..36502f6 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -1,5 +1,10 @@
-Integrating new subcommands
-===========================
+From: Eric S. Raymond <esr@thyrsus.com>
+Abstract: This is how-to documentation for people who want to add extension
+ commands to git.  It should be read alongside api-builtin.txt.
+Content-type: text/asciidoc
+
+How to integrate new subcommands
+================================
 
 This is how-to documentation for people who want to add extension
 commands to git.  It should be read alongside api-builtin.txt.
-- 
1.8.0.msysgit.0


---
Thomas
