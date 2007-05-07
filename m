From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 4/6] user-manual: fix .gitconfig editing examples
Date: Mon,  7 May 2007 01:14:00 -0400
Message-ID: <17154.7676822685$1178514875@news.gmane.org>
References: <11785148422793-git-send-email->
 <11785148433801-git-send-email->
 <11785148442263-git-send-email->
 <1178514845119-git-send-email->
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 07:14:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkvYN-0008WF-GY
	for gcvg-git@gmane.org; Mon, 07 May 2007 07:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbXEGFOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 01:14:14 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbXEGFOO
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 01:14:14 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53666 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753990AbXEGFOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 01:14:08 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HkvXy-0005Zv-1z; Mon, 07 May 2007 01:14:06 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <1178514845119-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46413>

=46rom: J. Bruce Fields <bfields@citi.umich.edu>

Santi B=C3=A9jar points out that when telling people how to "introduce
themselves" to git we're advising them to replace their entire
=2Egitconfig file.  Fix that.

Cc: "Santi B=C3=A9jar <sbejar@gmail.com>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 03206c5..c292b4d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -158,7 +158,7 @@ Making changes
 Make sure git knows who to blame:
=20
 ------------------------------------------------
-$ cat >~/.gitconfig <<\EOF
+$ cat >>~/.gitconfig <<\EOF
 [user]
 	name =3D Your Name Comes Here
 	email =3D you@yourdomain.example.com
@@ -1049,14 +1049,13 @@ Telling git your name
 ---------------------
=20
 Before creating any commits, you should introduce yourself to git.  Th=
e
-easiest way to do so is:
+easiest way to do so is to make sure the following lines appear in a
+file named .gitconfig in your home directory:
=20
 ------------------------------------------------
-$ cat >~/.gitconfig <<\EOF
 [user]
 	name =3D Your Name Comes Here
 	email =3D you@yourdomain.example.com
-EOF
 ------------------------------------------------
=20
 (See the "CONFIGURATION FILE" section of gitlink:git-config[1] for
--=20
1.5.1.1.98.gedb4f
