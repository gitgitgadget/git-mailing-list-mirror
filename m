From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Documentation: Fix git.7 dependencies.
Date: Fri, 19 Jan 2007 10:54:13 +0100
Message-ID: <873b67735m.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 19 10:54:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7qSW-0003pw-GZ
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 10:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbXASJyr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 04:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbXASJyr
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 04:54:47 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:57241 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965032AbXASJyq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 04:54:46 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l0J9shq00887
	for <git@vger.kernel.org>; Fri, 19 Jan 2007 10:54:44 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37169>



Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 96755ad..c258d09 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -78,10 +78,10 @@ cmds_txt =3D cmds-ancillaryinterrogators.txt \
 	cmds-plumbingmanipulators.txt \
 	cmds-synchingrepositories.txt
=20
-$(cmds_txt): cmd-list.perl $(MAN1_TXT) $(MAN7_TXT)
+$(cmds_txt): cmd-list.perl $(MAN1_TXT)
 	perl ./cmd-list.perl
=20
-git.7 git.html: git.txt core-intro.txt
+git.7 git.html: git.txt core-intro.txt $(cmds_txt)
=20
 clean:
 	rm -f *.xml *.html *.1 *.7 howto-index.txt howto/*.html doc.dep
--=20
1.5.0.rc1.g4b66a
