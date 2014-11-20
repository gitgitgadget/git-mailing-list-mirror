From: Jeff King <peff@peff.net>
Subject: [PATCH 1/7] docs: describe ANSI 256-color mode
Date: Thu, 20 Nov 2014 10:15:31 -0500
Message-ID: <20141120151531.GA23680@peff.net>
References: <20141120151418.GA23607@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Baker <bakers@canbytel.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:15:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrTSM-0003yi-OD
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 16:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757206AbaKTPPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 10:15:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:42764 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756860AbaKTPPe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 10:15:34 -0500
Received: (qmail 11673 invoked by uid 102); 20 Nov 2014 15:15:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 09:15:33 -0600
Received: (qmail 13011 invoked by uid 107); 20 Nov 2014 15:15:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 10:15:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 10:15:31 -0500
Content-Disposition: inline
In-Reply-To: <20141120151418.GA23607@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our color specifications have supported the 256-color ANSI
extension for years, but we never documented it.

Signed-off-by: Jeff King <peff@peff.net>
---
I have no clue which terminals do and don't support this. I would hope
the answer is "everything" by now, but I have seen some pretty awful
terminal emulators in my time.

 Documentation/config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9220725..f615a5c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -839,6 +839,10 @@ accepted are `normal`, `black`, `red`, `green`, `yellow`, `blue`,
 `blink` and `reverse`.  The first color given is the foreground; the
 second is the background.  The position of the attribute, if any,
 doesn't matter.
++
+Colors (foreground and background) may also be given as numbers between
+0 and 255; these use ANSI 256-color mode (but note that not all
+terminals may support this).
 
 color.diff::
 	Whether to use ANSI escape sequences to add color to patches.
-- 
2.2.0.rc2.402.g4519813
