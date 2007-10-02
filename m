From: Johan Herland <johan@herland.net>
Subject: [PATCH] Mention 'cpio' dependency in INSTALL
Date: Wed, 03 Oct 2007 01:42:29 +0200
Message-ID: <200710030142.30062.johan@herland.net>
References: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
 <200710012342.37352.johan@herland.net>
 <3f4fd2640710021409q104a4204r522391912d5b5c8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 01:43:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcrOZ-0006Zs-TT
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 01:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbXJBXnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2007 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbXJBXnJ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 19:43:09 -0400
Received: from smtp.getmail.no ([84.208.20.33]:49030 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbXJBXnI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2007 19:43:08 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JPB00M135VI5900@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Oct 2007 01:42:55 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPB0008O5UU7N50@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Oct 2007 01:42:30 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPB00HUH5UUB780@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Oct 2007 01:42:30 +0200 (CEST)
In-reply-to: <3f4fd2640710021409q104a4204r522391912d5b5c8c@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59758>

Signed-off-by: Johan Herland <johan@herland.net>
---

On Tuesday 02 October 2007, Reece Dunn wrote:
> Do you know if cpio is listed anywhere in required dependencies?

Doing the following in the git repo:
$ grep -r cpio *
git-clone.sh:           find objects -depth -print | cpio -pumd$l "$GIT=
_DIR/" || exit 1
git-merge.sh:   cpio -0 -o >"$GIT_DIR/MERGE_SAVE"
git-merge.sh:           cpio -iuv <"$GIT_DIR/MERGE_SAVE"

reveals that cpio is not mentioned anywhere in the documentation,
nor in the requirements section of the INSTALL file.


Have fun!

=2E..Johan


=A0INSTALL | =A0 =A03 +++
=A01 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/INSTALL b/INSTALL
index 289b046..f1eb404 100644
--- a/INSTALL
+++ b/INSTALL
@@ -79,6 +79,9 @@ Issues of note:
=A0	- "perl" and POSIX-compliant shells are needed to use most of
=A0	 =A0the barebone Porcelainish scripts.
=A0
+	- "cpio" is used by git-merge for saving and restoring the index,
+	 =A0and by git-clone when doing a local (possibly hardlinked) clone.
+
=A0 - Some platform specific issues are dealt with Makefile rules,
=A0 =A0 but depending on your specific installation, you may not
=A0 =A0 have all the libraries/tools needed, or you may have
--=20
1.5.3.3.1144.gf10f2
