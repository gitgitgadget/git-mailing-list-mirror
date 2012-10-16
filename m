From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch v3 2/8] Shorten two over-long lines in git-bisect-lk2009.txt
 by abbreviating some sha1
Date: Tue, 16 Oct 2012 19:21:57 +0200 (CEST)
Message-ID: <1739299099.154164.1350408117758.JavaMail.ngmail@webmail15.arcor-online.net>
References: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: philipoakley@iee.org, peff@peff.net, gitster@pobox.com,
	th.acker66@arcor.de, git@drmicha.warpmail.net
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 19:22:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOAqI-000187-Hh
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078Ab2JPRV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:21:59 -0400
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:37541 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754960Ab2JPRV7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 13:21:59 -0400
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id CBA0CCBC7A;
	Tue, 16 Oct 2012 19:21:57 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id C7A3D3F83DF;
	Tue, 16 Oct 2012 19:21:57 +0200 (CEST)
Received: from webmail15.arcor-online.net (webmail15.arcor-online.net [151.189.8.68])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id C0437E46AB;
	Tue, 16 Oct 2012 19:21:57 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-05.arcor-online.net C0437E46AB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1350408117; bh=Mt1jgnwoWTS2NUQ37yLN6jxQPoVjjGIkKLsFGxUipUc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=VCD8uerjH4uhiWMy9eU37tx8dr3JifFrOfzZHDDikjgTu/54eqbhwEf+AZ9oOwkN4
	 yQFA87hcWylRtukTDRQbMUpzmawaiPO5RjsOHdUHFq4ylKk9LT6df/3K+iQvxli5Ck
	 BoLBxVzr/HvNxwHlS50KZfNg5V2xcdVLV5lFdQN0=
Received: from [188.98.243.159] by webmail15.arcor-online.net (151.189.8.68) with HTTP (Arcor Webmail); Tue, 16 Oct 2012 19:21:57 +0200 (CEST)
In-Reply-To: <1213313884.154031.1350407865830.JavaMail.ngmail@webmail15.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.243.159
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207852>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/git-bisect-lk2009.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 8a2ba37..ec4497e 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -257,7 +257,7 @@ Date:   Sat May 3 11:59:44 2008 -0700
 
     Linux 2.6.26-rc1
 
-:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M      Makefile
+:100644 100644 5cf82581... 4492984e... M      Makefile
 -------------
 
 At this point we can see what the commit does, check it out (if it's
@@ -331,7 +331,7 @@ Date:   Sat May 3 11:59:44 2008 -0700
 
     Linux 2.6.26-rc1
 
-:100644 100644 5cf8258195331a4dbdddff08b8d68642638eea57 4492984efc09ab72ff6219a7bc21fb6a957c4cd5 M      Makefile
+:100644 100644 5cf82581... 4492984e... M      Makefile
 bisect run success
 -------------
 
-- 
1.7.11.msysgit.1


---
Thomas
