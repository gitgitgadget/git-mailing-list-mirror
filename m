From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] git-svn: don't confuse editors with an apostrophe
Date: Thu, 31 Mar 2011 17:02:33 +0200
Message-ID: <1301583753-2688-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 17:02:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5JOV-00036b-AI
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 17:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758202Ab1CaPCh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 11:02:37 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:49463 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758077Ab1CaPCf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 11:02:35 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id E3DCA4611D;
	Thu, 31 Mar 2011 17:02:24 +0200 (CEST)
Received: (nullmailer pid 2744 invoked by uid 1000);
	Thu, 31 Mar 2011 15:02:33 -0000
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170496>

The quotation mark serving as an apostrophe confuses editors and they
think a large part of the rest of the file is a string. Change
"you're" to "you are" to avoid this.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a5857c1..fe28f6a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -345,7 +345,7 @@ Usage: git svn <command> [options] [arguments]\n
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
1.7.4.1
