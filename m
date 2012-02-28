From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] Documentation: use {asterisk} in rev-list-options.txt when needed
Date: Tue, 28 Feb 2012 16:35:48 +0100
Message-ID: <1330443348-5742-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 16:35:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2P5G-0001g3-Hg
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 16:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277Ab2B1PfQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 10:35:16 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:56853 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932161Ab2B1PfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 10:35:15 -0500
Received: from centaur.lab.cmartin.tk (brln-4db9f055.pool.mediaWays.net [77.185.240.85])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 0469646057
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 16:35:08 +0100 (CET)
Received: (nullmailer pid 5779 invoked by uid 1000);
	Tue, 28 Feb 2012 15:35:48 -0000
X-Mailer: git-send-email 1.7.9.2.3.g4346f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191738>

Text between to '*' is emphasized in AsciiDoc which made the
glob-related explanations in rev-list-options.txt very confusing, as
the rendered text would be missing two asterisks and the text between
them would be emphasized instead.

Use '{asterisk}' where needed to make them show up as asterisks in the
rendered text.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 Documentation/rev-list-options.txt |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 39e6207..6a4b635 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -117,27 +117,27 @@ parents) and `--max-parents=3D-1` (negative numbe=
rs denote no upper limit).
 	Pretend as if all the refs in `refs/heads` are listed
 	on the command line as '<commit>'. If '<pattern>' is given, limit
 	branches to ones matching given shell glob. If pattern lacks '?',
-	'*', or '[', '/*' at the end is implied.
+	'{asterisk}', or '[', '/{asterisk}' at the end is implied.
=20
 --tags[=3D<pattern>]::
=20
 	Pretend as if all the refs in `refs/tags` are listed
 	on the command line as '<commit>'. If '<pattern>' is given, limit
-	tags to ones matching given shell glob. If pattern lacks '?', '*',
-	or '[', '/*' at the end is implied.
+	tags to ones matching given shell glob. If pattern lacks '?', '{aster=
isk}',
+	or '[', '/{asterisk}' at the end is implied.
=20
 --remotes[=3D<pattern>]::
=20
 	Pretend as if all the refs in `refs/remotes` are listed
 	on the command line as '<commit>'. If '<pattern>' is given, limit
 	remote-tracking branches to ones matching given shell glob.
-	If pattern lacks '?', '*', or '[', '/*' at the end is implied.
+	If pattern lacks '?', '{asterisk}', or '[', '/{asterisk}' at the end =
is implied.
=20
 --glob=3D<glob-pattern>::
 	Pretend as if all the refs matching shell glob '<glob-pattern>'
 	are listed on the command line as '<commit>'. Leading 'refs/',
-	is automatically prepended if missing. If pattern lacks '?', '*',
-	or '[', '/*' at the end is implied.
+	is automatically prepended if missing. If pattern lacks '?', '{asteri=
sk}',
+	or '[', '/{asterisk}' at the end is implied.
=20
 --ignore-missing::
=20
--=20
1.7.9.2.3.g4346f
