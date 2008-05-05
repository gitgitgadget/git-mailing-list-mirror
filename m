From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH] post-merge: Add it's not executed if merge failed.
Date: Mon,  5 May 2008 11:06:49 +0200
Message-ID: <1209978409-19396-1-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 14:18:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jszdw-0004lW-Tr
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 14:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbYEEMRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2008 08:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbYEEMRV
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 08:17:21 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3283 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbYEEMRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 08:17:20 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id ED0BB488038; Mon,  5 May 2008 14:17:18 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jsweo-0003cH-6a; Mon, 05 May 2008 11:06:50 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jswen-00053C-S5; Mon, 05 May 2008 11:06:49 +0200
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81277>


Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 Documentation/hooks.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 44fbe58..43764e3 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -136,7 +136,8 @@ post-merge
 This hook is invoked by `git-merge`, which happens when a `git pull`
 is done on a local repository.  The hook takes a single parameter, a s=
tatus
 flag specifying whether or not the merge being done was a squash merge=
=2E
-This hook cannot affect the outcome of `git-merge`.
+This hook cannot affect the outcome of `git-merge` and is not executed=
,
+if the merge failed due to conflicts.
=20
 This hook can be used in conjunction with a corresponding pre-commit h=
ook to
 save and restore any form of metadata associated with the working tree
--=20
1.5.5.1
