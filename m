From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: [PATCH 1/4] Clarify syntax and role of git-add in status output
Date: Tue,  2 Jan 2007 20:26:20 +0100
Message-ID: <11677659863797-git-send-email-j.ruehle@bmiag.de>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?q?J=FCrgen_R=FChle?= <j-r@online.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 20:26:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pHb-0007wE-EG
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbXABT0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:26:46 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbXABT0q
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:26:46 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:37838 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964913AbXABT0o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:26:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 3D4A13AED7;
	Tue,  2 Jan 2007 20:26:43 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14482-08; Tue, 2 Jan 2007 20:26:42 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 49EC23AED1;
	Tue,  2 Jan 2007 20:26:42 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 52DE63ADCC;
	Tue,  2 Jan 2007 20:26:41 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 20656-04; Tue, 2 Jan 2007 20:26:33 +0100 (CET)
Received: from localhost.localdomain (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id F379D3ADC8;
	Tue,  2 Jan 2007 20:26:26 +0100 (CET)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc0.g31e2
In-Reply-To: <1167765983316-git-send-email-j.ruehle@bmiag.de>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35802>

=46rom: =3D?iso-8859-1?q?J=3DFCrgen_R=3DFChle?=3D <j-r@online.de>

This uses the actual (simplified) synopsis line from the git-add man pa=
ge and
advertises its incremental nature.

Signed-off-by: J=FCrgen R=FChle <j-r@online.de>
---
 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index db42738..34be91b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -15,7 +15,7 @@ static char wt_status_colors[][COLOR_MAXLEN] =3D {
 	"\033[31m", /* WT_STATUS_CHANGED: red */
 	"\033[31m", /* WT_STATUS_UNTRACKED: red */
 };
-static const char* use_add_msg =3D "use \"git add file1 file2\" to inc=
lude for commit";
+static const char* use_add_msg =3D "use \"git add <file>...\" to incre=
mentally add content to commit";
=20
 static int parse_status_slot(const char *var, int offset)
 {
--=20
1.5.0.rc0.g31e2
