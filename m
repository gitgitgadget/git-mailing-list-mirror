From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 09/11] Remove unnecessary historical note from "Object
 storage format"
Date: Tue, 27 Aug 2013 20:04:08 +0200 (CEST)
Message-ID: <2104057570.34585.1377626648812.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 20:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENcl-0001Ak-AG
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 20:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab3H0SEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 14:04:10 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:47997 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751740Ab3H0SEJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 14:04:09 -0400
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id D53C3107AE3;
	Tue, 27 Aug 2013 20:04:08 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id CC769212073;
	Tue, 27 Aug 2013 20:04:08 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id C80C135A309;
	Tue, 27 Aug 2013 20:04:08 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-11.arcor-online.net C80C135A309
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377626648; bh=m9GqNd/t9ZTVOIzWK3qQYZhiepXSIkzHRRXo7qjbHhI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=q+zJHh/AX7nSoI8IcOqbYRleDTOrP0fIMBPrsBcIfEAfGXatMe5SVulCiE+2TsulG
	 mm1O5OZiJAtdFMkNRznPTbiD1eSqaRGQHMDuSYvngv9zvY51G2GuddJHZMk0HhUWGg
	 mO6p2QFYTlIW9ozc1PRyXKvLyUGNjSn6U3A7cKqc=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 20:04:08 +0200 (CEST)
In-Reply-To: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233129>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a7ca3e3..56bd088 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4145,8 +4145,6 @@ about the data in the object.  It's worth noting that the SHA-1 hash
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
