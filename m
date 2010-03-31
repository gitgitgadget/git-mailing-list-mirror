From: =?UTF-8?q?Jan=20St=C4=99pie=C5=84?= 
	<jstepien@users.sourceforge.net>
Subject: [PATCH] Updated the usage string of git reset
Date: Wed, 31 Mar 2010 11:24:19 +0200
Message-ID: <1270027459-1967-1-git-send-email-jstepien@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20St=C4=99pie=C5=84?= 
	<jstepien@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 31 11:24:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwuAN-0002cd-OV
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 11:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933055Ab0CaJYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 05:24:46 -0400
Received: from r245-52.iq.pl ([86.111.245.52]:35496 "EHLO stepien.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933035Ab0CaJYp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 05:24:45 -0400
Received: from localhost.localdomain (chello089078159032.chello.pl [89.78.159.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stepien.cc (Postfix) with ESMTPSA id 88C8E2A105D5;
	Wed, 31 Mar 2010 11:24:43 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143655>

Make git reset usage string reflect the command's behaviour and content=
s of
the man page.

Signed-off-by: Jan St=C4=99pie=C5=84 <jstepien@users.sourceforge.net>
---
 builtin/reset.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 2c3a69a..1283068 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -23,7 +23,8 @@
=20
 static const char * const git_reset_usage[] =3D {
 	"git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<comm=
it>]",
-	"git reset [--mixed] <commit> [--] <paths>...",
+	"git reset [-q] <commit> [--] <paths>...",
+	"git reset --patch [<commit>] [--] [<paths>...]",
 	NULL
 };
=20
--=20
1.7.0.3
