From: jari.aalto@cante.net
Subject: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Wed,  1 Dec 2010 20:14:18 +0200
Organization: Private
Message-ID: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 19:14:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNrCG-0004il-3t
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006Ab0LASOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:14:21 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:52891 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843Ab0LASOU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:14:20 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id C88D7EC1F2
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 20:14:19 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02D8C9834B; Wed, 01 Dec 2010 20:14:19 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id BA279158A66
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 20:14:18 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNrC6-0004fU-9m; Wed, 01 Dec 2010 20:14:18 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162564>

From: Jari Aalto <jari.aalto@cante.net>

In order to easily read paragraphs, use same notation and do not mixed
both ^ and ~N. This helps digesting the information more easier as the
tokens stay the same (dcumentation uniformity).

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-reset.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index fd72976..b679c99 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -129,7 +129,7 @@ Undo a commit and redo::
 +
 ------------
 $ git commit ...
-$ git reset --soft HEAD^      <1>
+$ git reset --soft HEAD~1     <1>
 $ edit                        <2>
 $ git commit -a -c ORIG_HEAD  <3>
 ------------
@@ -166,7 +166,7 @@ $ git commit ...
 $ git reset --hard HEAD~3   <1>
 ------------
 +
-<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
+<1> The last three commits (HEAD, HEAD~1, and HEAD~2) were bad
 and you do not want to ever see them again.  Do *not* do this if
 you have already given these commits to somebody else.  (See the
 "RECOVERING FROM UPSTREAM REBASE" section in linkgit:git-rebase[1] for
@@ -237,7 +237,7 @@ $ git checkout master
 $ fix fix fix
 $ git commit ;# commit with real log
 $ git checkout feature
-$ git reset --soft HEAD^ ;# go back to WIP state  <2>
+$ git reset --soft HEAD~1 ;# go back to WIP state <2>
 $ git reset                                       <3>
 ------------
 +
--=20
1.7.2.3
