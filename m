From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] push: re-flow non-fast-forward message
Date: Sun, 6 Sep 2009 02:47:20 -0400
Message-ID: <20090906064720.GB28941@coredump.intra.peff.net>
References: <20090906064454.GA1643@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 08:47:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkBX9-0006WF-Ik
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 08:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbZIFGrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 02:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754019AbZIFGrW
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 02:47:22 -0400
Received: from peff.net ([208.65.91.99]:57238 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbZIFGrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 02:47:22 -0400
Received: (qmail 9411 invoked by uid 107); 6 Sep 2009 06:47:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Sep 2009 02:47:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Sep 2009 02:47:20 -0400
Content-Disposition: inline
In-Reply-To: <20090906064454.GA1643@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127837>

The extreme raggedness of the right edge make this jarring
to read. Let's re-flow the text to fill the lines in a more
even way.

Signed-off-by: Jeff King <peff@peff.net>
---
I am actually not all that fond of the particular wording, either, but I
didn't want to re-open a wording bikeshed debate.

 builtin-push.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 8d72cc2..787011f 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -158,9 +158,9 @@ static int do_push(const char *repo, int flags)
 
 		error("failed to push some refs to '%s'", url[i]);
 		if (nonfastforward) {
-			printf("To prevent you from losing history, non-fast-forward updates were rejected.\n"
-			       "Merge the remote changes before pushing again.\n"
-			       "See the 'non-fast forward' section of 'git push --help' for details.\n");
+			printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
+			       "Merge the remote changes before pushing again.  See the 'non-fast forward'\n"
+			       "section of 'git push --help' for details.\n");
 		}
 		errs++;
 	}
-- 
1.6.4.2.266.g981efc.dirty
