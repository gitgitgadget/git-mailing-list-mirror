From: jari.aalto@cante.net
Subject: [PATCH] git-stash.txt: Add new example
Date: Wed,  5 May 2010 10:37:14 +0300
Organization: Private
Message-ID: <1273045035-7292-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 09:37:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9ZAi-00038S-Ee
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 09:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757124Ab0EEHhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 03:37:25 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:58163 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756791Ab0EEHhY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 03:37:24 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id DD8EF8C8C9
	for <git@vger.kernel.org>; Wed,  5 May 2010 10:37:22 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0510AD97D8; Wed, 05 May 2010 10:37:22 +0300
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 4AEC727D90
	for <git@vger.kernel.org>; Wed,  5 May 2010 10:37:21 +0300 (EEST)
Received: from webssh.cante.net ([192.168.1.7] helo=jondo.cante.net)
	by picasso.cante.net with esmtp (Exim 4.71)
	(envelope-from <jari.aalto@cante.net>)
	id 1O9ZAR-0002Zz-AO; Wed, 05 May 2010 10:37:15 +0300
X-Mailer: git-send-email 1.7.0
X-SA-Exim-Connect-IP: 192.168.1.7
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146380>

From: Jari Aalto <jari.aalto@cante.net>

Add new example "Saving selected files to stash" thanks to
ideas by Johan Sageryd <j416@1616.se>.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-stash.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 473889a..7d9f9e1 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -230,6 +230,18 @@ $ edit/build/test remaining parts
 $ git commit foo -m 'Remaining parts'
 ----------------------------------------------------------------
=20
+Saving selected files to stash::
+
+You can use `git stash save --keep-index` to put only selected files
+into the stash. Let's suppose the files A, B, C and D are modified and
+you want to stash only C and D:
++
+----------------------------------------------------------------
+$ git status			# Verify what's modified
+$ git add A B			# ...not these
+$ git stash save --keep-index   # ...but stash all the others
+----------------------------------------------------------------
+
 Recovering stashes that were cleared/dropped erroneously::
=20
 If you mistakenly drop or clear stashes, they cannot be recovered
--=20
1.7.0
