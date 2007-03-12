From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 5/5] fix a utf8 issue in t5100/patch005
Date: Mon, 12 Mar 2007 15:52:08 -0400
Message-ID: <11737291281424-git-send-email-dzickus@redhat.com>
References: <11737291282223-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 20:54:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqax-0002Ui-2V
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbXCLTxo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:53:44 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbXCLTxn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:53:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55957 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840AbXCLTxk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:53:40 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2CJrecj022122
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:53:40 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2CJrYuc020373
	for <git@vger.kernel.org>; Mon, 12 Mar 2007 15:53:34 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2CJrXX4029982;
	Mon, 12 Mar 2007 15:53:33 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2CJq8jF019779;
	Mon, 12 Mar 2007 15:52:08 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2CJq8ho019778;
	Mon, 12 Mar 2007 15:52:08 -0400
X-Mailer: git-send-email 1.5.0.2.211.g2ca9-dirty
In-Reply-To: <11737291282223-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42075>

This issue popped up when testing my changes.  I believe the patch is t=
he
intended output that git-mailinfo should provide.

Signed-off-by: Don Zickus <dzickus@redhat.com>
---
 t/t5100/patch0005 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5100/patch0005 b/t/t5100/patch0005
index 7d24b24..e7d6f66 100644
--- a/t/t5100/patch0005
+++ b/t/t5100/patch0005
@@ -61,7 +61,7 @@ diff --git a/git-cvsimport-script b/git-cvsimport-scr=
ipt
  		push(@old,$fn);
=20
 --=20
-David K=E5gedal
+David K=C3=A5gedal
 -
 To unsubscribe from this list: send the line "unsubscribe git" in
 the body of a message to majordomo@vger.kernel.org
--=20
1.5.0.2.211.g2ca9-dirty
