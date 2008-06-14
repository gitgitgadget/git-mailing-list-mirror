From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] bash: add more 'git add' options
Date: Sat, 14 Jun 2008 11:48:01 +0200
Message-ID: <1213436881-2360-2-git-send-email-szeder@ira.uka.de>
References: <1213436881-2360-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 11:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7SNb-0005X4-8y
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756433AbYFNJsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 05:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756237AbYFNJsJ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:48:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:55187 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143AbYFNJsG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 05:48:06 -0400
Received: from [127.0.1.1] (p5B131E03.dip0.t-ipconnect.de [91.19.30.3])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis)
	id 0ML21M-1K7SMd1iMp-0000l8; Sat, 14 Jun 2008 11:48:04 +0200
X-Mailer: git-send-email 1.5.6.rc2.55.g9b8c
In-Reply-To: <1213436881-2360-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX18Z3X3zx5rgy37RG6EYIrZ3fxP8Y0e9qM0Lmlh
 U5VVYMqSNRrmbz8SEMhx/if6rnHgZItp8I27a3ExvqYvDK4v61
 cs+wmhfdIXd75PbK3me8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85003>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 1698463..2141b6b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -500,7 +500,10 @@ _git_add ()
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
-		__gitcomp "--interactive --refresh"
+		__gitcomp "
+			--interactive --refresh --patch --update --dry-run
+			--ignore-errors
+			"
 		return
 	esac
 	COMPREPLY=3D()
--=20
1.5.6.rc2.55.g9b8c
