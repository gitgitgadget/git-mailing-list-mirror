From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH RESEND] git-svn: don't confuse editors with an apostrophe
Date: Fri, 29 Apr 2011 13:40:14 +0200
Message-ID: <1304077214-1707-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 13:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFm3c-0007Gl-3c
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 13:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489Ab1D2LkR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 07:40:17 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:53575 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476Ab1D2LkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 07:40:16 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 505E846132;
	Fri, 29 Apr 2011 13:39:57 +0200 (CEST)
Received: (nullmailer pid 1742 invoked by uid 1000);
	Fri, 29 Apr 2011 11:40:15 -0000
X-Mailer: git-send-email 1.7.4.2.437.g4fc7e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172448>

The quotation mark serving as an apostrophe confuses editors and they
think a large part of the rest of the file is a string. Change
"you're" to "you are" to avoid this.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
Acked-by: Eric Wong <normalperson@yhbt.net>
---

I sent this on 31-03-2011 but apart from Eric's ack, there was no
reaction and I don't see it in the patch queue.

   cmn

 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index bf0451b..bc5981d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -348,7 +348,7 @@ Usage: git svn <command> [options] [arguments]\n
 	}
 	print $fd <<"";
 \nGIT_SVN_ID may be set in the environment or via the --id/-i switch t=
o an
-arbitrary identifier if you're tracking multiple SVN branches/reposito=
ries in
+arbitrary identifier if you are tracking multiple SVN branches/reposit=
ories in
 one git repository and want to keep them separate.  See git-svn(1) for=
 more
 information.
=20
--=20
1.7.4.2.437.g4fc7e.dirty
