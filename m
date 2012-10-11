From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v2 1/8] Split over-long synopsis in git-fetch-pack.txt into
 several  lines
Date: Thu, 11 Oct 2012 19:16:47 +0200 (CEST)
Message-ID: <2080170330.46860.1349975807337.JavaMail.ngmail@webmail22.arcor-online.net>
References: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 19:17:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMMNY-0006Ae-GF
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 19:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759025Ab2JKRQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 13:16:50 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:54505 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759013Ab2JKRQt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 13:16:49 -0400
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 68AA4AAAE4;
	Thu, 11 Oct 2012 19:16:47 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 6379D112023;
	Thu, 11 Oct 2012 19:16:47 +0200 (CEST)
Received: from webmail22.arcor-online.net (webmail22.arcor-online.net [151.189.8.137])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 5902D10CD4E;
	Thu, 11 Oct 2012 19:16:47 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-06.arcor-online.net 5902D10CD4E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1349975807; bh=25Xb4xA4EYDzPdNGiwt40yIC1dNmhtpzySGDkIc1Eog=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=bZwfE09veDxOL6CbRJDMmjAxjXwwQvtVTaHienwBgrbjFzIr7liPJPiuEQwarJ6Lr
	 iUct2eGIc0aIpggIFurWOP2k4yd3IixVC9azmgdCr9NLHLmGjs1QArtuFX/CviUN0Y
	 HnoKRMosa3LamALfDvR3ZEiX8J8Z+LL1XDWemrnc=
Received: from [188.105.106.236] by webmail22.arcor-online.net (151.189.8.137) with HTTP (Arcor Webmail); Thu, 11 Oct 2012 19:16:47 +0200 (CEST)
In-Reply-To: <1412437370.46782.1349975589890.JavaMail.ngmail@webmail22.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.236
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207491>

>From 27b3105a374158fb8cb008c808a1ef94487a48f7 Mon Sep 17 00:00:00 2001
From: Thomas Ackermann <th.acker@arcor.de>
Date: Thu, 4 Oct 2012 19:11:43 +0200
Subject: [PATCH] Split over-long synopsis in git-fetch-pack.txt into several
 lines

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
