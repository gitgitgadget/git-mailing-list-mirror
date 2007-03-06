From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 5/5] fix a utf8 issue in t5100/patch005
Date: Tue,  6 Mar 2007 16:57:43 -0500
Message-ID: <11732182643193-git-send-email-dzickus@redhat.com>
References: <1173218263315-git-send-email-dzickus@redhat.com> <11732182643385-git-send-email-dzickus@redhat.com> <117321826466-git-send-email-dzickus@redhat.com> <11732182641895-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 22:59:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOhhJ-0007Zu-Nm
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 22:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbXCFV7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 16:59:18 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbXCFV7R
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 16:59:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49731 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030361AbXCFV7L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 16:59:11 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l26LxAmM007004
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 16:59:10 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l26Lx9wv013042
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 16:59:09 -0500
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l26Lx8b4007416;
	Tue, 6 Mar 2007 16:59:08 -0500
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l26Lvim2007902;
	Tue, 6 Mar 2007 16:57:44 -0500
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l26LviO8007901;
	Tue, 6 Mar 2007 16:57:44 -0500
X-Mailer: git-send-email 1.5.0.2.212.gd52f-dirty
In-Reply-To: <11732182641895-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41600>

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
1.5.0.2.212.gd52f-dirty
