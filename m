From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] .mailmap: fix broken entry for Martin Langhoff
Date: Wed, 12 Dec 2012 06:38:06 -0500
Message-ID: <20121212113806.GB18803@sigill.intra.peff.net>
References: <20121212113036.GB19625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin@laptop.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 12:38:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tikdw-000192-Bh
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 12:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987Ab2LLLiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 06:38:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42810 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878Ab2LLLiK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 06:38:10 -0500
Received: (qmail 23293 invoked by uid 107); 12 Dec 2012 11:39:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 06:39:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 06:38:06 -0500
Content-Disposition: inline
In-Reply-To: <20121212113036.GB19625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211342>

Commit adc3192 (Martin Langhoff has a new e-mail address,
2010-10-05) added a mailmap entry, but forgot that both the
old and new email addresses need to appear for one to be
mapped to the other (i.e., we do not key mailmap emails by
name).

Signed-off-by: Jeff King <peff@peff.net>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 69301bd..e370e86 100644
--- a/.mailmap
+++ b/.mailmap
@@ -54,7 +54,7 @@ Mark Rada <marada@uwaterloo.ca>
 Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
 Mark Rada <marada@uwaterloo.ca>
-Martin Langhoff <martin@laptop.org>
+Martin Langhoff <martin@laptop.org> <martin@catalyst.net.nz>
 Martin von Zweigbergk <martinvonz@gmail.com> <martin.von.zweigbergk@gm=
ail.com>
 Michael Coleman <tutufan@gmail.com>
 Michael J Gruber <git@drmicha.warpmail.net> <michaeljgruber+gmane@fast=
mail.fm>
--=20
1.8.0.2.4.g59402aa
