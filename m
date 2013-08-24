From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 06/13] Simplify "How to make a commit"
Date: Sat, 24 Aug 2013 09:29:36 +0200 (CEST)
Message-ID: <1687455733.1090999.1377329376866.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:29:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8I2-0000XV-5b
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550Ab3HXH3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:29:38 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:42479 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754220Ab3HXH3i (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:29:38 -0400
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id E49413BB5B8;
	Sat, 24 Aug 2013 09:29:36 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id D6F0A112017;
	Sat, 24 Aug 2013 09:29:36 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id D6B65197597;
	Sat, 24 Aug 2013 09:29:36 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net D6B65197597
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329376; bh=gO8rwIrIx1DawoTCXahRQ5u3+KkLjH5gCc7wAJb7oDk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=KnKyKPiikk6xfpKWevETUJwMapuGwmSlU4bbZuxZU6Xu9eVzEFM5a0EsvH0h0A5hU
	 PaqM0EeIaG7yn0u8i6j75hF+6Y6FomlLOCMa8TrRIf4EDmU2ed0QYtF1la5xBNSVME
	 bwakOpp0kApalpj1Wh3x0lgJDtrXyH/FP40xb/C4=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:29:36 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232873>


Combine the two cases for "git add" into one.
Add verb "use" to "git rm" case.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 8a1a441..ca78333 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1080,19 +1080,14 @@ produce no output at that point.
 
 Modifying the index is easy:
 
-To update the index with the new contents of a modified file, use
+To add the contents of a new file to the index or update the index 
+with the new contents of a modified file, use
 
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
