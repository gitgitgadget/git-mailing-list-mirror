From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 2/3] Documentation: gitrevisions
Date: Mon,  5 Jul 2010 18:11:40 +0200
Message-ID: <7efed85cefddff1cd2cc3a0e3802326306117f4e.1278346173.git.git@drmicha.warpmail.net>
References: <cover.1278346173.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 18:13:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVoHy-0006e5-5r
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 18:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab0GEQMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 12:12:38 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:50651 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753857Ab0GEQMh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 12:12:37 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A079E1185AA
	for <git@vger.kernel.org>; Mon,  5 Jul 2010 12:12:36 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 05 Jul 2010 12:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=aBc7gXERpzUFx++FCp2gGTPKyG8=; b=RVtiMMhFFI9WIaDjXqjmYRb0Nb4cxE/XyjNtVYRi/dmtauoHo16TLljA9DAcjTVvvhq/gVijDs244MIaFB5k3t1IGiOeKNEcOZhdh1U146CHYY2/yHM6Wqx7D8ZoKakgVRLArlq2no/iYexBgFR8QjrC0P8vH5t/Z1uGdQoOzzs=
X-Sasl-enc: JjZJ0vbaYDGXyn0452+/eHXiAZ+s0/Ng0Gq1L9MRmk/b 1278346356
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1139051DD6;
	Mon,  5 Jul 2010 12:12:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
In-Reply-To: <cover.1278346173.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150276>

Create a new man page gitrevisions(7) which contains the revsions and
ranges documentation but not more. This uses (per include) the same bits
as the pertaining section of git-rev-parse(1).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/Makefile         |    2 +-
 Documentation/gitrevisions.txt |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/gitrevisions.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 04f69cf..a4c4063 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -6,7 +6,7 @@ MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
 	gitrepository-layout.txt
 MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
 	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
-	gitdiffcore.txt gitworkflows.txt
+	gitdiffcore.txt gitrevisions.txt gitworkflows.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.txt
new file mode 100644
index 0000000..fc4789f
--- /dev/null
+++ b/Documentation/gitrevisions.txt
@@ -0,0 +1,35 @@
+gitrevisions(7)
+================
+
+NAME
+----
+gitrevisions - specifying revisions and ranges for git
+
+SYNOPSIS
+--------
+gitrevisions
+
+
+DESCRIPTION
+-----------
+
+Many Git commands take revision parameters as arguments. Depending on
+the command, they denote a specific commit or, for commands which
+walk the revision graph (such as linkgit:git-log[1]), all commits which can
+be reached from that commit. In the latter case one can also specify a
+range of revisions explicitly.
+
+In addition, some Git commands (such as linkgit:git-show[1]) also take
+revision parameters which denote other objects than commits, e.g. blobs
+("files") or trees ("directories of files").
+
+include::revisions.txt[]
+
+
+SEE ALSO
+--------
+linkgit:git-rev-parse[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.7.1.621.g01d76
