From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/3] Fix "multi-character character constant" compile warning
Date: Tue,  3 Feb 2009 14:08:49 +0100
Message-ID: <1233666531-21589-1-git-send-email-szeder@ira.uka.de>
References: <20090203130818.GA20359@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@fzi.de>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jesse van den Kieboom <jesse@icecrew.nl>
X-From: git-owner@vger.kernel.org Tue Feb 03 14:10:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUL3D-00033F-0X
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 14:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbZBCNIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 08:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbZBCNIw
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 08:08:52 -0500
Received: from francis.fzi.de ([141.21.7.5]:23842 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752919AbZBCNIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 08:08:52 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Feb 2009 14:08:50 +0100
X-Mailer: git-send-email 1.6.1.2.362.g0f78
In-Reply-To: <20090203130818.GA20359@neumann>
X-OriginalArrivalTime: 03 Feb 2009 13:08:50.0711 (UTC) FILETIME=[8E965A70:01C98600]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108187>

=46rom: SZEDER G=C3=A1bor <szeder@fzi.de>

=2E.. that was caused by a short command line option.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 gitg/gitg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitg/gitg.c b/gitg/gitg.c
index 1b33294..69c5b56 100644
--- a/gitg/gitg.c
+++ b/gitg/gitg.c
@@ -15,7 +15,7 @@ static gboolean commit_mode =3D FALSE;
=20
 static GOptionEntry entries[] =3D=20
 {
-	{ "commit", '-c', 0, G_OPTION_ARG_NONE, &commit_mode, N_("Start gitg =
in commit mode") },=20
+	{ "commit", 'c', 0, G_OPTION_ARG_NONE, &commit_mode, N_("Start gitg i=
n commit mode") },
 	{ NULL }
 };
=20
--=20
1.6.1.2.362.g0f78
