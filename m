From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Drop UTF-8 characters in manual pages
Date: Tue, 18 Sep 2007 09:26:19 +0200
Message-ID: <11901003792475-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 09:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXXUq-0001Aa-DE
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 09:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbXIRH1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 03:27:37 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754692AbXIRH1h
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 03:27:37 -0400
Received: from vawad.err.no ([85.19.200.177]:37136 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754631AbXIRH1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 03:27:36 -0400
Received: from aputeaux-153-1-18-194.w82-124.abo.wanadoo.fr ([82.124.60.194] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IXXUa-0004oS-6I; Tue, 18 Sep 2007 09:27:32 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IXXTP-0001qK-6R; Tue, 18 Sep 2007 09:26:19 +0200
X-Mailer: git-send-email 1.5.3.1
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58536>

The default character encoding for english manual pages is ISO8859-1, s=
o
UTF-8 characters are just displayed as their sequence of bytes, which i=
s
not very appealing.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 Documentation/git-lost-found.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-lost-found.txt b/Documentation/git-lost-=
found.txt
index e48607f..82b0699 100644
--- a/Documentation/git-lost-found.txt
+++ b/Documentation/git-lost-found.txt
@@ -65,7 +65,7 @@ $ git rev-parse not-lost-anymore
=20
 Author
 ------
-Written by Junio C Hamano =E6=BF=B1=E9=87=8E =E7=B4=94 <junkio@cox.net=
>
+Written by Junio C Hamano <junkio@cox.net>
=20
 Documentation
 --------------
--=20
1.5.3.1
