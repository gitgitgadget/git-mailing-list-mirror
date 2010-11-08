From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH/resend] Doc: git-push: Specify the default mode in the description
Date: Mon,  8 Nov 2010 14:20:35 +0100
Message-ID: <1289222435-9610-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 14:20:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFReY-00030T-CK
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 14:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab0KHNUt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 08:20:49 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54406 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab0KHNUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 08:20:48 -0500
Received: by ewy7 with SMTP id 7so2741171ewy.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 05:20:47 -0800 (PST)
Received: by 10.216.235.41 with SMTP id t41mr33972weq.55.1289222446718;
        Mon, 08 Nov 2010 05:20:46 -0800 (PST)
Received: from localhost.localdomain (ub222011.pcb.ub.es [161.116.222.11])
        by mx.google.com with ESMTPS id p4sm3099314wej.4.2010.11.08.05.20.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 05:20:46 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.337.gc40334
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160934>

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
Hi *,

  just resend a patch that maybe was missed inside this thread:

Subject:    possible bug when pushing with multiple remote repos.
=46rom:       Arnaud Mouiche
Date:       2010-10-22 9:12:51
http://marc.info/?i=3D1287738771.13348.34.camel%20()%20amolinux

Santi

 Documentation/git-push.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e11660a..9a2a93e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -23,6 +23,8 @@ You can make interesting things happen to a repositor=
y
 every time you push into it, by setting up 'hooks' there.  See
 documentation for linkgit:git-receive-pack[1].
=20
+The default operation mode if no explicit refspec is found is
+to push "matching" branches, see below.
=20
 OPTIONS[[OPTIONS]]
 ------------------
--=20
1.7.3.2.337.gc40334
