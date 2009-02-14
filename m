From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: add 'merge --ff' and '--no-ff' options
Date: Sat, 14 Feb 2009 17:22:56 +0100
Message-ID: <1234628576-4686-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 14 17:24:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYNJa-0003mX-Ff
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 17:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbZBNQXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Feb 2009 11:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbZBNQW7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 11:22:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:63686 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZBNQW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 11:22:58 -0500
Received: from [127.0.1.1] (p5B130271.dip0.t-ipconnect.de [91.19.2.113])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1LYNI73kWh-0006BG; Sat, 14 Feb 2009 17:22:56 +0100
X-Mailer: git-send-email 1.6.2.rc0.111.g246ed
X-Provags-ID: V01U2FsdGVkX19SrV1gp2azOJmDza+NiclL/tQK0C757NPT/JP
 FP9UxTDIY+0sfgY6798MM8N6cwG4J5qnU86hFROUaZalov5JMP
 y2/KClIeJGSHgRp8NNWcA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109881>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e848d5d..ad45717 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1037,6 +1037,7 @@ _git_merge ()
 	--*)
 		__gitcomp "
 			--no-commit --no-stat --log --no-log --squash --strategy
+			--ff --no-ff
 			"
 		return
 	esac
--=20
1.6.2.rc0.111.g246ed
