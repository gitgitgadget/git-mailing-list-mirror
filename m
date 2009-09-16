From: =?UTF-8?q?Jan=20St=C4=99pie=C5=84?= <jan@stepien.cc>
Subject: [PATCH] Updated the usage string of git reset
Date: Wed, 16 Sep 2009 18:29:41 +0300
Message-ID: <1253114981-31143-1-git-send-email-jan@stepien.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20St=C4=99pie=C5=84?= <jan@stepien.cc>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 16 17:38:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnwYn-0005EG-1E
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 17:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbZIPPge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2009 11:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbZIPPge
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 11:36:34 -0400
Received: from r245-52.iq.pl ([86.111.245.52]:43548 "EHLO stepien.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbZIPPge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 11:36:34 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2009 11:36:34 EDT
Received: from localhost.localdomain (kielo.uta.fi [153.1.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stepien.cc (Postfix) with ESMTPSA id EC1C417042E1;
	Wed, 16 Sep 2009 17:30:14 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128659>

Now the usage string reflects the behaviour of git reset and contents o=
f
the man page.

Signed-off-by: Jan St=C4=99pie=C5=84 <jan@stepien.cc>
---
 builtin-reset.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 73e6022..78103ab 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -21,7 +21,7 @@
=20
 static const char * const git_reset_usage[] =3D {
 	"git reset [--mixed | --soft | --hard | --merge] [-q] [<commit>]",
-	"git reset [--mixed] <commit> [--] <paths>...",
+	"git reset [-q] <commit> [--] <paths>...",
 	NULL
 };
=20
--=20
1.6.4.3
