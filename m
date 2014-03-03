From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: [PATCH v2 1/2] i18n: proposed command missing leading dash
Date: Mon,  3 Mar 2014 09:55:53 -0500
Message-ID: <1393858554-4392-1-git-send-email-sandy.carter@savoirfairelinux.com>
References: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jn.avila@free.fr, Sandy Carter <sandy.carter@savoirfairelinux.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 15:55:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKUGj-0005KL-1S
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 15:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118AbaCCOy5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 09:54:57 -0500
Received: from mail.savoirfairelinux.com ([209.172.62.77]:53917 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775AbaCCOyw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 09:54:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E783110D72B5;
	Mon,  3 Mar 2014 09:54:49 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id unq8MowOkmzo; Mon,  3 Mar 2014 09:54:49 -0500 (EST)
Received: from scarter-X220.mtl.sfl (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AA01E10D72B1;
	Mon,  3 Mar 2014 09:54:49 -0500 (EST)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243225>

Add missing leading dash to proposed commands in french output when
using the command:
    git branch --set-upstream remotename/branchname
and when upstream is gone

Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
---
 po/fr.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/fr.po b/po/fr.po
index e10263f..0b9d59e 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -1075,7 +1075,7 @@ msgstr "Votre branche est bas=C3=A9e sur '%s', ma=
is la branche amont a disparu.\n"
=20
 #: remote.c:1875
 msgid "  (use \"git branch --unset-upstream\" to fixup)\n"
-msgstr "  (utilisez \"git branch -unset-upstream\" pour corriger)\n"
+msgstr "  (utilisez \"git branch --unset-upstream\" pour corriger)\n"
=20
 #: remote.c:1878
 #, c-format
@@ -3266,7 +3266,7 @@ msgstr "    git branch -d %s\n"
 #: builtin/branch.c:1027
 #, c-format
 msgid "    git branch --set-upstream-to %s\n"
-msgstr "    git branch -set-upstream-to %s\n"
+msgstr "    git branch --set-upstream-to %s\n"
=20
 #: builtin/bundle.c:47
 #, c-format
--=20
1.9.0
