From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: [PATCH 2/2] git svn : documentation of 'pre-svn-dcommit'
Date: Sun,  3 Jul 2011 22:49:16 +0200
Message-ID: <1309726156-31156-3-git-send-email-frederic.heitzmann@gmail.com>
References: <vpqfwmos5sg.fsf@bauges.imag.fr>
 <1309726156-31156-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
To: Matthieu.Moy@grenoble-inp.fr, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 22:49:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdTbs-0008OR-QV
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 22:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab1GCUtf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jul 2011 16:49:35 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:65040 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab1GCUtb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 16:49:31 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so4671294fxd.11
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V3h9I/D8Px0lua5V/t5dM122iJscWEAi+FnB4woBkNs=;
        b=Loiy2gaH9dMY5/DAyzarOFTpU2p4/fC7ebQFgNFLcK85U8kyQra+14ZdHKgXe3JGMm
         f81w5FgBQOjfwMGiazsmJzw5v3CtJfdKT8wd2UhZ+Y3CJvsmtQu6s+4oaMXTjr3gj/QP
         cZaL4WzIP/qfWVx4TXwIdgx2Aax+1JRUxJSdo=
Received: by 10.223.57.5 with SMTP id a5mr8461901fah.90.1309726171188;
        Sun, 03 Jul 2011 13:49:31 -0700 (PDT)
Received: from localhost.localdomain (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id n27sm4044550faa.4.2011.07.03.13.49.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 13:49:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.133.gd3b55a
In-Reply-To: <1309726156-31156-1-git-send-email-frederic.heitzmann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176588>

Update of the git-svn documentation: 'pre-svn-dcommit' hook.

Signed-off-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.c=
om>
---
 Documentation/git-svn.txt |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 713e523..ec87ed3 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -700,6 +700,18 @@ section because they affect the 'git-svn-id:' meta=
data line, except
 for rewriteRoot and rewriteUUID which can be used together.
=20
=20
+HOOKS
+-----
+
+The 'pre-svn-dcommit' hook is called by 'git svn dcommit' and can be u=
sed to
+prevent some diff to be committed to a SVN repository. It may typicall=
y be
+used to filter some intermediate patches, which were committed into gi=
t but
+must not find their way to the SVN repository.
+
+It takes a single parameter, the reference given to 'git svn dcommit'.=
 If the
+hook exists with a non zero-status, 'git svn dcommit' will abort.
+
+
 BASIC EXAMPLES
 --------------
=20
@@ -901,7 +913,7 @@ reset) branches-maxRev and/or tags-maxRev as approp=
riate.
=20
 SEE ALSO
 --------
-linkgit:git-rebase[1]
+linkgit:git-rebase[1], linkgit:githooks[5]
=20
 GIT
 ---
--=20
1.7.6.133.gd3b55a
