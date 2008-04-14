From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 08/13] Unify the lenght of $SHORT* and the commits in the TODO list
Date: Mon, 14 Apr 2008 02:21:04 +0200
Message-ID: <1208132469-26471-8-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-5-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-6-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-7-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 02:52:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCw7-00049R-V6
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbYDNAv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbYDNAv4
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:51:56 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1629 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753500AbYDNAvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:54 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 8DBB548809F; Mon, 14 Apr 2008 02:51:53 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRa-0006IH-EV; Mon, 14 Apr 2008 02:21:11 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRa-0006u4-0M; Mon, 14 Apr 2008 02:21:10 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-7-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79434>

This makes it easier to test for equality of a commit in the TODO list
and one of SHORTUPSTREAM, SHORTHEAD or SHORTONTO.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index fd41ca0..d0a7e5c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -588,9 +588,9 @@ do
 			MERGES_OPTION=3D--no-merges
 		fi
=20
-		SHORTUPSTREAM=3D$(git rev-parse --short $UPSTREAM)
-		SHORTHEAD=3D$(git rev-parse --short $HEAD)
-		SHORTONTO=3D$(git rev-parse --short $ONTO)
+		SHORTUPSTREAM=3D$(git rev-parse --short=3D7 $UPSTREAM)
+		SHORTHEAD=3D$(git rev-parse --short=3D7 $HEAD)
+		SHORTONTO=3D$(git rev-parse --short=3D7 $ONTO)
 		git rev-list $MERGES_OPTION --pretty=3Doneline --abbrev-commit \
 			--abbrev=3D7 --reverse --left-right --cherry-pick \
 			$UPSTREAM...$HEAD | \
--=20
1.5.5
