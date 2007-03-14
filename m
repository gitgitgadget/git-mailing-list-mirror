From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 5/5] fix a utf8 issue in t5100/patch005
Date: Wed, 14 Mar 2007 16:12:26 -0400
Message-ID: <11739031471626-git-send-email-dzickus@redhat.com>
References: <11739031463211-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 21:14:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRZrf-0003ZQ-4u
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 21:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933143AbXCNUOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 16:14:05 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933147AbXCNUOD
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 16:14:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38256 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933143AbXCNUN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 16:13:59 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDwrp014192
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:58 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDrdZ025159
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:53 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2EKDqdL007066;
	Wed, 14 Mar 2007 16:13:52 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2EKCRRm009159;
	Wed, 14 Mar 2007 16:12:27 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2EKCRkj009158;
	Wed, 14 Mar 2007 16:12:27 -0400
X-Mailer: git-send-email 1.5.0.2.213.g18c8-dirty
In-Reply-To: <11739031463211-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42226>

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
