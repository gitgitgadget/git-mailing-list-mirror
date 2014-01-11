From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Fix asciidoc header in pack-heuristics.txt
Date: Sat, 11 Jan 2014 17:28:25 +0100 (CET)
Message-ID: <16941053.1711081.1389457705671.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 11 17:28:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W21QF-0001YD-S7
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 17:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbaAKQ22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jan 2014 11:28:28 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:35437 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751126AbaAKQ21 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jan 2014 11:28:27 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mx.arcor.de (Postfix) with ESMTP id AE888A9E69;
	Sat, 11 Jan 2014 17:28:25 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id AB6FD7DA845;
	Sat, 11 Jan 2014 17:28:25 +0100 (CET)
Received: from webmail12.arcor-online.net (webmail12.arcor-online.net [151.189.8.64])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id A43C6A9E69;
	Sat, 11 Jan 2014 17:28:25 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net A43C6A9E69
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1389457705; bh=UXIphRn30Ts5r/j22fKUoqNw7PHnmd6N8cm/5oBR9nE=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=J+EW08JpIgVL+hImSsLuxMcUdeSbkD3cPqch3jQZunX2PyS+zo3QTWam/h5653ytQ
	 4yl+cSA/EZjYwmStMYDuROOo5G6yGuUBndaXwRIzyHalZhBzQXBq737PeFJfYmBM1S
	 OjGSpf+cwt03cBV4ZsEBxHg/tCjB2//bK9MuoSEs=
Received: from [178.7.25.41] by webmail12.arcor-online.net (151.189.8.64) with HTTP (Arcor Webmail); Sat, 11 Jan 2014 17:28:25 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.25.41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240332>


Create a proper header when formatted as html.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/technical/pack-heuristics.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/pack-heuristics.txt b/Documentation/technical/pack-heuristics.txt
index b7bd951..95a07db 100644
--- a/Documentation/technical/pack-heuristics.txt
+++ b/Documentation/technical/pack-heuristics.txt
@@ -1,5 +1,5 @@
-        Concerning Git's Packing Heuristics
-        ===================================
+Concerning Git's Packing Heuristics
+===================================
 
         Oh, here's a really stupid question:
 
-- 
1.8.5.2.msysgit.0


---
Thomas
