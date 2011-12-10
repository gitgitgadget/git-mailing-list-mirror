From: Jeff King <peff@peff.net>
Subject: [PATCHv2 9/9] Makefile: OS X has /dev/tty
Date: Sat, 10 Dec 2011 05:41:30 -0500
Message-ID: <20111210104130.GI16648@sigill.intra.peff.net>
References: <20111210103943.GA16478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:41:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKN6-0000Nh-8u
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab1LJKld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:41:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47068
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567Ab1LJKlc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:41:32 -0500
Received: (qmail 14511 invoked by uid 107); 10 Dec 2011 10:48:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:48:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:41:30 -0500
Content-Disposition: inline
In-Reply-To: <20111210103943.GA16478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186756>

We can use our enhanced getpass(). Tested by me.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 198fc9b..1b3f5f0 100644
--- a/Makefile
+++ b/Makefile
@@ -902,6 +902,7 @@ ifeq ($(uname_S),Darwin)
 	endif
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
+	HAVE_DEV_TTY = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
-- 
1.7.8.rc2.40.gaf387
