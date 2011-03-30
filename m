From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] Documentation/config.txt: make truth value of numbers more explicit
Date: Wed, 30 Mar 2011 12:22:32 +0200
Message-ID: <1301480552-23940-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 12:22:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4sXv-000652-IR
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 12:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184Ab1C3KWe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2011 06:22:34 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:42837 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755762Ab1C3KWe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 06:22:34 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 9D5844611D;
	Wed, 30 Mar 2011 12:22:23 +0200 (CEST)
Received: (nullmailer pid 23990 invoked by uid 1000);
	Wed, 30 Mar 2011 10:22:32 -0000
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170376>

Change the order to 1/0 to have the same true/false order as the rest
of the possibilities for a boolean variable in order not not confuse
users.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

Though if I read the source correctly, anything other than a 0 will
give a true result, but it's better if we tell people to use 1.

 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 701fba9..1a571f4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -62,7 +62,7 @@ Internal whitespace within a variable value is retain=
ed verbatim.
=20
 The values following the equals sign in variable assign are all either
 a string, an integer, or a boolean.  Boolean values may be given as ye=
s/no,
-0/1, true/false or on/off.  Case is not significant in boolean values,=
 when
+1/0, true/false or on/off.  Case is not significant in boolean values,=
 when
 converting value to the canonical form using '--bool' type specifier;
 'git config' will ensure that the output is "true" or "false".
=20
--=20
1.7.4.1
