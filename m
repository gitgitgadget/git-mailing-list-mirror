From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] Documentation: update [section.subsection] to reflect what git does
Date: Wed, 12 Oct 2011 17:52:06 +0200
Message-ID: <1318434726-5556-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 17:52:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE16Q-0004Px-6Y
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 17:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab1JLPwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 11:52:13 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:46464 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab1JLPwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 11:52:12 -0400
Received: from cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id CC303460FE;
	Wed, 12 Oct 2011 17:51:43 +0200 (CEST)
Received: (nullmailer pid 5591 invoked by uid 1000);
	Wed, 12 Oct 2011 15:52:06 -0000
X-Mailer: git-send-email 1.7.6.557.gcee4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183373>

Using the [section.subsection] syntax, the subsection is transformed
to lower-case and is matched case sensitively. Say so in the
documentation and mention that you shouldn't be using it anyway.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

This bit me recently when I was creating a parser. See Jeff's
explanation here:
http://thread.gmane.org/gmane.comp.version-control.git/179569/focus=3D1=
80290

 Documentation/config.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0658ffb..1212c47 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -45,9 +45,10 @@ lines.  Variables may belong directly to a section o=
r to a given subsection.
 You can have `[section]` if you have `[section "subsection"]`, but you
 don't need to.
=20
-There is also a case insensitive alternative `[section.subsection]` sy=
ntax.
-In this syntax, subsection names follow the same restrictions as for s=
ection
-names.
+There is also a deprecated `[section.subsection]` syntax. With this
+syntax, the subsection name is converted to lower-case and is also
+compared case sensitively. These subsection names follow the same
+restrictions as section names.
=20
 All the other lines (and the remainder of the line after the section
 header) are recognized as setting variables, in the form
--=20
1.7.6.557.gcee4
