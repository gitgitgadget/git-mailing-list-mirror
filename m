From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] remove duplicate entry from 2.1.0 release notes
Date: Wed, 30 Jul 2014 22:03:54 +0200 (CEST)
Message-ID: <462743004.945886.1406750634339.JavaMail.ngmail@webmail16.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 22:04:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCa6S-0005ix-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 22:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbaG3UD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 16:03:57 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:33376 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750990AbaG3UD4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2014 16:03:56 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mx.arcor.de (Postfix) with ESMTP id 5FE633AE8B5;
	Wed, 30 Jul 2014 22:03:54 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 593A47D8224;
	Wed, 30 Jul 2014 22:03:54 +0200 (CEST)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 53F60A9D3A;
	Wed, 30 Jul 2014 22:03:54 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net 53F60A9D3A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1406750634; bh=kckCehcHRFHxc4thU4u1moU6I+76FRcJ3QUv7dScVc4=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=l5xXjwgTvaSUTB6WhiPeNPwXMNWNi3PKKWZOeoMrCzLXy1MnrqclHi9Pe540EQVCQ
	 r3lUWp0w4H6HEbXENRyV5Ht/6w4lxZRdakLwlgYAYdDpSoNZYpWSKc7vrHz9E+ze28
	 OWe9sYDArWEIY+UaG/h7MORg+9GWTZGSXBjkqkJQ=
Received: from [94.217.22.247] by webmail16.arcor-online.net (151.189.8.70) with HTTP (Arcor Webmail); Wed, 30 Jul 2014 22:03:54 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.22.247
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254517>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/RelNotes/2.1.0.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/RelNotes/2.1.0.txt b/Documentation/RelNotes/2.1.0.txt
index be598ad..e958498 100644
--- a/Documentation/RelNotes/2.1.0.txt
+++ b/Documentation/RelNotes/2.1.0.txt
@@ -137,9 +137,6 @@ Performance, Internal Implementation, etc.
    introduced; this may reduce I/O cost of rewriting a large index
    when only small part of the working tree changes.
 
- * Effort to shrink the size of patches Windows folks maintain on top
-   by upstreaming them continues.
-
  * Patches maintained by msysgit folks for Windows port are being
    upstreamed here a bit by bit.
 
-- 
1.9.4.msysgit.0


---
Thomas
