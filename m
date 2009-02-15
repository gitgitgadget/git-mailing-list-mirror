From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2] bash: add missing 'git merge' options
Date: Sun, 15 Feb 2009 14:25:11 +0100
Message-ID: <1234704311-14774-1-git-send-email-szeder@ira.uka.de>
References: <7v7i3sp8jk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 14:27:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYh1l-0006sb-J8
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 14:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbZBONZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 08:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753809AbZBONZV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 08:25:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:54056 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbZBONZV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 08:25:21 -0500
Received: from [127.0.1.1] (p5B131540.dip0.t-ipconnect.de [91.19.21.64])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1LYgzg0CXF-0007iJ; Sun, 15 Feb 2009 14:25:17 +0100
X-Mailer: git-send-email 1.6.2.rc0.112.gc888f
In-Reply-To: <7v7i3sp8jk.fsf@gitster.siamese.dyndns.org>
X-Provags-ID: V01U2FsdGVkX1+6Iv5r9cIgonRS1LQxjG1NLLnKRaTsopHVfb0
 lQsYcFCv6D8kuVRFXCHGiKa2dOZUP94WPRWTfXCyPEHYS9/g7R
 O9IOKMd4aAaFAJCQchinw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110006>

Namely: '--commit', '--stat', '--no-squash', '--ff', '--no-ff'.

One might wonder why add options that specify the default behaviour
anyway (e.g. '--commit', '--no-squash', etc.).  Users can override the
default with config options (e.g. 'branch.<name>.mergeoptions',
'merge.log'), but sometimes might still need the default behaviour.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e848d5d..98fa56e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1037,6 +1037,7 @@ _git_merge ()
 	--*)
 		__gitcomp "
 			--no-commit --no-stat --log --no-log --squash --strategy
+			--commit --stat --no-squash --ff --no-ff
 			"
 		return
 	esac
--=20
1.6.2.rc0.112.gc888f
