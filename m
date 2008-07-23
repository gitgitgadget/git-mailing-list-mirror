From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] documentation: 'git am --abort' also invokes 'git rerere
	clear'
Date: Wed, 23 Jul 2008 19:14:53 +0200
Message-ID: <1216833293-15925-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:16:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhwf-00087O-5b
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 19:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbYGWROy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 13:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYGWROy
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 13:14:54 -0400
Received: from francis.fzi.de ([141.21.7.5]:44249 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752858AbYGWROx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 13:14:53 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Jul 2008 19:14:52 +0200
X-Mailer: git-send-email 1.6.0.rc0.36.g3c05
X-OriginalArrivalTime: 23 Jul 2008 17:14:52.0882 (UTC) FILETIME=[9EF9A320:01C8ECE7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89718>

Other git commands invoking 'git rerere clear' are mentioned there,
except this.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-rerere.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.tx=
t
index beebd53..5246565 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -37,8 +37,8 @@ its working state.
 'clear'::
=20
 This resets the metadata used by rerere if a merge resolution is to be
-is aborted.  Calling 'git-am --skip' or 'git-rebase [--skip|--abort]'
-will automatically invoke this command.
+is aborted.  Calling 'git-am [--skip|--abort]' or 'git-rebase
+[--skip|--abort]' will automatically invoke this command.
=20
 'diff'::
=20
--=20
1.6.0.rc0.36.g3c05
