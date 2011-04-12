From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] format-patch: document --quiet option
Date: Tue, 12 Apr 2011 17:51:37 +0200
Message-ID: <1302623497-7658-1-git-send-email-cmn@elego.de>
References: <1302622538-7535-1-git-send-email-cmn@elego.de>, <4DA36D95.6060108@windriver.com>, <7v8vvgv5dm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 17:51:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9fsW-00079v-Cx
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 17:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757822Ab1DLPvj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 11:51:39 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:47148 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757746Ab1DLPvj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 11:51:39 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id AEF5E4612C;
	Tue, 12 Apr 2011 17:51:24 +0200 (CEST)
Received: (nullmailer pid 7719 invoked by uid 1000);
	Tue, 12 Apr 2011 15:51:37 -0000
X-Mailer: git-send-email 1.7.4.2.437.g4fc7e.dirty
In-Reply-To: <1302622538-7535-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171401>

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

I guess this should be squashed into the previous one. I forgot it
wasn't documented, partly because reading the commit log for
ec2956df59 (Nate Case, format-patch: Respect --quiet option) says the
man page suggests this should work.

 Documentation/git-format-patch.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index 9dcafc6..616726b 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 		   [--ignore-if-in-upstream]
 		   [--subject-prefix=3DSubject-Prefix]
 		   [--to=3D<email>] [--cc=3D<email>]
-		   [--cover-letter]
+		   [--cover-letter] [--quiet]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
=20
@@ -192,6 +192,9 @@ will want to ensure that threading is disabled for =
`git send-email`.
 	filenames, use specified suffix.  A common alternative is
 	`--suffix=3D.txt`.  Leaving this empty will remove the `.patch`
 	suffix.
+
+--quiet::
+	Do not print the patch names to standard output.
 +
 Note that the leading character does not have to be a dot; for example=
,
 you can use `--suffix=3D-patch` to get `0001-description-of-my-change-=
patch`.
--=20
1.7.4.2.437.g4fc7e.dirty
