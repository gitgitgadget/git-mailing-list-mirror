From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 06/11] Simplify "How to make a commit"
Date: Tue, 27 Aug 2013 20:01:17 +0200 (CEST)
Message-ID: <878772375.34519.1377626477170.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 20:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENZz-0007O4-Av
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 20:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409Ab3H0SBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 14:01:18 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:50313 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752166Ab3H0SBS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 14:01:18 -0400
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id 351753016D;
	Tue, 27 Aug 2013 20:01:17 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id 300D53F844D;
	Tue, 27 Aug 2013 20:01:17 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 29BDD2D687C;
	Tue, 27 Aug 2013 20:01:17 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-10.arcor-online.net 29BDD2D687C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377626477; bh=NaVktQcQ1C6ugZSU4FgtYkZQMjLfU/GeM2aZb2PFca8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=MnIJ5Bg3FRgC3lWnAgfTpM+rEIkjm4W8hCzLMlyLPA3oukquC5qTw7Anczg8tY7rP
	 n9YZ3K+8y3l92dGy1nnefHD8F2IiwX9HXPde+UPccqznlNTDW/nd99TeaSb6Mb8AzA
	 OevvmZAF38ZF1V4nf6u4uQZLleSZO2J5TcLJFB+A=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 20:01:17 +0200 (CEST)
In-Reply-To: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233126>


Combine the two cases for "git add" into one.
Add verb "use" to "git rm" case.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 465d9cb..98d2804 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1080,19 +1080,13 @@ produce no output at that point.
 
 Modifying the index is easy:
 
-To update the index with the new contents of a modified file, use
+To update the index with the contents of a new or modified file, use
 
 -------------------------------------------------
 $ git add path/to/file
 -------------------------------------------------
 
-To add the contents of a new file to the index, use
-
--------------------------------------------------
-$ git add path/to/file
--------------------------------------------------
-
-To remove a file from the index and from the working tree,
+To remove a file from the index and from the working tree, use
 
 -------------------------------------------------
 $ git rm path/to/file
-- 
1.8.3.msysgit.0


---
Thomas
