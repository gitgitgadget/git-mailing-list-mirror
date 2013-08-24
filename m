From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 10/13] Remove unnecessary historical note from "Object
 storage format"
Date: Sat, 24 Aug 2013 09:33:16 +0200 (CEST)
Message-ID: <1339924016.1091137.1377329596491.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:33:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8La-0006Gv-9W
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252Ab3HXHdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:33:18 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:50922 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754220Ab3HXHdR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:33:17 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mx.arcor.de (Postfix) with ESMTP id 83AE4107A54;
	Sat, 24 Aug 2013 09:33:16 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 8125414ACBB;
	Sat, 24 Aug 2013 09:33:16 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 7A9D610C539;
	Sat, 24 Aug 2013 09:33:16 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-06.arcor-online.net 7A9D610C539
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329596; bh=4vih+wZsQNZaT3EswTczkclA2ykvijOkZdfw/19vrcY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=XZQTEtMT5SQKxD0Iw3SMIsDp/sfs9vdsAzyI474BOOBjLhB/RDG7HEyy9CaHFwUNA
	 mM7uztOTocv3VL/xZ00o6PgISmmiPuRF1OLCe3erBV+5t+WzZkObIsrMtpUMQeDK7y
	 FNfFWu9oF1IUgqcxmVUA/PLYVJw1NZDHrCblfKG0=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:33:16 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232877>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f713f26..aa6bfab 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4132,8 +4132,6 @@ about the data in the object.  It's worth noting that the SHA-1 hash
 that is used to name the object is the hash of the original data
 plus this header, so `sha1sum` 'file' does not match the object name
 for 'file'.
-(Historical note: in the dawn of the age of Git the hash
-was the SHA-1 of the 'compressed' object.)
 
 As a result, the general consistency of an object can always be tested
 independently of the contents or the type of the object: all objects can
-- 
1.8.3.msysgit.0


---
Thomas
