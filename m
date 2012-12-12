From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] .mailmap: normalize emails for Linus Torvalds
Date: Wed, 12 Dec 2012 06:41:04 -0500
Message-ID: <20121212114104.GD18803@sigill.intra.peff.net>
References: <20121212113036.GB19625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 12:41:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tikgp-00040y-35
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 12:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab2LLLlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 06:41:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42820 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab2LLLlI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 06:41:08 -0500
Received: (qmail 23400 invoked by uid 107); 12 Dec 2012 11:42:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 06:42:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 06:41:04 -0500
Content-Disposition: inline
In-Reply-To: <20121212113036.GB19625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211344>

Linus used a lot of different per-machine email addresses in
the early days. This means that "git shortlog -nse" does not
aggregate his counts, and he is listed well below where he
should be (8th instead of 3rd).

Signed-off-by: Jeff King <peff@peff.net>
---
Linus,

I recall you considered "email ident from random machine" as a feature
very early on in git's history, but you seem to have settled on using
the linux-foundation address pretty consistently these days. Please let
me know if you object to normalizing your entries in this way.

 .mailmap | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.mailmap b/.mailmap
index 4a27b7f..c7e8618 100644
--- a/.mailmap
+++ b/.mailmap
@@ -52,6 +52,12 @@ Li Hong <leehong@pku.edu.cn>
 Lars Doelle <lars.doelle@on-line ! de>
 Lars Doelle <lars.doelle@on-line.de>
 Li Hong <leehong@pku.edu.cn>
+Linus Torvalds <torvalds@linux-foundation.org> <torvalds@woody.linux-f=
oundation.org>
+Linus Torvalds <torvalds@linux-foundation.org> <torvalds@osdl.org>
+Linus Torvalds <torvalds@linux-foundation.org> <torvalds@g5.osdl.org>
+Linus Torvalds <torvalds@linux-foundation.org> <torvalds@evo.osdl.org>
+Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl.o=
rg>
+Linus Torvalds <torvalds@linux-foundation.org> <torvalds@ppc970.osdl.o=
rg.(none)>
 Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
 Mark Rada <marada@uwaterloo.ca>
--=20
1.8.0.2.4.g59402aa
