From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH] Change the signature start string to "-- \n"
Date: Fri, 17 Feb 2006 03:25:02 +0100
Message-ID: <20060217022502.13103.4332.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 03:25:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9vIy-000615-Sk
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 03:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWBQCZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 21:25:05 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWBQCZF
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 21:25:05 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:9961 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751244AbWBQCZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 21:25:04 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060217022502.JQXF12400.mxfep01.bredband.com@backpacker.hemma.treskal.com>;
          Fri, 17 Feb 2006 03:25:02 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id 75D9016BE;
	Fri, 17 Feb 2006 03:25:02 +0100 (CET)
To: Catalin Marinas <catalin.marinas@arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16322>

Change the signature start string from "--\n" to "-- \n" in the cover
mail template, as recommended in Mutt's manual:

    It is *strongly* recommended that you not unset this variable
    [from its default value of "-- \n"] unless your "signature"
    contains just your name. The reason for this is because many
    software packages use "-- \n" to detect your signature. For
    example, Mutt has the ability to highlight the signature in a
    different color in the builtin pager.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 templates/covermail.tmpl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/covermail.tmpl b/templates/covermail.tmpl
index 9789c9c..44cd19e 100644
--- a/templates/covermail.tmpl
+++ b/templates/covermail.tmpl
@@ -4,5 +4,5 @@ Date: %(date)s
 %(endofheaders)s
 The following series implements...
=20
---
+--=20
 Signature
