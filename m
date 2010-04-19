From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] reflog: remove 'show' from 'expire's usage string
Date: Mon, 19 Apr 2010 11:52:30 +0200
Message-ID: <1271670750-30297-2-git-send-email-szeder@ira.uka.de>
References: <1271670750-30297-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 12:08:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ntc-0005a6-A8
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 12:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab0DSKH5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 06:07:57 -0400
Received: from francis.fzi.de ([141.21.7.5]:55038 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751807Ab0DSKH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 06:07:56 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2010 06:07:56 EDT
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Apr 2010 11:52:38 +0200
X-Mailer: git-send-email 1.7.1.rc1.43.gf0841
In-Reply-To: <1271670750-30297-1-git-send-email-szeder@ira.uka.de>
X-OriginalArrivalTime: 19 Apr 2010 09:52:38.0432 (UTC) FILETIME=[0B852200:01CADFA6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145287>

Most of 'expire's options are not recognized by the 'show' subcommand,
hence it errors out.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 builtin/reflog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index d4d4409..fe8b36d 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -13,7 +13,7 @@
  */
=20
 static const char reflog_expire_usage[] =3D
-"git reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--exp=
ire=3D<time>] [--expire-unreachable=3D<time>] [--all] <refs>...";
+"git reflog expire [--verbose] [--dry-run] [--stale-fix] [--expire=3D<=
time>] [--expire-unreachable=3D<time>] [--all] <refs>...";
 static const char reflog_delete_usage[] =3D
 "git reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <=
refs>...";
=20
--=20
1.7.1.rc1.43.gf0841
