From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] bash: fix misspelled 'git svn' option
Date: Sat, 14 Feb 2009 17:21:52 +0100
Message-ID: <1234628513-4573-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 14 17:23:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYNId-0003Uv-55
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 17:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbZBNQV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 11:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbZBNQV6
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 11:21:58 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:64366 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbZBNQV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 11:21:58 -0500
Received: from [127.0.1.1] (p5B130271.dip0.t-ipconnect.de [91.19.2.113])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1LYNH71QO1-0006D7; Sat, 14 Feb 2009 17:21:56 +0100
X-Mailer: git-send-email 1.6.2.rc0.111.g246ed
X-Provags-ID: V01U2FsdGVkX19fPpJJVzprcYJ3u3lScKd0ggizbT27oE7Fkha
 /P1Y++x4xnxet08oIFhnaKhitqCqKXaXt2Bc8QUsMw2mfOm6za
 n40E1MQ3WZKt56McR7H4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109880>

'--user-log-author' -> '--use-log-author'

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index ad45717..18cabe2 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1614,7 +1614,7 @@ _git_svn ()
 			--follow-parent --authors-file=3D --repack=3D
 			--no-metadata --use-svm-props --use-svnsync-props
 			--log-window-size=3D --no-checkout --quiet
-			--repack-flags --user-log-author --localtime $remote_opts
+			--repack-flags --use-log-author --localtime $remote_opts
 			"
 		local init_opts=3D"
 			--template=3D --shared=3D --trunk=3D --tags=3D
--=20
1.6.2.rc0.111.g246ed
